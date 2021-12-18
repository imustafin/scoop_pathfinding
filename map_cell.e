note
	description: "Summary description for {MAP_CELL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAP_CELL

create
	make

feature

	make (a_free: BOOLEAN)
		do
			free := a_free
		end

	free: BOOLEAN

end
