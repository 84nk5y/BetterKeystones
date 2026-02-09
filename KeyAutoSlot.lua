local function SlotKeystone()
    for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info and info.hyperlink and info.hyperlink:match("|Hkeystone:") then
                C_Container.PickupContainerItem(bagId, slotId)
                if CursorHasItem() then
                    C_ChallengeMode.SlotKeystone()
                end
            end
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event, ...)
    if C_AddOns.IsAddOnLoaded("Blizzard_ChallengesUI") and ChallengesKeystoneFrame and ChallengesKeystoneFrame.OnShow then
        ChallengesKeystoneFrame:HookScript("OnShow", SlotKeystone)

        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end
end)