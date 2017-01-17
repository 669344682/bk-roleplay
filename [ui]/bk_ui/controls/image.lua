local function init(x, y, width, height, parent, texture)
    local control = getControlBase(x, y, width, height, parent)
    control.texture = texture
    control.color = tocolor(255, 255, 255)
    return control
end

local function draw(control, x, y)
    if control.texture then 
        dxDrawImage(x, y, control.width, control.height, control.texture, 0, 0, 0, control.color)
    end
end

addControl("image", {init = init, draw = draw})