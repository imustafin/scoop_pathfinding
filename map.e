note
	description: "Summary description for {MAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAP

create
	read_from_file

feature

	read_from_file (a_filename: STRING)
		local
			file: PLAIN_TEXT_FILE
			row: LINKED_LIST [BOOLEAN]
			rows: LINKED_LIST [LINKED_LIST [BOOLEAN]]
			ex: DEVELOPER_EXCEPTION
			w, h: INTEGER
			had_empty_line: BOOLEAN
		do
			create rows.make
			from
				create row.make
				create file.make_open_read (a_filename)
				file.read_character
			until
				had_empty_line or file.exhausted
			loop
				inspect file.last_character

				when '.' then
					row.extend (True)
				when '#' then
					row.extend (False)
				when '_' then
					row.extend (True)
					create start.make (rows.count + 1, row.count)
				when '*' then
					row.extend (True)
					create finish.make (rows.count + 1, row.count)
				when '%N' then
					if row.is_empty then
						had_empty_line := True
					else
						rows.extend (row)
						create row.make
					end
				else
					create ex
					ex.set_description ("Unknown map char '" + file.last_character.out + "'")
					ex.raise
				end
				file.read_character
			end
			file.close
			h := rows.count
			w := -1
			across
				rows as r
			loop
				if w = -1 then
					w := r.item.count
				elseif w /= r.item.count then
					create ex
					ex.set_description ("Inconsistent map width, was " + w.out + " and another row is " + r.item.count.out + " at line " + r.cursor_index.out)
					ex.raise
				end
			end
			create cells.make_filled (create {MAP_CELL}.make (False), h, w)
			across
				rows as i
			loop
				across
					i.item as j
				loop
					cells [i.cursor_index, j.cursor_index] := create {MAP_CELL}.make (j.item)
				end
			end
		end

feature

	cells: ARRAY2 [MAP_CELL]

	start, finish: POSITION

end
