require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    session[:letters] = @letters
  end

  def score
    @guess = params[:guess].upcase
    @score = 0

    @letters = session[:letters] || []
    if !in_grid?(@guess, @letters)
      @message = "Sorry but #{@guess} can't be built out of #{@letters.join(', ')}"
    elsif !valid_english_word?(@guess)
      @message = "Sorry but #{@guess} does not seem to be a valid English word..."
    else
      @score = @guess.size
      @message = "Congratulations! #{@guess} is a valid English word! Your score is #{@score}."
    end
  end

  private 

  def in_grid?(guess, grid)
    return guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def valid_english_word?(word)
    response = URI.parse("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
