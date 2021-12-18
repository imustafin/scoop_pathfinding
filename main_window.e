class
	MAIN_WINDOW

inherit

	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize,
			is_in_default_state
		end

create
	default_create

feature {NONE}

	main_container: EV_HORIZONTAL_BOX

	right_stack: EV_VERTICAL_BOX

	solve_button: EV_BUTTON

	graph: GRAPH

	solvers: EV_MULTI_COLUMN_LIST

	create_interface_objects
		do
			create right_stack
			create main_container
			create graph
			create solvers
			create solve_button.make_with_text ("Solve")
		end

	assemble_containers
		do
			main_container.extend (graph)
			right_stack.extend (solve_button)
			right_stack.extend (solvers)
			main_container.extend (right_stack)
			extend (main_container)
		end

	initialize
		local
			map: MAP
		do
			Precursor {EV_TITLED_WINDOW}
			assemble_containers
			show
			set_title ("SCOOP Pathfinding")
			set_minimum_size (1000, 1000)
			graph.set_size (500, 500)
			create map.read_from_file ("map.txt")
			graph.set_map (map)
			graph.draw_map
		end

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

end
