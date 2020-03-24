# frozen_string_literal: true

class Game

  def initialize(interface, player, dealer, cards)
    @interface = interface
    @player = player
    @dealer = dealer
    @cards = cards.initialize_cards
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
        @interface.action_open_cards
      else
        @interface.action_unknown_command
        redo
      end

      end_round
      break if !play_more?
      reset_game
    end
  end

  def start_round
    [@player, @dealer].each do |gambler|
      2.times { add_card(gambler) }
      gambler.make_bet
    end
    @interface.show_status(@player, @dealer)

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
    @interface.game_result(@player, "won")
    @player.won
  end

  def dealer_wins
    @interface.game_result(@player, "lose")
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
  end

  def no_money(gambler)
    @interface.dealer_lost_money if gambler.class == Dealer
    @interface.player_lost_money if gambler.class == Gambler
    start_again
  end

  def play_more?
      @interface.ask_for_more
      answer = gets.chomp
      return false if answer.match?(/\s*no*\s*/)
      check_for_money
  end

  def start_again
    reset_game
    [@player, @dealer].each{ |gambler| gambler.reset_bank }
    true
  end

  def check_for_money
    [@player, @dealer].each do |gambler|
      no_money(gambler) if !have_money?(gambler)
    end
  end

    def ace_score(current_score)
    win_score = 21
    current_score + 11 <= win_score ? 11 : 1
  end

  def take_card
    add_card(@player)

    return if @player.score > 21

    dealer_action
  end

  def random_card
    card_num = rand(0...@cards.keys.length)
    @cards.keys[card_num]
  end

  def add_card(gambler)
    card = random_card
    card_score = @cards[card] == :ace ? ace_score(gambler.score) : @cards[card]

    gambler.cards.push(card)
    gambler.add_score(card_score)
  end

  def open_cards
    @dealer.cards_open = true
    @interface.open_cards(@player, @dealer)
  end
end
