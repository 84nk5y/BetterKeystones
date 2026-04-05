local function AddForcesPercentage(tooltip, tooltipData)
    if not MDT then print("no MDT") return end

    local scenarioType = select(10, C_Scenario.GetInfo())
    if scenarioType ~= LE_SCENARIO_TYPE_CHALLENGE_MODE then return end

    local guid = tooltipData.guid
    if not guid then print("no guid") return end

    local npcId = select(6, strsplit("-", guid))
    if not npcId then print("no npcId") return end

    local count, total = MDT:GetEnemyForces(npcId)
    if not count or not total then print("no GetEnemyForces") return end

    local text = format("(+%.2f%%)", count / total * 100)

    local prefix = " - Enemy Forces: "
    for i = 2, tooltip:NumLines() do
        local leftLine = tooltip:GetTooltipTextObject(i, false)
        local lineText = leftLine and leftLine:GetText()
        print("found tooltip line: "..lineText)

        if lineText and lineText:find(prefix, 1, true) then
            leftLine:SetText(lineText.." "..text)
            return
        end
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, AddForcesPercentage)