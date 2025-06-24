local TIME_FOR_3 = 0.6
local TIME_FOR_2 = 0.8

local function timeFormat(seconds)
    local hours = floor(seconds / 3600)
    local minutes = floor((seconds / 60) - (hours * 60))
    seconds = seconds - hours * 3600 - minutes * 60

    if hours == 0 then
        return format("%d:%.2d", minutes, seconds)
    else
        return format("%d:%.2d:%.2d", hours, minutes, seconds)
    end
end

local function GetTimerFrame(block)
    if not block.TimerFrame then
        local TimerFrame = CreateFrame("Frame", nil, block)
        TimerFrame:SetAllPoints(block)
        
        TimerFrame.Text = TimerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        TimerFrame.Text:SetPoint("LEFT", block.TimeLeft, "RIGHT", 4, 0)
        
        TimerFrame.Text2 = TimerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        TimerFrame.Text2:SetPoint("LEFT", TimerFrame.Text, "RIGHT", 4, 0)

        TimerFrame.Bar3 = TimerFrame:CreateTexture(nil, "OVERLAY")
        TimerFrame.Bar3:SetPoint("TOPLEFT", block.StatusBar, "TOPLEFT", block.StatusBar:GetWidth() * (1 - TIME_FOR_3) - 4, 0)
        TimerFrame.Bar3:SetSize(8, 10)
        TimerFrame.Bar3:SetTexture("Interface\\Addons\\BetterKeystones\\bar")
        TimerFrame.Bar3:SetTexCoord(0, 0.5, 0, 1)

        TimerFrame.Bar2 = TimerFrame:CreateTexture(nil, "OVERLAY")
        TimerFrame.Bar2:SetPoint("TOPLEFT", block.StatusBar, "TOPLEFT", block.StatusBar:GetWidth() * (1 - TIME_FOR_2) - 4, 0)
        TimerFrame.Bar2:SetSize(8, 10)
        TimerFrame.Bar2:SetTexture("Interface\\Addons\\BetterKeystones\\bar")
        TimerFrame.Bar2:SetTexCoord(0.5, 1, 0, 1)

        TimerFrame:Show()

        block.TimerFrame = TimerFrame
    end

    return block.TimerFrame
end

local function UpdateTime(block, elapsedTime)
    local TimerFrame = GetTimerFrame(block)

    local time3 = block.timeLimit * TIME_FOR_3
    local time2 = block.timeLimit * TIME_FOR_2

    TimerFrame.Bar3:SetShown(elapsedTime < time3)
    TimerFrame.Bar2:SetShown(elapsedTime < time2)

    if elapsedTime < time3 then
        TimerFrame.Text:SetText(timeFormat(time3 - elapsedTime))
        TimerFrame.Text:SetTextColor(1, 0.843, 0)
        TimerFrame.Text:Show()
        TimerFrame.Text2:Hide()
    elseif elapsedTime < time2 then
        TimerFrame.Text:SetText(timeFormat(time2 - elapsedTime))
        TimerFrame.Text:SetTextColor(0.78, 0.78, 0.812)
        TimerFrame.Text:Show()
        TimerFrame.Text2:Hide()
    else
        TimerFrame.Text:Hide()
        TimerFrame.Text2:Hide()
    end

    if elapsedTime > block.timeLimit then
        block.TimeLeft:SetText(SecondsToClock(elapsedTime - block.timeLimit, false))
    end
end

hooksecurefunc(ScenarioObjectiveTracker.ChallengeModeBlock, "UpdateTime", UpdateTime)