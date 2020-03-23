# frozen_string_literal: true

require './modules/cards.rb'
require_relative 'gambler'
require_relative 'interface'
require_relative 'dealer'

puts 'Welcome to Black Jack. Please write your name:'
name = gets.chomp
puts 'List of commands:'
puts "'add card' to add card to your hand."
puts "'skip' to skip to the next action."
puts "'open cards' to open your cards."

player = Gambler.new(name)
dealer = Dealer.new('Dealer')

Interface.new(player, dealer).start
