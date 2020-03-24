# frozen_string_literal: true

class Gambler
  attr_accessor :cards
  attr_reader :score, :name, :money

  def initialize(name)
    @name = name
    @money = 10
    @score = 0
    @cards = []
  end

  def add_score(score)
    @score += score
  end

  def reset_score
    @score = 0
  end

  def reset_cards
    @cards = []
  end

  def make_bet
    @money -= 10
  end

  def won
    @money += 20
  end

  def draw
    @money += 10
  end

  def reset_bank
    @money = 100
  end

  private

  attr_writer :score, :money
end
