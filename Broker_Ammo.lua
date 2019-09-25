local frame = CreateFrame("Frame")
local dataObject = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_Ammo", {type = "data source", text = ""})

local CTimerAfter = C_Timer.After
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemTexture = GetInventoryItemTexture

local ammoSlotId

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
	ammoSlotId = GetInventorySlotInfo("AMMOSLOT")
	CheckAmmo()
end

local eventHandlers = {
	PLAYER_LOGIN = Initialize,
	UNIT_INVENTORY_CHANGED = CheckAmmo,
	BAG_UPDATE = CheckAmmo
  }

  for event in pairs(eventHandlers) do frame:RegisterEvent(event) end
  frame:SetScript("OnEvent", function (_, event, ...) eventHandlers[event](...) end)
