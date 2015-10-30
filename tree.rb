
class PolyTreeNode
  attr_reader :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(parent)
    @parent.children.delete(self) if @parent
    @parent = parent
    if @parent && !@parent.children.include?(self)
      @parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "child doesn't have a parent" if child.parent.nil?
    child.parent = nil
  end

  def dfs(target_value)
    if target_value == self.value
      return self
    end
    self.children.each do |child|
      return_value = child.dfs(target_value)
      return return_value if return_value != nil
    end
    nil
  end

  def bfs(target_value)

    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each {|child| queue << child}
    end

    #first, check self
    #enter all children in queue
    #check each child (dequeueing from queue)
  end

  # def children
  #   @children
  # end
  #
  # def value
  #   @value
  # end
end
