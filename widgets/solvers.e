class
	SOLVERS

inherit

	EV_MULTI_COLUMN_LIST

create
	make

feature

	make
		do
			create solvers.make (0)
			default_create
			set_column_titles ({ARRAY [READABLE_STRING_GENERAL]} <<"A", "B", "Status">>)
		end

	generate_and_solve (a_map: MAP)
		do
			map := a_map
			generate_solvers
			solve_all
		end

	generate_solvers
		require
			attached map
		local
			solver: SOLVER
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			check attached map as m then
				solvers.wipe_out
				wipe_out
				across
					1 |..| m.cells.height is start_row
				loop
					across
						1 |..| m.cells.width is start_col
					loop
						across
							start_row |..| m.cells.height is finish_row
						loop
							across
								(if finish_row = start_row then start_col + 1 else 1 end) |..| m.cells.width is finish_col
							loop
								if m.cells [start_row, start_col].free and m.cells [finish_row, finish_col].free then
									create solver.make (create {POSITION}.make (start_row, start_col), create {POSITION}.make (finish_row, finish_col))
									create row
									row.extend (solver.start.out)
									row.extend (solver.finish.out)
									row.extend (solver.status)
									solvers.extend ([solver, row])
									extend (row)
								end
							end
						end
					end
				end
			end
		end

	solve_all
		require
			attached map
		do
			check attached map as m then
				across
					solvers is t
				loop
					t.row [3] := "Solving"
					t.solver.solve (m)
					t.row [3] := "Solved"
				end
			end
		end

	map: detachable MAP

	solvers: ARRAYED_LIST [TUPLE [solver: SOLVER; row: EV_MULTI_COLUMN_LIST_ROW]]

end
