Marker = {
	_id = "marker",
}

function Marker:new(area, folder)
	return setmetatable({
		_area = area,
		_folder = folder,
	}, { __index = self })
end

function Marker:render()
	return {
		ui.Bar(self._area, ui.Bar.LEFT):symbol(THEME.manager.border_symbol):style(THEME.manager.border_style),
	}
end

-- Mouse events
function Marker:click(event, up) end

function Marker:scroll(event, step) end

function Marker:touch(event, step) end
