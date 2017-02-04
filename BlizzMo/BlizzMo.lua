---------------------------------------------------------------------------------------------------
-- Name: BlizzMo
-- Version: 0.1
-- Author: Dyaxler
-- Description: Just your basic frame mover. You can add your own custom frames in the last
-- function at the very bottom of this file. There are some notes in the comments.
---------------------------------------------------------------------------------------------------
--///////////////////////////////////////////////////////////////////////////////////////////////--
---------------------------------------------------------------------------------------------------
-- Setup environment
db = nil
local frame = CreateFrame("Frame")
UIPanelWindows["CharacterFrame"] =	{ area = "left",	pushable = 7 ,	whileDead = 1 }
UIPanelWindows["SpellBookFrame"] =	{ area = "left",	pushable = 7,	whileDead = 1 }
UIPanelWindows["LootFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["TaxiFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["QuestFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["QuestLogFrame"] =	{ area = "left",	pushable = 7,	whileDead = 1 }
UIPanelWindows["MerchantFrame"] =	{ area = "left",	pushable = 7 }
UIPanelWindows["TradeFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["BankFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["GossipFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["MailFrame"] =		{ area = "left",	pushable = 7 }
UIPanelWindows["PetStableFrame"] =  { area = "left",	pushable = 7 }
UIPanelWindows["DressUpFrame"] =	{ area = "left",	pushable = 7 }
UIPanelWindows["CraftFrame"] =      { area = "left",    pushable = 7 }
UIPanelWindows["MacroFrame"] =      { area = "left",    pushable = 7,   whileDead = 1 }
UIPanelWindows["TalentFrame"] =     { area = "left",    pushable = 7,   whileDead = 1 }
-- These are windows that rely on a parent frame to be open.  If the parent closes or a pushable frame overlaps them they must be hidden.
UIChildWindows = {
	"OpenMailFrame",
	"GuildControlPopupFrame",
	"GuildMemberDetailFrame",
	"GuildInfoFrame",
    "FriendsFrame",
};
---------------------------------------------------------------------------------------------------
-- Setup frames you always want to save by default. Don't worry you can change these flags in game
-- using your CTRL + Click combo while your mouse is over the desired frame. You'll see a
-- confirmation message in the chat window indicating the two states.
---------------------------------------------------------------------------------------------------
local defaultDB = {
    AuctionFrame = {save = true},
    CharacterFrame = {save = true},
    ClassTrainerFrame = {save = true},
    FriendsFrame = {save = true},
    QuestLogFrame = {save = true},
    SpellBookFrame = {save = true},
    TalentFrame = {save = true},
    GossipFrame = {save = true},
    MailFrame = {save = true},
    MerchantFrame = {save = true},
    TradeSkillFrame  = {save = true},
    DressUpFrame  = {save = true},
    LootFrame  = {save = true},
    TaxiFrame  = {save = true},
    TradeFrame  = {save = true},
    -- Player Bags
    ContainerFrame1  = {
        save = true,
        cache = false,
        reset = true,
        },
    ContainerFrame2  = {
        save = true,
        cache = false,
        reset = true,
        },
    ContainerFrame3  = {
        save = true,
        cache = false,
        reset = true,
        },
    ContainerFrame4  = {
        save = true,
        cache = false,
        reset = true,
        },
    ContainerFrame5  = {
        save = true,
        cache = false,
        reset = true,
        },
    -- Bank Bags
    ContainerFrame6  = {
        save = false,
        cache = false,
        },
    ContainerFrame7  = {
        save = false,
        cache = false,
        },
    ContainerFrame8  = {
        save = false,
        cache = false,
        },
    ContainerFrame9  = {
        save = false,
        cache = false,
        },
    ContainerFrame10 = {
        save = false,
        cache = false,
        },
    ContainerFrame11 = {
        save = false,
        cache = false,
        },
    -- Key Ring
    ContainerFrame12  = {
        save = false,
        cache = false,
        },
}
---------------------------------------------------------------------------------------------------
local function Print(msg, r, g, b, frame)
	if (not r) then r = 1.0 end
	if (not g) then g = 1.0 end
	if (not b) then b = 1.0 end
	if (frame) then
		frame:AddMessage(msg, r, g, b)
	else
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
		end
	end
end
---------------------------------------------------------------------------------------------------
local function OnShow()
	local settings = this.settings
	if settings and settings.point and settings.save then
        this:ClearAllPoints()
		this:SetPoint(settings.point, settings.relativeTo, settings.relativePoint, settings.xOfs, settings.yOfs)
        this:SetClampedToScreen(true)
		local scale = this.settings.scale
		if scale then
			this:SetScale(scale)
        end
    else
        this:SetScale(1)
    end
    -- Hook Frames
    if this == CharacterFrame then
        ShowUIPanel(CharacterFrame_OnShow())
    elseif this == SpellBookFrame then
        ShowUIPanel(SpellBookFrame_OnShow())
    elseif this == TalentFrame then
        ShowUIPanel(TalentFrame_OnShow())
    elseif this == QuestLogFrame then
        ShowUIPanel(QuestLog_OnShow())
    elseif this == FriendsFrame then
        ShowUIPanel(FriendsFrame_OnShow())
    elseif this == KeyBindingFrame then
        KeyBindingFrame_OnShow()
    elseif this == MacroFrame then
        MacroFrame_OnShow()
    elseif this == HelpFrame then
        HelpFrame_OnShow()
    elseif this == MailFrame then
        ShowUIPanel(MailFrame)
    elseif this == ClassTrainerFrame then
        PlaySound("igCharacterInfoOpen")
        SetTrainerServiceTypeFilter("available", TRAINER_FILTER_AVAILABLE)
        SetTrainerServiceTypeFilter("unavailable", TRAINER_FILTER_UNAVAILABLE)
        SetTrainerServiceTypeFilter("used", TRAINER_FILTER_USED)
    elseif this == DressUpFrame then
        SetPortraitTexture(DressUpFramePortrait, "player")
        PlaySound("igCharacterInfoOpen")
    elseif this == GossipFrame then
        PlaySound("igQuestListOpen")
        if (StaticPopup_Visible("XP_LOSS")) then
            StaticPopup_Hide("XP_LOSS")
        end
    elseif this == InspectFrame then
        InspectFrame_OnShow()
    elseif this == AuctionFrame then
        AuctionFrame_OnShow()
    elseif this == MerchantFrame then
        MerchantFrame_OnShow()
        PlaySound("igCharacterInfoOpen")
    elseif this == TradeSkillFrame then
        TradeSkillInputBox:SetNumber(1)
        PlaySound("igCharacterInfoOpen")
    elseif this == FriendsFrame then
        ShowUIPanel(FriendsFrame_OnShow())
    elseif this == CraftFrame then
        CraftFrame_Show()
        PlaySound("igCharacterInfoOpen")
    elseif this == QuestFrame then
        QuestFrame_OnShow()
    elseif this == LootFrame then
        LootFrame_OnShow()
    elseif this == PetFrame then
        UnitFrame_Update()
        PetFrame_Update()
    elseif this == PetStableFrame then
        ShowUIPanel(PetStableFrame_OnShow())
    elseif this == TaxiFrame then
        PlaySound("igMainMenuOpen")
        DrawOneHopLines()
    elseif this == TradeFrame then
        TradeFrame_OnShow()
        PlaySound("igCharacterInfoOpen")
    elseif this == BankFrame then
        PlaySound("igMainMenuOpen")
    end
    UpdateMicroButtons()
    -- Player Bags
    local parentNum = strsub(this:GetName(), 15)
    if (tonumber(parentNum) ~= nil) and (tonumber(parentNum) < 6) then
        if ((this.settings.reset == true) and (this.settings.cache == false)) or ((this.settings.save == false) and (this.settings.cache == true)) then
            this:ClearAllPoints()
            this:SetPoint("TOPLEFT", "UIParent", "BOTTOMRIGHT", -(380 + tonumber(parentNum) * 1), 250 + tonumber(parentNum) * 140)
            this:SetClampedToScreen(true)
        end
        if this == ContainerFrame0 then
            OpenBackpack(0)
        elseif this == ContainerFrame1 then
            OpenBag(1)
        elseif this == ContainerFrame2 then
            OpenBag(2)
        elseif this == ContainerFrame3 then
            OpenBag(3)
        elseif this == ContainerFrame4 then
            OpenBag(4)
        elseif this == ContainerFrame5 then
            OpenBag(5)
        end
    end
    -- Bank Bags
    local parentNum = strsub(this:GetName(), 15)
    if (tonumber(parentNum) ~= nil) and ((tonumber(parentNum) > 5) and (tonumber(parentNum) < 12)) then
        if ((this.settings.save == false) and (this.settings.cache == false)) or ((this.settings.save == false) and (this.settings.cache == true)) then
            this:ClearAllPoints()
            this:SetPoint("LEFT", "UIParent", "LEFT", (-1200 + parentNum * 200), -100 + parentNum * 0)
            this:SetClampedToScreen(true)
        end
        if this == ContainerFrame6 then
            OpenBag(6)
        elseif this == ContainerFrame7 then
            OpenBag(7)
        elseif this == ContainerFrame8 then
            OpenBag(8)
        elseif this == ContainerFrame9 then
            OpenBag(9)
        elseif this == ContainerFrame10 then
            OpenBag(10)
        elseif this == ContainerFrame11 then
            OpenBag(11)
        end
    end
    -- Key Ring
    if (this == ContainerFrame12) then
        local settings = this.settings
        if ((this.settings.save == false) and (this.settings.cache == false)) or ((this.settings.save == false) and (this.settings.cache == true)) then
            this:ClearAllPoints()
            this:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -380, 152)
            this:SetClampedToScreen(true)
        end
        if this == KEYRING_CONTAINER then
            ToggleBag(12)
        end
    end
end
---------------------------------------------------------------------------------------------------
local function OnMouseWheel()
	if IsControlKeyDown() then
		local frameToMove = this.frameToMove
		local scale = frameToMove:GetScale() or 1
		if (arg1 == 1) then
			scale = scale +.1
			if (scale > 1.5) then
				scale = 1.5
			end
		else
			scale = scale -.1
			if (scale < .5) then
				scale = .5
			end
		end
		frameToMove:SetScale(scale)
		if this.settings then
			this.settings.scale = scale
		end
	end
end
---------------------------------------------------------------------------------------------------
local function OnDragStart()
	local frameToMove = this.frameToMove
	local settings = frameToMove.settings
	if settings and not settings.default then -- set defaults
		settings.default = {}
        settings.default.scale = 1
		local def = settings.default
		def.point, def.relativeTo, def.relativePoint, def.xOfs, def.yOfs = frameToMove:GetPoint()
		if def.relativeTo then
			def.relativeTo = def.relativeTo:GetName()
		end
	end
    if (settings.cache ~= nil) or (not frameToMove:IsUserPlaced()) then
        settings.cache = true
        settings.reset = false
    end
	frameToMove:StartMoving()
	frameToMove.isMoving = true
end
---------------------------------------------------------------------------------------------------
local function OnDragStop()
	local frameToMove = this.frameToMove
	local settings = frameToMove.settings
	frameToMove:StopMovingOrSizing()
	frameToMove.isMoving = false
	if settings then
		settings.point, _, settings.relativePoint, settings.xOfs, settings.yOfs = frameToMove:GetPoint()
	end
end
---------------------------------------------------------------------------------------------------
local function OnMouseUp()
	local frameToMove = this.frameToMove
	if IsControlKeyDown() then
		local settings = frameToMove.settings
		--toggle save
		if settings then
			settings.save = not settings.save
			if settings.save then
				Print("Frame: "..frameToMove:GetName().." will be saved.")
			else
				Print("Frame: "..frameToMove:GetName().." will be not saved.")
                frameToMove:SetScale(1)
			end
		else
			Print("FrameBackup: "..frameToMove:GetName().." will be saved.")
			db[frameToMove:GetName()] = {}
			settings = db[frameToMove:GetName()]
			settings.save = true
			settings.point, settings.relativeTo, settings.relativePoint, settings.xOfs, settings.yOfs = frameToMove:GetPoint()
			if settings.relativeTo then
			    settings.relativeTo = settings.relativeTo:GetName()
			end
			frameToMove.settings = settings
		end
	end
end
---------------------------------------------------------------------------------------------------
local function SetMoveHandler(frameToMove, handler)
	if not frameToMove then
		return
	end
	if not handler then
		handler = frameToMove
	end
	local settings = db[frameToMove:GetName()]
	if not settings then
		settings = defaultDB[frameToMove:GetName()] or {}
		db[frameToMove:GetName()] = settings
	end
	frameToMove.settings = settings
	handler.frameToMove = frameToMove
    frameToMove:EnableMouse(true)
	frameToMove:SetMovable(true)
    frameToMove:SetClampedToScreen(true)
    handler:RegisterForDrag("LeftButton")
    handler:SetScript("OnDragStart", OnDragStart)
    handler:SetScript("OnDragStop", OnDragStop)

    -- Override frame position according to settings when shown
   	frameToMove:SetScript("OnShow", OnShow)

    -- Hook OnMouseUp
	handler:SetScript("OnMouseUp", OnMouseUp)

    -- Hook Scroll for setting scale
	handler:EnableMouseWheel(true)
	handler:SetScript("OnMouseWheel", OnMouseWheel)
end
---------------------------------------------------------------------------------------------------
StaticPopupDialogs["BLIZZMO_RESET_CONFIRM"] = {
	text = "|cFFFFFF00Reset all BlizzMo Frames?|r",
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		BlizzMo_resetDB()
	end,
	timeout = 0,
	exclusive = 1,
	showAlert = 1
}
---------------------------------------------------------------------------------------------------
function BlizzMo_resetDB()
    if BlizzMoDB == nil then
        Print("BlizzMoError: No frames found to reset!")
    else
        BlizzMoDB = {}
        HideUIPanel(GameMenuFrame)
        ReloadUI()
    end
end
---------------------------------------------------------------------------------------------------
local function OnEvent()
	if event == "PLAYER_ENTERING_WORLD" then
		frame:RegisterEvent("ADDON_LOADED") --for blizz lod addons
		db = BlizzMoDB or defaultDB
		BlizzMoDB = db
		--SetMoveHandler(frameToMove, handler)
        if not IsAddOnLoaded("Auctioneer") then
            SetMoveHandler(AuctionFrame)
        else
            return
        end
        SetMoveHandler(BankFrame)
        -- Player Bags
        SetMoveHandler(ContainerFrame1)
        SetMoveHandler(ContainerFrame2)
        SetMoveHandler(ContainerFrame3)
        SetMoveHandler(ContainerFrame4)
        SetMoveHandler(ContainerFrame5)
        -- Bank Bags
        SetMoveHandler(ContainerFrame6)
        SetMoveHandler(ContainerFrame7)
        SetMoveHandler(ContainerFrame8)
        SetMoveHandler(ContainerFrame9)
        SetMoveHandler(ContainerFrame10)
        SetMoveHandler(ContainerFrame11)
        -- Key Ring
        SetMoveHandler(ContainerFrame12)
        SetMoveHandler(CharacterFrame)
		SetMoveHandler(CharacterFrame, PaperDollFrame)
		SetMoveHandler(CharacterFrame, TokenFrame)
		SetMoveHandler(CharacterFrame, SkillFrame)
		SetMoveHandler(CharacterFrame, ReputationFrame)
		SetMoveHandler(CharacterFrame, PetPaperDollFrameCompanionFrame)
        SetMoveHandler(ClassTrainerFrame)
        SetMoveHandler(CraftFrame)
        SetMoveHandler(DressUpFrame)
        SetMoveHandler(FriendsFrame)
        SetMoveHandler(FriendsFrame, FriendsListFrame)
        SetMoveHandler(FriendsFrame, IgnoreListFrame)
        SetMoveHandler(FriendsFrame, WhoFrame)
        SetMoveHandler(FriendsFrame, GuildFrame)
        SetMoveHandler(FriendsFrame, RaidFrame)
        SetMoveHandler(GossipFrame)
        SetMoveHandler(HelpFrame)
        if not IsAddOnLoaded("SuperInspect") then
            SetMoveHandler(InspectFrame)
        else
            return
        end
        SetMoveHandler(KeyBindingFrame)
        if not IsAddOnLoaded("XLoot") then
            SetMoveHandler(LootFrame)
        else
            return
        end
        SetMoveHandler(MerchantFrame)
        if not IsAddOnLoaded("SuperMacro") then
            SetMoveHandler(MacroFrame)
        else
            return
        end
        SetMoveHandler(MailFrame)
        SetMoveHandler(PetFrame)
        SetMoveHandler(PetStableFrame)
        SetMoveHandler(QuestFrame)
        if not IsAddOnLoaded("EQL3") then
            SetMoveHandler(QuestLogFrame)
        else
            return
        end
        SetMoveHandler(SpellBookFrame)
        SetMoveHandler(TalentFrame)
        if not IsAddOnLoaded("EnhancedFlightMap") then
            SetMoveHandler(TaxiFrame)
        else
            return
        end
        SetMoveHandler(TradeFrame)
        if not IsAddOnLoaded("AdvancedTradeSkillWindow") then
            SetMoveHandler(TradeSkillFrame)
        else
            return
        end
        CustomFrames()
	-- Blizzard AddOns
	elseif arg1 == "Blizzard_AuctionUI" then
		SetMoveHandler(AuctionFrame)
	elseif arg1 == "Blizzard_BindingUI" then
		SetMoveHandler(KeyBindingFrame)
	elseif arg1 == "Blizzard_CraftUI" then
		SetMoveHandler(CraftFrame)
	elseif arg1 == "Blizzard_InspectUI" then
		SetMoveHandler(InspectFrame)
	elseif arg1 == "Blizzard_MacroUI" then
		SetMoveHandler(MacroFrame)
	elseif arg1 == "Blizzard_TalentUI" then
		SetMoveHandler(TalentFrame)
	elseif arg1 == "Blizzard_TradeSkillUI" then
		SetMoveHandler(TradeSkillFrame)
	elseif arg1 == "Blizzard_TrainerUI" then
		SetMoveHandler(ClassTrainerFrame)
	end
end
---------------------------------------------------------------------------------------------------
frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
---------------------------------------------------------------------------------------------------
-- User function to move or lock a frame. Use CTRL + CLICK to toggle save states.
---------------------------------------------------------------------------------------------------
BlizzMo = {}
function BlizzMo:Toggle(handler)
    --Print("BlizzMo:Toggle")
	if not handler then
		handler = GetMouseFocus()
	end
	if handler:GetName() == "WorldFrame" then
		return
	end
	local lastParent = handler
	local frameToMove = handler
	local i=0
	-- Get the parent attached to UIParent from handler
	while lastParent and lastParent ~= UIParent and i < 100 do
			frameToMove = lastParent --set to last parent
			lastParent = lastParent:GetParent()
			i = i + 1
	end
	if handler and frameToMove then
		if handler:GetScript("OnDragStart") then
			handler:SetScript("OnDragStart", nil)
			Print("FrameBlizzMo: "..frameToMove:GetName().." locked.")
		else
			Print("FrameBlizzMo: "..frameToMove:GetName().." to move with handler "..handler:GetName())
			SetMoveHandler(frameToMove, handler)
		end
	else
		Print("BlizzMoError: Parent frame not found.")
	end
end
---------------------------------------------------------------------------------------------------
-- Game menu reset button
---------------------------------------------------------------------------------------------------
function GameMenu_AddButton(button)
	if (GameMenu_InsertAfter == nil) then
		GameMenu_InsertAfter = GameMenuButtonMacros
	end
	if (GameMenu_InsertBefore == nil) then
		GameMenu_InsertBefore = GameMenuButtonLogout
	end
	button:ClearAllPoints()
	button:SetPoint("TOP", GameMenu_InsertAfter:GetName(), "BOTTOM", 0, -1)
	GameMenu_InsertBefore:SetPoint("TOP", button:GetName(), "BOTTOM", 0, -1)
	GameMenu_InsertAfter = button
	GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + button:GetHeight() + 2)
end
---------------------------------------------------------------------------------------------------
if (GameMenuButtonAddOns) then
	GameMenu_AddButton(GameMenuButtonAddOns)
end
---------------------------------------------------------------------------------------------------
-- Bag functions - most of this is just rewritten game client code.
---------------------------------------------------------------------------------------------------
function ToggleBag(id)
    --Print("ToggleBag"..id)
	if (IsOptionFrameOpen()) then
		return
	end
	local size
	if (id == KEYRING_CONTAINER) then
		size = GetKeyRingSize()
	else
		size = GetContainerNumSlots(id)
	end
	if (size > 0) then
		local frame
		if (id == KEYRING_CONTAINER) then
			frame = getglobal("ContainerFrame12")
		else
			frame = getglobal("ContainerFrame"..(id+1))
		end
		if (frame:IsVisible()) then
			frame:Hide()
		else
			if (CanOpenPanels()) then
				ContainerFrame_GenerateFrame(frame, size, id)
                UpdateBagButtonHighlight(frame:GetID())
			else
				if (UnitIsDead("player")) then
					NotWhileDeadError()
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------
function ToggleKeyRing()
    --Print("ToggleKeyRing")
	if (IsOptionFrameOpen()) then
		return
	end
    local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
	if (shownContainerID) then
		getglobal("ContainerFrame12"):Hide()
	else
        local frame = getglobal("ContainerFrame12")
		ContainerFrame_GenerateFrame(frame, GetKeyRingSize(), KEYRING_CONTAINER)
		-- Stop keyring button pulse
		SetButtonPulse(KeyRingButton, 0, 1)
        PlaySound("KeyRingOpen")
	end
    UpdateMicroButtons()
end
---------------------------------------------------------------------------------------------------
function ToggleBackpack()
    --Print("ToggleBackpack")
	if (IsBagOpen(0)) then
		local frame = ContainerFrame1
		if (frame:IsVisible()) then
			frame:Hide()
		end
	else
		ToggleBag(0)
	end
end
---------------------------------------------------------------------------------------------------
function ContainerFrame_OnHide()
    --Print("ContainerFrame_OnHide")
	if (this:GetID() == 0) then
		MainMenuBarBackpackButton:SetChecked(0)
	else
		local bagButton = getglobal("CharacterBag"..(this:GetID() - 1).."Slot")
		if (bagButton) then
			bagButton:SetChecked(0)
		else
			-- If its a bank bag then update its highlight
			UpdateBagButtonHighlight(this:GetID())
		end
	end
	if ( this:GetID() == KEYRING_CONTAINER ) then
		UpdateMicroButtons()
		PlaySound("KeyRingClose")
	else
		PlaySound("igBackPackClose")
	end
end
---------------------------------------------------------------------------------------------------
function ContainerFrame_OnShow()
    --Print("ContainerFrame_OnShow")
	if (this:GetID() == 0) then
		MainMenuBarBackpackButton:SetChecked(1)
	elseif (this:GetID() <= NUM_BAG_SLOTS) then
		local button = getglobal("CharacterBag"..(this:GetID() - 1).."Slot")
		if (button) then
			button:SetChecked(1)
		end
	end
	if ( this:GetID() == KEYRING_CONTAINER ) then
		UpdateMicroButtons()
		PlaySound("KeyRingOpen")
	else
		PlaySound("igBackPackOpen")
	end
end
---------------------------------------------------------------------------------------------------
function OpenBag(id)
    --Print("OpenBag"..id)
	if (not CanOpenPanels()) then
		if (UnitIsDead("player")) then
			NotWhileDeadError()
		end
		return
	end
	local size = GetContainerNumSlots(id)
	if (size > 0) then
		if (id == KEYRING_CONTAINER) then
			frame = "ContainerFrame12"
            if (id == KEYRING_CONTAINER) then
                return
            end
		else
            local frame = getglobal("ContainerFrame"..id)
            if (not frame:IsVisible()) then
                ContainerFrame_GenerateFrame(ContainerFrame_GetOpenFrame(), size, id)
            end
        end
	end
	if ( this:GetID() == KEYRING_CONTAINER ) then
		UpdateMicroButtons()
		PlaySound("KeyRingOpen")
	else
		PlaySound("igBackPackOpen")
	end
    ContainerFrame_OnShow()
end
---------------------------------------------------------------------------------------------------
function CloseBag(id)
    --Print("CloseBag"..id)
	local containerFrame = getglobal("ContainerFrame"..id)
	if (containerFrame:IsVisible()) then
		containerFrame:Hide()
	end
end
---------------------------------------------------------------------------------------------------
function IsBagOpen(id)
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame"..i)
		if (containerFrame:IsShown() and (containerFrame:GetID() == id)) then
			return i
		end
	end
	return nil
end
---------------------------------------------------------------------------------------------------
function OpenBackpack()
    --Print("OpenBackpack")
	if (not CanOpenPanels()) then
		if (UnitIsDead("player")) then
			NotWhileDeadError()
		end
		return
	end
	local containerFrame = ContainerFrame1
	if (not containerFrame:IsVisible()) then
		ToggleBackpack()
	end
end
---------------------------------------------------------------------------------------------------
function CloseBackpack()
    --Print("CloseBackpack")
	local containerFrame = ContainerFrame1
	if (containerFrame:IsVisible()) then
		containerFrame:Hide()
	end
end
---------------------------------------------------------------------------------------------------
function ContainerFrame_GenerateFrame(frame, size, id)
    --Print("ContainerFrame_GenerateFrame")
	frame.size = size
	local name = frame:GetName()
	local bgTextureTop = getglobal(name.."BackgroundTop")
	local bgTextureMiddle = getglobal(name.."BackgroundMiddle1")
	local bgTextureBottom = getglobal(name.."BackgroundBottom")
	local columns = NUM_CONTAINER_COLUMNS
	local rows = ceil(size / columns)
	-- if size = 0 then its the backpack
	if (id == 0) then
		getglobal(name.."MoneyFrame"):Show()
		-- Set Backpack texture
		bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-BackpackBackground")
		bgTextureTop:SetHeight(256)
		bgTextureTop:SetTexCoord(0, 1, 0, 1)
		-- Hide unused textures
		for i=1, MAX_BG_TEXTURES do
			getglobal(name.."BackgroundMiddle"..i):Hide()
		end
		bgTextureBottom:Hide()
		frame:SetHeight(240)
	else
		-- Not the backpack
		-- Set whether or not its a bank bag
		local bagTextureSuffix = ""
		if (id > NUM_BAG_FRAMES) then
			bagTextureSuffix = "-Bank"
		elseif (id == KEYRING_CONTAINER) then
			bagTextureSuffix = "-Keyring"
		end
		-- Set textures
		bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix)
		for i=1, MAX_BG_TEXTURES do
			getglobal(name.."BackgroundMiddle"..i):SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix)
			getglobal(name.."BackgroundMiddle"..i):Hide()
		end
		bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix)
		-- Hide the moneyframe since its not the backpack
		getglobal(name.."MoneyFrame"):Hide()
		local bgTextureCount, height
		local rowHeight = 41
		-- Subtract one, since the top texture contains one row already
		local remainingRows = rows-1
		-- See if the bag needs the texture with two slots at the top
		local isPlusTwoBag
		if (mod(size,columns) == 2) then
			isPlusTwoBag = 1
		end
		-- Bag background display stuff
		if (isPlusTwoBag) then
			bgTextureTop:SetTexCoord(0, 1, 0.189453125, 0.330078125)
			bgTextureTop:SetHeight(72)
		else
			if (rows == 1) then
				-- If only one row chop off the bottom of the texture
				bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.16796875)
				bgTextureTop:SetHeight(86)
			else
				bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.18359375)
				bgTextureTop:SetHeight(94)
			end
		end
		-- Calculate the number of background textures we're going to need
		bgTextureCount = ceil(remainingRows/ROWS_IN_BG_TEXTURE)
		local middleBgHeight = 0
		-- If one row only special case
		if (rows == 1) then
			bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "TOP", 0, 0)
			bgTextureBottom:Show()
			-- Hide middle bg textures
			for i=1, MAX_BG_TEXTURES do
				getglobal(name.."BackgroundMiddle"..i):Hide()
			end
		else
			-- Try to cycle all the middle bg textures
			local firstRowPixelOffset = 9
			local firstRowTexCoordOffset = 0.353515625
			for i=1, bgTextureCount do
				bgTextureMiddle = getglobal(name.."BackgroundMiddle"..i)
				if (remainingRows > ROWS_IN_BG_TEXTURE) then
					-- If more rows left to draw than can fit in a texture then draw the max possible
					height = (ROWS_IN_BG_TEXTURE*rowHeight) + firstRowTexCoordOffset
					bgTextureMiddle:SetHeight(height)
					bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, (height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset))
					bgTextureMiddle:Show()
					remainingRows = remainingRows - ROWS_IN_BG_TEXTURE
					middleBgHeight = middleBgHeight + height
				else
					-- If not its a huge bag
					bgTextureMiddle:Show()
					height = remainingRows*rowHeight-firstRowPixelOffset
					bgTextureMiddle:SetHeight(height)
					bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, (height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset))
					middleBgHeight = middleBgHeight + height
				end
			end
			-- Position bottom texture
			bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "BOTTOM", 0, 0)
			bgTextureBottom:Show()
		end
		-- Set the frame height
		frame:SetHeight(bgTextureTop:GetHeight()+bgTextureBottom:GetHeight()+middleBgHeight)
	end
	frame:SetWidth(CONTAINER_WIDTH)
	frame:SetID(id)
	getglobal(frame:GetName().."PortraitButton"):SetID(id)
	--Special case code for keyrings
	if (id == KEYRING_CONTAINER) then
		getglobal(frame:GetName().."Name"):SetText(KEYRING)
		SetPortraitToTexture(frame:GetName().."Portrait", "Interface\\ContainerFrame\\KeyRing-Bag-Icon")
	else
		getglobal(frame:GetName().."Name"):SetText(GetBagName(id))
		SetBagPortaitTexture(getglobal(frame:GetName().."Portrait"), id)
	end
	for j=1, size, 1 do
		local index = size - j + 1
		local itemButton =getglobal(name.."Item"..j)
		itemButton:SetID(index)
		-- Set first button
		if (j == 1) then
			-- Anchor the first item differently if its the backpack frame
			if (id == 0) then
				itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 30)
			else
				itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 9)
			end
		else
			if (mod((j-1), columns) == 0) then
				itemButton:SetPoint("BOTTOMRIGHT", name.."Item"..(j - columns), "TOPRIGHT", 0, 4)
			else
				itemButton:SetPoint("BOTTOMRIGHT", name.."Item"..(j - 1), "BOTTOMLEFT", -5, 0)
			end
		end
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(id, index)
		SetItemButtonTexture(itemButton, texture)
		SetItemButtonCount(itemButton, itemCount)
		SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5)
		if (texture) then
			ContainerFrame_UpdateCooldown(id, itemButton)
			itemButton.hasItem = 1
		else
			getglobal(name.."Item"..j.."Cooldown"):Hide()
			itemButton.hasItem = nil
		end
		itemButton.readable = readable
		itemButton:Show()
	end
	for j=size + 1, MAX_CONTAINER_ITEMS, 1 do
		getglobal(name.."Item"..j):Hide()
	end
	-- Add the bag to the baglist
	ContainerFrame1.bags[ContainerFrame1.bagsShown + 1] = frame:GetName()
	updateContainerFrameAnchors()
	frame:Show()
end
---------------------------------------------------------------------------------------------------
function updateContainerFrameAnchors()
    --Print("updateContainerFrameAnchors")
end
---------------------------------------------------------------------------------------------------
function OpenAllBags(forceOpen)
	if ( not UIParent:IsVisible() ) then
		return;
	end
	local bagsOpen = 0;
	local totalBags = 1;
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame"..i);
		local bagButton = getglobal("CharacterBag"..(i -1).."Slot");
		if ( (i <= NUM_BAG_FRAMES) and GetContainerNumSlots(bagButton:GetID() - CharacterBag0Slot:GetID() + 1) > 0) then
			totalBags = totalBags + 1;
		end
		if ( containerFrame:IsShown() ) then
			containerFrame:Hide();
			if ( containerFrame:GetID() ~= KEYRING_CONTAINER ) then
				bagsOpen = bagsOpen + 1;
			end
		end
	end
	if ( bagsOpen >= totalBags and not forceOpen ) then
		return;
	else
		ToggleBackpack();
		ToggleBag(1);
		ToggleBag(2);
		ToggleBag(3);
		ToggleBag(4);
		if ( BankFrame:IsVisible() ) then
			ToggleBag(5);
			ToggleBag(6);
			ToggleBag(7);
			ToggleBag(8);
			ToggleBag(9);
			ToggleBag(10);
            ToggleKeyRing()
        end
        UpdateMicroButtons()
    end
end
---------------------------------------------------------------------------------------------------
-- Add your custom frames from your mods here. If your mod has an XML, then look in there for the
-- main parent frame. If not then you'll have to search through all the files for CreateFrame() to
-- find the name of the primary frame name for your mod. It'll be the one that is attached to
-- *UIParent* and closly matches the mods title.
---------------------------------------------------------------------------------------------------
function CustomFrames()
    SetMoveHandler(EQL3_QuestLogFrame)
    SetMoveHandler(ATSWFrame)
    SetMoveHandler(SuperMacroFrame)
    SetMoveHandler(EnhancedFlightMapFrame)
    SetMoveHandler(AuctioneerFrame)
    SetMoveHandler(SuperInspectFrame)
    SetMoveHandler(XLootFrame)
end
