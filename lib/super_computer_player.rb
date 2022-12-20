require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    new_node = TicTacToeNode.new(game.board, mark)
    pos_moves = new_node.children

    new_node = pos_moves.select { |move| move.winning_node?(mark) }[rand(2)]
    return new_node.prev_move_pos if new_node

    new_node = pos_moves.select { |move| !move.losing_node?(mark) }.first
    return new_node.prev_move_pos if new_node
    
    raise 'error'

    # node = TicTacToeNode.new(game.board, mark)
    # test1 = node.children.select { |child| child.prev_move_pos if node.winning_node?(mark) }.first
    # return test1.prev_move_pos if test1
    
    # test2 = node.children.select { |child| child.prev_move_pos if !node.losing_node?(mark) }.first
    # return test2.prev_move_pos if test2
    # raise 'error'
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
