
require_relative "tree.rb"
class KnightPathFinder

  def initialize(starting_pos = [0,0])
    @starting_pos = starting_pos
    @visited_positions = [starting_pos]
    @move_tree = build_move_tree
  end

  attr_reader :starting_pos
  attr_accessor :visited_positions

  def build_move_tree
    @root = PolyTreeNode.new(starting_pos)
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      new_moves = new_move_positions(current_node.value) # [[1,2],[2,1]]
      new_moves.each do |move|
        break if move.nil? || move.empty?
        new_node = PolyTreeNode.new(move) # [2,2]
        new_node.parent = current_node # [1, 0]
        current_node.add_child(new_node)
        queue << new_node
      end
    end
  end

  def find_path(end_value)
    path = @root.dfs(end_value)
  end

  def trace_path_back(bottom_node)
    parents = []
    node = bottom_node
    until node.parent.nil?
      parents << node.value
      node = node.parent
    end
    parents << node.value
    parents.reverse
  end

  def new_move_positions(pos)
    legal_moves = self.class.generate_legal_moves(pos)
    valid_moves = legal_moves.select do |move|
      !@visited_positions.include?(move)
    end
    @visited_positions += valid_moves
    valid_moves
  end

  def self.generate_legal_moves(pos)
    @knight_moves =[[1, 2],[-1, 2],[1, -2], [-1, -2],
                    [2,1],[2,-1],[-2,1],[-2, -1]]
    possible_moves = []
    @knight_moves.each do |move|
      idx0 = pos[0] + move[0]
      idx1 = pos[1] + move[1]
      if (idx0 <= 7 && idx0 >= 0) && (idx1 <= 7 && idx1 >= 0)
        possible_moves << [idx0,idx1]
      end
    end
    possible_moves
  end
end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new
  p k.trace_path_back(k.find_path([6,2]))
end
