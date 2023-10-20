
class PokemonBattle
  def initialize(a, b)
    @turn = 1
    @players = [a, b]
  end

  def turn
      @turn += 1
  
      # @players.reverse! if @players.size.modulo(@turn).even?
  end

  def battle
      
      attacker, defender = @players 
      # if defender.attack_power == attacker.attack_power then
      #   puts("攻撃力が同じなので引き分けです")
      #   exit
      # end
      if @turn == 1 then
        puts("戦闘開始")
      end
      defender.taken_damage(attacker.attack_power)
  end

  def game_over
      @players.find(&:defeated) 
  end



  def results
      attacker, defender = @players
      puts [
        "#{@turn}戦目",
        "#{attacker.name}の残りHP#{attacker.vitality}",
        "#{defender.name}の残りHP#{defender.vitality}",
        ("#{defender.name}の瀕死、、#{attacker.name}の勝利！" if defender.defeated)
      ]
  end

  def game_start
    
    loop do
      battle
      results
      turn
      break if game_over
    end
  end

end

class Pokemon
 
  def name
      @name
  end

  def vitality
      @vitality
  end
  
  def attack_power
      @attack_power
  end
  
  def initialize(**zokusei)
    @name = zokusei[:name]
    @vitality = zokusei[:vitality]
    @attack_power = zokusei[:attack_power]
  end

  
  def defeated
    @vitality <= 0
  end

  def taken_damage(attack_power)
   
    @vitality = @vitality - attack_power
  end
end

pokemon1 = Pokemon.new(name: "ピカチュウ", vitality: 30, attack_power: 8)
pokemon2 = Pokemon.new(name: "ゼニガメ", vitality: 50, attack_power: 6)

if pokemon1.attack_power > pokemon2.attack_power then
  battle = PokemonBattle.new(pokemon1, pokemon2)
elsif pokemon2.attack_power > pokemon1.attack_power then
  battle = PokemonBattle.new(pokemon2,pokemon1)
elsif pokemon1.attack_power == pokemon2.attack_power then
  puts "攻撃力が同じなので引き分け"
  exit
end

battle.game_start
