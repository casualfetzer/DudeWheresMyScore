SLASH_SHOWKEYSCORE1 = "/showkeyscore"
SlashCmdList["SHOWKEYSCORE"] = function(msg)
    
    local my_key_map_id, my_key_level, just_timed, plus_two, plus_three = DWMS_calculateMyKeyScore()

    if my_key_map_id ~= nil then
        local my_key_map_name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(my_key_map_id)
        print(format("%s (%d) : +1 (%.1f) +2 (%.1f) +3 (%.1f)",  my_key_map_name, my_key_level, just_timed, plus_two, plus_three))
    else
	print("No Keystone Found")
    end
end
