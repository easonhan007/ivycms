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

  def build_children()
    tree = {element: self, children: []}
    children = ProductCategory.where("path like ?", "#{id}%").order("level ASC").order("sorting ASC")

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

end
