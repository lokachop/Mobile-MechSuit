LvLKUI = LvLKUI or {}

LvLKUI.Themes = LvLKUI.Themes or {}
function LvLKUI.NewTheme(name, data)
    LvLKUI.Themes[name] = {
        ["primary"] = data.primary or {0, 1, 0},
        ["secondary"] = data.secondary or {0.1, 0.1, 0.1},
        ["highlight"] = data.highlight or {1, 0, 0},
        ["font"] = data.font or nil,
    }
    local ptr = LvLKUI.Themes[name]
    ptr._fontObj = love.graphics.newFont(ptr.font or 14)

    print("LvLKUI: New theme! \"" .. name .. "\"")
end

LvLKUI.NewTheme("base", {
    ["primary"] = {0.3, 0.3, 0.4},
    ["secondary"] = {0.1, 0.1, 0.125},
    ["highlight"] = {0.95, 0.95, 1},
})