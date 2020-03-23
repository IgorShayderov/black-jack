class Dealer < Gambler

  attr_writer :cards_open

  def initialize(name)
    super(name)
    @cards_open = false
  end

  def show_cards
    @cards_open ? @cards : @cards.map{"*"}
  end

end