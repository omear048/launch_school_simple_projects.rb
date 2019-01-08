class Pet
  attr_accessor :breed, :name

  def initialize(breed, name)
    @breed = breed
    @name = name
  end

  def to_s
    "a #{breed} named #{name}"
  end
end

class Owner
  attr_accessor :name, :collection_of_animals

  def initialize(name)
    @name = name
    @collection_of_animals = []
  end

  def number_of_pets
    collection_of_animals.count 
  end 

  def list_pets
    collection_of_animals.each do |animal|
      puts "#{animal}"
    end
  end
end

class Shelter
  attr_accessor :adoption_record

  def initialize
    @adoption_record = {}
  end

  def adopt(owner, animal)      #the collection of animals will be passed into the key which will be the owner 
    owner.collection_of_animals << animal
    @adoption_record[owner.name] = owner
  end

  def print_adoptions       #iterates through a hash of every owner and the adopted pets that they have
    @adoption_record.each do |name, owner|
     puts "#{name} has adopted the following pets:"
     owner.list_pets
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# puts shelter.adoption_record


=begin
  P Hanson has adopted the following pets:
  a cat named Butterscotch
  a cat named Pudding
  a bearded dragon named Darwin

  B Holmes has adopted the following pets:
  a dog named Molly
  a parakeet named Sweetie Pie
  a dog named Kennedy
  a fish named Chester

  P Hanson has 3 adopted pets.
  B Holmes has 4 adopted pets.
=end



