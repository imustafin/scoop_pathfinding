class
	BFS

create
	for_map

feature

	for_map (a_map: MAP)
		do
			map := a_map.deep_twin
		end

	map: MAP

	solution: detachable LINKED_LIST [POSITION]

feature

	Inf: INTEGER = 999999

	solve
		require
			not attached solution
		local
			cost: ARRAY2 [INTEGER]
			q: ARRAYED_QUEUE [POSITION]
			finished: BOOLEAN
			pos: POSITION
			cur_cost: INTEGER
			ps: ARRAY [POSITION]
			ex: DEVELOPER_EXCEPTION
			added: BOOLEAN
			sol: like solution
		do
			create cost.make_filled (Inf, map.cells.height, map.cells.width)
			create q.make (1)
			from
				cost [map.start.row, map.start.col] := 0
				q.extend (map.start)
			until
				finished or q.is_empty
			loop
				pos := q.item
				q.remove
				cur_cost := cost [pos.row, pos.col]
				if pos ~ map.finish then
					finished := True
				else
					across
						around (pos) is p
					loop
						if p.in_map (map) and then map.cells[p.row, p.col].free then
							if cost [p.row, p.col] = Inf then
								cost [p.row, p.col] := cur_cost + 1
								q.extend (p)
							end
						end
					end
				end
			end
			if not finished then
				create ex
				ex.set_description ("Couldn't find solution")
				ex.raise
			end
			create sol.make
			solution := sol
			from
				sol.extend (map.finish)
			until
				sol.first = map.start
			loop
				added := False
				across
					around (sol.first) is p
				loop
					if not added and then cost [p.row, p.col] = cost [sol.first.row, sol.first.col] - 1 then
						sol.put_front (p)
						added := True
					end
				end
			end
		ensure
			attached solution
		end

	around (p: POSITION): ARRAY [POSITION]
		do
			Result := <<{DIRECTION}.up.step (p), {DIRECTION}.down.step (p), {DIRECTION}.left.step (p), {DIRECTION}.right.step (p)>>
		end

end
