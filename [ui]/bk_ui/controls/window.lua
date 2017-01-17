local frameSize = 3
local headerSize = 20

local function init(x, y, width, height, parent, text, showHeader)
	local control = getControlBase(x, y, width, height, parent)
	if not text then
		text = ""
	end
	control.text = text

	if showHeader == nil then
		showHeader = true
	end
	control.headerSize = headerSize
	if not showHeader then
		control.headerSize = 0
		control.text = ""
	end
	return control
end

local function draw(control, x, y)
	dxDrawRectangle(x - frameSize - 1, y - control.headerSize - frameSize - 1, control.width + frameSize*2 + 1, control.height + control.headerSize + frameSize*2 + 1, colors.window.border)
	dxDrawRectangle(x - frameSize, y - control.headerSize - frameSize, control.width + frameSize*2, control.height + control.headerSize + frameSize*2, colors.window.frame)
	dxDrawRectangle(x, y, control.width, control.height, colors.window.background)
	drawText(control.text, x, y - control.headerSize - frameSize, control.width, control.headerSize + frameSize, colors.window.header_text, "title")
end

addControl("window", {init = init, draw = draw})