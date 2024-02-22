LoveJam = LoveJam or {}
LvLK3D = LvLK3D or {}
LvLKUI = LvLKUI or {}
LKEdit = LKEdit or {}

function LKEdit.SaveLevel(name)
    local writeStr = {}
    local cLevel = LKEdit.CurrLevel
    writeStr[#writeStr + 1] = "LoveJam = LoveJam or {}"
    writeStr[#writeStr + 1] = "LvLK3D = LvLK3D or {}"


    writeStr[#writeStr + 1] = "local levelData = {"
    writeStr[#writeStr + 1] = "\tname = \"" .. cLevel.name .. "\","
    writeStr[#writeStr + 1] = "\tnextLevel = \"" .. cLevel.nextLevel .. "\","
    writeStr[#writeStr + 1] = "\tisNoVis = " .. tostring(cLevel.isNoVis) .. ","
    writeStr[#writeStr + 1] = "\tgW = " .. cLevel.gW .. ","
    writeStr[#writeStr + 1] = "\tgH = " .. cLevel.gH .. ","
    writeStr[#writeStr + 1] = "\tgOX = " .. cLevel.gOX .. ","
    writeStr[#writeStr + 1] = "\tgOY = " .. cLevel.gOY .. ","
    writeStr[#writeStr + 1] = "\tdeco = {"
    for k, v in pairs(cLevel.deco) do
        writeStr[#writeStr + 1] = "\t\t[" .. k .. "] = {"
        writeStr[#writeStr + 1] = "\t\t\tpos = Vector(" .. v.pos[1] .. ", " .. v.pos[2] .. ", " .. v.pos[3] .. "),"
        writeStr[#writeStr + 1] = "\t\t\tang =  Angle(" .. v.ang[1] .. ", " .. v.ang[2] .. ", " .. v.ang[3] .. "),"
        writeStr[#writeStr + 1] = "\t\t\tscl = Vector(" .. v.scl[1] .. ", " .. v.scl[2] .. ", " .. v.scl[3] .. "),"
        writeStr[#writeStr + 1] = "\t\t\tmat = \"" .. v.mat .. "\","
        writeStr[#writeStr + 1] = "\t\t\tmdl = \"" .. v.mdl .. "\","
        writeStr[#writeStr + 1] = "\t\t\tfullbright = " .. tostring(v.fullbright) .. ","
        writeStr[#writeStr + 1] = "\t\t\tshadow = " .. tostring(v.shadow) .. ","
        writeStr[#writeStr + 1] = "\t\t\tshaded = " .. tostring(v.shaded) .. ","
        writeStr[#writeStr + 1] = "\t\t\tuvScaleX = " .. v.uvScaleX .. ","
        writeStr[#writeStr + 1] = "\t\t\tuvScaleY = " .. v.uvScaleY .. ","
        writeStr[#writeStr + 1] = "\t\t},"
    end
    writeStr[#writeStr + 1] = "\t},"
    writeStr[#writeStr + 1] = "\tlights = {"
    for k, v in pairs(cLevel.lights) do
        writeStr[#writeStr + 1] = "\t\t[" .. k .. "] = {"
        writeStr[#writeStr + 1] = "\t\t\tpos = Vector(" .. v.pos[1] .. ", " .. v.pos[2] .. ", " .. v.pos[3] .. "),"
        writeStr[#writeStr + 1] = "\t\t\tint = " .. v.int .. ","
        writeStr[#writeStr + 1] = "\t\t\tcol = Vector(" .. math.floor(v.col[1] * 255) .. ", " .. math.floor(v.col[2] * 255) .. ", " .. math.floor(v.col[3] * 255) .. "),"
        writeStr[#writeStr + 1] = "\t\t},"
    end
    writeStr[#writeStr + 1] = "\t},"
    writeStr[#writeStr + 1] = "\ttiles = {"
    for k, v in pairs(cLevel.tiles) do
        local miniconcat = {}
        for k2, v2 in pairs(v) do
            miniconcat[#miniconcat + 1] = "[" .. k2 .. "] = " .. v2 .. ", "
        end
        writeStr[#writeStr + 1] = "\t\t["  .. k .. "] = {" .. table.concat(miniconcat, "") .. "},"
    end
    writeStr[#writeStr + 1] = "\t},"


    writeStr[#writeStr + 1] = "}"
    writeStr[#writeStr + 1] = ""
    writeStr[#writeStr + 1] = "LoveJam.DeclareLevel(\"" .. cLevel.name .. "\", levelData)"

    local f_str = table.concat(writeStr, "\n")
    love.filesystem.write("lovejam_2024_map_" .. cLevel.name .. ".txt", f_str)
end