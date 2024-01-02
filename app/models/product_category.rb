# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  level       :integer          default(1)
#  path        :string
#  name        :string
#  key         :string
#  description :string
#  image       :string
#  url         :string
#  type        :string
#  sorting     :integer          default(1)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  content     :text
#
class ProductCategory < Category
  attribute :parent_id, :integer
  attr_accessor :nodes

  has_many :products, class_name: 'Product', foreign_key: 'category_id'

  before_save :set_level1_path
  scope :with_children, ->(path) { where("path like ? ", "#{path}%").where(active: true).order("level ASC").order("sorting ASC") }

  def build_tree(ignore_status=false)
    if ignore_status
      children = ProductCategory.with_children(self[:path]).unscope(where: :active)
    else
      children = ProductCategory.with_children(self[:path])
    end

    last_level_elements = {}
    last_level_elements[self[:id]] = self 
    children.each do |category|
      parent_id = get_parent_id_from(category.path, category.id)
      parent = last_level_elements[parent_id]
      if not parent
        next 
      end
      if parent.nodes 
        parent.nodes << category
      else
        parent.nodes = [category]
      end
      last_level_elements[category.id] = category
    end #each
    self
  end

  def get_parent_id_from(path, cid)
    seq = path.split(',')

    if seq.size.eql?(1) and seq.first.to_i.eql?(cid)
      return 0
    end #if

    index = seq.index(cid.to_s)
    if index 
      parent = index - 1
    else
      return 0
    end

    # puts("#{path}, #{cid}, #{seq[parent].to_i}")
    return seq[parent].to_i
  end

  def create_child(**args)
    child = ProductCategory.new(args)
    child.level = self[:level] + 1
    child.active = self[:active]
    child.transaction do
      child.save!
      child.path = "#{self[:path]},#{child.id}"
      child.save!
    end
    child
  end

  def set_level1_path
    Rails.logger.info('xx' * 1000)
    Rails.logger.info(self[:level])

    if self[:level].eql?(1)
      self[:path] = "#{self[:id]}"
    end #if
  end

  def destroy_with_children()
    with_children = ProductCategory.with_children(self[:path]).unscope(where: :active)
    self.transaction do
      with_children.each do |c|
        c.destroy!
      end #each
      if not self.destroyed?
        self.destroy!
      end
    end 
  end

  def inactive_with_children()
    with_children = ProductCategory.with_children(self[:path])
    with_children.update_all(active: false)
    self.update(active: false)
  end

  def active_with_children()
    with_children = ProductCategory.with_children(self[:path]).unscope(where: :active)
    with_children.update_all(active: true)
    self.update(active: true)
  end

  def self.build()
    level1 = ProductCategory.where(level: 1, active: true).order("sorting ASC")
    categories = []
    level1.each do |category| 
      categories << category.build_tree()
    end
    categories
  end

  def self.build_ignore_status()
    level1 = ProductCategory.where(level: 1).order("sorting ASC")
    categories = []
    level1.each do |category| 
      categories << category.build_tree(true)
    end
    categories
  end

  def path_to_category_arr()
    path_list = self[:path].split(',').map {|p| p.to_i}
    ProductCategory.where(id: path_list).order('level ASC') 
  end

  def has_children?()
    ProductCategory.with_children(self[:path]).size > 1
  end

  def full_path_text
    categories = path_to_category_arr.map {|c| c.name }
    categories.join(" -> ")
  end

  def default_img
    "https://images.unsplash.com/photo-1488190211105-8b0e65b80b4e?q=80&w=1080&auto=format&fit=crop"
  end

end
