local PREVIOUS_LINES_IDS = {}

local EVENT_TO_CHANNEL = {
    CHAT_MSG_GUILD = "GUILD",
    CHAT_MSG_PARTY = "PARTY",
    CHAT_MSG_PARTY_LEADER = "PARTY",
}

local function ChatKeystoneFilter(_, event, msg, player, _, _, _, _, _, _, _, _, lineId, guid)
    if lineId == PREVIOUS_LINES_IDS[event] then return end

    PREVIOUS_LINES_IDS[event] = lineId

    if msg and msg:lower() == '!keys' then
        local channel = EVENT_TO_CHANNEL[event]

        if channel then
            for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
                for slot = 1, C_Container.GetContainerNumSlots(bag) do
                    local info = C_Container.GetContainerItemInfo(bag, slot)
                    if info and info.hyperlink and info.hyperlink:find("|Hkeystone:", 1, true) then
                        SendChatMessage(info.hyperlink, channel)
                        return
                    end
                end
            end
        end
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatKeystoneFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatKeystoneFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatKeystoneFilter)