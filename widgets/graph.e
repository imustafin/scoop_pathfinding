class
	GRAPH

inherit

	EV_PIXMAP

feature

	set_map (a_map: MAP)
		do
			map := a_map
		end

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
		end

end
