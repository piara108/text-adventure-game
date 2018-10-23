#!/usr/local/bin/ruby
# NAME: Piara Sandhu
# DATE: 22/10/2018
# FILE: dungeon.rb
# DESC: This is the code to write a text adventure game. The Dungeon,
#       Character, and Room classes make form the logic of the game.
#       The game takes place in a haunted house that has three stories:
#       A kitchen, larder, and cold storage room below ground, several rooms
#       on the ground level, and some more rooms on the second story.
#       The game is still very rough, but it is working w/o error.

class Dungeon
  attr_accessor :character, :number_of_rooms

  # Counts the number of rooms in the dungeon
  @@number_of_rooms = 0

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

  # I chose to add the room object just in case
  # I need to access the fields for each room
  def add_room(room)
    @@number_of_rooms += 1
    @rooms << room
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
    puts "-" * 50
    print "#{@character.name} goes " + direction.to_s + " to the: "
    @character.location = find_room_in_direction(direction)
    show_current_description()
  end
end

separator = "-" * 50

# Creates the main dungeon object
print "What is your name: "
name = gets.chomp!.capitalize
puts ""

raven_hall = Dungeon.new(name)

# Add the Hallway to the dungeon (1st Floor)
hallway1 = Dungeon::Room.new(:hallway1, "1st floor HALLWAY",
"The hall is dusty and littered with cobwebs." +
"\nThe HALLWAY connects to the CLOAK ROOM to the EAST and the STUDY to the WEST.",
1, { :north => :hallway2, :east => :cloak_room, :west => :study })
raven_hall.add_room(hallway1)

hallway2 = Dungeon::Room.new(:hallway2, "1st floor HALLWAY",
  "The hall is dusty and littered with cobwebs." +
  "\nThe HALLWAY connects to the LIBRARY to the WEST and UP the stairs.",
  1, { :north => :hallway3, :west => :library, :south => :hallway1, :up => :hallway5 })
raven_hall.add_room(hallway2)

hallway3 = Dungeon::Room.new(:hallway3, "1st floor HALLWAY",
  "The hall is dusty and littered with cobwebs." +
  "\nThe HALLWAY connects to the SERVICE ROOM to the EAST.",
  1, { :south => :hallway2, :east => :service_room })
raven_hall.add_room(hallway3)

# Add the Cloak Room to the dungeon (1st Floor)
cloak_room = Dungeon::Room.new(:cloak_room, "CLOAK ROOM",
  "In addition to your jacket and hat, the cloak room contains various\n" +
  "hunting coats, rain jackets, and boots that once belonged to Albert." +
  "\nThe door goes to the HALLWAY to the EAST.",
  1, { :west => :hallway1 })
raven_hall.add_room(cloak_room)

# Add the Study to the dungeon (1st Floor)
study = Dungeon::Room.new(:study, "STUDY",
  "Various papers and parchment lay about the desk and room as if someone had already rifled " +
  "through his papers." +
  "\nThe doors go to the LIBRARY to the NORTH and the HALLWAY to the EAST.",
  1, { :east => :hallway, :north => :library })
raven_hall.add_room(study)

# Add the Library to the dungeon (1st Floor)
library = Dungeon::Room.new(:library, "LIBRARY",
"Old dusty books and long forgotten tomes line the book shelves. The upholstery on the " +
"once-comfortable reading chairs have fallen apart." +
"\nThe doors go to the STUDY to the SOUTH, the CONSERVATORY to the NORTH and the HALLWAY to the EAST.",
1, { :south => :study, :east => :hallway2, :north => :conservatory })
raven_hall.add_room(library)

# Add the Conservatory to the dungeon (1st Floor)
conservatory = Dungeon::Room.new(:conservatory, "CONSERVATORY",
"The conservatory is warm and muggy from all of the exotic vegetation. Venus flytraps sit " +
"next to pitcher plants. Albert's mother was famous for her collection of poisonous plants. " +
"\nThe door goes to the LIBRARY to the SOUTH.",
1, { :south => :library })
raven_hall.add_room(conservatory)

# Add the Service Room to the dungeon (1st Floor)
service_room = Dungeon::Room.new(:service_room, "SERVICE ROOM",
"The SERVICE ROOM is where the servants did much of their work." +
"\nThe stairs go DOWN to the KITCHEN and EAST back into the HALLWAY.",
1, { :down => :kitchen})
raven_hall.add_room(service_room)

# Add the Kitchen to the dungeon (0th Floor)
kitchen = Dungeon::Room.new(:kitchen, "KITCHEN",
"The once bustling KITCHEN was where Bessie the cook and\nEliza the scullery maid made meals " +
"for the family. It is now completely empty.\nThe pots and pans are still neatly arranged " +
"on the shelves and racks.\nNow only your footsteps echo throughout the KITCHEN." +
"\nThe door goes to the LARDER to the SOUTH and the stairs go back UP to the SERVICE ROOM.",
0, { :south => :larder, :up => :service_room })
raven_hall.add_room(kitchen)

# Add the Larder to the dungeon (0th Floor)
larder = Dungeon::Room.new(:larder, "LARDER",
"The LARDER was once well stocked with verdant vegetables, exotic spices, and other victuals " +
"that the cook used to make wonderful repasts." +
"\nThe door to the EAST goes to the COLD STORAGE and the KITCHEN to the NORTH.",
0, { :north => :kitchen, :east => :cold_storage })
raven_hall.add_room(larder)

# Add the Cold Storage to the dungeon (0th Floor)
cold_storage = Dungeon::Room.new(:cold_storage, "COLD STORAGE",
"The COLD STORAGE used to hold fresh fish, the choicest cuts of meat, and anything else that " +
"the family killed while hunting on the once well manicured grounds. The room now contains " +
"some grouse and pheasant curing on the rack presumably killed by Irving." +
"\nThe door to the WEST goes to the LARDER.",
0, { :west => :cold_storage })
raven_hall.add_room(cold_storage)

# Add the Hallway (2nd Floor)
hallway4 = Dungeon::Room.new(:hallway4, "2nd floor HALLWAY",
  "The HALLWAY floor boards are creaky and you worry you might fall through." +
  "\nThe doors go to the GAME ROOM to the EAST, the HALLWAY to the NORTH, and the SMOKING ROOM " +
  "to the WEST.",
  2, { :north => :hallway5, :west => :smoking_room, :east => :game_room })
raven_hall.add_room(hallway4)

hallway5 = Dungeon::Room.new(:hallway5, "2nd floor HALLWAY",
  "The HALLWAY floor boards are creaky and you worry you might fall through." +
  "\nThe HALLWAY leads to the HALLWAY to the NORTH and the SOUTH and DOWN the STAIRS.",
  2, { :north => :hallway6, :south => :hallway4, :down => :hallway2 })
raven_hall.add_room(hallway5)

hallway6 = Dungeon::Room.new(:hallway6, "2nd floor HALLWAY",
  "The HALLWAY floor boards are creaky and you worry you might fall through." +
  "\nThe doors go to the DINING ROOM to the WEST, the SALON to the EAST, " +
  "and the HALLWAY to the SOUTH.",
  2, { :west => :dining_room, :east => :salon, :south => :hallway5 })
raven_hall.add_room(hallway6)

# Add the Game Room (2nd Floor)
game_room = Dungeon::Room.new(:game_room, "GAME ROOM",
"The GAME ROOM contains a billiards table with the balls still in the triangle on the velvet, " +
"green surface. A well-worn dart board is on the wall, however, the darts are long missing." +
"\nThe door goes to the HALLWAY to the WEST.",
2, { :west => :hallway4 })
raven_hall.add_room(game_room)

# Add the Smoking Room (2nd Floor)
smoking_room = Dungeon::Room.new(:smoking_room, "SMOKING ROOM",
  "The SMOKING ROOM reeks of stale cigar and pipe smoke. You remember the good times you spent " +
  "in here with Bertie. You remember the two of you stealing away to try his father's cigars. " +
  "\"It looks like those days are over,\" you whisper to yourself." +
  "\nThe door goes to the HALLWAY to the EAST.",
  2, { :east => :hallway4 })
raven_hall.add_room(smoking_room)

# Add the Dining Room (2nd Floor)
dining_room = Dungeon::Room.new(:dining_room, "DINING ROOM",
  "The DINING ROOM is the longest room in the house with a table that can seat 50 people. You " +
  "remember frugal dinners with the family and fabulous banquets when the family would host " +
  "foreign dignitaries and powerful peers of the realm. It has been many years, it seems, since " +
  "food has been served here. Now only dust and cobwebs blanket the fine china still laid out " +
  "perfectly on the table." +
  "\nThe door leads to the HALLWAY to the WEST.",
  2, { :east => :hallway6 })
raven_hall.add_room(dining_room)

# Add the Salon (2nd Floor)
salon = Dungeon::Room.new(:salon, "SALON",
"The SALON was where the women used to sit after dinner when the men were smoking in the " +
"smoking room downing bottles of expensive port. Some would talk about the difficulties of " +
"running their households, some their children who were always getting in trouble, and a few " +
"spoke of trying to make the world a better place. Those lively conversations long gone." +
"\nThe door leads to the HALLWAY to the EAST.",
2, { :west => :hallway6 })
raven_hall.add_room(salon)

puts  "You can hear owls hooting and unknown creatures flitting in the underbrush." +
      "\nA thick layer of fog has descended upon the valley making it difficult for" +
      "\nyour horse to find her footing. You pass a carriage house that has long" +
      "\nsince seen any passengers. You know the house is not far from here. You can" +
      "\nhear a wolf howl in distance as the ancient keep suddenly emerges from the fog" +
      "\nas if it were expecting you. The ancient brick and stone walls are covered in " +
      "\nivy. The house, Ravenscroft Keep, is the ancestral seat of the once proud and" +
      "\nancient Ravenscroft family. The last inhabitant of the house passed recently." +
      "\nThe last scion of an ancient and noble family, Albert Ravenscroft, was your" +
      "\nfriend from Oxford. You smile wryly as you remember your university days" +
      "\ntogether. The main line, now extinct, has passed to distant cousin and on his" +
      "\nbehalf are here to settle the estate. They have sent you here to determine if" +
      "\nthe estate is even worth keeping. You get off your horse, tie him to the gate," +
      "\nand remove your belongings from the saddle bags. As you walk up to the door the" +
      "\ngargoyles seem to peer down at you with contempt. You knock on the door using the" +
      "\nbronze door knocker. Irving, Albert's personal valet, answers the door and invites" +
      "\nyou in.\n" +
      "\n\"I've been expecting you, mister #{name}\" Irvine croaked as he takes your hat " +
      "and coat\ncaked stiff with dust and damp\nfrom the long, cold ride from London.\n" +
      "\"Hello Irving, It's been too long. It's been at least 15 years since I was last here " +
      "\nvisiting Bertie,\" I tried to say as cheerfully as possible.\n" +
      "\"How are the other staff: Elias, Edith, Bess, and Eliza?\" I asked.\n" +
      "\"They left directly after mister Ravenscroft passed.\" Irving said brusquely.\n" +
      "\"Shame. So, it's just you then?\" I asked.\n" +
      "\"It is, sir. I've also been instructed to give you free reign of the place.\" " +
      "He replied.\n" +
      "\"Thank you, Irving, I will be retiring to room and then look at the rest of the house.\"" +
      "\n\nYou've unpacked your bags and changed out of your riding clothes and decide" +
      "to start at\nthe entrance of the manse."

puts separator

puts  "                        FIRST FLOOR\n" +
      "                 ________________________\n" +
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

# Goes into the CLOAK ROOM
raven_hall.go(:east)

# Goes back into the HALLWAY
raven_hall.go(:west)

# Goes forward in the HALLWAY
raven_hall.go(:north)

# Goes up the STAIRS to the second floor HALLWAY
raven_hall.go(:up)

# Goes down the STAIRS to the first floor HALLWAY
raven_hall.go(:down)

# Goes forward in the HALLWAY
raven_hall.go(:north)

# Goes into the SERVICE ROOM
raven_hall.go(:east)

# Goes down to the KITCHEN
raven_hall.go(:down)

# This is just to make sure the level of the
# house that the character is on is correct
# puts "Level: #{kitchen.level}"
# puts "Level: #{conservatory.level}"
# puts "Level: #{smoking_room.level}"
