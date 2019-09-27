local frame = CreateFrame("Frame")

local CTimerAfter = C_Timer.After
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemTexture = GetInventoryItemTexture

local ammoSlotId
local dataObject

local function CheckAmmo()
	if (ammoSlotId ~= nil) then
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
	end
end

local function Initialize()
	local ammoClasses = {
		1, -- Warrior
		3, -- Hunter
		4, -- Rogue
	}

	local _, _, classId = UnitClass("player")

	if (tContains(ammoClasses, classId)) then
		dataObject = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_Ammo", {type = "data source", text = ""})
		ammoSlotId = GetInventorySlotInfo("AMMOSLOT")

		frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
		frame:RegisterEvent("BAG_UPDATE")

		CheckAmmo()
	end
end

local eventHandlers = {
	PLAYER_LOGIN = Initialize,
	UNIT_INVENTORY_CHANGED = CheckAmmo,
	BAG_UPDATE = CheckAmmo
  }

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function (_, event, ...) eventHandlers[event](...) end)
