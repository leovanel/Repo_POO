class Player
  attr_accessor :name , :life_points
  def initialize (name)
    @name = name
    @life_points = 10
  end
  def show_state
    puts "#{@name} a #{@life_points} points de vie."
  end
  def get_dammage (dammage)
    @life_points = @life_points - dammage
      if @life_points <= 0
      puts "T'es mort #{@name} !"
      @life_points = 0
      end
  end
  def attacks(player)
    puts "le joueur #{@name} attaque le joueur #{player.name}"
    damage = compute_damage
    puts "#{@name} lui inflige #{damage} points de dommages !"
    player.get_dammage(damage)
  end
  def compute_damage
    return rand(1..6)
  end
end
