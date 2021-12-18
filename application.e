note
	description: "scoop_pathfinding application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
		local
			map: MAP
			bfs: BFS
		do
			create map.read_from_file ("map.txt")
			create bfs.for_map (map)
			bfs.solve
			check attached bfs.solution as sol then
				across
					sol is p
				loop
					print (p.row.out + " " + p.col.out + "%N")
				end
			end
		end

end
