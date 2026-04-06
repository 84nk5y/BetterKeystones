local function SlotKeystone()
    for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info and info.hyperlink and info.hyperlink:find("|Hkeystone:", 1, true) then
                C_Container.PickupContainerItem(bag, slot)
                if CursorHasItem() then
                    C_ChallengeMode.SlotKeystone()
                    CloseAllBags()
                    return
                end
            end
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "Blizzard_ChallengesUI" then
        ChallengesKeystoneFrame:HookScript("OnShow", SlotKeystone)
        f:UnregisterEvent("ADDON_LOADED")
    end
end)