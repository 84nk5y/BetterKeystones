local previousLineId = -1
local function ChatKeystoneFilter(_, event, msg, player, _, _, _, _, _, _, _, _, lineId, guid)
    if lineId ~= previousLineId then
        previousLineId = lineId

        if msg and strlower(msg) == '!keys' then
            local channel
            if event == "CHAT_MSG_GUILD" then
                channel = "GUILD"
            elseif event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_PARTY" then
                channel = "PARTY"
            end

            if channel then
                for bag = 0, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
                    for slot = 1, C_Container.GetContainerNumSlots(bag) do
                        local info = C_Container.GetContainerItemInfo(bag, slot)
                        if info and info.hyperlink and info.hyperlink:match("|Hkeystone:") then
                            SendChatMessage(info.hyperlink, channel)
                        end
                    end
                end
            end
        end
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatKeystoneFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatKeystoneFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatKeystoneFilter)