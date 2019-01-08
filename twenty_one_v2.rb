# Assignment: Twenty-One
#shift tab to move code to the left 

require 'pry' # exit-program

card_deck = { '2d' => 2, '2h' => 2, '2s' => 2, '2c' => 2,
              '3d' => 3, '3h' => 3, '3s' => 3, '3c' => 3,
              '4d' => 4, '4h' => 4, '4s' => 4, '4c' => 4,
              '5d' => 5, '5h' => 5, '5s' => 5, '5c' => 5,
              '6d' => 6, '6h' => 6, '6s' => 6, '6c' => 6,
              '7d' => 7, '7h' => 7, '7s' => 7, '7c' => 7,
              '8d' => 8, '8h' => 8, '8s' => 8, '8c' => 8,
              '9d' => 9, '9h' => 9, '9s' => 9, '9c' => 9,
              '10d' => 10, '10h' => 10, '10s' => 10, '10c' => 10,
              'Jd' => 10, 'Jh' => 10, 'Js' => 10, 'Jc' => 10,
              'Qd' => 10, 'Qh' => 10, 'Qs' => 10, 'Qc' => 10,
              'Kd' => 10, 'Kh' => 10, 'Ks' => 10, 'Kc' => 10,
              'Ad' => 11, 'Ah' => 11, 'As' => 11, 'Ac' => 11 }

# TV: Implement this method
def busted?(cards)

end

# TV: Implement this method
def blackjack?(cards)

end

# TV: Implement this method
def score(cards)

end

def player_won?

end

def dealer_won?

end

# TV: Implement this method
def deal_card!(cards)

end

# KO: Check hand for aces 
def ace_check?(players_cards)
  players_cards.key?('Ad' || 'Ah' || 'As' || 'Ac')
end


loop do
  players_hand = {}
  dealers_hand = {}

  loop do # Dealing Out The First Two Cards  #No Loop 
    # Player first card
    card = card_deck.keys.sample
    players_hand[card] = card_deck.delete(card)

    # Players second card
    card = card_deck.keys.sample
    players_hand[card] = card_deck.fetch(card)
    card_deck.delete_if { |key, _value| key == card }

    # Computers first card
    card = card_deck.keys.sample
    dealers_hand[card] = card_deck.fetch(card)
    card_deck.delete_if { |key, _value| key == card }

    # Computers second card
    card = card_deck.keys.sample
    dealers_hand[card] = card_deck.fetch(card)
    card_deck.delete_if { |key, _value| key == card }
    break
  end

  puts "Dealer has: #{dealers_hand.keys[0]} and ?"
  dealers_total = dealers_hand.values.inject(:+)    

  puts "You have: #{players_hand.keys[0]} and #{players_hand.keys[1]}"
  players_total = players_hand.values.inject(:+)
  p players_total

  loop do
    puts "Hit or stay? (h or s)"
    answer = gets.chomp

    # Add the blackjack option - Does the player or delaer have BJ

    if answer.start_with?("h")
      card = card_deck.keys.sample
      players_hand[card] = card_deck.fetch(card)
      card_deck.delete_if { |key, _value| key == card }

      players_total = players_hand.values.inject(:+)

      if players_total > 21 # How can I make this a method? What about ace_check?(players_total, players_hand)
        if players_hand.key?('Ad' || 'Ah' || 'As' || 'Ac')
          players_hand.each do |key, value|
            if key == 'Ad' and value == 11
              players_hand[key] = 1
              break
            elsif key == 'Ah' and value == 11
              players_hand[key] = 1
              break
            elsif key == 'As' and value == 11
              players_hand[key] = 1
              break
            elsif key == 'Ac' and value == 11
              players_hand[key] = 1
              break
            end
          end
        end
      end

      =begin
      if ace_check?(players_hand)
        players_hand.each do |key, value|
            if key == 'Ad' and value == 11
              players_hand[key] = 1
              break
            elsif key == 'Ah' and value == 11
              players_hand[key] = 1
              break
            elsif key == 'As' and value == 11
              players_hand[key] = 1
              break
            elsif key == 'Ac' and value == 11
              players_hand[key] = 1
              break
            end
          end
      end
      =end 

      players_total = players_hand.values.inject(:+)

      p players_hand

      if players_total > 21
        puts "You busted Mother Fucker! #{players_total}"
        break
      else
        puts "You have #{players_total}"
      end
    else 
      break
    end
  end

  puts "Dealers turn: You have #{players_total} & Dealer has #{dealers_total}"

  loop do
    if players_total < 22
      if dealers_total <= players_total
        if dealers_total > 16
          break
        end
        if dealers_total < 17
          card = card_deck.keys.sample
          dealers_hand[card] = card_deck.fetch(card)
          # binding.pry
          card_deck.delete_if { |key, _value| key == card }
          p dealers_hand
          dealers_total = dealers_hand.values.inject(:+)
        end
      end
      if dealers_total > players_total
        break
      end
    end
    if players_total > 21
      break
    end
  end

  puts "Player busted, Dealer wins!" if players_total > 21
  puts "Dealer busted, Player wins! #{dealers_total} vs. #{players_total}" if dealers_total > 21
  puts "Player wins! #{players_total} vs. #{dealers_total}" if players_total <  22 && players_total > dealers_total
  puts "Dealer wins! #{dealers_total} vs. #{players_total}" if dealers_total < 22 && dealers_total > players_total
  puts "Push! #{dealers_total} vs. #{players_total}" if dealers_total == players_total

  players_hand.clear
  dealers_hand.clear
  break if card_deck.keys.count < 10
end

puts "End of shoot. Thanks for Playing Dick Face!"



