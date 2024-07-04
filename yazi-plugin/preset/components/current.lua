Current = {
	_id = "current",
}

function Current:new(area, tab)
	return setmetatable({
		_area = area,
		_tab = tab,
		_folder = tab.current,
	}, { __index = self })
end

function Current:empty()
	local line
	if self._folder.files.filter then
		line = ui.Line("No filter results")
	else
		line = ui.Line(self._folder.stage == "loading" and "Loading..." or "No items")
	end

	return {
		ui.Paragraph(self._area, { line }):align(ui.Paragraph.CENTER),
	}
end

function Current:render()
	local files = self._folder.window
	if #files == 0 then
		return self:empty()
	end

	local items = {}
	for _, f in ipairs(files) do
		items[#items + 1] = ui.ListItem(File:children_render(f)):style(File:style(f))
	end

	return {
		ui.List(self._area, items),
		Folder:linemode(self._area, files),
	}
end

-- Mouse events
function Current:click(event, up)
	if up or event.is_middle then
		return
	end

	local f = self._folder
	if event.y > #f.window or not f.hovered then
		return
	end

	-- TODO
	ya.manager_emit("arrow", { event.y + f.offset - f.hovered.idx })
	if event.is_right then
		ya.manager_emit("open", {})
	end
end

function Current:scroll(event, step) ya.manager_emit("arrow", { step }) end

function Current:touch(event, step) end
