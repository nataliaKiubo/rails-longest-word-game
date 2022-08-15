require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    number = rand(5..10)
    @letters = []
    number.times do |x|
      x = ('A'..'Z').to_a.sample
      @letters << x
    end
    @letters.shuffle
  end

  def score
    @result = params[:result]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@result}"
    serialized_word = URI.open(filepath).read
    @word = JSON.parse(serialized_word)

    @letters = params[:letters].split
    @input = @result.upcase.split("")
    @has_letters = @input.all? do |letter| @input.count(letter) <= @letters.count(letter)
    end

    if @has_letters
        if @word["found"]
          @puts = "word exists in repo & has letters"
        elsif @word["found"] == false
          @puts = "word is not an english word"
        end
    elsif
      @puts = "is not in the grid"
    end
  end
end
