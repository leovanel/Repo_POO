require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1= Player.new("Josiane")
player2= Player.new("José")

while player1.life_points > 0 && player2.life_points >0
  puts "Voici l'état des joueurs :"
  puts player1.show_state
  puts player2.show_state
  puts "C'est l'heure du Duuuuel !"
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  else
    player2.attacks(player1)
  end
end

#binding.pry
