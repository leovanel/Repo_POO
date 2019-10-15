class Player
  attr_accessor :name , :life_points
  def initialize (name)
    @name = name
    @life_points = 10
  end
  def show_state
    "#{@name} a #{@life_points} points de vie."
  end
  def get_dammage (dammage)
    @life_points = @life_points - dammage
      if @life_points <= 0
      puts "T'es mort #{@name} !"
      @life_points = 0
      end
  end
  def attacks(player)
    puts "#{@name} attaque le joueur #{player.name}"
    damage = compute_damage
    puts "#{@name} lui inflige #{damage} points de dommages !"
    player.get_dammage(damage)
  end
  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer<Player
attr_accessor :weapon_level
  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end
  def show_state
    "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end
  def compute_damage
    return (rand(1..6))*@weapon_level
  end
  def search_weapon
    level=rand(1..6)
    puts "tu as trouvé une arme de niveau #{level}"
    if @weapon_level<level
      @weapon_level=level
      puts"youhou! elle est meilleure que ton arme actuelle: tu la prends"
    else @weapon_level = @weapon_level
      puts "m****! elle n'est pas mieux que ton arme actuelle "
    end
  end
  def search_health_pack
    health=rand(1..6)
    case health
    when 1
      puts"tu n'as rien trouvé"
    when 2..5
      puts"bravo, tu as trouvé 50 points de vie "   # total ne doit pas dépasser 100
      if @life_points+50>100
        @life_points= 100
      else @life_points=life_points+50
      end
    when 6
      puts"whaou, tu as trouvé 80 points de vie "
      if @life_points+80>100
        @life_points= 100
      else @life_points=life_points+80
      end
    end
  end
end
