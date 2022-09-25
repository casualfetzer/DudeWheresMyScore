local function getScoreForTimingLevel(level)

    -- 25 base score plus 5 * key_level
    local base_score = 25 + (5 * level)

    -- each extra affix is worth 5 more points
    -- except for seasonal +10 affix which is
    -- worth 10
    if level >= 10 then
        base_score = base_score + 25
    elseif level >= 7 then
        base_score = base_score + 15
    elseif level >= 4 then
        base_score = base_score + 10
    else
        base_score = base_score + 5
    end

    return base_score, base_score + 2.5, base_score + 5
end

-- Highest of the two fort/tyran score is multiplied by
-- 1.5 and lowest is multiplied by 0.5. Overall score
-- is those two adjusted scores combined
local function getOverallScore(tyran_score, fort_score)
    if tyran_score > fort_score then
        return (tyran_score * 1.5) + (fort_score * 0.5)
    else
        return (fort_score * 1.5) + (tyran_score * 0.5)
    end
end

function DWMS_calculateMyKeyScore()

    local my_key_map_id = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local my_key_level  = C_MythicPlus.GetOwnedKeystoneLevel()

    if my_key_map_id == nil then
        return nil, nil, nil, nil, nil
    end

    local just_timed, plus_two, plus_three = DWMS_calculateKeyScore(my_key_map_id, my_key_level)

    return my_key_map_id, my_key_level, just_timed, plus_two, plus_three
end


function DWMS_calculateKeyScore(key_map_id, key_level)
    local base_affix = C_MythicPlus.GetCurrentAffixes()[1].id

    local just_timed_score, plus_two_score, plus_three_score = getScoreForTimingLevel(key_level)

    local affixScores, bestOverAllScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(key_map_id)

    local tyran_score = 0
    local fort_score  = 0

    if affixScores ~= nil then

        if affixScores[1] ~= nil then
            tyran_score = affixScores[1].score
        end

        if affixScores[2] ~= nil then
            fort_score = affixScores[2].score
        end
    end

    if bestOverAllScore == nil then
        bestOverAllScore = 0
    end

    -- affix ID 9 is tyrannical ID 10 is Fortified
    if my_key_base_affix == 9 then
        just_timed = math.max(getOverallScore(math.max(just_timed_score, tyran_score), fort_score) - bestOverAllScore, 0)
        plus_two   = math.max(getOverallScore(math.max(plus_two_score, tyran_score), fort_score) - bestOverAllScore, 0)
        plus_three = math.max(getOverallScore(math.max(plus_three_score, tyran_score), fort_score) - bestOverAllScore, 0)
    else
        just_timed = math.max(getOverallScore(tyran_score, math.max(just_timed_score, fort_score)) - bestOverAllScore, 0)
        plus_two   = math.max(getOverallScore(tyran_score, math.max(plus_two_score, fort_score)) - bestOverAllScore, 0)
        plus_three = math.max(getOverallScore(tyran_score, math.max(plus_three_score, fort_score)) - bestOverAllScore, 0)
    end

    return just_timed, plus_two, plus_three
end
