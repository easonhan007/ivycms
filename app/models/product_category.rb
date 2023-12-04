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
#
class ProductCategory < Category
  after_save :set_level1_path
  scope :with_children, ->(path) { where("path like ? and active = ?", "#{path}%", true).order("level ASC").order("sorting ASC") }

  def build_children()
    tree = {element: self, children: []}
    children = ProductCategory.with_children(self[:path])

    children.each do |category|
      parent_id = get_parent_id_from(category.path, category.id)  
      if parent_id.eql?(self[:id])
        tree[:children] << {element: category, children: []}
      else
        insert_to_tree(tree, category, parent_id)
      end
    end #each
    tree
  end #children

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

  def insert_to_tree(tree, category, parent_id)
    while not tree[:children].empty?
      tree[:children].each do |child|
        if child[:element].id.eql?(parent_id)
          child[:children] << {element: category, children: []}
          return 
        else
          return insert_to_tree(child, category, parent_id)
        end #if
      end #each
    end #while
  end

  def create_child(**args)
    child = ProductCategory.new(args)
    child.level = self[:level] + 1
    child.transaction do
      child.save!
      child.path = "#{self[:id]},#{child.id}"
      child.save!
    end
    child
  end

  def set_level1_path
    if self[:level].eql?(1)
      self[:path] = "#{self[:id]}"
    end #if
  end

  def destroy_with_children()
    with_children = ProductCategory.with_children(self[:path])
    with_children.destroy_all()
  end

  def self.build()
    level1 = ProductCategory.where(level: 1, active: true).order("sorting ASC")
    categories = []
    level1.each do |category| 
      categories << category.build_children()
    end
    categories
  end

  def path_to_category_arr()
    path_list = self[:path].split(',').map {|p| p.to_i}
    ProductCategory.where(id: path_list).order('level ASC') 
  end

end
