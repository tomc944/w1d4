
require_relative "tree.rb"
class KnightPathFinder
  attr_reader :starting_pos

  def initialize(starting_pos = [0,0])
    @starting_pos = starting_pos
    @visited_positions = [starting_pos]
    build_move_tree
  end

  def find_path(end_value)
    bottom_node = root_node.dfs(end_value)
    trace_path_back(bottom_node)
  end

  private

  KNIGHT_MOVES=  [[1, 2],[-1, 2],[1, -2],[-1, -2],
                  [2, 1],[2, -1],[-2, 1],[-2, -1]]

  attr_accessor :visited_positions, :root_node

  def build_move_tree
    self.root_node = PolyTreeNode.new(starting_pos)
    nodes = [root_node]

    until nodes.empty?
      current_node = nodes.shift

      new_moves = new_move_positions(current_node.value) # [[1,2],[2,1]]
      new_moves.each do |move|
        break if move.nil?
        new_node = PolyTreeNode.new(move) # [2,2]
        new_node.parent = current_node # [1, 0]
        nodes << new_node
      end
    end
  end

  def trace_path_back(bottom_node)
    nodes = []
    current_node = bottom_node
    until current_node.nil?
      nodes << current_node.value
      current_node = current_node.parent
    end
    #parents << node.value
    nodes.reverse
  end

  def new_move_positions(pos)
    legal_moves = KnightPathFinder.generate_legal_moves(pos)

    valid_moves = legal_moves.reject do |move|
      visited_positions.include?(move)
    end

    valid_moves.each { |move| visited_positions << move}
  end

  def self.generate_legal_moves(pos)
    possible_moves = []

    cur_x, cur_y = pos
    KNIGHT_MOVES.each do |(dx, dy)|
      new_pos = [cur_x + dx, cur_y + dy]
      if new_pos.all? { |coord| coord.between?(0, 7)}
        possible_moves << new_pos
      end
    end

    possible_moves
  end
end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new
  p k.find_path([7, 7])
end
