require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return board.won? && board.winner != evaluator if board.over?
    self.next_mover_mark == evaluator ? self.children.all? { |move| move.losing_node?(evaluator) } : self.children.any? { |move| move.losing_node?(evaluator) }
  end

  def winning_node?(evaluator)
    return board.won? && board.winner == evaluator if board.over?
    self.next_mover_mark == evaluator ? self.children.any? { |move| move.winning_node?(evaluator) } : self.children.all? { |move| move.winning_node?(evaluator) }
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        
        board_node = board.dup
        if board.empty?(pos)
          board_node[pos] = self.next_mover_mark
          self.next_mover_mark == :x ? next_mover_mark = :o : next_mover_mark = :x
          child = TicTacToeNode.new(board_node, next_mover_mark, pos)
          children << child
        end
      end
    end
    children
  end
end
