require 'pry'
class Pokemon
  attr_accessor :name, :type, :db, :id, :hp

  def initialize(id:, name:, type:, db:, hp: 60)
    @name = name
    @type = type
    @db = db
    @id = id
    @hp = hp
  end

  def self.save(name, type, db)
    pokemon_arr = db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?);", name, type)
#    binding.pry
#    pokemon_arr[0].reject{|element| element == nil}
  end

  def self.find(id, db)
    sql_return = db.execute("SELECT * FROM pokemon WHERE id = ?;", id)
    poke_arr = sql_return[0]
    if poke_arr.count > 3
      poke = Pokemon.new(id: poke_arr[0], name: poke_arr[1], type: poke_arr[2], db: db, hp: poke_arr[3])
    else
      poke = Pokemon.new(id: poke_arr[0], name: poke_arr[1], type: poke_arr[2], db: db)
    end
  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE name = ?;", hp, self.name)
  end

end
