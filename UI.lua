-- Add Score Gains to the Tooltip of the Keystone Item
GameTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
    local name, link = tooltip:GetItem()
    --Add the name and path of the item's texture
    if name == "Mythic Keystone" then
        local my_key_map_id, my_key_level, just_timed, plus_two, plus_three = DWMS_calculateMyKeyScore()
        tooltip:AddLine(format("Score Gain (+1): %.1f", just_timed), 0, 1, 0)
        tooltip:AddLine(format("Score Gain (+2): %.1f", plus_two), 0, 1, 0)
        tooltip:AddLine(format("Score Gain (+3): %.1f", plus_three), 0, 1, 0)
    end
    --Repaint tooltip with newly added lines
    tooltip:Show()
end)
