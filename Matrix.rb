
def matrix(rows)

	puts "[?, ?, ?]",
		 "[?, ?, ?]",
		 "[?, ?, ?]"
	attempt = 1

	loop do
		puts "select the row between 1, 2, 3"
		rowChoice = gets.chomp.to_i - 1 #minus 1 to match index num


		puts "select the column 1, 2, or 3"
		colChoice = gets.chomp.to_i - 1

		row = rows[rowChoice] || "invalid" #assign false if chosen row array index is nil


		if row 
			chosen = rows[rowChoice][colChoice]  #assiging the chose row and col
		end
		if chosen == "invalid" || chosen == nil #if chosen row and col index is nil print invalid
			puts "invalid input"
		end

		if chosen == "Winner" 
			puts "Winner"
			break
		elsif chosen == "miss"
			puts "Miss"
		end

		if attempt == 3
			puts "That's 3 tries, Game Over!"
			break
		end
		attempt +=1
	end

end



sets = [[["miss", "miss", "miss"],
		["miss", "miss", "Winner"],
		["miss", "miss", "miss"]],

		[["Winner", "miss", "miss"],
		["miss", "miss", "miss"],
		["miss", "miss", "miss"]],

		[["miss", "miss", "miss"],
		["miss", "Winner", "miss"],
		["miss", "miss", "miss"]],

		[["miss", "miss", "miss"],
		["Winner", "miss", "miss"],
		["miss", "miss", "miss"]]]
rows = sets.sample

matrix(rows)