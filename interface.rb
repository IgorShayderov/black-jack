# frozen_string_literal: true

class Interface
  include Cards

  def initialize(player, dealer)
    @cards = initialize_cards
    @player = player
    @dealer = dealer
    @game_bank = 0
  end

  def start
    loop do
      [@player, @dealer].each do |gambler|
        2.times { add_card(gambler) }
        gambler.make_bet
        @game_bank += 10
      end

      puts "Your money: #{@player.money}, dealer's money: #{@dealer.money}."
      puts "You have cards: #{@player.cards}, your score: #{@player.score}."
      puts "Dealers cards: #{@dealer.show_cards}."

      input = gets.chomp

      case input
      when /add\s*card/
        take_card
      when /skip/
        dealer_action
      when /open\s*cards/
        puts "You have opened your cards."
      else
        puts 'Unknown command. Try again.'
        redo
      end

      end_round
      puts 'Want to play more? y/n'
      answer = gets.chomp

      break if answer.match?(/\s*no*\s*/)

      reset_game
    end
  end

  private

  def dealer_action
    add_card(@dealer) if @dealer.score <= 17
  end

  def exceed_limit?(gambler)
    gambler.score > 21
  end

  def end_round
    open_cards

    return dealer_wins if exceed_limit?(@player)
    return player_wins if exceed_limit?(@dealer)

    if @player.score == @dealer.score
      draw
    elsif @player.score > @dealer.score
      player_wins
    elsif @dealer.score > @player.score
      dealer_wins
    end
  end

  def player_wins
    puts "#{@player.name}, you won."
    @player.won
  end

  def dealer_wins
    puts "#{@player.name} you lose."
    @dealer.won
  end

  def draw
    puts 'Draw.'
    [@player, @dealer].each(&:draw)
  end

  def reset_game
    [@player, @dealer].each do |gambler|
      gambler.reset_score
      gambler.reset_cards
    end
    puts 'Starting new round...'
  end
end
