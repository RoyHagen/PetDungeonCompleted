RematchFrame = _G.RematchFrame
local pdcFrameOpen
local pdcFrame

local function CreatePDCFrame()
    if pdcFrameOpen then
        return
    else
        pdcFrameOpen = true
    end
    UpdateInfo()
    -- Define the text variable.
    local myText = "\
-- Deadmines --\
"..DeadState.."\
"..DeadminesPets.."\
\
-- Wailing Caverns --\
"..WailingState.."\
"..WailingCavernPets.."\
\
-- Gnomeregan --\
"..GnomeState.."\
"..GnomereganPets.."\
\
-- Stratholme --\
"..StratState.."\
"..StratholmePets.."\
\
-- Blackrock Depths --\
"..BlackrockState.."\
"..BlackrockDepthsPets.."\
\
-- Celestial Tournament --\
"..CelestialState.."\
"..CelestialPets..""

    -- Create the main frame
    local pdcFrame = CreateFrame("Frame", "PDCCustomFrame", UIParent, "BasicFrameTemplateWithInset")
    
    -- Determine the longest line width
    local maxWidth = 0
    for line in myText:gmatch("[^\n]+") do
        local dummyString = UIParent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        dummyString:SetText(line)
        local lineWidth = dummyString:GetStringWidth()
        if lineWidth > maxWidth then
            maxWidth = lineWidth
        end
        dummyString:Hide()
    end

    -- gather variables to make it easier for myself
    -- Add some padding to the calculated width
    maxWidth = maxWidth + 25
    -- height of window | heigh of textbox is window - 70
    local maxHeight = 470

    pdcFrame:SetSize(maxWidth, maxHeight)
    pdcFrame:SetPoint("TOP", UIParent, "TOP", 0, -50)  -- Move frame 50 pixels down from the top


    -- Enable the frame to be movable
    pdcFrame:SetMovable(true)
    pdcFrame:EnableMouse(true)
    pdcFrame:RegisterForDrag("LeftButton")
    pdcFrame:SetScript("OnDragStart", pdcFrame.StartMoving)
    pdcFrame:SetScript("OnDragStop", pdcFrame.StopMovingOrSizing)

    -- Set the frame title
    pdcFrame.title = pdcFrame:CreateFontString(nil, "OVERLAY")
    pdcFrame.title:SetFontObject("GameFontHighlight")
    pdcFrame.title:SetPoint("CENTER", pdcFrame.TitleBg, "CENTER", 0, 0)
    pdcFrame.title:SetText("Pet Dungeon Completed")

    -- Add a text label
    pdcFrame.textLabel = pdcFrame:CreateFontString(nil, "OVERLAY")
    pdcFrame.textLabel:SetFontObject("GameFontNormal")
    pdcFrame.textLabel:SetPoint("TOP", pdcFrame, "TOP", 0, -20)
    -- pdcFrame.textLabel:SetWidth(280)
    pdcFrame.textLabel:SetSize(maxWidth-25, maxHeight-70)
    pdcFrame.textLabel:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")  -- Change the size to 14 and make it bold
    pdcFrame.textLabel:SetText(myText)

    -- Create the "Okay" button
    pdcFrame.okayButton = CreateFrame("Button", nil, pdcFrame, "GameMenuButtonTemplate")
    pdcFrame.okayButton:SetPoint("BOTTOM", pdcFrame, "BOTTOM", 0, 20)
    pdcFrame.okayButton:SetSize(100, 25)
    pdcFrame.okayButton:SetText("Okay")

    -- Set the script for the button to hide and destroy the frame
    pdcFrame.okayButton:SetScript("OnClick", function()
        pdcFrame:Hide()  -- Hide the frame
        pdcFrame:SetScript("OnHide", function() pdcFrame:OnHide() end)
        -- pdcFrame = nil
        pdcFrameOpen = nil
    end)
    
    -- Show the frame
    pdcFrame:Show()
end

-- Generate the data
-- future, include currency info?
function UpdateInfo()
    -- print("Updated info")
    -- Deadmines
    DeadState = "Completed Deadmines: " .. (C_QuestLog.IsQuestFlaggedCompleted(46292) and "Yes" or "No")
    local has_pocket_cannon = C_PetJournal.GetOwnedBattlePetString(2041)
    local has_tricorne = C_PetJournal.GetOwnedBattlePetString(2057)
    local has_foe_reaper = C_PetJournal.GetOwnedBattlePetString(2058)
    local has_mining_monkey = C_PetJournal.GetOwnedBattlePetString(2064)
    DeadminesPets = (has_pocket_cannon == nil and "Pocket Cannon, " or "") ..
                    (has_tricorne == nil and "Tricorne, " or "") ..
                    (has_foe_reaper == nil and "Foe Reaper, " or "") ..
                    (has_mining_monkey == nil and "Mining Monkey" or "")
    DeadminesPetsLen = DeadminesPets:len()
    DeadminesPets = "Missing Pets: " .. (DeadminesPets:len() > 0 and DeadminesPets:gsub(", %s*$", "") or "No")

    -- Wailing caverns
    WailingState = "Completed Wailing Caverns: " .. (C_QuestLog.IsQuestFlaggedCompleted(45539) and "Yes" or "No")
    local has_young_venomfang = C_PetJournal.GetOwnedBattlePetString(2000)
    local has_cavern_moccasin = C_PetJournal.GetOwnedBattlePetString(1999)
    local has_everliving_spore = C_PetJournal.GetOwnedBattlePetString(1998)
    local has_son_of_skum = C_PetJournal.GetOwnedBattlePetString(2049)
    WailingCavernPets = (has_young_venomfang == nil and "Young Venomfang, " or "") ..
                        (has_cavern_moccasin == nil and "Cavern Moccasin, " or "") ..
                        (has_everliving_spore == nil and "Everliving Spore, " or "") ..
                        (has_son_of_skum == nil and "Son of Skum" or "")
    WailingCavernPetsLen = WailingCavernPets:len()
    WailingCavernPets = "Missing Pets: " .. (WailingCavernPets:len() > 0 and WailingCavernPets:gsub(", %s*$", "") or "No")

    -- Gnomeregan
    GnomeState = "Completed Gnomeregan: " .. (C_QuestLog.IsQuestFlaggedCompleted(54186) and "Yes" or "No")
    local has_mechanical_cockroach = C_PetJournal.GetOwnedBattlePetString(2531)
    local has_leper_rat = C_PetJournal.GetOwnedBattlePetString(2532)
    local has_alarm_o_dog = C_PetJournal.GetOwnedBattlePetString(2533)
    local has_mini_spider_tank = C_PetJournal.GetOwnedBattlePetString(2534)
    GnomereganPets = (has_mechanical_cockroach == nil and "Mechanical Cockroach, " or "") ..
                    (has_leper_rat == nil and "Leper Rat, " or "") ..
                    (has_alarm_o_dog == nil and "Alarm-O-Dog, " or "") ..
                    (has_mini_spider_tank == nil and "Mini Spider Tank" or "")
    GnomereganPetsLen = GnomereganPets:len()
    GnomereganPets = "Missing Pets: " .. (GnomereganPets:len() > 0 and GnomereganPets:gsub(", %s*$", "") or "No")

    -- Stratholme
    StratState = "Completed Stratholm: " .. (C_QuestLog.IsQuestFlaggedCompleted(56492) and "Yes" or "No")
    local has_ziggy = C_PetJournal.GetOwnedBattlePetString(2748)
    local has_crypt_fiend = C_PetJournal.GetOwnedBattlePetString(2749)
    local has_shrieker = C_PetJournal.GetOwnedBattlePetString(2750)
    local has_gruesome_belcher = C_PetJournal.GetOwnedBattlePetString(2747)
    local has_minimancer = C_PetJournal.GetOwnedBattlePetString(2638)
    local has_burnout = C_PetJournal.GetOwnedBattlePetString(2767)
    StratholmePets = (has_ziggy == nil and "Ziggy, " or "") ..
                    (has_crypt_fiend == nil and "Crypt Fiend, " or "") ..
                    (has_shrieker == nil and "Shrieker, " or "") ..
                    (has_gruesome_belcher == nil and "Gruesome Belcher, " or "") ..
                    (has_minimancer == nil and "Minimancer, " or "") ..
                    (has_burnout == nil and "Burnout" or "")
    StratholmePetsLen = StratholmePets:len()
    StratholmePets = "Missing Pets: " .. (StratholmePets:len() > 0 and StratholmePets:gsub(", %s*$", "") or "No")

    -- Blackrock Depths
    BlackrockState = "Completed Blackrock Depths: " .. (C_QuestLog.IsQuestFlaggedCompleted(58458) and "Yes" or "No")
    local has_wailing_lasher = C_PetJournal.GetOwnedBattlePetString(2870)
    local has_tinyclaw = C_PetJournal.GetOwnedBattlePetString(2869)
    local has_experiment = C_PetJournal.GetOwnedBattlePetString(2868)
    BlackrockDepthsPets = (has_wailing_lasher == nil and "Wailing Lasher, " or "") ..
                    (has_tinyclaw == nil and "Tinyclaw, " or "") ..
                    (has_experiment == nil and "Experiment 13" or "")
    BlackrockDepthsPetsLen =  BlackrockDepthsPets:len()
    BlackrockDepthsPets = "Missing Pets: " .. (BlackrockDepthsPets:len() > 0 and BlackrockDepthsPets:gsub(", %s*$", "") or "No")

    -- Celestial Tournament
    CelestialState = "Completed Celestial Tournament: " .. (C_QuestLog.IsQuestFlaggedCompleted(33137) and "Yes" or "No")
    local has_chi_chi = C_PetJournal.GetOwnedBattlePetString(1303)
    local has_xu_fu = C_PetJournal.GetOwnedBattlePetString(1266)
    local has_yu_la = C_PetJournal.GetOwnedBattlePetString(1304)
    local has_zao = C_PetJournal.GetOwnedBattlePetString(1305)
    CelestialPets = (has_chi_chi == nil and "Chi-Chi, " or "") ..
                    (has_xu_fu == nil and "Xu-Fu, " or "") ..
                    (has_yu_la == nil and "Yu-La, " or "") ..
                    (has_zao == nil and "Zao" or "")
    CelestialPetsLen = CelestialPets:len()
    CelestialPets = "Missing Pets: " .. (CelestialPets:len() > 0 and CelestialPets:gsub(", %s*$", "") or "No")
end

local function CreatePdcButton(rematch)
    local buttonTable = {}
    -- If we have Rematch installed, buttons need to be made for rematch, as well as "disabled" rematch, done with the checkbox.
    if rematch then
        pdcRematchButton = CreateFrame("Button","PetDungonCompletedButton", RematchFrame, "UIPanelButtonTemplate")
        pdcRematchButton:SetPoint("LEFT", RematchFrame.BottomBar.UseRematchCheckButton.Text, "RIGHT", 20, 0)
        table.insert(buttonTable, pdcRematchButton)
        -- Because Rematch is a thing, the regular petjournal button needs to be offset even more, to account for the checkbox, and text, that rematch places there for when rematch is "disabled"
        pdcButton = CreateFrame("Button","PetDungonCompletedButton", CollectionsJournal, "UIPanelButtonTemplate")
        pdcButton:SetPoint("LEFT", PetJournalSummonButton, "RIGHT", 95, 0)
        table.insert(buttonTable, pdcButton)
    else
        pdcButton = CreateFrame("Button","PetDungonCompletedButton", CollectionsJournal, "UIPanelButtonTemplate")
        pdcButton:SetPoint("LEFT", PetJournalSummonButton, "RIGHT", 20, 0)
        table.insert(buttonTable, pdcButton)
    end

    for _, button in ipairs(buttonTable) do
        button:SetHeight(20)
        button:SetWidth(100)
        button:SetText("PDC")
        button:SetScript("OnClick", function() 
            local pdcFrame = CreatePDCFrame() 
        end)
        local function UpdateButtonVisibility(tabId)
            if tabId == 2 then
                button:Show()
            else
                button:Hide()
            end
        end
        hooksecurefunc("CollectionsJournal_UpdateSelectedTab",function(self)
            local selected=PanelTemplates_GetSelectedTab(self);
            UpdateButtonVisibility(selected)
        end);
    end
end

PetJournal:HookScript("OnShow", function()
    CreatePdcButton(IsRematch())
end)

-- check for Rematch
function IsRematch()
    local _, AddOnLoaded = C_AddOns.IsAddOnLoaded("Rematch")
    if AddOnLoaded then
        return true
    end
end

SLASH_PDC1 = "/pdc"
SlashCmdList["PDC"] = function(input)
        CreatePDCFrame()
        end