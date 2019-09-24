local dataObject = LibStub("LibDataBroker-1.1"):NewDataObject("Ammo", {type = "data source", text = ""})

local CTimerAfter = C_Timer.After
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemTexture = GetInventoryItemTexture

local ammoSlotId = GetInventorySlotInfo(AMMOSLOT);

local function CheckAmmo()
	local texture = GetInventoryItemTexture("player", ammoSlotId)

	if (texture ~= nil) then
		local amount = tostring(GetInventoryItemCount("player", ammoSlotId))

		dataObject.text = amount
		dataObject.value = amount
		dataObject.icon = texture
	else
		dataObject.text = ""
		dataObject.value = nil
		dataObject.icon = nil
	end

	-- update each second
	CTimerAfter(1, CheckAmmo)
end

CheckAmmo()
