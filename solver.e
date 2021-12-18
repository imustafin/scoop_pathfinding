class
	SOLVER

create
	make

feature

	make (a_start, a_finish: POSITION)
		do
			start := a_start
			finish := a_finish
			status := "Ready"
		end

	start, finish: POSITION

	status: STRING

	solve (a_map: MAP)
		do
			status := "Solving"
			create bfs.for_map (a_map)
			check attached bfs as b then
				b.solve (start, finish)
			end
			status := "Solved"
		end

	bfs: detachable BFS

end
