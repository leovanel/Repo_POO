require 'bundler'
Bundler.require

#require_relative 'lib/game'
require_relative 'lib/player'

def perform

    ennemies=[]

    puts "------------------------------------------------"
    puts"| Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
    puts"| Le but du jeu est d'être le dernier survivant !|"
    puts "-------------------------------------------------"
    puts"quel est ton nom?"
    name= gets.chomp
    human=HumanPlayer.new(name)
    player1= Player.new("Josiane")
    player2= Player.new("José")
    ennemies<< player1
    ennemies << player2

    while human.life_points > 0 && (player1.life_points>0 || player2.life_points>0)
    puts "Voici l'état des joueurs :"
    puts human.show_state
    puts"quelle action veux tu effectuer?"
    puts"a - chercher une meilleure arme"
    puts"s - chercher à se soigner "
    puts ""
    puts"attaquer un joueur en vue :"
    if player1.life_points<=0
        puts "1 - #{player2.show_state}"
    elsif player2.life_points<=0
        puts "0 - #{player1.show_state}"
    else
        puts "0 - #{player1.show_state}"
        puts "1 - #{player2.show_state}"
    end
    menu= gets.chomp
    case menu
        when "a"
            human.search_weapon
        when "s"
            human.search_health_pack
        when "0"
            human.attacks(player1)
        when "1"
            human.attacks(player2)
    end

    gets.chomp
    puts "les bots attaquent !"
    ennemies.each {|ennemie|
        if ennemie.life_points <= 0
            break
        else ennemie.attacks(human)
        end}


    end

    puts"la partie est finie "
    if human.life_points>0
        puts"bravo tu as gagné!"

    else puts "looser tu as perdu !"
    end
end

perform


#binding.pry
