require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    if word_validation(params[:word], params[:letters])
      @score = :word.size
    end
  end

  def word_validation(word, letters)
    @letters = letters
    word.chars.all? { |letter| @letters.include?(letter) }
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    something = JSON.parse(response)
    true if something["found"]
  end
end
