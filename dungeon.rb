# Dungeon class

class Dungeon
  attr_accessor :character

  def initialize(name)
    @character = Character.new(name)
    @rooms = []
  end

  # The character class
  class Character
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end

  # The room class
  class Room
    attr_accessor :reference, :name, :description, :level, :connections

    def initialize(reference, name, description, level, connections)
      @reference = reference
      @name = name
      @description = description
      @level = level
      @connections = connections
    end

    def full_description()
      @name + "\n\nYou are in the " + @name + "\n#{@description}"
    end
  end

  def add_room(reference, name, description, level, connections)
    @rooms << Room.new(reference, name, description, level, connections)
  end

  def start(location)
    @character.location = location
    show_current_description()
  end

  def show_current_description()
    puts find_room_in_dungeon(@character.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@character.location).connections[direction]
  end

  def go(direction)
    puts "You go " + direction.to_s
    @character.location = find_room_in_direction(direction)
    show_current_description()
  end
end

separator = "-" * 50

# Creates the main dungeon object
# print "What is your name: "
# name = gets.chomp
name = "Drake"
raven_hall = Dungeon.new(name)

# Add the Hallway to the dungeon (1st Floor)
raven_hall.add_room(
  :hallway1, "HALLWAY",
  "The hall is dusty and littered with cobwebs." +
  "\nThe HALLWAY connects to the CLOAK ROOM to the EAST and the STUDY to the WEST.",
  1, { :north => :hallway2, :east => :cloak_room, :west => :study }
)

raven_hall.add_room(
  :hallway2, "HALLWAY",
  "The hall is dusty and littered with cobwebs." +
  "\nThe HALLWAY connects to the LIBRARY to the WEST.",
  1, { :north => :hallway3, :west => :library, :south => :hallway1 }
)

raven_hall.add_room(
  :hallway3, "HALLWAY",
  "The hall is dusty and littered with cobwebs." +
  "\nThe HALLWAY connects to the SERVICE ROOM to the EAST.",
  1, { :south => :hallway2, :east => :service_room }
)

# Add the Cloak Room to the dungeon (1st Floor)
raven_hall.add_room(
  :cloak_room, "CLOAK ROOM",
  "In addition to your jacket and hat, the cloak room contains various hunting coats, " +
  "rain jackets, and boots that once belonged to Albert." +
  "\nThe door goes to the HALLWAY to the EAST.\n#{separator}",
  1, { :west => :hallway1 }
)

# Add the Study to the dungeon (1st Floor)
raven_hall.add_room(
  :study, "STUDY",
  "Various papers and parchment lay about the desk and room as if someone had already rifled " +
  "through his papers." +
  "\nThe doors go to the LIBRARY to the NORTH and the HALLWAY to the EAST.\n#{separator}",
  1, { :east => :hallway, :north => :library }
)

# Add the Library to the dungeon (1st Floor)
raven_hall.add_room(
  :library, "LIBRARY",
  "Old dusty books and long forgotten tomes line the book shelves. The upholstery on the " +
  "once-comfortable reading chairs have fallen apart." +
  "\nThe doors go to the STUDY to the SOUTH, the CONSERVATORY to the NORTH and the HALLWAY to the EAST.",
  1, { :south => :study, :east => :hallway2, :north => :conservatory }
)

# Add the Conservatory to the dungeon (1st Floor)
raven_hall.add_room(
  :conservatory, "CONSERVATORY",
  "The conservatory is warm and muggy from all of the exotic vegetation. Venus flytraps sit " +
  "next to pitcher plants. Albert's mother was famous for her collection of poisonous plants. " +
  "\nThe door goes to the LIBRARY to the SOUTH.",
  1, { :south => :library }
)

# Add the Service Room to the dungeon (1st Floor)
raven_hall.add_room(
  :service_room, "SERVICE ROOM",
  "The SERVICE ROOM is where the servants did much of their work." +
  "\nThe stairs go DOWN to the KITCHEN.",
  1, { :down => :kitchen}
)

# Add the Kitchen to the dungeon (0th Floor)
raven_hall.add_room(
  :kitchen, "KITCHEN",
  "The once bustling KITCHEN was where Bessie the cook and Eliza the scullery maid made meals " +
  "for the family. It is now completely empty. The pots and pans are still neatly arranged " +
  "on the shelves and racks. Now only your footsteps echo throughout the KITCHEN." +
  "\nThe door goes to the LARDER to the SOUTH and the stairs go UP to the SERVICE ROOM.",
  0, { :south => :larder, :up => :service_room }
)

# Add the Larder to the dungeon (0th Floor)
raven_hall.add_room(
  :larder, "LARDER",
  "The LARDER was once well stocked with verdant vegetables, exotic spices, and other victuals " +
  "that the cook used to make wonderful repasts." +
  "\nThe door to the EAST goes to the COLD STORAGE and the KITCHEN to the NORTH.",
  0, { :north => :kitchen, :east => :cold_storage }
)

# Add the Cold Storage to the dungeon (0th Floor)
raven_hall.add_room(
  :cold_storage, "COLD STORAGE",
  "The COLD STORAGE used to hold fresh fish, the choicest cuts of meat, and anything else that " +
  "the family killed while hunting on the once well manicured grounds. The room now contains " +
  "some grouse and pheasant curing on the rack presumably killed by Irving."
  "\nThe door to the WEST goes to the LARDER.",
  0, { :west => cold_storage }
)

# Add the Hallway (2nd Floor)
raven_hall.add_room(
  :hallway4, "HALLWAY",
  "The HALLWAY floor boards are creaky and you worry you might fall through." +
  "\nThe doors go to the GAME ROOM to the EAST, the HALLWAY to the NORTH and the SMOKING ROOM " +
  "to the WEST.",
  2, { :north => :hallway5, :west => :smoking_room, :east => :game_room }
)

raven_hall.add_room(
  :hallway5, "HALLWAY",
  "The HALLWAY floor boards are creaky and you worry you might fall through." +
  "\nThe HALLWAY leads to the HALLWAY to the NORTH and DOWN the STAIRS.",
  2, { :north => :hallway6, :south => :hallway4, :down => :hallway2 }
)

raven_hall.add_room(
  :hallway6, "HALLWAY",
  "The HALLWAY floor boards are creaky and you worry you might fall through." +
  "\nThe doors go to the DINING ROOM to the WEST, the SALON to the EAST, " +
  "and the HALLWAY to the SOUTH",
  2, { :west => :dining_room, :east => :salon, :south => :hallway5 }
)

# Add the Game Room (2nd Floor)
raven_hall.add_room(
  :game_room, "GAME ROOM",
  "The GAME ROOM contains a billiards table with the balls still in the triangle on the velvet, " +
  "green surface. A well-worn dart board is on the wall, however, the darts are long missing.",
  "\nThe door goes to the HALLWAY to the EAST.",
  2, { :west => :hallway4 }
)

puts  "You can hear owls hooting and unknown creatures flitting in the underbrush. " +
      "A thick layer of fog has descended upon the valley making it difficult for your " +
      "horse to find her footing. You pass a carriage house that has long since seen any " +
      "passengers. You know the house is not far from here.\n" +
      "You can hear a wolf howl in distance as the ancient keep suddenly emerges from " +
      "the fog as if it were expecting you. The ancient brick and stone walls are covered in " +
      "ivy. The house, Wolf Hall, is the ancestral seat of the once proud and ancient " +
      "Ravenscroft family. The last inhabitant of the house passed recently. The last scion of " +
      "an ancient and noble family, Albert Ravenscroft, was your friend from Oxford. You smile " +
      "as you remember your university days together. The main line, now extinct, has passed to " +
      "distant cousin and on his behalf are here to settle the estate. They have sent you here " +
      "to determine if the estate is even worth keeping. You get off your horse, tie him to the " +
      "gate, and remove your belongings from the saddle bags. As you walk up to the door the " +
      "gargoyles peer down at you with contempt. You knock on the door using the bronze door " +
      "knocker. Irving, Alberts personal valet, answers the door and invites you in.\n\n" +
      "\"I've been expecting you, mister #{name}\" Irvine croaked as he takes your hat and coat.\n" +
      "\"Hello Irving, It's been too long. It's been 15 years since I was last here visiting Bertie." +
      " How are Elias, Edith, Bess, and Eliza?\"\n" +
      "\"They left directly after mister Ravenscroft passed\"\n" +
      "\"So, it's just you then?\" I asked.\n" +
      "\"It is, sir. I've also been instructed to give you free reign of the place.\" He replied.\n" +
      "\"Thank you, Irving, I will be retiring to room and then look at the rest of the house.\"" +
      "You've unpacked your bags and changed out of your riding clothes and decide to start at the " +
      "entrance of the manse."

puts separator

puts  "                 ________________________\n" +
      "                |      |          |      |\n" +
      "conservatory -> |  5   |         /    2  | <- service room\n" +
      "                |__--__|          |______|\n" +
      "                |      |                 |\n" +
      "     library -> |  4    \\\         [ [ [ [| <- stairs\n" +
      "                |__--__|           ______|\n" +
      "                |      |          |      |\n" +
      "       study -> |  3    \\\        /    1  | <- cloak room\n" +
      "                |______|____==____|______|\n\n"

puts separator

# Start the dungeon by placing the player in the hallway
raven_hall.start(:hallway1)

raven_hall.go(:east)
raven_hall.go(:west)
raven_hall.go(:north)
