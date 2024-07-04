Rail = {
	_id = "rail",
}

function Rail:new(chunks, tab)
	return setmetatable({
		_chunks = chunks,
		_tab = tab,
	}, { __index = self }):build()
end

function Rail:build()
	self._children = {
		Marker:new(self._chunks[1], self._tab.parent),
		Marker:new(self._chunks[2], self._tab.current),
	}
	return self
end

function Rail:render()
	local children = {}
	for _, child in ipairs(self._children) do
		children = ya.list_merge(children, ya.render_with(child))
	end
	return children
end

-- Mouse events
function Rail:click(event, up) end

function Rail:scroll(event, step) end

function Rail:touch(event, step) end
