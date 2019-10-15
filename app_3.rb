require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

def perform
  puts "------------------------------------------------"
  puts"| Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts"| Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
  puts
  puts"quel est ton nom?"
  name= gets.chomp
  my_game = Game.new(name)        # on lance les méthodes de la nouvelle classe Game
  puts
  while my_game.is_stil_ongoing? == true
    puts ""
    my_game.show_player
    gets.chomp
    puts " "
    my_game.menu
    choice = gets.chomp

    if choice != "a" && choice != "s"  # selectionne les string et si différents de "a" et "s" les convertis en integer
      my_game.menu_choice(choice.to_i)
    else
      my_game.menu_choice(choice)
    end
    gets.chomp
    my_game.show_player
    my_game.ennemies_attack
  end
    my_game.end
end
perform
