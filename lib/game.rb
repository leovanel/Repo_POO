require 'pry'

require_relative 'player'

class Game
  attr_accessor :human_player, :ennemies
  def initialize (name)
    @ennemies = []
    @human_player = HumanPlayer.new(name)
    for i in 1..4 do
      player = Player.new("Bots_#{i}")
      @ennemies << player
    end
  end
  def kill_player (player)
    @ennemies.delete(player)
  end
  def is_stil_ongoing?
    if @human_player.life_points > 0 && !@ennemies.empty?
      return true
    else
      return false
    end
  end
  def show_player
    puts @human_player.show_state
    puts "Il reste #{@ennemies.size} bots dans le game !"
  end
  def menu
    puts"quelle action veux tu effectuer?"
    puts"a - chercher une meilleure arme"
    puts"s - chercher à se soigner "
    puts ""
    puts"attaquer un joueur en vue :"
    @ennemies.each_with_index { |player , i| # i correcspond à l'index et commence à "0"
      puts "#{i} - #{player.show_state}"
      }
  end
  def menu_choice (choice)
    case choice
      when "a"
        @human_player.search_weapon
      when "s"
        @human_player.search_health_pack
      when 0..4
        @human_player.attacks(@ennemies[choice])
        if @ennemies[choice].life_points <= 0
           kill_player(@ennemies[choice])
        end
    end
  end
  def ennemies_attack
    puts "les bots attaquent !"
    @ennemies.each {|ennemie| ennemie.attacks(@human_player)}
  end
  def end
    puts"la partie est finie "
    if @human_player.life_points>0
      puts"bravo tu as gagné !"
    else puts "looser tu as perdu !"
    end
  end
#  binding.pry
end
