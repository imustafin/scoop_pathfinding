class
	GRAPH

inherit

	EV_PIXMAP

feature

	set_map (a_map: MAP)
		do
			map := a_map
		end

	set_solution(a_solution: detachable LINKED_LIST [POSITION])
		do
			solution := a_solution
		end

	solution: detachable LINKED_LIST [POSITION]

	map: detachable MAP

	draw_map
		local
			s: INTEGER
		do
			if attached map as m then
				clear
				s := (width // m.cells.width).min (height // m.cells.height)
				across
					1 |..| m.cells.width is i
				loop
					across
						1 |..| m.cells.height is j
					loop
						if not m.cells [j, i].free then
							fill_rectangle ((i - 1) * s, (j - 1) * s, s, s)
						else
							draw_rectangle ((i - 1) * s, (j - 1) * s, s, s)
						end
					end
				end
			end
			if attached solution as sol then
				across
					sol as step
				loop
					draw_text ((step.item.col - 1) * s + (s // 2), (step.item.row - 1) * s + (s // 2), step.cursor_index.out)
				end
			end
		end

end
