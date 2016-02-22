# {:path=>"README.txt",
#    :mode=>"100644",
#    :type=>"blob",
#    :sha=>"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391",
#    :size=>0,
#    :url=>""}

# CONVERTED TO

# "[{\"id\":\"README.txt\",\"parent\":\"#\",\"icon\":\"file\",
#    \"data\":{\"sha\":\"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391\",
#    \"type\":\"file\"}}]"
class Node
  attr_reader :node

  def initialize(node)
    @node = node
  end

  def text
    path_names.last
  end

  def id
    node.path
  end

  def parent
    if root_node?
      "#"
    else
      names = path_names
      names.pop
      names.join("/")
    end
  end

  def icon
    node.type.eql?("tree") ? "" : "file"
  end

  def data
    { sha: node.sha, type: icon }
  end

  def get_hash
    { id: id, parent: parent, icon: icon, data: data, text: text }
  end

  def root_node?
    path_names.size == 1
  end

  def path_names
    node.path.split("/")
  end
end
