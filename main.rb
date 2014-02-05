require 'sinatra'
require_relative './lib/sudoku'
require_relative './lib/cell'

enable :sessions

def random_sudoku
  seed = (1..9).to_a.shuffle+Array.new(81-9,0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
  end

def puzzle(sudoku)
  @level = {:easy=>35, :hard=> 55}
  puzzle = sudoku.dup
  puzzle_numbers = (0..80).to_a.sample(@level[:easy])
  puzzle_numbers.each do |index|
    puzzle[index] = ''
  end
  puzzle
end

get '/' do
  sudoku = random_sudoku
  session[:solution] = sudoku
  @current_solution = puzzle(sudoku)
  erb :index
end