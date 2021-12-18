expanded class
	POSITION

create
	make, default_create

feature

	make (a_row, a_col: INTEGER)
		do
			row := a_row
			col := a_col
		end

	row, col: INTEGER

	in_map(a_map: MAP): BOOLEAN
		do
			Result := (1 <= row and row <= a_map.cells.height) and (1 <= col and col <= a_map.cells.width)
		end

end
