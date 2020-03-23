module Cards

  private

  def initialize_cards
    card_pack = {}
    card_types = ["♧", "♥", "♤", "♦"]
    high_cards = ["V", "Q", "K"]
    high_card_score = 10

    card_types.each do |type|
      (2..10).each do |card|
        card_score = card
        card_pack["#{card}#{type}"] = card_score
      end
      high_cards.each do |card|
        card_pack["#{card}#{type}"] = high_card_score
      end
      card_pack["A#{type}"] = :ace
    end

    card_pack
  end

  def ace_score(current_score)
    win_score = 21
    current_score + 11 <= win_score ? 11 : 1
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
    puts "Your score is: #{@player.score}. Dealer's score is #{@dealer.score}."
    puts "Your cards: #{@player.cards}."
    puts "Dealer's cards: #{@dealer.cards}."
  end

end
