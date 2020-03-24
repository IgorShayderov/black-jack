# frozen_string_literal: true

class Interface
  include CardActions
  include GameActions

  def initialize(player, dealer)
    @cards = initialize_cards
    @player = player
    @dealer = dealer
  end

  def start
    loop do
      start_round
      input = gets.chomp

      case input
      when /add\s*card/
        take_card
      when /skip/
        dealer_action
      when /open\s*cards/
        puts 'You have opened your cards.'
      else
        puts 'Unknown command. Try again.'
        redo
      end

      end_round
      p should_end_game
      break if should_end_game
      redo if !should_end_game

      break if !play_more?

      reset_game
    end
  end

  def should_end_game
    [@player, @dealer].each do |gambler|
      return end_game(gambler) if !have_money?(gambler)
    end
    false
  end
end
