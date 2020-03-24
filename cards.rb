# frozen_string_literal: true

class Cards

  def initialize_cards
    card_pack = {}
    card_types = %w[♧ ♥ ♤ ♦]
    high_cards = %w[V Q K]
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

end
