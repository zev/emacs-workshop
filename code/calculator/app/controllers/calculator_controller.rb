class CalculatorController < ApplicationController

  def index
    #do nothing for now
  end

  def game
    @name = params[:name] || 'anon'
    @step = params[:step] || 1
    @quiz = Quiz.new(@step)
  end

  def answer

  end

end
