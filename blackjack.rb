
cards = [[2, "Heart"],[2, "Diamond"],[2, "Clover"],[2, "Spade"],
		[3, "Heart"],[3, "Diamond"],[3, "Clover"],[3, "Spade"],
		[4, "Heart"],[4, "Diamond"],[4, "Clover"],[4, "Spade"],
		[5, "Heart"],[5, "Diamond"],[5, "Clover"],[5, "Spade"],
		[6, "Heart"],[6, "Diamond"],[6, "Clover"],[6, "Spade"],
		[7, "Heart"],[7, "Diamond"],[7, "Clover"],[7, "Spade"],
		[8, "Heart"],[8, "Diamond"],[8, "Clover"],[8, "Spade"],
		[9, "Heart"],[9, "Diamond"],[9, "Clover"],[9, "Spade"],
		[10, "Heart"],[10, "Diamond"],[10, "Clover"],[10, "Spade"],
		["Jack", "Heart"],["Jack", "Diamond"],["Jack", "Clover"],["Jack", "Spade"],
		["Queen", "Heart"],["Queen", "Diamond"],["Queen", "Clover"],["Queen", "Spade"],
		["King", "Heart"],["King", "Diamond"],["King", "Clover"],["King", "Spade"],
		["Ace", "Heart"],["Ace", "Diamond"],["Ace", "Clover"],["Ace", "Spade"]]


def displayHand(hand)
	hand.each {|card| puts card[0].to_s + " " + card[1].to_s}
end

def countingPoints(hand)
	point = 0
	ace = 0
	hand.each do |card|
		if card[0].to_s.start_with?("A","K","Q","J","10")
			point += 10
		else
			point += card[0]
		end

		if card[0] == "Ace"
			ace += 1
		end
	end

	while ace > 0 
		if point <= 20 && ace >= 1
			point += 1
			ace -= 1
		elsif point > 21 && ace >= 1
			point -= 9
			ace -= 1
		end
	end
	return point

end

def player(hand, cards, dealer = false)
	
	point = countingPoints(hand)

	while point <= 15 && dealer == true
		puts "Dealer drawing"
		drawResult = draw(cards, hand)
		cards = drawResult[0]
		hand = drawResult[1]

		point = countingPoints(hand)
		puts "#{hand[-1][0].to_s}  #{hand[-1][1].to_s}", ""
	end

	return point
end


def draw(cards, hand)
	randomNumber = rand(cards.length)
	randomDraw = cards[randomNumber]
	cards.delete_at(randomNumber)
	hand << randomDraw
	return [cards, hand]
end



def comparingPoints(playerPoint, dealerPoint)
	puts "Player Point: #{playerPoint.to_s}",
		 "Dealer Point: #{dealerPoint.to_s}"

	if playerPoint > 21 && dealerPoint > 21 
		puts "Draw! Both dealer and player bust"
		return "Draw"
	elsif playerPoint == dealerPoint
		puts "Draw, both player and dealer got same point"
		return "Draw"
	elsif playerPoint > 21
		puts "Dealer Won!"
		return "Dealer"
	elsif dealerPoint > 21
		puts "Player Won!"
		return "Player"
	elsif playerPoint > dealerPoint
		puts "Player Won!"
		return "Player"
	else
		puts "Dealer Won!"
		return "Dealer"
	end

end

def game(cards)
	dealerHand = []
	playerHand = []
	loop do
		drawResult = draw(cards, playerHand)
		cards = drawResult[0]
		playerHand = drawResult[1]

		if dealerHand.count < 2
			drawResult = draw(cards, dealerHand)
			cards = drawResult[0]
			dealerhand = drawResult[1]
		end

		if playerHand.count == 2

			if  playerHand[1][0].to_s.start_with?("A", "K", "Q", "J", "10") && playerHand[0][0] == "Ace" || 
				playerHand[0][0].to_s.start_with?("A", "K", "Q", "J", "10")  && playerHand[1][0] == "Ace"
				
				playerBlackJack = true
			end
			if  dealerhand[1][0].to_s.start_with?("A", "K", "Q", "J", "10") && dealerhand[0][0] == "Ace" || 
				dealerhand[0][0].to_s.start_with?("A", "K", "Q", "J", "10")  && dealerhand[1][0] == "Ace"
				
				dealerBlackJack = true
			end

			if playerBlackJack & dealerBlackJack
				puts "Dealer Hand: "
				displayHand(playerHand)
				puts "Player Hand: "
				displayHand(dealerHand)
				puts "Draw! Both dealer and player got BlackJack"
				return "Draw"
			elsif playerBlackJack
				displayHand(playerHand)
				puts "Congratulation! BlackJack"	
				return "Player"
			elsif dealerBlackJack
				displayHand(dealerHand)
				puts "Dealer got BlackJack, House Wins!"
				return "Dealer"
			end
		end

		if playerHand.count >= 2
			displayHand(playerHand)
			puts "Hit? Yes or no."
			answer = gets.chomp.downcase

			if answer.start_with? "n"
				return [playerHand, dealerHand, cards]
			elsif answer.start_with? "y"
				puts "","Here's another card","---------"
			end
		end
	end
end


def start_game(cards1)
	playerScore = 0
	dealerScore = 0
	drawScore = 0
	cards = cards1
	puts "", ">>>>>Match Begin<<<<<<", ""
	loop do
		bothHands = game(cards)

		if bothHands == "Player"
			playerScore +=1
		elsif bothHands == "Dealer"
			dealerScore +=1
		elsif bothHands == "Draw"
			drawScore +=1
		else
			playerHand = bothHands[0]
			dealerHand = bothHands[1]
			cards = bothHands[2]

			puts "Player Hand: ",
			"==============="
			displayHand(playerHand)
			puts "***************", ""
			puts "Dealer Hand: ",
			"==============="
			displayHand(dealerHand)
			puts "***************", ""

			dealerPoint = player(dealerHand, cards, dealer = true)
			playerPoint = player(playerHand, cards)


			mathResult = comparingPoints(playerPoint,dealerPoint)
		end

		if mathResult == "Player"
			playerScore += 1
		elsif mathResult == "Dealer"
			dealerScore += 1
		elsif mathResult == "Draw"
			drawScore += 1
		end

		puts "Continue game y/n?"
		answer = gets.chomp.downcase.to_s

		if answer.start_with? "n"
			puts "******Final Score*******",
				"Player Score: #{playerScore.to_s}",
				"Dealer Score: #{dealerScore.to_s}", 
				"Draw Score: #{drawScore.to_s}", ""
			break
		elsif answer.start_with? "y"
			puts "=*=*=*=*=*=*=*=*=*=*", 
				"Player Score: #{playerScore.to_s}",
				"Dealer Score: #{dealerScore.to_s}", 
				"Draw Score: #{drawScore.to_s}", ""
		end

		if cards.count < 10
			cards = cards1
		end

	end
end

start_game(cards)






