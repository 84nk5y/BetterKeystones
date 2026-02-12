local function AddForcesPercentage(tooltip, tooltipData)
    if not MDT then return end

    local guid = tooltipData.guid
    if not guid then return end

    local unit = UnitTokenFromGUID(guid)
    if not unit then return end

    local scenarioType = select(10, C_Scenario.GetInfo())
    if scenarioType ~= LE_SCENARIO_TYPE_CHALLENGE_MODE then return end

    local npc_id = tonumber(select(6, strsplit("-", guid)))
    if not npc_id then return end

    local count, total = MDT:GetEnemyForces(npc_id)
    if not count or not total then return end

    local text = format("(+%.2f%%)", count / total * 100)

    local prefix = " - Enemy Forces: "
    for i = 2, tooltip:NumLines() do
        local tooltipText = _G["GameTooltipTextLeft"..i]
        local lineText = tooltipText and tooltipText:GetText()

        if lineText and lineText:find(prefix, 1, true) then
            tooltipText:SetText(lineText.." "..text)
            tooltip:Show()
            return
        end
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, AddForcesPercentage)