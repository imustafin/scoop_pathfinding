expanded class
	DIRECTION

inherit
	ANY
	export
		{NONE}
		default_create
	end

create
	make, default_create

feature

	Up: DIRECTION
		once
			create Result.make (-1, 0)
		ensure
			class
		end

	Down: DIRECTION
		once
			create Result.make (1, 0)
		ensure
			class
		end

	Left: DIRECTION
		once
			create Result.make (0, -1)
		ensure
			class
		end

	Right: DIRECTION
		once
			create Result.make (0, 1)
		ensure
			class
		end

feature
	step(a_pos: POSITION): POSITION
		do
			create Result.make(a_pos.row + dr, a_pos.col + dc)
		end

feature {NONE}

	make (a_dr, a_dc: INTEGER)
		do
			dr := a_dr
			dc := a_dc
		end

	dr, dc: INTEGER

end
