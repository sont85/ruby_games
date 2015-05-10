

def Hanoi_Tower(tower)
	loop do
		puts "*****Move all numbers to tower 3"
		puts "Slot1: " + tower[0].to_s 
		puts "Slot2: " + tower[1].to_s
		puts "Slot3: " + tower[2].to_s 

		puts "Enter 1, 2, or 3 to remove numbers from slot\n"
		removeTower = gets.chomp.to_i - 1

		puts "Enter 1, 2,or 3 to add numbers to slot"
		pickTower = gets.chomp.to_i - 1

		if removeTower > 2  || removeTower < 0 || pickTower > 2 || pickTower < 0
			puts "=====must be 1, 2, or 3====="
		else
			unless tower[removeTower].empty?
				if tower[pickTower].empty?
					tower[pickTower] << tower[removeTower].pop
				elsif tower[removeTower].last < tower[pickTower].last
					tower[pickTower] << tower[removeTower].pop
				else
					puts "=====Must add to bigger number====="
				end

				if tower[0].empty? && tower[1].empty?
					puts "******* CONGRATULATION *********"
					break
				end
			end
		end
	end
end

Hanoi_Tower([[3,2,1], [], []])