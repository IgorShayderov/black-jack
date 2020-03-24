# frozen_string_literal: true

class Interface

  def show_status(player, dealer)
    puts "Your money: #{player.money}, dealer's money: #{dealer.money}."
    puts "You have cards: #{player.cards}, your score: #{player.score}."
    puts "Dealers cards: #{dealer.show_cards}."
  end

  def action_open_cards
    puts 'You have opened your cards.'
  end

  def action_unknown_command
    puts 'Unknown command. Try again.'
  end

  def game_result(player, result)
    puts "#{player.name}, you #{result}."
  end

  def player_lost_money
    puts "You lost all your money."
  end

  def dealer_lost_money
    puts "Dealer lost all his money. You won."
  end

  def ask_for_more
    puts 'Want to play more? y/n'
  end

  def open_cards(player, dealer)
    puts "Your score is: #{player.score}. Dealer's score is #{dealer.score}."
    puts "Your cards: #{player.cards}."
    puts "Dealer's cards: #{dealer.cards}."
  end

end
