_menuPool = NativeUI.CreatePool()

menu_male = NativeUI.CreateMenu("EUP Menu", "", 0, 0)
_menuPool:Add(menu_male)

menu_female = NativeUI.CreateMenu("EUP Menu", "", 0, 0)
_menuPool:Add(menu_female)

outfits_male = {}
outfits_female = {}

Citizen.CreateThread(function()
	TriggerServerEvent('eup-ui:retrieve')
end)

RegisterNetEvent('eup-ui:retrieve')
AddEventHandler('eup-ui:retrieve', function(outfits)

end)