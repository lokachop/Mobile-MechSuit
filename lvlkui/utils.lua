LvLKUI = LvLKUI or {}

local _tblPrintAdd = 2
function LvLKUI.PrintTable(tbl, elevStr)
	elev = elev or 0
	local spacing = elevStr or ""

	for k, v in pairs(tbl) do
		if type(v) == "table" then
			print(spacing .. "[" .. tostring(tbl) .. "]")

			local newElevStr = spacing .. "|" .. string.rep(" ", _tblPrintAdd)
			LvLKUI.PrintTable(v, newElevStr)
		else
			print(spacing .. "[" .. k .. "]: " .. tostring(v))
		end
	end
end

local function inrange(x, min, max)
	return (x >= min) and (x <= max)
end

function LvLKUI.Inrange2D(pos, minPos, maxPos)
	return inrange(pos[1], minPos[1], maxPos[1]) and inrange(pos[2], minPos[2], maxPos[2])
end