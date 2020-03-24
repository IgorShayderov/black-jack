# frozen_string_literal: true

module GameActions
  private

  def start_round
    [@player, @dealer].each do |gambler|
      2.times { add_card(gambler) }
      gambler.make_bet
    end

    puts "Your money: #{@player.money}, dealer's money: #{@dealer.money}."
    puts "You have cards: #{@player.cards}, your score: #{@player.score}."
    puts "Dealers cards: #{@dealer.show_cards}."
  end

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

  def have_money?(gambler)
    gambler.money > 0
  end

  def reset_game
    [@player, @dealer].each do |gambler|
      gambler.reset_score
      gambler.reset_cards
    end
    puts 'Starting new round...'
  end

  def end_game(gambler)
    puts "Dealer lost all his money. You won." if gambler.class == Dealer
    puts "You lost all your money." if gambler.class == Gambler
    play_more? ?
    start_again :
    false
  end

  def play_more?
      puts 'Want to play more? y/n'
      answer = gets.chomp
      !answer.match?(/\s*no*\s*/)
  end

  def start_again
    reset_game
    [@player, @dealer].each{ |gambler| gambler.reset_bank }
    true
  end
end
