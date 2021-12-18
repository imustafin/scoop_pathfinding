class
	APPLICATION

inherit

	EV_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		local
			window: MAIN_WINDOW
		do
			default_create
			create window
			window.close_request_actions.extend (agent destroy)
			launch
		end

end
