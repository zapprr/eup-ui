local outfits = {}
local creating_outfits = true

Citizen.CreateThread(function()

	if #outfit_files > 0 then
		for _, item in ipairs(outfit_files) do
			local content = LoadResourceFile(GetCurrentResourceName(), "presets/"..item)
			
			if string.find(item, ".json") then
				print("JSON File detected - will support these eventually")
			elseif string.find(item, ".ini") then
				ConvertIni(content)
				print("Loaded file " .. item)
			else
				print("^rError: " .. item .. " is not a supported file type.")
			end
		end

		creating_outfits = false
	else
		print("^rError: No outfit files declared in config.lua.")
	end
end)

function CleanUp(input, remove)
	input = string.gsub(input, "]", "")
	input = string.gsub(input, "[", "")
	input = string.gsub(input, "\t", "")
	input = string.gsub(input, " ", "")
	input = string.gsub(input, "=", "")

	if remove then
		input = string.gsub(input, remove, "")
	end

	if string.find(input, ":") then
		input = string.split(input, ":")

		local t1 = tonumber(input[1])
		local t2 = tonumber(input[2])

		return {t1, t2}
	else
		return input
	end
end)

function ConvertIni(content)
	local outfit = {}
	for line in content:gmatch("([^\n]*)\n?") do
		if not string.find(line, "//") then
			
			if string.sub(line, 1, 1) == "[" and string.find(line, "]" then
				if #outfit > 0 then
					table.insert(outfits, outfit)
				end
				outfit = {}
				outfit.Name = CleanUp(line)

			elseif string.sub(line, 1, 9) == "Category2" then
				outfit.Category2 = CleanUp(line, "Category2")
			elseif string.sub(line, 1, 9) == "Category3" then
				outfit.Category3 = CleanUp(line, "Category3")
			elseif string.sub(line, 1, 8) == "Category" then
				outfit.Category = CleanUp(line, "Category")

			elseif string.sub(line, 1, 3) == "Hat" then
				outfit.Hat = CleanUp(line, "Hat")
			elseif string.sub(line, 1, 7) == "Glasses" then
				outfit.Glasses = CleanUp(line, "Glasses")
			end
		end
	end
end


RegisterNetEvent('eup-ui:request')
AddEventHandler('eup-ui:request', function()
	while creating_outfits do
		Citizen.Wait(100)
	end

	TriggerClientEvent('eup-ui:retrieve', outfits)	
end)