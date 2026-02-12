local function SlotKeystone()
    for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info and info.hyperlink and info.hyperlink:find("|Hkeystone:", 1, true) then
                C_Container.PickupContainerItem(bag, slot)
                if CursorHasItem() then
                    C_ChallengeMode.SlotKeystone()
                    return
                end
            end
        end
    end
end

local function TryHookKeystoneFrame()
    if C_AddOns.IsAddOnLoaded("Blizzard_ChallengesUI") and ChallengesKeystoneFrame and ChallengesKeystoneFrame.OnShow then
        ChallengesKeystoneFrame:HookScript("OnShow", SlotKeystone)
        return true
    end

    return false
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        if TryHookKeystoneFrame() then
            self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
    end
end)