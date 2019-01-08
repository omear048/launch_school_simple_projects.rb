require 'pry'

#Twenty-One 
  #  ruby OO_Twenty_One_1_1.rb

=begin
  Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.

  Here is an overview of the game:
  - Both participants are initially dealt 2 cards from a 52-card deck.
  - The player takes the first turn, and can "hit" or "stay".
  - If the player busts, he loses. If he stays, it's the dealer's turn.
  - The dealer must hit until his cards add up to at least 17.
  - If he busts, the player wins. If both player and dealer stays, then the highest total wins.
  - If both totals are equal, then it's a tie, and nobody wins. 
=end

module Generic_Methods
  CARD_VALUE_HASH = {"2D" =>2, "2H"=>2, "2C"=>2, "2S"=>2,
                 "3D"=>3, "3H"=>3, "3C"=>3, "3S"=>3, 
                 "4D"=>4, "4H"=>4, "4C"=>4, "4S"=>4,
                 "5D"=>5, "5H"=>5, "5C"=>5, "5S"=>5,
                 "6D"=>6, "6H"=>6, "6C"=>6, "6S"=>6, 
                 "7D"=>7, "7H"=>7, "7C"=>7, "7S"=>7,
                 "8D"=>8, "8H"=>8, "8C"=>8, "8S"=>8, 
                 "9D"=>9, "9H"=>9, "9C"=>9, "9S"=>9,
                 "10D"=>10, "10H"=>10, "10C"=>10, "10S"=>10,
                 "JD"=>10, "JH"=>10, "JC"=>10, "JS"=>10,
                 "QD"=>10, "QH"=>10, "QC"=>10, "QS"=>10, 
                 "KD"=>10, "KH"=>10, "KC"=>10, "KS"=>10,
                 "AD"=>11, "AH"=>11, "AC"=>11, "AS"=>11}

  def hand_value(user)
    total = 0
    user.hand.each do |card| 
      total += CARD_VALUE_HASH[card]
    end
    total 
  end
end

class Player
  include Generic_Methods
  attr_reader :hand, :total

  def initialize
    @hand = []
    @total = 0
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end

  def ace_after_bust(hand)
    hand.map! do |card|
      if card != "AH" || "AC" || "AD" || "AS"
        card = card
      elsif card == "AH" || "AC" || "AD" || "AS"
        card = "2H"
      end
    end
  end
end

class Dealer
  include Generic_Methods
  attr_reader :hand 

  def initialize
    @hand = []
    # seems like very similar to Player... do we even need this?
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end

  def ace_after_bust
     
  end
end

class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Deck
  attr_reader :shuffled_deck

  CARD_DECK = ["2D", "2H", "2C", "2S",
               "3D", "3H", "3C", "3S", 
               "4D", "4H", "4C", "4S",
               "5D", "5H", "5C", "5S",
               "6D", "6H", "6C", "6S", 
               "7D", "7H", "7C", "7S",
               "8D", "8H", "8C", "8S", 
               "9D", "9H", "9C", "9S",
               "10D", "10H", "10C", "10S",
               "JD", "JH", "JC", "JS",
               "QD", "QH", "QC", "QS", 
               "KD", "KH", "KC", "KS",
               "AD", "AH", "AC", "AS"]

  def initialize
    @shuffled_deck = CARD_DECK.shuffle
  end

  def deal
    # does the dealer or the deck deal?

  end
end

class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  include Generic_Methods
  CARD_VALUE_HASH = {"2D" =>2, "2H"=>2, "2C"=>2, "2S"=>2,
                   "3D"=>3, "3H"=>3, "3C"=>3, "3S"=>3, 
                   "4D"=>4, "4H"=>4, "4C"=>4, "4S"=>4,
                   "5D"=>5, "5H"=>5, "5C"=>5, "5S"=>5,
                   "6D"=>6, "6H"=>6, "6C"=>6, "6S"=>6, 
                   "7D"=>7, "7H"=>7, "7C"=>7, "7S"=>7,
                   "8D"=>8, "8H"=>8, "8C"=>8, "8S"=>8, 
                   "9D"=>9, "9H"=>9, "9C"=>9, "9S"=>9,
                   "10D"=>10, "10H"=>10, "10C"=>10, "10S"=>10,
                   "JD"=>10, "JH"=>10, "JC"=>10, "JS"=>10,
                   "QD"=>10, "QH"=>10, "QC"=>10, "QS"=>10, 
                   "KD"=>10, "KH"=>10, "KC"=>10, "KS"=>10,
                   "AD"=>11, "AH"=>11, "AC"=>11, "AS"=>11}

  def initialize #I need to make objects of the classes available for use within the Game instance by assigning them to instance variables
    @dealer = Dealer.new
    @player = Player.new 
    @deck = Deck.new 
  end

  def deal_cards #The player and dealer are dealt two cards
    #deck > @shuffled_deck #player > hand #dealer > hand 
    2.times do 
      @player.hand << @deck.shuffled_deck.pop && @dealer.hand << @deck.shuffled_deck.pop
    end
  end

  def busted?(user)
    hand_value(user) > 21
  end

  def round_draw?(player, dealer)
    hand_value(@player) == hand_value(@dealer)
  end

  def player_turn
    loop do 
      puts "You have a total of #{hand_value(@player)}. Would you like to hit or stay? ('hit' or 'stay')"
      choice = gets.chomp
      if choice == "stay"
        puts "Player stayed for a total of #{hand_value(@player)} - #{@player.hand}"
        break
      elsif choice == "hit"
        draw = nil
        1.times do 
          draw = @deck.shuffled_deck.pop
          @player.hand << draw
          @player.ace_after_bust(@player.hand)
          p @player.hand
          if busted?(@player)
            puts "Player busted with #{hand_value(@player)}"
          else
            puts "Player drew a #{draw} for a total of #{hand_value(@player)} - #{@player.hand}"
          end
        end
        break if busted?(@player)
      end 
    end   
  end

  def dealer_turn 
    #hit until the dealer's hand is over 17
    if hand_value(@player) > 21
      nil 
    else 
      until hand_value(@dealer) >= 17
        @dealer.hand << @deck.shuffled_deck.pop
      end
    end

    if busted?(@dealer)
      puts "Dealer busted with #{hand_value(@dealer)}"
    else
      puts "Dealer total is #{hand_value(@dealer)} - #{@dealer.hand}"
    end
  end

  def show_result
    if busted?(@player)
      puts "Player busted, Dealer wins!"
    elsif busted?(@dealer)
      puts "Dealer busted, Player wins!"
    elsif round_draw?(@player, @dealer)
      puts "Push. Nobody wins!"
    else
      if hand_value(@player) > hand_value(@dealer) 
        puts "Player won! Player = #{hand_value(@player)} : Dealer = #{hand_value(@dealer)}" 
      else
        "Dealer won! Dealer = #{hand_value(@dealer)} : Player = #{hand_value(@player)}"
      end
    end
  end



  def show_initial_cards
    puts "Player has #{@player.hand[0]} and #{@player.hand[1]} for a total of #{hand_value(@player)}"
    puts "Dealer has #{@player.hand[1]}"
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

  #  p @player.hand
   # p @dealer.hand 
    #p @deck.shuffled_deck

Game.new.start



















