--[[
@TheAlmightyForehead
October 18th, 2024
This handles (mostly) everything on the client
]]

-- ROBLOX SERVICES --
local Services = {
	Players = game:GetService("Players"),
	ReplicatedStorage = game:GetService("ReplicatedStorage"),
	UserInputService = game:GetService("UserInputService"),
	RunService = game:GetService("RunService"),
	TweenService = game:GetService("TweenService"),
	Lighting = game:GetService("Lighting"),
	SoundService = game:GetService("SoundService"),
	TextChatService = game:GetService("TextChatService"),
	StarterGui = game:GetService("StarterGui"),
	GuiService = game:GetService("GuiService"),
	MarketplaceService = game:GetService("MarketplaceService"),
	VRService = game:GetService("VRService"),
	ContentProvider = game:GetService("ContentProvider"),
	VoiceChatService = game:GetService("VoiceChatService"),
	TeleportService = game:GetService("TeleportService"),
	GamepadService = game:GetService("GamepadService"),
	HapticService = game:GetService("HapticService")
}

-- PACKAGES --
local Packages = Services.ReplicatedStorage:WaitForChild("Packages")

-- KNIT SET UP --
local Knit = require(Packages:WaitForChild("Knit"))

Knit.AddControllers(Services.ReplicatedStorage:WaitForChild("Controllers"))

Knit.Start({ServicePromises = false}):andThen(function()
	print("Knit started on client")
end):catch(warn):await()

-- KNIT SERVICES --
Services.ChatTagService = Knit.GetService("ChatTagService")
Services.CollisionService = Knit.GetService("CollisionService")
Services.CurrencyService = Knit.GetService("CurrencyService")
Services.InventoryService = Knit.GetService("InventoryService")
Services.ItemService = Knit.GetService("ItemService")
Services.LeaderboardService = Knit.GetService("LeaderboardService")
Services.ModerationService = Knit.GetService("ModerationService")
Services.PetService = Knit.GetService("PetService")
Services.PlayerDataService = Knit.GetService("PlayerDataService")
Services.RewardsService = Knit.GetService("RewardsService")
Services.ShopService = Knit.GetService("ShopService")
Services.GameplayService = Knit.GetService("GameplayService")
Services.SettingsService = Knit.GetService("SettingsService")
Services.QuestsService = Knit.GetService("QuestsService")
Services.MedalService = Knit.GetService("MedalService")
Services.EmoteService = Knit.GetService("EmoteService")

-- KNIT CONTROLLERS --
local CameraController = Knit.GetController("CameraController")
local AnimationController = Knit.GetController("AnimationController")
local BeamController = Knit.GetController("BeamController")
local PetController = Knit.GetController("PetController")

-- UTILITIES --
local UtilitiesFolder = Services.ReplicatedStorage:WaitForChild("Utilities")
local Utilities = {
	Utils = require(UtilitiesFolder:WaitForChild("Utils")),
	UtilSettings = require(UtilitiesFolder:WaitForChild("Settings")),
	ProductIds = require(UtilitiesFolder:WaitForChild("ProductIds")),
	Icon = require(Packages:WaitForChild("Icon")),
	Slider = require(script.Slider),
	ControllerKeybinds = require(script.ControllerKeybinds),
	ItemColors = require(script.ShopColors),
	CardImages = require(script.CardImages),
	BattlePassItems = require(UtilitiesFolder:WaitForChild("BattlePassItems")),
	Animations = require(script.Animations)
}

-- VALUES --
local ReplicatedValues = Services.ReplicatedStorage:WaitForChild("Values")
local CurrentTick = ReplicatedValues:WaitForChild("CurrentTick")
local TimeUntilReset = ReplicatedValues:WaitForChild("TimeUntilReset")
local EventTimer = ReplicatedValues:WaitForChild("EventTimer")

-- PLAYER --
local Player = Services.Players.LocalPlayer
local GamePassOwned = script.Parent:WaitForChild("GamePassOwned")
local mouse = Player:GetMouse()
local camera = workspace.CurrentCamera

-- UI --
local UIStorage = Services.ReplicatedStorage:WaitForChild("UIStorage")
local TableExample = UIStorage:WaitForChild("TableExample")
local PlayerNameExample = UIStorage:WaitForChild("PlayerExample")
local LeaderboardExample = UIStorage:WaitForChild("LeaderboardExample")
local InventoryExample = UIStorage:WaitForChild("InventoryExample")
local MobileCardExample = UIStorage:WaitForChild("MobileCard")
local EffectTemplate = UIStorage:WaitForChild("EffectTemplate")
local DeckContainsTemplate = UIStorage:WaitForChild("DeckContainsTemplate")
local ShopItemTemplate = UIStorage:WaitForChild("ShopItemTemplate")
local ShopFrameTemplate = UIStorage:WaitForChild("ShopFrameTemplate")
local BattlePassTemplate = UIStorage:WaitForChild("BattlePassTier")
local SongTemplate = UIStorage:WaitForChild("SongTemplate")
local VRTableClaim = UIStorage:WaitForChild("VRTableClaim")

local MainGui = Player.PlayerGui

local LobbyGui = MainGui:WaitForChild("LobbyGui")
local LobbyListFrame = LobbyGui:WaitForChild("LobbyList")
local LobbyScreenFrame = LobbyGui:WaitForChild("LobbyScreen")
local CreateLobbyFrame = LobbyGui:WaitForChild("CreateLobby")
local LobbySettingsFrame = CreateLobbyFrame:WaitForChild("Settings")
local ListFrame = LobbyListFrame:WaitForChild("List")
local LobbyScreenButtons = LobbyScreenFrame:WaitForChild("Buttons")
local LobbyNamesFrame = LobbyScreenFrame:WaitForChild("PlayerNames")
local LobbyScreenTitle = LobbyScreenFrame:WaitForChild("Title")
local LobbyPassLabel = LobbyScreenFrame:WaitForChild("PassLabel")
local LobbyScreenTimer = LobbyScreenFrame:WaitForChild("Timer")

local SpectateGui = MainGui:WaitForChild("Spectate")
local MainSpectateFrame = SpectateGui:WaitForChild("Frame")

local LoadingScreenGui = MainGui:WaitForChild("LoadingScreen")
local LoadingScreenFrame = LoadingScreenGui:WaitForChild("MainFrame"):WaitForChild("Frame")
local LoadingScreenText = LoadingScreenFrame:WaitForChild("LoadingText")
local LoadingCenteredText = LoadingScreenGui:WaitForChild("MainFrame"):WaitForChild("CenteredText")

local MainMenuGui = MainGui:WaitForChild("MainMenu")
local MainMenuFrame = MainMenuGui:WaitForChild("Frame")
local MainMenuUpdateLog = MainMenuGui:WaitForChild("UpdateLog")

local MobileGui = MainGui:WaitForChild("MobileGui")
local MobileFrame = MobileGui:WaitForChild("Frame")
local MobileCardsFrame = MobileGui:WaitForChild("CardSelect")
local MobileCardsTitle = MobileGui:WaitForChild("TextLabel")

local CreditsGui = MainGui:WaitForChild("Credits")

local HowToPlayGui = MainGui:WaitForChild("HowToPlay")
local HowToPlayButtons = HowToPlayGui:WaitForChild("Buttons")
local VRTutorialFrame = HowToPlayGui:WaitForChild("VRTutorial")
local VRTutorialVideos = VRTutorialFrame:WaitForChild("Videos")

local SettingsGui = MainGui:WaitForChild("Settings")
local BackgroundSettingsFrame = SettingsGui:WaitForChild("MainFrame")
local ScrollSettingsFrame = BackgroundSettingsFrame:WaitForChild("ScrollingFrame")
local SettingsFrame = ScrollSettingsFrame:WaitForChild("SettingsFrame")
local MainSettingsFrame = SettingsFrame:WaitForChild("Settings")
local StatsFrame = ScrollSettingsFrame:WaitForChild("StatsFrame")
local MainStatsFrame = StatsFrame:WaitForChild("Stats")

local TableClaimGui = MainGui:WaitForChild("TableClaim")
local TableClaimLabel = TableClaimGui:WaitForChild("TextLabel")
local PlayerClaimGroup = TableClaimGui:WaitForChild("PlayerClaim")
local PlayerClaimName = PlayerClaimGroup:WaitForChild("PlayerName")
local PlayerClaimInfo = PlayerClaimGroup:WaitForChild("CardInfo")
local TopMiddleClaim = TableClaimGui:WaitForChild("TopMiddle")
local TopMiddleClaimLabel = TopMiddleClaim:WaitForChild("TextLabel")
local TopMiddleLastClaim = TopMiddleClaim:WaitForChild("LastClaim")
local AdminClaimFolder = TableClaimGui:WaitForChild("Admin")
local AdminCurrent = AdminClaimFolder:WaitForChild("CurrentPlayer")
local AdminLast = AdminClaimFolder:WaitForChild("LastPlayed")

local TimerGui = MainGui:WaitForChild("Timer")
local TimerFrame = TimerGui:WaitForChild("Frame")
local TimerLabel =  TimerFrame:WaitForChild("TextLabel")
 
local KeybindsGui = MainGui:WaitForChild("Keybinds")
local KeybindsFrame = KeybindsGui:WaitForChild("Frame")
local KeybindsIcons = KeybindsFrame:WaitForChild("Icons")

local LeaderboardsGui = MainGui:WaitForChild("Leaderboards")
local LeaderboardsFrame = LeaderboardsGui:WaitForChild("Leaderboards"):WaitForChild("InnerFrame")

local BlackFadeGui = MainGui:WaitForChild("BlackFade")
local BlackFadeImage = BlackFadeGui:WaitForChild("ImageLabel")

local ShopGui = MainGui:WaitForChild("ShopGui")
local ShopBackground = ShopGui:WaitForChild("MainFrame")
local GamePassBuyScreens = ShopBackground:WaitForChild("GamePassScreens")
local ShopFrame = ShopBackground:WaitForChild("Shop")
local ShopBuyScreen = ShopBackground:WaitForChild("BuyScreen")
local ShopBuyButtons = ShopBuyScreen:WaitForChild("Buttons")
local ShopScrollingFrame = ShopFrame:WaitForChild("Shop")
local ShopTimer = ShopBackground:WaitForChild("ResetTimer")
local ShopDescription = ShopFrame:WaitForChild("SettingDescription")
local ShopCashFrame = ShopBackground:WaitForChild("Cash")
local ShopCashLabel = ShopCashFrame:WaitForChild("TextLabel")
local ShopGiftScreen = ShopBackground:WaitForChild("Gifting")
local ShopGiftDetails = ShopGiftScreen:WaitForChild("ItemDetails")
local ShopSelectedPlayer = ShopGiftScreen:WaitForChild("SelectedPlayer")
local ShopGiftButton = ShopGiftScreen:WaitForChild("StartButton")
local ShopGiftBackButton = ShopGiftScreen:WaitForChild("LeaveButton")
local CashShopBackground = ShopBackground:WaitForChild("CashShop")
local CashShopFrame = CashShopBackground:WaitForChild("ShopFrame")
local CashShopVIP = CashShopBackground:WaitForChild("VIPOption")
local CashShopButtons = CashShopBackground:WaitForChild("Buttons")

local EffectShopGui = MainGui:WaitForChild("EffectShopGui")
local BackgroundEffectFrame = EffectShopGui:WaitForChild("MainFrame")
local MainEffectFrame = BackgroundEffectFrame:WaitForChild("ScrollingFrame")
local EffectShopGiftScreen = BackgroundEffectFrame:WaitForChild("Gifting")
local EffectShopGiftDetails = EffectShopGiftScreen:WaitForChild("ItemDetails")
local EffectShopSelectedPlayer = EffectShopGiftScreen:WaitForChild("SelectedPlayer")
local EffectShopGiftButton = EffectShopGiftScreen:WaitForChild("StartButton")
local EffectShopGiftBackButton = EffectShopGiftScreen:WaitForChild("LeaveButton")
local CashEffectBackground = BackgroundEffectFrame:WaitForChild("CashShop")
local CashEffectFrame = CashEffectBackground:WaitForChild("ShopFrame")
local CashEffectVIP = CashEffectBackground:WaitForChild("VIPOption")
local CashEffectButtons = CashEffectBackground:WaitForChild("Buttons")
local EffectCashFrame = BackgroundEffectFrame:WaitForChild("Cash")
local EffectCashLabel = EffectCashFrame:WaitForChild("TextLabel")

local InventoryGui = MainGui:WaitForChild("Inventory")
local MainInventoryFrame = InventoryGui:WaitForChild("MainFrame")
local MainInventoryArea = MainInventoryFrame:WaitForChild("MainArea")
local ActualMainInvArea = MainInventoryArea:WaitForChild("ActualMain")
local InventoryFrames = ActualMainInvArea:WaitForChild("Inventories")
local InventoryButtons = MainInventoryArea:WaitForChild("Buttons")

local CashEarnedGui = MainGui:WaitForChild("CashEarned")
local cashEarnedLabel = CashEarnedGui:WaitForChild("CashEarned")

local EndScreenGui = MainGui:WaitForChild("EndScreenGui")
local EndScreenFrame = EndScreenGui:WaitForChild("EndScreen")
local EndScreenButtons = EndScreenFrame:WaitForChild("Buttons")
local EndScreenStats = EndScreenFrame:WaitForChild("StatsArea")
local EndTopStats = EndScreenStats:WaitForChild("TopStats")
local EndBottomStats = EndScreenStats:WaitForChild("BottomStats")
local EndCashStats = EndScreenStats:WaitForChild("CashStats")
local EndNoCashInfo = EndScreenStats:WaitForChild("NoCashInfo")

local EffectNotificationGui = MainGui:WaitForChild("EffectNotificationGui")
local EffectNotificationLabel = EffectNotificationGui:WaitForChild("TextLabel")

local PromoCodesGui = MainGui:WaitForChild("PromoCodesGui")
local PromoCodesFrame = PromoCodesGui:WaitForChild("MainFrame")
local PromoCodesBox = PromoCodesFrame:WaitForChild("BoxFrame"):WaitForChild("TextBox")

local RadioGui = MainGui:WaitForChild("RadioGui")
local RadioBackground = RadioGui:WaitForChild("Background")
local RadioMainArea = RadioBackground:WaitForChild("MainArea")
local RadioSearchFrame = RadioMainArea:WaitForChild("SearchFrame")
local RadioSongsFrame = RadioMainArea:WaitForChild("SongsFrame")
local RadioSearchList = RadioSearchFrame:WaitForChild("SongList")
local RadioSongsList = RadioSongsFrame:WaitForChild("SongList")
local RadioSearchBar = RadioSearchFrame:WaitForChild("SearchBar"):WaitForChild("TextBox")
local RadioSongBar = RadioSongsFrame:WaitForChild("MainBox"):WaitForChild("TextBox")

local GiftRedeemGui = MainGui:WaitForChild("GiftCreditGui")
local GiftCreditFrame = GiftRedeemGui:WaitForChild("MainFrame")

local VRNoticeGui = MainGui:WaitForChild("VRNotice")

local CurrentEventGui = MainGui:WaitForChild("SummerEventGui")
local CurrentEventMainFrame = CurrentEventGui:WaitForChild("MainFrame")
local CurrentEventTimer = CurrentEventMainFrame:WaitForChild("Timer")
local CurrentEventCurrency = CurrentEventMainFrame:WaitForChild("Currency")
local CurrentEventCurrencyLabel = CurrentEventCurrency:WaitForChild("TextLabel")
local CurrentEventCurrencyShop = CurrentEventMainFrame:WaitForChild("CurrencyShop")
local CurrentEvent2xOption = CurrentEventCurrencyShop:WaitForChild("2xOption")
local CurrentEventCurrencyShopFrame = CurrentEventCurrencyShop:WaitForChild("ShopFrame")
local CurrentEventCurrencyButtons = CurrentEventCurrencyShop:WaitForChild("Buttons")
local CurrentEventMainArea = CurrentEventMainFrame:WaitForChild("MainArea")
local CurrentEventBattlePassFrame = CurrentEventMainArea:WaitForChild("BattlePass")
local CurrentEventQuestsFrame = CurrentEventMainArea:WaitForChild("Quests")
local CurrentEventQuestsTimer = CurrentEventQuestsFrame:WaitForChild("Timer")
local CurrentEventQuestsMain = CurrentEventQuestsFrame:WaitForChild("MainArea")

local CurrentTableSettingsGui = MainGui:WaitForChild("CurrentTableSettings")
local CurrentTableSettingsBackground = CurrentTableSettingsGui:WaitForChild("MainFrame")
local CurrentTableSettingsFrame = CurrentTableSettingsBackground:WaitForChild("Settings")

local EmoteGui = MainGui:WaitForChild("EmoteGui")
local EmoteLabel = EmoteGui:WaitForChild("ImageLabel")

-- OBJECTS --
local Objects = Services.ReplicatedStorage:WaitForChild("Objects")
local SeatExample = Objects:WaitForChild("Seat")
local ClientStorage = Instance.new("Folder") ClientStorage.Parent = workspace
local SoundStorage = Instance.new("Folder") SoundStorage.Parent = Services.SoundService
local ItemStorage = Services.ReplicatedStorage:WaitForChild("ItemService_STORAGE")
local LobbyRoom = require(ItemStorage.Rooms["Default"])
local LobbyRoomModel = LobbyRoom and LobbyRoom.Model
local LobbyRoomClone = LobbyRoomModel and LobbyRoomModel:Clone()
local BlurEffect = Services.Lighting:WaitForChild("Blur")
local HitSound = Services.SoundService:WaitForChild("FistHit")
local DrinkSound = Services.SoundService:WaitForChild("PotionDrink")
local MainMusic = Services.SoundService:WaitForChild("Music")
local BonkSound = Services.SoundService:WaitForChild("Bonk")
local BindableCallback = Instance.new("BindableFunction")

-- SLIDERS --
local Sliders = {
	MusicSlider = Utilities.Slider.new(
		MainSettingsFrame:WaitForChild("MainMusic"):WaitForChild("SliderFrame"), {

			SliderData = {
				Start = 0,
				End = 10,
				Increment = 0.01,
				DefaultValue = 1
			},

			Axis = "X",
			
			AllowBackgroundClick = true
		}
	),

	AmbienceSlider = Utilities.Slider.new(
		MainSettingsFrame:WaitForChild("InGameMusic"):WaitForChild("SliderFrame"), {

			SliderData = {
				Start = 0,
				End = 10,
				Increment = 0.01,
				DefaultValue = 1
			},

			Axis = "X",

			AllowBackgroundClick = true
		}
	),

	VoiceSlider = Utilities.Slider.new(
		MainSettingsFrame:WaitForChild("VoiceCalls"):WaitForChild("SliderFrame"), {

			SliderData = {
				Start = 0,
				End = 10,
				Increment = 0.01,
				DefaultValue = 1
			},

			Axis = "X",

			AllowBackgroundClick = true
		}
	),
	
	RadioSlider = Utilities.Slider.new(
		MainSettingsFrame:WaitForChild("Radios"):WaitForChild("SliderFrame"), {

			SliderData = {
				Start = 0,
				End = 10,
				Increment = 0.01,
				DefaultValue = 1
			},

			Axis = "X",

			AllowBackgroundClick = true
		}
	)
}

Sliders.MusicSlider:Track()
Sliders.AmbienceSlider:Track()
Sliders.VoiceSlider:Track()
Sliders.RadioSlider:Track()

-- VARIABLES --
waitingTurnTick = tick()
potionChoiceStarted = false
sendingAttemptDrinkPotion = false
adding = false
updatingRadioList = false
searching = false
SwitchingCards = false
gameInProgress = false
changingChoice = false
resetButtonSuccess = false
isSpectating = false
changingShop = false
attemptingEquip = false
isAdmin = false
allItemsLoaded = false
loadingBattlePass = false
loadedBattlePass = false
isAnyLiar = false
grabbingCardVR = false
liarVRDebounce = false
mouseCurrentlyEnabled = true
CurrentSelected = nil
currentSpectate = nil
lastSpectate = nil
currentShopSoundPlaying = nil
lastCardAmounts = nil
camPart = nil
currentPlacementCFrame = nil
lastStackedPos = nil
currentRotationPart = nil
currentPositions = nil
currentItems = nil
currentParticipants = nil
lastGiftScreen = nil
lastHandPosition = nil
currentPersonalCards = nil
lastVelocityCheck = 0
totalLoaded = 0
totalToLoad = 30
lastWins = 0
lastGamesPlayed = 0

-- TABLES --
local global = {
	currentCreditsRedeem = {Gifted = nil, Id = nil, Type = nil},
	CurrentQuestData = {
		LastRefresh = nil,
		CurrentQuests = {}
	},
	lastHandVelocities = {},
	ChosenPotions = {},
	MutedRadios = {},
	Connections = {},
	SelectedCards = {},
	AllItems = {},
	playerItemData = {},
	CurrentHeldCards = {},
	CachedPasses = {},
	ActiveEffects = {},
	Values = {
		["CurrentTurn"] = {Value = nil},
		["CurrentCard"] = {Value = nil},
		["CurrentState"] = {Value = nil},
		["Status"] = {Value = nil}
	},
	seatedLoaded = {},
}

local PlayerSettings = {
	["ControllerType"] = function(typeName : string)
		local icons = KeybindsIcons:FindFirstChild("controller")

		if icons then
			for _, frame in pairs(icons:GetChildren()) do
				if frame:IsA("Frame") then
					for _, image in pairs(frame:GetChildren()) do
						if image:IsA("ImageLabel") then
							image.Image = Utilities.ControllerKeybinds[typeName][image.Name]
						end
					end
				end
			end
		end

		MainSpectateFrame.Left.Controller.Image = Utilities.ControllerKeybinds[typeName]["DPadLeft"]
		MainSpectateFrame.Right.Controller.Image = Utilities.ControllerKeybinds[typeName]["DPadRight"]

		for _, v2 in pairs(MainSettingsFrame:WaitForChild("ControllerType"):GetChildren()) do
			if v2:IsA("GuiButton") then
				local stroke = v2:FindFirstChildWhichIsA("UIStroke")

				if stroke then
					if v2.Name == typeName then
						stroke.Enabled = true
					else
						stroke.Enabled = false
					end
				end
			end
		end
	end,
	
	["RadioEnabled"] = function(typeName : string)
		for _, v2 in pairs(MainSettingsFrame:WaitForChild("RadioEnabled"):GetChildren()) do
			if v2:IsA("GuiButton") then
				local stroke = v2:FindFirstChildWhichIsA("UIStroke")

				if stroke then
					if v2.Name == typeName then
						stroke.Enabled = true
					else
						stroke.Enabled = false
					end
				end
			end
		end
	end,
}

local tableCreationDescriptions = {
	MaxCards = "The amount of cards players will start with at the beginning of each round.",
	MaxPotions = "The amount of potions each player will have, making it easier or harder to get lucky.",
	MaxParticipants = "The maximum amount of players able to join the table.",
	JoinType = "Whether the game is public, private, or limited to friends only.",
	IncludeJokers = "Whether the game should include Jokers, aka wild cards, which can be played and counted as any card.",
	IncludeDemon = "Adds a Demon card to the deck, which if played and called out, causes everyone else to drink a potion.",
	IncludeAngel = "Adds an Angel card to the deck, which if played and called out, gives a potion back to the user.",
	AutoLiar = "Liar will automatically be called once every player except the last has ran out of cards.",
	AnyLiar = "When enabled, anybody can call Liar whether it's their turn or not.",
	OnLastPotion = "The last potion will be the one that knocks you out, rather than it being random.",
	EffectsEnabled = "In-game buyable effects, giving anyone the ability to temporarily change visuals or time limits with cash."
}

local tableCreationChoices = {
	MaxCards = {
		[1] = 3,
		[2] = 4,
		[3] = 5
	},
	
	MaxPotions = {
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4
	},
	
	MaxParticipants = {
		[1] = 2,
		[2] = 3,
		[3] = 4,
		[4] = 5,
		[5] = 6
	},
	
	JoinType = {
		[1] = "Public",
		[2] = "Private",
		--[3] = "Friends"
	},
	
	IncludeJokers = {
		[1] = "Yes",
		[2] = "No"
	},
	
	IncludeDemon = {
		[1] = "No",
		[2] = "Yes"
	},
	
	IncludeAngel = {
		[1] = "No",
		[2] = "Yes"
	},
	
	AutoLiar = {
		[1] = "No",
		[2] = "Yes"
	},
	
	AnyLiar = {
		[1] = "No",
		[2] = "Yes"
	},
	
	OnLastPotion = {
		[1] = "No",
		[2] = "Yes"
	},
	
	EffectsEnabled = {
		[1] = "No",
		[2] = "Yes"
	}
}

local tableCreationData = {
	MaxCards = 5,
	MaxPotions = 3,
	MaxParticipants = 4,
	JoinType = "Public",
	IncludeJokers = "Yes",
	IncludeDemon = "No",
	IncludeAngel = "No",
	AutoLiar = "No",
	AnyLiar = "No",
	OnLastPotion = "No",
	EffectsEnabled = "No"
}

-- TWEEN INFOS --
local allTweenInfos = {
	eyeShutInfo = TweenInfo.new(
		1,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.In
	),
	
	groupTweenInfo = TweenInfo.new(
		0.3,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut
	),
	
	movementTweenFo = TweenInfo.new(
		0.1,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut,
		0,
		false,
		0
	),
	
	cardTweenInfo = TweenInfo.new(
		0.7,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut
	),
	
	billboardTweenInfo = TweenInfo.new(
		1,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut,
		-1,
		true
	),
	
	cameraTweenInfo = TweenInfo.new(
		1,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut
	),
	
	effectNotification1 = TweenInfo.new(
		0.7,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	
	effectNotification2 = TweenInfo.new(
		0.7,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.In
	)
}

-- TWEENS --
local allTweens = {
	groupTween1 = Services.TweenService:Create(PlayerClaimGroup, allTweenInfos.groupTweenInfo, {GroupTransparency = 0}),
	groupTween2 = Services.TweenService:Create(PlayerClaimGroup, allTweenInfos.groupTweenInfo, {GroupTransparency = 1}),
	eyeShutTween = Services.TweenService:Create(BlackFadeImage, allTweenInfos.eyeShutInfo, {Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 1, 0)}),
	eyeVRTween = Services.TweenService:Create(Services.Lighting.ColorCorrection, allTweenInfos.eyeShutInfo, {TintColor = Color3.fromRGB(0, 0, 0)}),
	cashEarnedTween1 = Services.TweenService:Create(cashEarnedLabel, allTweenInfos.cardTweenInfo, {TextTransparency = 0}),
	cashEarnedTween2 = Services.TweenService:Create(cashEarnedLabel, allTweenInfos.cardTweenInfo, {TextTransparency = 1}),
	effectNotificationTween1 = Services.TweenService:Create(EffectNotificationLabel, allTweenInfos.effectNotification1, {Position = UDim2.new(0.5, 0, 0.97, 0)}),
	effectNotificationTween2 = Services.TweenService:Create(EffectNotificationLabel, allTweenInfos.effectNotification2, {Position = UDim2.new(0.5, 0, 1.1, 0)})
}

task.spawn(function()
	Services.ContentProvider:PreloadAsync({LoadingScreenFrame:WaitForChild("ImageLabel").Image})
	
	LoadingScreenText.Text = "Loading... (" .. totalLoaded .. "/" .. totalToLoad .. ")"
	
	if Services.VRService.VREnabled then
		Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0)
	end
	
	LoadingScreenGui.Enabled = true
	
	local tickStarted = tick()

	repeat task.wait(0.1)
		LoadingScreenText.Text = "Loading... (" .. totalLoaded .. "/" .. totalToLoad .. ")"
	until totalLoaded >= totalToLoad or tick() - tickStarted > 20
	
	task.wait(1)
	
	LoadingScreenText.Text = "Loaded!"
	
	task.wait(2)
	
	Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
	
	if Services.VRService.VREnabled then
		VRNoticeGui.Enabled = true
	else
		MainMenuGui.Enabled = true
	end
	
	LoadingScreenGui.Enabled = false
	LoadingScreenText.Visible = false
	LoadingScreenFrame.Visible = false
	LoadingCenteredText.Text = "Loading..."
	LoadingCenteredText.Visible = true
end)

task.spawn(function()
	while not resetButtonSuccess do
		resetButtonSuccess = pcall(Services.StarterGui.SetCore, Services.StarterGui, "ResetButtonCallback", false)
		task.wait()
	end

	Services.GuiService.TouchControlsEnabled = false
end)

totalLoaded += 1

-- ICONS --
cashIcon = Utilities.Icon.new()
cashIcon:setRight()
cashIcon:setOrder(1)
cashIcon:lock()
cashIcon:setLabel("$0")
cashIcon:setTextFont("Guru", Enum.FontWeight.Bold)

--[[eventCurrencyIcon = Utilities.Icon.new()
eventCurrencyIcon:setRight()
eventCurrencyIcon:setOrder(2)
eventCurrencyIcon:lock()
eventCurrencyIcon:setImage("rbxassetid://106432558355449")
eventCurrencyIcon:setLabel("0")
eventCurrencyIcon:setTextFont("Guru", Enum.FontWeight.Bold)]]

updateLogsIcon = Utilities.Icon.new()
updateLogsIcon:setRight()
updateLogsIcon:setOrder(5)
updateLogsIcon:setLabel("Update Logs")
updateLogsIcon:setTextFont(Enum.Font.Merriweather)

promoCodesIcon = Utilities.Icon.new()
promoCodesIcon:setRight()
promoCodesIcon:setOrder(4)
promoCodesIcon:setLabel("Codes")
promoCodesIcon:setTextFont(Enum.Font.Merriweather)

gameEffectsIcon = Utilities.Icon.new()
gameEffectsIcon:setOrder(2)
gameEffectsIcon:setImageScale(1)
gameEffectsIcon:setImage("rbxassetid://74815357031079")
gameEffectsIcon:setLabel("Effects")
gameEffectsIcon:setTextFont(Enum.Font.Merriweather)
gameEffectsIcon:setEnabled(false)

currentSettingsIcon = Utilities.Icon.new()
currentSettingsIcon:setOrder(3)
currentSettingsIcon:setImageScale(1)
currentSettingsIcon:setImage("rbxassetid://79530386758431")
currentSettingsIcon:setLabel("Table Settings")
currentSettingsIcon:setTextFont(Enum.Font.Merriweather)
currentSettingsIcon:setEnabled(false)

spectatingIcon = Utilities.Icon.new()
spectatingIcon:setRight()
spectatingIcon:setOrder(3)
spectatingIcon:setTextFont("Guru", Enum.FontWeight.Bold)
spectatingIcon:setEnabled(false)
spectatingIcon:lock()

voiceChatIcon = nil
proServerIcon = nil
--seventeenPlusIcon = nil

totalLoaded += 1

function Disconnect(connectionName : string)
	if global.Connections[connectionName] then
		pcall(function()
			global.Connections[connectionName]:Disconnect()
		end)
	end
	
	global.Connections[connectionName] = nil
end

function ExpandTableFrame(frame, enable)
	for _, v in pairs(ListFrame:GetChildren()) do
		if v:IsA("CanvasGroup") or v:IsA("Frame") then
			if v == frame then
				if enable then
					v["1"].Size = UDim2.new(1, 0, 0.25, 0)
					v["1"].TableImage.Size = UDim2.new(1.5, 0, 4, 0)
					frame.Size = UDim2.new(1, 0, 0.8, 0)
				else
					v["1"].Size = UDim2.new(1, 0, 1, 0)
					v["1"].TableImage.Size = UDim2.new(1.5, 0, 1, 0)
					frame.Size = UDim2.new(1, 0, 0.2, 0)
				end
				
				v["2"].Visible = enable
				v["1"].JoinTable.TextLabel.Text = (enable and "-") or ("+")
			else
				v["2"].Visible = false
				v["1"].Size = UDim2.new(1, 0, 1, 0)
				v["1"].TableImage.Size = UDim2.new(1.5, 0, 1, 0)
				v.Size = UDim2.new(1, 0, 0.2, 0)
				v["1"].JoinTable.TextLabel.Text = "+"
			end
		end
	end
end

function UpdateLobbyScreen(participants, host)
	for _, v in pairs(LobbyNamesFrame:GetChildren()) do
		if v:IsA("TextLabel") or v:IsA("Frame") then
			v:Destroy()
		end
	end
	
	local currentZindex = 1
	
	for _, v in pairs(participants) do
		local new = PlayerNameExample:Clone()
		
		new.Text = v.Name
		new.Name = v.UserId
		
		if host and type(host) == "table" and host.UserId and tonumber(host.UserId) == Player.UserId and tonumber(v.UserId) ~= Player.UserId then
			new.KickButton.MouseButton1Click:Connect(function()
				Services.GameplayService:AttemptKickFromTable(v.UserId)
			end)
			
			new.KickButton.Visible = true
		end
		
		new.ZIndex = currentZindex
		new.Parent = LobbyNamesFrame
		
		currentZindex += 1
	end
end

function UpdateStatsFrame(name : string, amount : number)
	local frame = MainStatsFrame:FindFirstChild(name)

	if frame and frame:IsA("Frame") and frame.Name == name then
		if name == "TimePlayed" then
			frame.Amount.Text = Utilities.Utils.convertToHMS(amount)
		else
			frame.Amount.Text = ((name == "Cash" and "$") or ("")) .. Utilities.Utils.formatNumber(amount)
		end
	end
	
	if name == "GamesPlayed" then
		lastGamesPlayed = amount
	elseif name == "Wins" then
		lastWins = amount
	end
	
	local WinPercentageFrame = MainStatsFrame:FindFirstChild("WinPercentage")
	
	WinPercentageFrame.Amount.Text = math.round(lastWins / lastGamesPlayed * 100) .. "%"
end

function AttemptJoinTable(host, password)
	local success, result = Services.GameplayService:AttemptJoinTable(host.UserId, password)

	if success then
		LobbyScreenTitle.Text = host.Name .. "'s Table"
		LobbyListFrame.Visible = false
		LobbyScreenTimer.Visible = false
		LobbyScreenFrame.Visible = true
		LobbyScreenButtons.StartButton.Visible = false
		LobbyScreenButtons.LeaveButton.Visible = true
	else
		--warn(result)
	end
	
	return result
end

function CreateVictorySoundFor(victory : any)
	if not Services.SoundService:FindFirstChild("Victories") then
		local newFolder = Instance.new("Folder")
		newFolder.Name = "Victories"
		newFolder.Parent = Services.SoundService
	end
	
	local celeData = victory.Data
	
	if type(victory) == "table" then
		local exists = Services.SoundService.Victories:FindFirstChild(victory.Name)
		
		if exists then return exists end
		
		local celeData = victory.Data
		
		if type(celeData) == "table" then
			local newSound = Instance.new("Sound")

			for property, value in pairs(celeData) do
				newSound[property] = value
			end
			
			local startVal = Instance.new("NumberValue")
			startVal.Name = "StartVolume"
			startVal.Value = newSound.Volume or 0.5
			startVal.Parent = newSound

			newSound.Name = victory.Name
			newSound.Volume = Sliders.VoiceSlider:GetValue() * startVal.Value
			newSound.Parent = Services.SoundService.Victories
			
			return newSound
		end
	end
end

function CreateVoiceFolderFor(voice : any)
	local voiceData = voice.Data
	
	if voiceData then
		local voicesFolder = SoundStorage:FindFirstChild(voice.Name)

		if not voicesFolder then
			voicesFolder = Instance.new("Folder")
			voicesFolder.Name = voice.Name
			voicesFolder.Parent = SoundStorage
		end

		for name, sound in pairs(voiceData) do
			if sound[1] then
				for index, otherSound in pairs(sound) do
					if voicesFolder:FindFirstChild(name .. "_" .. index) then continue end

					local newSound = Instance.new("Sound")

					for property, value in pairs(otherSound) do
						newSound[property] = value
					end
					
					local startVal = Instance.new("NumberValue")
					startVal.Name = "StartVolume"
					startVal.Value = newSound.Volume or 0.5
					startVal.Parent = newSound

					newSound.Name = name .. "_" .. index
					newSound.Volume = Sliders.VoiceSlider:GetValue() * startVal.Value
					newSound.Parent = voicesFolder
				end
			else
				if voicesFolder:FindFirstChild(name) then continue end

				local newSound = Instance.new("Sound")

				for property, value in pairs(sound) do
					newSound[property] = value
				end
				
				local startVal = Instance.new("NumberValue")
				startVal.Name = "StartVolume"
				startVal.Value = newSound.Volume or 0.5
				startVal.Parent = newSound

				newSound.Name = name
				newSound.Volume = Sliders.VoiceSlider:GetValue() * startVal.Value
				newSound.Parent = voicesFolder
			end
		end
		
		return voicesFolder
	elseif type(voice) == "table" and voice.Name then
		warn("Unable to find voice data for " .. voice.Name)
	else
		warn("Unable to find voice data for unknown")
	end
end

function ManageLimitedButtons(frame : Frame)
	local buyScreen = frame:FindFirstChild("BuyScreenName")
	local itemName = frame:FindFirstChild("BuyItemName")
	local itemType = frame:FindFirstChild("BuyItemType")
	local button = frame:FindFirstChildWhichIsA("GuiButton")

	if buyScreen and itemName and itemType and button then
		button.MouseButton1Click:Connect(function()
			ShopFrame.Visible = false
			GamePassBuyScreens[buyScreen.Value].Visible = true

			if itemType.Value == "Victories" or itemType.Value == "Voices" then
				local tPassed = 2

				if currentShopSoundPlaying and currentShopSoundPlaying.IsPlaying then
					tPassed = 3 - currentShopSoundPlaying.TimeLength - 1
				end

				while GamePassBuyScreens[buyScreen.Value].Visible do
					tPassed += Services.RunService.Heartbeat:Wait()

					if tPassed >= 3 then
						tPassed = 0

						local items = global.AllItems[itemType.Value]
						local item = items and items[itemName.Value]

						if item then
							local randomSound = (itemType.Value == "Victories" and CreateVictorySoundFor(item)) or (itemType.Value == "Voices" and CreateVoiceFolderFor(item))

							if itemType.Value == "Voices" then
								randomSound = randomSound and randomSound:GetChildren()[math.random(1, #randomSound:GetChildren())]
							end

							if randomSound then
								randomSound:Play()
								currentShopSoundPlaying = randomSound
							end
						end
					end
				end	
			end
		end)

		if itemType.Value == "Victories" or itemType.Value == "Voices" then
			button.MouseEnter:Connect(function()
				local items = global.AllItems[itemType.Value]
				local item = items and items[itemName.Value]

				if item then
					ShopDescription.Text = item.Description

					if currentShopSoundPlaying then
						currentShopSoundPlaying:Stop()
						currentShopSoundPlaying = nil
					end

					local randomSound = (itemType.Value == "Victories" and CreateVictorySoundFor(item)) or (itemType.Value == "Voices" and CreateVoiceFolderFor(item))
					
					if itemType.Value == "Voices" then
						randomSound = randomSound and randomSound:GetChildren()[math.random(1, #randomSound:GetChildren())]
					end

					if randomSound and ShopDescription.Text == item.Description and ShopFrame.Visible then
						randomSound:Play()
						currentShopSoundPlaying = randomSound
					end
				end
			end)

			button.MouseLeave:Connect(function()
				local items = global.AllItems[itemType.Value]
				local item = items and items[itemName.Value]

				if ShopDescription.Text == item.Description then
					if item then
						ShopDescription.Text = ""

						if currentShopSoundPlaying and ShopFrame.Visible then
							currentShopSoundPlaying:Stop()
							currentShopSoundPlaying = nil
						end
					end
				end
			end)
		end
	end
end

function UpdateLobbyList(updateType, host, participants, tableSettings)
	local findLobby = host and host.UserId and ListFrame:FindFirstChild(host.UserId)
	
	if updateType then
		if not findLobby then
			findLobby = TableExample:Clone()
			findLobby.Name = host.UserId
			findLobby.Parent = ListFrame
			findLobby["1"].TableName.Text = host.Name .. "'s Table"
			
			if not global.AllItems or not global.AllItems["Rooms"] then repeat task.wait() until global.AllItems and global.AllItems["Rooms"] end
			
			local item = global.AllItems["Rooms"][tableSettings.Room or "Default"]
			
			if type(item) == "table" and item.Image then
				findLobby["1"].TableImage.Image = item.Image
			end
			
			if tableSettings.JoinType == "Private" then
				findLobby["2"].PassBox.Visible = true
				findLobby["2"].JoinTable.Visible = false
				
				local textBox = findLobby["2"].PassBox.TextBox
				
				textBox.FocusLost:Connect(function()
					if textBox.Text ~= "" and tonumber(textBox.Text) then
						local result = AttemptJoinTable(host, textBox.Text)
						
						if result == "Password incorrect" then
							textBox.Text = "Password incorrect"
							
							task.wait(2)
							
							if textBox.Text == "Password incorrect" then
								textBox.Text = ""
							end
						end
					end
				end)
			else
				findLobby["2"].JoinTable.MouseButton1Click:Connect(function()
					AttemptJoinTable(host)
				end)
			end
			
			findLobby["1"].ExpandButton.MouseButton1Click:Connect(function()
				ExpandTableFrame(findLobby, not findLobby["2"].Visible)
			end)
		end
		
		for _, v in pairs(findLobby["2"].Settings:GetChildren()) do
			if v:IsA("Frame") then
				if v.Name == "IncludeJokers" or v.Name == "EffectsEnabled" or v.Name == "IncludeDemon" or v.Name == "IncludeAngel" or v.Name == "AutoLiar" or v.Name == "AnyLiar" or v.Name == "OnLastPotion" then
					v.ValueLabel.Text = (tableSettings[v.Name] and "Yes") or ("No")
				else
					v.ValueLabel.Text = tableSettings[v.Name]
				end
			end
		end
		
		findLobby["1"].TableName.Text = host.Name .. "'s Table (" .. #participants .. "/" .. tableSettings.MaxPlayers .. ")"
	else
		if findLobby then
			findLobby:Destroy()
		end
	end
end

function CreateHighlight(card)
	local highlight = Instance.new("Highlight")

	highlight.FillColor = Color3.fromRGB(255, 200, 15)
	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	highlight.Enabled = false
	highlight.Adornee = card
	highlight.Parent = card

	return highlight
end

function GetAvailableCards(characterCards : Folder, checkForSpecific : number?)
	local availableCards = {}
	local specificIndex = nil

	for i = 1, 5 do
		local currentCard = characterCards:FindFirstChild("Card" .. i)

		if currentCard.Transparency ~= 1 then
			table.insert(availableCards, currentCard)
			
			if i == checkForSpecific then
				specificIndex = #availableCards
			end
		end
	end
	
	return availableCards, specificIndex
end

function SwitchCards(positive : boolean, index : number?, isCardNum : boolean?)
	if not SwitchingCards then
		SwitchingCards = true

		local neg = (positive and 1) or (-1)
		local character = Player.Character
		local characterCards = character and character:FindFirstChild("Cards")

		if characterCards then		
			local availableCards, specificIndex = GetAvailableCards(characterCards, (isCardNum and index) or (nil))

			CurrentSelected = CurrentSelected or availableCards[1]

			if CurrentSelected then
				local currentIndex = specificIndex or index or table.find(availableCards, CurrentSelected)

				if currentIndex then
					local nextIndex = (index) or (currentIndex + neg)

					if nextIndex > #availableCards then
						nextIndex = #availableCards
					elseif nextIndex < 1 then
						nextIndex = 1
					end

					local currentCard = availableCards[nextIndex]

					if currentCard then
						CurrentSelected = currentCard

						for _, v in pairs(characterCards:GetChildren()) do
							local highlight = v:FindFirstChildWhichIsA("Highlight")

							if not highlight then
								highlight = CreateHighlight(v)
							end

							if highlight then
								if v == currentCard and index ~= 0 then
									highlight.OutlineTransparency = 0
									highlight.Enabled = not Services.VRService.VREnabled

									for _, d in pairs(v:GetChildren()) do
										if d:IsA("Decal") then
											d.Color3 = Color3.fromRGB(255, 255, 255)
										end
									end
								else
									highlight.OutlineTransparency = 1

									if not table.find(global.SelectedCards, tonumber(string.split(v.Name, "Card")[2])) then
										highlight.Enabled = false

										for _, d in pairs(v:GetChildren()) do
											if d:IsA("Decal") then
												d.Color3 = Color3.fromRGB(200, 200, 200)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		SwitchingCards = false
	end
end

function SelectingCard()
	local selectedName = CurrentSelected and CurrentSelected.Name
	local highlight = CurrentSelected and CurrentSelected:FindFirstChildWhichIsA("Highlight")
	local split = selectedName and string.split(selectedName, "Card")
	local num = split and split[2]
	local toNum = num and tonumber(num)
	local isDemon = CurrentSelected.Color == Color3.fromRGB(0, 0, 0) or CurrentSelected.Color == Color3.fromRGB(255, 225, 110)
	local isAngel = CurrentSelected.Color == Color3.fromRGB(255, 255, 200) or CurrentSelected.Color == Color3.fromRGB(255, 225, 55)
	local character = Player and Player.Character
	local characterCards = character and character:FindFirstChild("Cards")
	local cardsChildren = characterCards and characterCards:GetChildren()
	
	if not isDemon and not isAngel and cardsChildren then
		for _, v in pairs(cardsChildren) do
			local vSplit = v.Name and string.split(v.Name, "Card")
			local vNum = vSplit and vSplit[2]
			local vToNum = vNum and tonumber(vNum)
			
			if vToNum and table.find(global.SelectedCards, vToNum) and (v.Color == Color3.fromRGB(0, 0, 0) or v.Color == Color3.fromRGB(255, 225, 110) or v.Color == Color3.fromRGB(255, 255, 200) or v.Color == Color3.fromRGB(255, 225, 55)) then
				return
			end
		end
	end
	
	if (isDemon or isAngel) and (#global.SelectedCards > 0) and (#global.SelectedCards ~= 1 or global.SelectedCards[1] ~= toNum) then return end
	
	if (highlight) and (toNum) then
		local find = table.find(global.SelectedCards, toNum)
		local mobileCard = MobileCardsFrame:FindFirstChild(num, true)

		if CurrentSelected then
			if not find then
				if isDemon then
					CurrentSelected.Color = Color3.fromRGB(255, 225, 110)
				elseif isAngel then
					CurrentSelected.Color = Color3.fromRGB(255, 225, 55)
				else
					CurrentSelected.Color = Color3.fromRGB(255, 200, 15)
				end

				if mobileCard and mobileCard:IsA("ImageButton") then
					mobileCard.ImageColor3 = Color3.fromRGB(255, 225, 115)
				end

				for _, v in pairs(CurrentSelected:GetChildren()) do
					if v:IsA("Decal") and v.Transparency < 1 then
						v.Transparency = 0.25
					end
				end

				table.insert(global.SelectedCards, toNum)
			else
				table.remove(global.SelectedCards, find)

				for _, v in pairs(CurrentSelected:GetChildren()) do
					if v:IsA("Decal") and v.Transparency < 1 then
						v.Transparency = 0
					end
				end

				if mobileCard and mobileCard:IsA("ImageButton") then
					mobileCard.ImageColor3 = Color3.fromRGB(255, 255, 255)
				end

				if isDemon then
					CurrentSelected.Color = Color3.fromRGB(0, 0, 0)
				elseif isAngel then
					CurrentSelected.Color = Color3.fromRGB(255, 255, 200)
				else
					CurrentSelected.Color = Color3.fromRGB(255, 255, 255)
				end
			end
		end
	end
end

function ChangeCardDecal(card : BasePart, cardName : string? | boolean?)
	for _, v in pairs(card:GetChildren()) do
		if v:IsA("Decal") then
			if (cardName == "Demon" or cardName == "Angel") and v.Name == global.Values["CurrentCard"].Value then
				if Utilities.CardImages[cardName][global.Values["CurrentCard"].Value] then
					v.Texture = Utilities.CardImages[cardName][global.Values["CurrentCard"].Value]	
				end
				
				v.Transparency = 0
			else
				if (v.Name == cardName) or (cardName and v.Name == "Back") or (cardName == true and v.Name == "Unknown") then
					if v.Name == cardName and Utilities.CardImages.Normal[cardName] then
						v.Texture = Utilities.CardImages.Normal[cardName]
					end
					
					v.Transparency = 0
				else
					v.Transparency = 1
				end
			end
		end
	end
end

function UpdateCards(player : Player, cards : {any}, roundStarted : boolean?)
	local character = player and player.Character
	local characterCards = character and character:FindFirstChild("Cards")
	
	task.spawn(function()
		if currentParticipants then
			for _, v in pairs(currentParticipants) do
				if v.Cards and v.Player and v.Player == player then
					for i, _ in pairs(v.Cards) do
						if not cards[i] then
							v.Cards[i] = nil
						end
					end
				end
			end
		end
	end)
	
	if characterCards then
		local destroyedCurrent = false
		
		for i, v in pairs(characterCards:GetChildren()) do
			local split = string.split(v.Name, "Card")
			local num = (split and split[2]) and (tonumber(split[2]))
			
			if num then
				if cards[num] then
					v.CanQuery = true
					v.Transparency = 0
					
					if roundStarted then
						if cards[num] == "Demon" then
							v.Color = Color3.fromRGB(0, 0, 0)
						elseif cards[num] == "Angel" then
							v.Color = Color3.fromRGB(255, 255, 200)
						else
							v.Color = Color3.fromRGB(255, 255, 255)
						end
					end
					
					if type(cards[num]) == "string" then
						ChangeCardDecal(v, cards[num])
						
						if not destroyedCurrent then
							for _, v in pairs(MobileCardsFrame:GetChildren()) do
								if v:IsA("GuiButton") then
									v:Destroy()
								end
							end
							
							destroyedCurrent = true
						end
						
						local mobileCard = MobileCardExample:Clone()
						
						if roundStarted or not table.find(global.SelectedCards, num) then
							mobileCard.ImageColor3 = Color3.fromRGB(255, 255, 255)
						else
							mobileCard.ImageColor3 = Color3.fromRGB(255, 225, 115)
						end
						
						mobileCard.Image = ((cards[num] == "Demon" or cards[num] == "Angel") and Utilities.CardImages[cards[num]][global.Values["CurrentCard"].Value]) or (Utilities.CardImages.Normal[cards[num]])
						mobileCard.Name = num
						mobileCard.Visible = true
						
						mobileCard.MouseButton1Click:Connect(function()
							local indexs = {}
							
							for i = 1, #characterCards:GetChildren() do
								local child = characterCards:FindFirstChild("Card" .. i)
								
								if child.Transparency ~= 1 then
									table.insert(indexs, i)
								end
							end
							
							local cardToSwitch = table.find(indexs, num)
							
							if cardToSwitch then
								if global.Values["CurrentTurn"].Value == Player.UserId and global.Values["CurrentState"].Value == "TURN START" then
									SwitchCards(true, cardToSwitch)
									SelectingCard()
								end
							end
						end)
						
						mobileCard.Parent = MobileCardsFrame
					elseif player ~= Player then
						ChangeCardDecal(v, true)
					end
				else
					v.CanQuery = false
					v.Transparency = 1
					
					ChangeCardDecal(v)
					
					if Player == player then
						local findCard = MobileCardsFrame:FindFirstChild(num)
						
						if findCard then
							findCard:Destroy()
						end
					end
				end
			end
		end
	end
end

function EnableHighlights(character : Model, enable : boolean?)
	local characterCards = character and character:FindFirstChild("Cards")

	if characterCards then
		for _, v in pairs(characterCards:GetChildren()) do
			local highlight = v:FindFirstChildWhichIsA("Highlight")
			
			if not highlight then
				highlight = CreateHighlight(v)
			end

			if highlight then
				highlight.Enabled = (not Services.VRService.VREnabled and enable) or (false)
				
				if not enable then
					highlight.FillTransparency = 1
				end
			end
			
			for _, d in pairs(v:GetChildren()) do
				if d:IsA("Decal") then
					d.Color3 = (enable and Color3.fromRGB(255, 255, 255)) or (Color3.fromRGB(200, 200, 200))
					
					if not enable then
						if d.Transparency < 1 then
							d.Transparency = 0
						end
					end
				end
			end
			
			if v.Color == Color3.fromRGB(0, 0, 0) or v.Color == Color3.fromRGB(255, 225, 110) then
				v.Color = Color3.fromRGB(0, 0, 0)
			elseif v.Color == Color3.fromRGB(255, 255, 200) or v.Color == Color3.fromRGB(255, 225, 55) then
				v.Color = Color3.fromRGB(255, 255, 200)
			else
				v.Color = Color3.fromRGB(255, 255, 255)
			end
			
			for _, label in pairs(MobileCardsFrame:GetDescendants()) do
				if label:IsA("ImageButton") then
					label.ImageColor3 = Color3.fromRGB(255, 255, 255)
				end
			end
		end
	end
end

function TriggerHaptics()
	local lastInput = Utilities.Utils.getLastInput()
	local inputType
	local vibrationMotor
	
	if Services.VRService.VREnabled then
		inputType = Enum.UserInputType.Gamepad1
		vibrationMotor = Enum.VibrationMotor.RightHand
	elseif lastInput == "controller" then
		inputType = Enum.UserInputType.Gamepad1
		vibrationMotor = Enum.VibrationMotor.Large
	elseif lastInput == "touch" then
		inputType = Enum.UserInputType.Gyro
		vibrationMotor = Enum.VibrationMotor.Large
	elseif lastInput == "mouse" then
		inputType = Enum.UserInputType.Keyboard
		vibrationMotor = Enum.VibrationMotor.Large
	end
	
	if inputType and vibrationMotor then
		Services.HapticService:SetMotor(inputType, vibrationMotor, 1)
		task.wait(0.5)
		Services.HapticService:SetMotor(inputType, vibrationMotor, 0)
	end
end

function TweenCard(player)
	local character = player and player.Character
	local getCard = character and character:FindFirstChild("RightHandCard")
	local newCard = getCard and getCard:Clone()
	local motor6D = newCard and newCard:FindFirstChildWhichIsA("Motor6D")

	if motor6D then
		motor6D:Destroy()
	end

	if newCard and currentPlacementCFrame then
		getCard.Transparency = 1

		local backOfCard = getCard:FindFirstChild("Back")

		if backOfCard then
			backOfCard.Transparency = 1
		end

		newCard.CFrame = getCard.CFrame
		newCard.Parent = ClientStorage:FindFirstChild("STACKED_CARDS") or ClientStorage

		local newTween = Services.TweenService:Create(newCard, allTweenInfos.cardTweenInfo, {Position = currentPlacementCFrame.Position})

		newTween.Completed:Once(function()
			if not lastStackedPos then
				lastStackedPos = currentPlacementCFrame.Position
			end

			lastStackedPos += Vector3.new(0, 0.0025, 0)

			newCard.Anchored = true
			newCard.Name = "STACKED_CARD"
			newCard.CFrame = CFrame.new(lastStackedPos) * CFrame.Angles(0, math.rad(math.random(0, 360)), 0)

			local stackedCards = ClientStorage:FindFirstChild("STACKED_CARDS")

			if stackedCards and not stackedCards.PrimaryPart then
				stackedCards.PrimaryPart = newCard
			else
				newCard.Anchored = true
			end

			newTween:Destroy()	
		end)

		newTween:Play()
	end
end

function DrinkPutDown(player : Player)
	local character = player and player.Character

	if character then
		local getPotion = character:FindFirstChild("RightHandPotion")

		if getPotion then
			for _, v in pairs(getPotion:GetDescendants()) do
				if (v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Texture")) then
					v.Transparency = 1
				elseif Utilities.Utils.isEffect(v) then
					v.Enabled = false
				end
			end

			getPotion.Transparency = 1
		end
	end
end

function DrinkTopOff(player : Player)
	local character = player and player.Character
	
	if character then
		local getPotion = character:FindFirstChild("RightHandPotion")
		local topPart = getPotion:FindFirstChild("Top")

		if topPart then
			topPart.Transparency = 1

			for _, v in pairs(topPart:GetChildren()) do
				if v:IsA("Decal") or v:IsA("Texture") then
					v.Transparency = 1
				end
			end
		end
	end
end

function AddDrink(player : Player, potionNum : number)
	local playerPotions = ClientStorage:FindFirstChild(tostring(player.UserId) .. "_POTIONS")
	local potionToAdd = playerPotions and playerPotions:FindFirstChild(potionNum)
	
	if potionToAdd then
		local transparency = potionToAdd:GetAttribute("Transparency")
		
		potionToAdd.Transparency = transparency or 0

		for _, v in pairs(potionToAdd:GetDescendants()) do
			if (v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Texture")) then
				local toNum = tonumber(v.Name)
				v.Transparency = toNum or 0
			elseif Utilities.Utils.isEffect(v) then
				v.Enabled = true
			end
		end
		
		task.delay(1.5, function()
			local highlight = potionToAdd:FindFirstChildWhichIsA("Highlight")
			
			if highlight then
				highlight.Enabled = false
			end
		end)
	end
end

function DrinkPickUp(player : Player, length : number)
	local character = player and player.Character
	
	if character then
		local getPotion = character:FindFirstChild("RightHandPotion")
		local findPotions = ClientStorage:FindFirstChild(tostring(player.UserId) .. "_POTIONS")
		local foundPotion = nil
		local foundTransparency = 0

		if findPotions then
			local potion = global.ChosenPotions[tostring(player.UserId)] and findPotions:FindFirstChild(global.ChosenPotions[tostring(player.UserId)])

			if potion and potion.Transparency == 1 then
				local foundVisible = false

				for _, v in pairs(potion:GetChildren()) do
					if v and v:IsA("BasePart") and v.Transparency ~= 1 then
						foundVisible = true
					end
				end

				if not foundVisible then
					potion = nil
				end
			end

			if not potion then
				for _, v in pairs(findPotions:GetChildren()) do
					if v.Transparency ~= 1 then
						foundPotion = v
					end
				end
			else
				foundPotion = potion
			end
		end

		if foundPotion then
			foundPotion:SetAttribute("Transparency", foundPotion.Transparency)
			foundTransparency = foundPotion.Transparency
			foundPotion.Transparency = 1

			for _, v in pairs(foundPotion:GetDescendants()) do
				if (v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Texture")) then
					v.Transparency = 1
				elseif Utilities.Utils.isEffect(v) then
					v.Enabled = false
				end
			end
		end

		if getPotion then
			getPotion.Transparency = foundTransparency

			task.delay(length, function()
				getPotion.Transparency = 1
			end)

			for _, v in pairs(getPotion:GetDescendants()) do
				if (v:IsA("BasePart") or v:IsA("Decal") or v:IsA("Texture")) then
					local toNum = tonumber(v.Name)

					v.Transparency = toNum or 0

					task.delay(length, function()
						v.Transparency = 1
					end)
				elseif Utilities.Utils.isEffect(v) then
					v.Enabled = true

					task.delay(length, function()
						v.Enabled = false
					end)
				end
			end
		end
	end
end

function LoadAnimations(player : Player, hum : Humanoid)
	local timePassed = 0
	
	repeat
		timePassed += Services.RunService.Heartbeat:Wait()
	until hum:IsDescendantOf(workspace) or timePassed >= 5
	
	for i, v in pairs(Utilities.Animations) do
		AnimationController:Load(v, player.UserId .. "_" .. i, ((player ~= Player and hum) or (nil)))
	end

	if (player ~= Player or not Services.VRService.VREnabled) and (not player:FindFirstChild("isVR")) then
		AnimationController:Play(player.UserId .. "_Idle")
	end
	
	AnimationController:Play(player.UserId .. "_Sitting")
end

function CharacterAdded(player : Player, character : Model)
	local humanoid = character and character:WaitForChild("Humanoid", 10)

	if not humanoid then warn("FAILED TO LOAD HUMANOID FOR " .. player.UserId) return end

	humanoid.Seated:Connect(function()
		global.seatedLoaded[character] = true

		task.wait(1)

		LoadAnimations(player, humanoid)
	end)

	task.spawn(function()
		task.wait(1)

		if global.seatedLoaded[character] then
			global.seatedLoaded[character] = nil
			return
		end

		LoadAnimations(player, humanoid)
		
		task.delay(10, function()
			global.seatedLoaded[character] = nil
		end)
	end)
	
	--[[if player == Player and Services.VRService.VREnabled then
		task.spawn(function()
			local RightHand = character:WaitForChild("RightHand", 10)
			
			if RightHand then
				Objects.HandSpeed:Clone().Parent = RightHand
			end
		end)
	end]]
	
	local tries = 0
	
	repeat task.wait(1)
		tries += 1
	until currentParticipants or tries == 10
	
	local shouldReturn = true
	
	if currentParticipants then
		for i, v in pairs(currentParticipants) do
			if tostring(v.UserId) == tostring(player.UserId) then
				shouldReturn = false
			end
		end
	end
	
	if shouldReturn then
		return
	end
	
	local animator = (player == Player and humanoid:WaitForChild("ClientAnimator", 10)) or (humanoid:WaitForChild("Animator", 10))

	if animator and character and character.Parent and player and player.Character == character then
		pcall(function()
			local animate = character:FindFirstChild("Animate", true)
			
			if animate then
				for i,v in pairs(animate:GetDescendants()) do
					if v:IsA("Animation") then
						v.AnimationId = 0
					end
				end
				
				animate:Destroy()
			end
			
			for _, track in pairs(animator:GetPlayingAnimationTracks()) do
				print(track)
				track:Stop(0)
			end
			
			if not Services.VRService.VREnabled then
				AnimationController:Play(player.UserId .. "_Idle")
			end
			
			AnimationController:Play(player.UserId .. "_Sitting")
		end)
		
		local toStringId = tostring(player.UserId)
		
		if global.Connections[toStringId] then
			for _, v in pairs(global.Connections[toStringId]) do
				pcall(function()
					v:Disconnect()
				end)
			end
			
			table.clear(global.Connections[toStringId])
		else
			global.Connections[toStringId] = {}
		end

		table.insert(global.Connections[toStringId], animator.AnimationPlayed:Connect(function(animTrack)
			local animTrackConnections = {}
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("CARD_PICK_UP"):Once(function()
				if not global.Values["CurrentTurn"].Value or tostring(global.Values["CurrentTurn"].Value) ~= tostring(player.UserId) then return end
				
				UpdateCards(player, lastCardAmounts)

				local getCard = character:FindFirstChild("RightHandCard")

				if getCard then
					getCard.Transparency = 0
					
					task.delay(animTrack.Length, function()
						getCard.Transparency = 1
					end)

					local backOfCard = getCard:FindFirstChild("Back")

					if backOfCard then
						backOfCard.Face = Enum.NormalId.Top
						backOfCard.Transparency = 0
						
						task.delay(animTrack.Length, function()
							backOfCard.Transparency = 1
						end)
					end
				end
			end))
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("FIST_DOWN"):Once(function()
				local voice = currentItems and global.AllItems["Voices"][currentItems[tostring(player.UserId)]["Voices"] or "Default"]
				local voiceName = voice and voice.Name
				local soundFolder = voiceName and SoundStorage:FindFirstChild(voiceName)
				local currentSound = soundFolder and soundFolder:FindFirstChild("Liar")

				if currentSound then
					currentSound:Play()
					HitSound.TimePosition = 0.7
					HitSound:Play()
					TriggerHaptics()
				end
				
				Services.GameplayService:ClientLoaded("LIAR FINISHED")
			end))
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("CARD_THROW_START"):Once(function()
				if not global.Values["CurrentTurn"].Value or tostring(global.Values["CurrentTurn"].Value) ~= tostring(player.UserId) then return end
				
				TweenCard(player)
			end))

			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("CARD_THROW_FINISHED"):Once(function()
				if (player ~= Player or not Services.VRService.VREnabled) and (not player:FindFirstChild("isVR")) then
					AnimationController:Play(player.UserId .. "_Idle")
				end
			end))
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("DRINK_PICK_UP"):Once(function()
				DrinkPickUp(player, animTrack.Length)
			end))
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("TAKE_TOP_OFF"):Once(function()
				DrinkTopOff(player)
			end))
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("DRINK_START"):Once(function()
				if not gameInProgress then return end
				DrinkSound:Play()
			end))
			
			table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal("DRINK_PUT_DOWN"):Once(function()
				DrinkPutDown(player)
			end))
			
			local success, err = pcall(function()
				for _, v in pairs(global.AllItems["Knockouts"]) do
					if type(v.Data) == "table" and type(v.Data.Markers) == "table" then
						for name, func in pairs(v.Data.Markers) do
							table.insert(animTrackConnections, animTrack:GetMarkerReachedSignal(name):Once(function()
								func(player, character, Sliders.AmbienceSlider:GetValue())
							end))
						end
					end
				end
			end)
			
			if not success then
				warn(err)
			end
			
			task.delay(animTrack.Length, function()
				for _, v in pairs(animTrackConnections) do
					v:Disconnect()
				end
			end)
		end))
	end
end

function enableMobileGui(...)
	local UI = table.pack(...)

	for _, v in pairs(MobileFrame:GetChildren()) do
		if table.find(UI, v.Name) then
			v.Visible = true
		elseif v:IsA("GuiObject") then
			v.Visible = false
		end
	end
end

function enableMobileCards(enable)
	if enable then
		if Utilities.Utils.getLastInput() == "touch" then
			BlurEffect.Size = 8
		end
		
		MobileCardsFrame.Visible = true
		MobileCardsTitle.Visible = true
	else
		BlurEffect.Size = 2
		MobileCardsFrame.Visible = false
		MobileCardsTitle.Visible = false
	end
end

function PlayCard(player, cardAmount, adminCards, isVR)
	if adminCards and isAdmin then
		task.spawn(function()
			AdminLast.Visible = true
			
			for i, v in pairs(AdminLast.Cards:GetChildren()) do
				if v:IsA("ImageButton") then
					if adminCards[tonumber(v.Name)] then
						if adminCards[tonumber(v.Name)] == "Demon" or adminCards[tonumber(v.Name)] == "Angel" then
							v.Image = Utilities.CardImages[adminCards[tonumber(v.Name)]][global.Values.CurrentCard.Value]
						else
							v.Image = Utilities.CardImages.Normal[adminCards[tonumber(v.Name)]]
						end
						
						v.Visible = true
					else
						v.Visible = false
					end
				end
			end
		end)
	end
	
	if not player then
		enableMobileGui()
		enableMobileCards()
		EnableHighlights(Player.Character, false)
		table.clear(global.SelectedCards)
		
		if not isVR then
			AnimationController:Stop(Player.UserId .. "_Hold")
			
			task.spawn(function()
				Services.GameplayService:UpdateAnimation("Hold", "Stop")
			end)
			
			AnimationController:Stop(Player.UserId .. "_Idle")
			AnimationController:Play(Player.UserId .. "_Throw")
		else
			TweenCard(Player)
		end
	else
		if isVR then
			TweenCard(player)
		elseif player ~= Player then
			AnimationController:Stop(player.UserId .. "_Hold")
			AnimationController:Stop(player.UserId .. "_Idle")
			AnimationController:Play(player.UserId .. "_Throw")
		end
		
		if global.Values["CurrentCard"].Value and global.AllItems then
			local voice = currentItems and global.AllItems["Voices"][currentItems[tostring(player.UserId)]["Voices"] or "Default"]
			local voiceName = voice and voice.Name
			local soundFolder = voiceName and SoundStorage:FindFirstChild(voiceName)
			local currentSound = soundFolder and soundFolder:FindFirstChild(global.Values["CurrentCard"].Value .. "_" .. cardAmount)

			if currentSound then
				currentSound:Play()
			end

			task.wait(0.25)

			PlayerClaimName.Text = player.Name

			if tonumber(cardAmount) then
				PlayerClaimInfo.Text = cardAmount .. " x " .. global.Values["CurrentCard"].Value
			else
				PlayerClaimInfo.Text = global.Values["CurrentCard"].Value
			end
			
			PlayerClaimGroup.AnchorPoint = Vector2.new(0.5, 0.5)
			PlayerClaimGroup.Position = UDim2.new(0.5, 0, 0.5, 0)

			allTweens.groupTween1:Play()

			task.wait(3)

			allTweens.groupTween2:Play()
		end

		task.delay(1, function()
			Services.GameplayService:ClientLoaded(tostring(player.UserId) .. " CARD PLAYED")
		end)
	end
end

function ChangeSpectate(positive : boolean?)
	if isSpectating then
		if type(currentParticipants) == "table" and #currentParticipants > 0 then
			local current
			
			for i, v in pairs(currentParticipants) do
				if tostring(v.UserId) == tostring(currentSpectate.UserId) then
					current = i
				end
			end
			
			if not current then
				current = math.random(1, #currentParticipants)
			end
			
			local nextSpectate = current + ((positive and 1) or (-1))
			
			if not currentParticipants[nextSpectate] then
				nextSpectate = (positive and 1) or (#currentParticipants)
			end
			
			local participant = currentParticipants[nextSpectate]
			
			if participant then
				local success, err = pcall(function()
					lastSpectate = currentSpectate
					currentSpectate = participant.Player
					MainSpectateFrame.TextLabel.Text = currentSpectate.Name
					
					if participant and participant.UserId then
						task.spawn(function()
							local success, result = Services.GameplayService:ChangeSpectate(participant.UserId)
							
							if not success then
								warn(result)
							end
						end)
					end
				end)
				
				if not success then
					warn(err)
				end
			end
		end
		
		enableMobileCards()
		enableMobileGui()

		mouseCurrentlyEnabled = true
		Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and true) or (false)
		Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer

		SpectateGui.Enabled = true
	end
end

function DrinkPotion(knockedOut : boolean?)
	potionChoiceStarted = false
	
	task.wait(0.1)
	
	local potionModels = ClientStorage:FindFirstChild(tostring(Player.UserId) .. "_POTIONS")
	
	if potionModels then
		task.spawn(function()
			for _, v in pairs(potionModels:GetChildren()) do
				local potionHighlight = v:FindFirstChildWhichIsA("Highlight")
				local clickDetector = v:FindFirstChildWhichIsA("ClickDetector")
				local arrowGui = v:FindFirstChild("ARROW_GUI")
				local centerGui = v:FindFirstChild("CENTER_GUI")

				if potionHighlight then
					potionHighlight.Enabled = false
				end

				if clickDetector then
					clickDetector.MaxActivationDistance = 0
				end

				if arrowGui then
					arrowGui.Enabled = false
				end

				if centerGui then
					centerGui.Enabled = false
				end
			end
		end)
	end
	
	local knockout = global.AllItems["Knockouts"][currentItems[tostring(Player.UserId)]["Knockouts"] or "Default"]

	mouseCurrentlyEnabled = false
	Services.UserInputService.MouseIconEnabled = false
	Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Disabled

	AnimationController:Stop(Player.UserId .. "_Potions")
	
	local isVR = Services.VRService.VREnabled
	local animTrack = (not isVR and AnimationController:Play(Player.UserId .. "_Drink")) or (AnimationController:GetTrack(Player.UserId .. "_Drink"))
	
	----
	
	if isVR then
		DrinkPickUp(Player, animTrack.Length)
		DrinkTopOff(Player)

		local character = Player and Player.Character
		local head = character and character:FindFirstChild("Head")
		local hand = character and character:FindFirstChild("RightHand")

		if head and head:IsA("BasePart") and hand and hand:IsA("BasePart") then
			local timePassed = 0
			local nearHead = false

			repeat
				timePassed += Services.RunService.Heartbeat:Wait()

				if (head.Position - hand.Position).Magnitude < 1 then
					nearHead = true
				end
			until timePassed > animTrack.Length or nearHead

			DrinkSound:Play()

			task.wait(1)
		else
			task.wait(animTrack.Length / 2)

			DrinkSound:Play()

			task.wait(animTrack.Length / 2)
		end
	else
		task.wait(animTrack.Length)
	end

	if knockedOut and knockout then
		BlackFadeImage.Size = UDim2.new(1, 0, 41, 0)
		BlackFadeImage.Position = UDim2.new(0, 0, -20, 0)
		BlackFadeImage.BackgroundTransparency = 1
		BlackFadeGui.Enabled = true

		allTweens.eyeShutTween:Play()

		if Services.VRService.VREnabled then
			allTweens.eyeVRTween:Play()
		end

		task.wait(0.8)

		isSpectating = true

		local knockoutTrack = AnimationController:Play(Player.UserId .. "_Knockout_" .. knockout.Name)

		task.delay(0.1, function()
			BonkSound:Play()
		end)

		Player.CameraMode = Enum.CameraMode.Classic
		camera.CameraType = Enum.CameraType.Scriptable

		currentSpectate = Player

		task.wait(knockoutTrack.Length)

		if not Services.VRService.VREnabled then
			ChangeSpectate(true)
		else
			camera.CFrame = CFrame.new(currentPlacementCFrame.Position + Vector3.new(7.5, 5.5, 7.5), currentPlacementCFrame.Position)
			mouseCurrentlyEnabled = true
			Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and true) or (false)
			Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer
			SpectateGui.Frame.Visible = false
			SpectateGui.MainMenu.AnchorPoint = Vector2.new(0.5, 0.5)
			SpectateGui.MainMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
			SpectateGui.MainMenu.Size = UDim2.new(0.454, 0, 0.12, 0)
			SpectateGui.Enabled = true
		end

		task.wait(0.5)

		spectatingIcon:setEnabled(false)
		spectatingIcon:setLabel("")

		Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)

		BlackFadeGui.Enabled = false
	end
	
	----

	--[[if isVR then
		DrinkPickUp(Player, animTrack.Length)
		DrinkTopOff(Player)
		
		task.delay(animTrack.Length / 2, function()
			DrinkSound:Play()
		end)
	end]]

	--[[if potionModels and knockout then
		if knockedOut then
			task.delay(animTrack.Length, function()
				BlackFadeImage.Size = UDim2.new(1, 0, 41, 0)
				BlackFadeImage.Position = UDim2.new(0, 0, -20, 0)
				BlackFadeImage.BackgroundTransparency = 1
				BlackFadeGui.Enabled = true
				
				allTweens.eyeShutTween:Play()
				
				if Services.VRService.VREnabled then
					allTweens.eyeVRTween:Play()
				end
				
				task.wait(0.8)
				
				isSpectating = true
				
				local knockoutTrack = AnimationController:Play(Player.UserId .. "_Knockout_" .. knockout.Name)
				
				task.delay(0.1, function()
					BonkSound:Play()
				end)
				
				Player.CameraMode = Enum.CameraMode.Classic
				camera.CameraType = Enum.CameraType.Scriptable
				
				currentSpectate = Player
				
				task.wait(knockoutTrack.Length)
				
				ChangeSpectate(true)
				
				task.wait(0.5)
				
				spectatingIcon:setEnabled(false)
				spectatingIcon:setLabel("")
				
				Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
				
				BlackFadeGui.Enabled = false
			end)
		end

		for _, v in pairs(potionModels:GetChildren()) do
			local potionHighlight = v:FindFirstChildWhichIsA("Highlight")
			local clickDetector = v:FindFirstChildWhichIsA("ClickDetector")
			local arrowGui = v:FindFirstChild("ARROW_GUI")
			local centerGui = v:FindFirstChild("CENTER_GUI")

			if potionHighlight then
				potionHighlight.Enabled = false
			end

			if clickDetector then
				clickDetector.MaxActivationDistance = 0
			end

			if arrowGui then
				arrowGui.Enabled = false
			end

			if centerGui then
				centerGui.Enabled = false
			end
		end
	end]]
end

function UpdateLeaderboard(name, page)
	local boardFrame = LeaderboardsFrame:FindFirstChild(name)
	local scrollFrame = boardFrame and boardFrame:FindFirstChildWhichIsA("ScrollingFrame")

	if scrollFrame then
		for _, v in pairs(scrollFrame:GetChildren()) do
			if not v:IsA("UIListLayout") then
				v:Destroy()
			end
		end

		for i, v in pairs(page) do
			local textColor = Color3.fromRGB(190, 190, 190)

			if tonumber(i) == 1 then
				textColor = Color3.fromRGB(236, 189, 0)
			elseif tonumber(i) == 2 then
				textColor = Color3.fromRGB(225, 225, 225)
			elseif tonumber(i) == 3 then
				textColor = Color3.fromRGB(191, 116, 46)
			end

			local newExample = LeaderboardExample:Clone()

			for _, v in pairs(newExample:GetChildren()) do
				if v:IsA("TextLabel") then
					v.TextColor3 = textColor
				end
			end

			newExample.Spot.Text = i
			newExample.Emoji.Text = v.CountryEmoji or "❓"
			newExample.PlayerName.Text = v.PlayerName or "Unknown"
			
			local success, err = pcall(function()
				newExample.Amount.Text = v.Value or "N/A"
			end)
			
			if not success then
				warn(err)
				newExample.Amount.Text = "N/A"
			end
			
			newExample.Name = i
			newExample.Parent = scrollFrame
		end
	end
end

function UpdateRadioSongList(songList)
	if not updatingRadioList then
		updatingRadioList = true

		for _, v in pairs(RadioSongsList:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end

		for _, v in pairs(songList) do
			if type(v) == "table" then
				local newTemplate = SongTemplate:Clone()

				newTemplate.Name = v.Id
				newTemplate.SongName.Text = v.Name
				newTemplate.Buttons.Add:Destroy()

				newTemplate.Buttons.Delete.MouseButton1Click:Connect(function()
					UpdateRadioWith(v.Id, "REMOVE")
				end)

				newTemplate.Buttons.Play.MouseButton1Click:Connect(function()
					local radiosFolder = ClientStorage:FindFirstChild("RADIOS")
					local radioModel = radiosFolder and radiosFolder:FindFirstChild(Player.UserId .. "_RADIO")
					local soundObject = radioModel and radioModel:FindFirstChildWhichIsA("Sound", true)

					if soundObject and soundObject.IsPlaying and soundObject.SoundId == "rbxassetid://" .. v.Id then
						Services.GameplayService:UpdateRadio("SONG", 0)
					else
						Services.GameplayService:UpdateRadio("SONG", v.Id)
					end
				end)

				newTemplate.Parent = RadioSongsList
			end
		end

		updatingRadioList = false
	end
end

function UpdateRadioWith(songId, updateType)
	if songId and not adding then
		adding = true

		local toLookUp = songId

		RadioSongBar.Text = "Adding..."

		local success, result = Services.GameplayService:UpdateRadio(updateType, songId)

		if success and type(result) == "table" then
			RadioSongBar.Text = ""

			UpdateRadioSongList(result)
		else
			RadioSongBar.Text = "Unknown error; try again?"
		end

		adding = false
	end
end

loadedServerIcon = false

--[[function LoadProServerIcon(wins : number)
	local isProServer = game.PlaceId == Utilities.UtilSettings.Pro_Server
	local currentLabel
	local delayTask

	if isProServer or wins >= 50 and proServerIcon == nil and not loadedServerIcon then
		loadedServerIcon = true
		proServerIcon = Utilities.Icon.new()

		if not isProServer then
			currentLabel = "Pro Server (50+ Wins)"
			proServerIcon:setLabel("Pro Server (50+ Wins)")
			--proServerIcon:setImage("rbxassetid://71879367287389")
		else
			currentLabel = "Back To Main Server"
			proServerIcon:setLabel("Back To Main Server")
		end

		proServerIcon:setOrder(1)
		proServerIcon:setTextFont(Enum.Font.Merriweather)

		proServerIcon.toggled:Connect(function(enabled)
			if not enabled then return end

			if delayTask then
				task.cancel(delayTask)
				delayTask = nil
			end

			if currentLabel == "Pro Server (50+ Wins)" or currentLabel == "Back To Main Server" then
				currentLabel = "Are you sure?"
				proServerIcon:setLabel("Are you sure?")
				proServerIcon:deselect()

				delayTask = task.delay(3, function()
					if currentLabel ~= "Pro Server (50+ Wins)" and currentLabel ~= "Back To Main Server" and currentLabel == "Are you sure?" then
						if not isProServer then
							currentLabel = "Pro Server (50+ Wins)"
							proServerIcon:setLabel("Pro Server (50+ Wins)")
						else
							currentLabel = "Back To Main Server"
							proServerIcon:setLabel("Back To Main Server")
						end
					end
				end)
			elseif currentLabel == "Are you sure?" then
				proServerIcon:lock()
				currentLabel = "Teleporting..."
				proServerIcon:setLabel("Teleporting...")

				if not isProServer then
					Services.TeleportService:Teleport(Utilities.UtilSettings.Pro_Server)
				else
					Services.TeleportService:Teleport(Utilities.UtilSettings.Main_Server)
				end
			end
		end)

		Services.TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMsg, placeId, teleportOptions)
			if player == Player and teleportResult ~= Enum.TeleportResult.Success then
				currentLabel = "Teleport Failed"
				proServerIcon:setLabel("Teleport Failed")

				task.delay(1, function()
					proServerIcon:unlock()
					proServerIcon:deselect()

					if not isProServer then
						currentLabel = "Pro Server (50+ Wins)"
						proServerIcon:setLabel("Pro Server (50+ Wins)")
					else
						currentLabel = "Back To Main Server"
						proServerIcon:setLabel("Back To Main Server")
					end
				end)
			end
		end)
	end
end]]

function GameEnded(winner, numOfParticipants, participantsStartedWith, participant, isInGroup, canPlayAgain, fromServer, playAgain)
	TableClaimLabel.Text = ""
	TopMiddleClaimLabel.Text = ""
	TopMiddleLastClaim.Text = ""
	VRTableClaim.CurrentClaim.Text = ""
	VRTableClaim.LastClaim.Text = ""
	
	isSpectating = false
	currentSpectate = nil

	if winner then
		local success, err = pcall(function()
			EndBottomStats.Winner.Visible = ((winner.Player and winner.Player == Player) and (true)) or (false)
			EndBottomStats.Winner.CashAmount.Text = "+ $" .. math.round(75 * (participantsStartedWith / 6))
			
			SpectateGui.Enabled = false
			
			task.wait(0.1)
			
			local character = winner.Player and winner.Player.Character

			if character then
				for i, v in pairs(character:GetDescendants()) do
					if (v:IsA("BasePart")) and (v:FindFirstAncestorWhichIsA("Accessory") or v.Name == "Head") then
						v.Transparency = 0
						v.LocalTransparencyModifier = 0
					end
				end
			end
			
			local winnerChair = winner and ClientStorage:FindFirstChild(winner.UserId)

			if winnerChair and currentPlacementCFrame then
				TableClaimLabel.Text = "WINNER: " .. winner.Name
				TableClaimLabel.Visible = true

				camera.CameraType = Enum.CameraType.Scriptable

				local from = currentPlacementCFrame.Position + Vector3.new(0, 1.5, 0)
				local lookAt = Vector3.new(winnerChair:GetPivot().X, from.Y, winnerChair:GetPivot().Z)
				local newTween = Services.TweenService:Create(camera, allTweenInfos.cameraTweenInfo, {CFrame = CFrame.new(from, lookAt) * CFrame.new(0, 0, 0.5)})

				if tonumber(winner.UserId) == Player.UserId then
					local character = Player.Character

					if character then
						for i, v in pairs(character:GetDescendants()) do
							if (v:IsA("BasePart")) and (v.Name == "Head" or v:FindFirstAncestorWhichIsA("Accessory")) then
								global.Connections["TEMPORARY_TRANSPARENCY_" .. i] = v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
									v.LocalTransparencyModifier = 0
								end)

								v.LocalTransparencyModifier = 0

								--[[task.delay(6, function()
									Disconnect("TEMPORARY_TRANSPARENCY_" .. i)
									v.LocalTransparencyModifier = 1
								end)]]
							end
						end
					end
				end

				newTween.Completed:Once(function()
					newTween:Destroy()
					Disconnect("TEMPORARY_TRANSPARENCY")
				end)

				newTween:Play()
				
				local winnerItems = currentItems[tostring(winner.UserId)]
				local winnerCelebrationName = type(winnerItems) == "table" and winnerItems["Victories"]
				local winnerCelebration = winnerCelebrationName and global.AllItems["Victories"][winnerCelebrationName]

				if type(winnerCelebration) == "table"  then
					local newSound = CreateVictorySoundFor(winnerCelebration)
					newSound:Play()
				end

				task.wait(4)
			end
		end)
		
		if not success then
			warn(err)
		end
	end
	
	if fromServer then
		if participant then
			local totalCardsPlayedNum = tonumber(participant.TotalCardsPlayed)
			local roundSurvivedNum = tonumber(participant.RoundDied)
			
			EndTopStats.RoundsSurvived.Text = participant.RoundDied .. " Round(s) Survived"
			EndTopStats.LiarsCalled.Text = participant.LiarsCalled .. " Liar(s) Called"
			EndTopStats.CardsPlayed.Text = participant.TotalCardsPlayed .. " Card(s) Played"
			EndTopStats.PotionsDrank.Text = participant.PotionsDrank .. " Potion(s) Drank"
			
			if totalCardsPlayedNum and totalCardsPlayedNum > 0 and participant.CashEarned then
				EndBottomStats.CardsPlayed.TextLabel.Text = "Cards Played (" .. totalCardsPlayedNum .. ")"
				EndBottomStats.CardsPlayed.CashAmount.Text = "+ $" .. totalCardsPlayedNum
				EndBottomStats.CardsPlayed.Visible = true
			else
				EndBottomStats.CardsPlayed.Visible = false
			end
			
			if roundSurvivedNum and roundSurvivedNum > 0 and participant.CashEarned then
				EndBottomStats.RoundsSurvived.TextLabel.Text = "Rounds Survived (" .. roundSurvivedNum .. ")"
				EndBottomStats.RoundsSurvived.CashAmount.Text = "+ $" .. roundSurvivedNum * 10
				EndBottomStats.RoundsSurvived.Visible = true
			else
				EndBottomStats.RoundsSurvived.Visible = false
			end
			
			if not participant.CashEarned then
				EndBottomStats.Visible = false
				EndCashStats.Visible = false
				EndNoCashInfo.Visible = true
			else
				EndBottomStats.Visible = true
				EndCashStats.Visible = true
				EndNoCashInfo.Visible = false
			end
			
			EndCashStats.MultiplierLabel.Text = "x " .. ((global.CachedPasses[Utilities.ProductIds.Passes.VIP.Id] and "2") or ("1")) .. "." .. ((isInGroup and "5") or ("0")) .. " ="
			EndCashStats.MainFrame.Amount.Text = participant.CashEarned or "0"
			
			EndCashStats.EventMultiplierLabel.Text = "x " .. ((global.CachedPasses[Utilities.ProductIds.Passes["x2 Beach Balls"].Id] and "2") or ("1")) .. ".0 ="
			EndCashStats.EventCurrency.Amount.Text = participant.EventCurrencyEarned or "0"
			
			if not global.CachedPasses[Utilities.ProductIds.Passes.VIP.Id] then
				Utilities.Utils.sendNotification("Double Cash", "Get x2 Cash permanently with the VIP game pass", "rbxassetid://123001081533070", "Purchase", nil, BindableCallback)
			elseif not global.CachedPasses[Utilities.ProductIds.Passes["x2 Beach Balls"].Id] then
				--Utilities.Utils.sendNotification("Double Beach Balls", "Get x2 Beach Balls permanently with the x2 Beach Balls game pass", "rbxassetid://106432558355449", "Purchase", nil, BindableCallback)
			end
		end
		
		if canPlayAgain then
			EndScreenButtons.PlayAgainButton.Title.Text = "Play Again (0/" .. numOfParticipants .. ")"
			EndScreenButtons.PlayAgainButton.Visible = true
		else
			EndScreenButtons.PlayAgainButton.Visible = false
		end
		
		EndScreenGui.Enabled = true
		RadioGui.Enabled = false
		EffectShopGui.Enabled = false
		
		if Utilities.Utils.getLastInput() == "controller" then
			Services.GamepadService:EnableGamepadCursor(nil)
		end
		
		mouseCurrentlyEnabled = true
		Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and true) or (false)
		Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer
		
		for i, v in pairs(global.Connections) do
			if type(v) == "table" then
				for _, connection in pairs(v) do
					pcall(function()
						connection:Disconnect()
					end)
				end
			end
		end
		
		gameEffectsIcon:deselect()
		gameEffectsIcon:setEnabled(false)
		
		currentSettingsIcon:deselect()
		currentSettingsIcon:setEnabled(false)
		
		Services.GameplayService:ClientLoaded("END GAME")
	else
		LoadingCenteredText.Text = "Loading..."
		LoadingScreenGui.Enabled = true

		isSpectating = false
		currentSpectate = nil
		
		local victories = Services.SoundService:FindFirstChild("Victories")
		
		if victories and victories:IsA("Folder") then
			for _, v in pairs(victories:GetChildren()) do
				if v:IsA("Sound") then
					v:Stop()
				end
			end
		end 
		
		VRTableClaim.Parent = UIStorage

		if not playAgain then
			camera.CameraType = Enum.CameraType.Custom

			repeat task.wait(1) until not Player.Character or not Player.Character.Parent

			for _, obj in pairs(ClientStorage:GetChildren()) do
				obj:Destroy()
			end

			Player.CameraMode = Enum.CameraMode.Classic

			camPart = LobbyRoomClone and LobbyRoomClone:FindFirstChild("CameraPart")

			if camPart then
				camera.CameraType = Enum.CameraType.Scriptable
				camera.CFrame = camPart.CFrame
			end
		end
		
		gameInProgress = false
		
		gameEffectsIcon:deselect()
		gameEffectsIcon:setEnabled(false)
		
		currentSettingsIcon:deselect()
		currentSettingsIcon:setEnabled(false)
		
		table.clear(global.ActiveEffects)
		
		for _, v in pairs(global.AllItems["Effects"]) do
			if type(v) == "table" and v.Data then
				v.Data.Unload(currentParticipants)
			end
		end

		local character = Player.Character

		if character then
			for i, v in pairs(character:GetDescendants()) do
				if global.Connections["TEMPORARY_TRANSPARENCY_" .. i] then
					Disconnect("TEMPORARY_TRANSPARENCY_" .. i)
				end
				
				if (v:IsA("BasePart")) and (v.Name == "Head" or v:FindFirstAncestorWhichIsA("Accessory")) then
					v.LocalTransparencyModifier = 1
				end
			end
		end

		currentParticipants = nil
		currentPositions = nil
		currentPlacementCFrame = nil
		currentItems = nil
		
		if voiceChatIcon then
			voiceChatIcon:setEnabled(true)
		end
		
		if proServerIcon then
			proServerIcon:setEnabled(true)
		end
		
		--if seventeenPlusIcon then
		--	seventeenPlusIcon:setEnabled(true)
		--end

		updateLogsIcon:deselect()
		updateLogsIcon:setEnabled(true)
		
		local serversIcon = Utilities.Icon.getIcon("Servers")
		local vcServersIcon = Utilities.Icon.getIcon("VC Servers")

		if serversIcon then
			serversIcon:setEnabled(true)
		end

		if vcServersIcon then
			vcServersIcon:setEnabled(true)
		end
		
		promoCodesIcon:deselect()
		promoCodesIcon:setEnabled(true)
		
		mouseCurrentlyEnabled = true
		Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and true) or (false)
		Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer
		
		for i, v in pairs(global.Values) do
			Disconnect("VALUE_CHANGED_" .. i)
		end
		
		table.clear(global.Values)
		
		global.Values = {
			["CurrentTurn"] = {Value = nil},
			["CurrentCard"] = {Value = nil},
			["CurrentState"] = {Value = nil},
			["Status"] = {Value = nil}
		}

		TimerGui.Enabled = false
		LobbyGui.Enabled = false
		TableClaimLabel.Visible = false
		EndScreenGui.Enabled = false
		
		TableClaimLabel.Text = ""
		TopMiddleClaimLabel.Text = ""
		TopMiddleLastClaim.Text = ""
		VRTableClaim.CurrentClaim.Text = ""
		VRTableClaim.LastClaim.Text = ""
		
		spectatingIcon:setEnabled(false)
		
		if not playAgain then
			MainMenuGui.Enabled = true
			
			BlurEffect.Size = 8
			
			Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
			
			LoadingScreenGui.Enabled = false
			SpectateGui.Enabled = false

			MainMusic:Play()
		end
	end
end

function ChangeShop(items) -- items = {["itemType"] = {["amount"] = item}}
	if not changingShop then
		changingShop = true
		
		local success, err = pcall(function()
			for _, v in pairs(ShopScrollingFrame:GetChildren()) do
				if v:IsA("Frame") and not string.find(v.Name, "LimitedTimeItems") and not string.find(v.Name, "MedalCollab") and not string.find(v.Name, "TopButtons") and not string.find(v.Name, "UGC") then
					v:Destroy()
				end
			end
			
			local prices = {
				[1] = 250,
				[2] = 750,
				[3] = 2000,
				[4] = 5000
			}
			
			for itemType, amounts in pairs(items) do
				local newShopFrame = ShopFrameTemplate:Clone()
				
				for amount, item in pairs(amounts) do
					local toNum = tonumber(amount)
					local index = toNum and table.find(prices, toNum)
					
					if index then
						local newItemFrame = ShopItemTemplate:Clone()
						
						newItemFrame.ImageLabel.Image = item.Image
						newItemFrame.ItemName.Text = item.Name
						newItemFrame.ItemType.Text = item.Type
						newItemFrame.ItemPrice.Text = ((item.CurrencyType == "Cash" and "$") or (item.CurrencyType == "Robux" and "") or ("")) .. (item.Price)
						newItemFrame.PriceType.Value = item.Price
						newItemFrame.ItemType.BackgroundColor3 = Utilities.ItemColors.Items[item.Type] or Color3.fromRGB(255, 255, 255)
						newItemFrame.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Utilities.ItemColors.Prices[tonumber(item.Price)])
						newItemFrame.Name = index
						
						local button = newItemFrame:FindFirstChild("TextButton")
						
						button.MouseButton1Click:Connect(function()
							ShopBuyScreen.UIGradient.Color = newItemFrame.UIGradient.Color
							ShopBuyScreen.ImageLabel.Image = newItemFrame.ImageLabel.Image
							ShopBuyScreen.ItemName.Text = newItemFrame.ItemName.Text
							ShopBuyScreen.ItemPrice.Text = newItemFrame.ItemPrice.Text
							ShopBuyScreen.ItemType.Text = newItemFrame.ItemType.Text
							ShopBuyScreen.ItemType.BackgroundColor3 = newItemFrame.ItemType.BackgroundColor3

							local buyButton = ShopBuyButtons:FindFirstChild("StartButton")

							if global.playerItemData[ShopBuyScreen.ItemType.Text] and table.find(global.playerItemData[ShopBuyScreen.ItemType.Text], ShopBuyScreen.ItemName.Text) then
								buyButton.Active = false
								buyButton.Interactable = false
								buyButton.Title.TextColor3 = Color3.fromRGB(135, 135, 135)
								buyButton.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
								buyButton.UIGradient.Enabled = false
								buyButton.Title.Text = "Owned"
							else
								buyButton.Active = true
								buyButton.Interactable = true
								buyButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
								buyButton.BackgroundColor3 = Color3.fromRGB(163, 222, 136)
								buyButton.UIGradient.Enabled = true
								buyButton.Title.Text = "Buy"
							end

							ShopFrame.Visible = false
							ShopBuyScreen.Visible = true
							ShopBackground.Back.Visible = false

							local tPassed = 2

							if currentShopSoundPlaying and currentShopSoundPlaying.IsPlaying then
								tPassed = 3 - currentShopSoundPlaying.TimeLength - 1
							end

							while ShopBuyScreen.Visible do
								tPassed += Services.RunService.Heartbeat:Wait()

								if tPassed >= 3 then
									tPassed = 0
									local items = global.AllItems[newItemFrame.ItemType.Text]
									local item = items and items[newItemFrame.ItemName.Text]

									if item then
										local randomSound
										
										if item.Type == "Voices" then
											local sounds = CreateVoiceFolderFor(item)
											randomSound = sounds and sounds:GetChildren()[math.random(1, #sounds:GetChildren())]
										elseif item.Type == "Victories" then
											randomSound = CreateVictorySoundFor(item)
										end
										
										if randomSound then
											randomSound:Play()
											currentShopSoundPlaying = randomSound
										end
									end
								end
							end
						end)

						button.MouseEnter:Connect(function()
							local items = global.AllItems[newItemFrame.ItemType.Text]
							local item = items and items[newItemFrame.ItemName.Text]

							if item then
								ShopDescription.Text = item.Description

								if currentShopSoundPlaying then
									currentShopSoundPlaying:Stop()
									currentShopSoundPlaying = nil
								end
								
								local randomSound

								if item.Type == "Voices" then
									local sounds = CreateVoiceFolderFor(item)
									randomSound = sounds and sounds:GetChildren()[math.random(1, #sounds:GetChildren())]
								elseif item.Type == "Victories" then
									randomSound = CreateVictorySoundFor(item)
								end

								if randomSound and ShopDescription.Text == item.Description and ShopFrame.Visible then
									randomSound:Play()
									currentShopSoundPlaying = randomSound
								end
							end
						end)

						button.MouseLeave:Connect(function()
							local items = global.AllItems[newItemFrame.ItemType.Text]
							local item = items and items[newItemFrame.ItemName.Text]

							if ShopDescription.Text == item.Description then
								if item then
									ShopDescription.Text = ""

									if currentShopSoundPlaying and ShopFrame.Visible then
										currentShopSoundPlaying:Stop()
										currentShopSoundPlaying = nil
									end
								end
							end
						end)
						
						newItemFrame.Parent = newShopFrame.ShopFrame
					end
				end
				
				newShopFrame.Name = itemType
				newShopFrame.ItemType.Text = itemType
				newShopFrame.Parent = ShopScrollingFrame
			end
			
			local robuxShopFrame = ShopFrameTemplate:Clone()
			
			for passName, pass in pairs(Utilities.ProductIds.Passes) do
				if passName == "VIP" then continue end
				
				local toNum = tonumber(pass.Price)
				local index = 9

				if index and not string.find(passName, "Space") and not string.find(passName, "Beach Balls") and not string.find(passName, "Exclusive") then
					local newItemFrame = ShopItemTemplate:Clone()

					newItemFrame.ImageLabel.Image = pass.Image
					newItemFrame.ItemName.Text = passName
					newItemFrame.ItemType.Text = "Game Pass"
					newItemFrame.ItemPrice.Text = "" .. pass.Price
					newItemFrame.PriceType.Value = pass.Price
					newItemFrame.ItemType.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					newItemFrame.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(55, 155, 55))
					newItemFrame.Name = index
					
					local newCorner = Instance.new("UICorner")
					
					newCorner.CornerRadius = UDim.new(1, 0)
					newCorner.Parent = newItemFrame.ImageLabel

					local button = newItemFrame:FindFirstChild("TextButton")
					local giftButton = newItemFrame:FindFirstChild("GiftButton")

					button.MouseButton1Click:Connect(function()
						ShopBuyScreen.UIGradient.Color = newItemFrame.UIGradient.Color
						ShopBuyScreen.ImageLabel.Image = newItemFrame.ImageLabel.Image
						ShopBuyScreen.ItemName.Text = newItemFrame.ItemName.Text
						ShopBuyScreen.ItemPrice.Text = newItemFrame.ItemPrice.Text
						ShopBuyScreen.ItemType.Text = newItemFrame.ItemType.Text
						ShopBuyScreen.ItemType.BackgroundColor3 = newItemFrame.ItemType.BackgroundColor3

						local buyButton = ShopBuyButtons:FindFirstChild("StartButton")

						if global.playerItemData[ShopBuyScreen.ItemType.Text] and table.find(global.playerItemData[ShopBuyScreen.ItemType.Text], ShopBuyScreen.ItemName.Text) then
							buyButton.Active = false
							buyButton.Interactable = false
							buyButton.Title.TextColor3 = Color3.fromRGB(135, 135, 135)
							buyButton.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
							buyButton.UIGradient.Enabled = false
							buyButton.Title.Text = "Owned"
						else
							buyButton.Active = true
							buyButton.Interactable = true
							buyButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
							buyButton.BackgroundColor3 = Color3.fromRGB(163, 222, 136)
							buyButton.UIGradient.Enabled = true
							buyButton.Title.Text = "Buy"
						end

						ShopFrame.Visible = false
						
						local passBuyScreen = GamePassBuyScreens:FindFirstChild(passName)
						
						if passBuyScreen then
							passBuyScreen.Visible = true
						else
							ShopBuyScreen.Visible = true
						end
						
						ShopBackground.Back.Visible = false

						local tPassed = 2

						if currentShopSoundPlaying and currentShopSoundPlaying.IsPlaying then
							tPassed = 3 - currentShopSoundPlaying.TimeLength - 1
						end

						while ShopBuyScreen.Visible do
							tPassed += Services.RunService.Heartbeat:Wait()

							if tPassed >= 3 then
								tPassed = 0
								local items = global.AllItems[newItemFrame.ItemType.Text]
								local item = items and items[newItemFrame.ItemName.Text]

								if item then
									local randomSound

									if item.Type == "Voices" then
										local sounds = CreateVoiceFolderFor(item)
										randomSound = sounds and sounds:GetChildren()[math.random(1, #sounds:GetChildren())]
									elseif item.Type == "Victories" then
										randomSound = CreateVictorySoundFor(item)
									end

									if randomSound then
										randomSound:Play()
										currentShopSoundPlaying = randomSound
									end
								end
							end
						end
					end)
					
					giftButton.MouseButton1Click:Connect(function()
						CashShopBackground.Visible = false
						ShopBackground.Back.Visible = false
						ShopGiftDetails.ImageLabel.Image = pass.Image
						ShopGiftDetails.ItemName.Text = passName
						ShopGiftDetails.ItemPrice.Text = "" .. pass.Price
						ShopGiftDetails.ItemType.Text = "Game Pass"
						ShopGiftScreen.Visible = true
						
						ShopFrame.Visible = false
						ShopBuyScreen.Visible = false
						ShopCashFrame.TextButton.Visible = false
						
						lastGiftScreen = "GamePass"
					end)

					giftButton.Visible = true
					
					newItemFrame.Parent = robuxShopFrame.ScrollingFrame
				end
			end
			
			robuxShopFrame.ShopFrame.Visible = false
			robuxShopFrame.ScrollingFrame.Visible = true
			robuxShopFrame.Name = "Passes"
			robuxShopFrame.ItemType.Text = "Passes"
			robuxShopFrame.Parent = ShopScrollingFrame
		end)
		
		if not success then
			warn(err)
		end
		
		ShopBuyScreen.Visible = false
		ShopFrame.Visible = true
		
		changingShop = false
	end
end

function UpdateInventory(inventoryName, inventory, equipped)
	local invFrame = InventoryFrames:FindFirstChild(inventoryName) 
	
	if invFrame then
		if inventory and global.AllItems[inventoryName] then
			attemptingEquip = false
			
			for _, v in pairs(invFrame:GetChildren()) do
				if v:IsA("GuiObject") then
					v:Destroy()
				end
			end
			
			table.sort(inventory, function(a, b)
				local itemA = global.AllItems[inventoryName] and global.AllItems[inventoryName][a]
				local itemB = global.AllItems[inventoryName] and global.AllItems[inventoryName][b] 
				
				return itemA and itemB and tonumber(itemA.Price) > tonumber(itemB.Price)
			end)
			
			for _, itemName in pairs(inventory) do
				local item = global.AllItems[inventoryName] and global.AllItems[inventoryName][itemName]
				
				if item then
					local newFrame = InventoryExample:Clone()
					
					newFrame.Name = item.Name
					newFrame.ImageLabel.Image = item.Image
					newFrame.EditionLabel.Image = item.Edition or "rbxassetid://"
					newFrame.EditionLabel.Visible = (item.Edition and true) or (false)
					newFrame.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Utilities.ItemColors.Prices[tonumber(item.Price)])
					newFrame.ItemName.Text = item.Name
					newFrame.ItemType.Text = item.Type
					newFrame.ItemType.BackgroundColor3 = Utilities.ItemColors.Items[item.Type]
					newFrame.Visible = true
					
					newFrame.TextButton.MouseButton1Click:Connect(function()
						if not attemptingEquip then
							attemptingEquip = true
							
							local success = Services.ShopService:AttemptEquip(item.Type, item.Name)
							
							if success then
								for _, v in pairs(invFrame:GetChildren()) do
									local UIStroke = v:FindFirstChildWhichIsA("UIStroke")

									if UIStroke then
										if item.Name == v.Name then
											UIStroke.Enabled = true
										else
											UIStroke.Enabled = false
										end
									end
								end
							end
							
							attemptingEquip = false
						end
					end)
					
					newFrame.TextButton.MouseEnter:Connect(function()
						if currentShopSoundPlaying then
							currentShopSoundPlaying:Stop()
							currentShopSoundPlaying = nil
						end
						
						local randomSound

						if item.Type == "Voices" then
							local sounds = CreateVoiceFolderFor(item)
							randomSound = sounds and sounds:GetChildren()[math.random(1, #sounds:GetChildren())]
						elseif item.Type == "Victories" then
							randomSound = CreateVictorySoundFor(item)
						end

						if randomSound and not currentShopSoundPlaying then
							randomSound:Play()
							currentShopSoundPlaying = randomSound
						end
					end)

					newFrame.TextButton.MouseLeave:Connect(function()
						if (currentShopSoundPlaying) and (currentShopSoundPlaying.Parent.Name == item.Name or currentShopSoundPlaying.Name == item.Name) then
							currentShopSoundPlaying:Stop()
							currentShopSoundPlaying = nil
						end
					end)
					
					newFrame.Parent = invFrame
				end
			end
		end
		
		if equipped then
			for _, v in pairs(invFrame:GetChildren()) do
				local UIStroke = v:FindFirstChildWhichIsA("UIStroke")
				
				if UIStroke then
					if equipped == v.Name then
						UIStroke.Enabled = true
					else
						UIStroke.Enabled = false
					end
				end
			end
		end
	end
end

function UpdateQuests(questData : any)
	global.CurrentQuestData = questData
	
	if type(questData) == "table" and type(questData.CurrentQuests) == "table" then
		for _, v in pairs(CurrentEventQuestsMain:GetChildren()) do
			if v:IsA("Frame") then
				local quest = questData.CurrentQuests[tonumber(v.Name)]

				if quest and type(quest) == "table" then
					v.Quest.Bar.Size = UDim2.new((quest.Value or 0) / (quest.Goal or 1), 0, 1, 0)
					v.Quest.Title.Text = quest.Display or "..."
					v.Title.Text = quest.Reward or 0
				end
			end
		end
	end
end

function UpdateBattlePass(currencyAmount : number)
	CurrentEventCurrencyLabel.Text = Utilities.Utils.formatNumber(currencyAmount, 100000)
	
	--eventCurrencyIcon:setLabel(CurrentEventCurrencyLabel.Text)
	
	if not loadingBattlePass then
		loadingBattlePass = true
		
		for i, v in pairs(Utilities.BattlePassItems) do
			local newPassTier = BattlePassTemplate:Clone()
			
			newPassTier.LayoutOrder = i
			newPassTier.ItemName.Text = v.Value
			newPassTier.ItemType.Text = v.Type
			newPassTier.ItemPrice.Text = Utilities.Utils.formatNumber(v.Price, 100000)
			
			if v.Type ~= "Cash" then
				local item = global.AllItems[v.Type] and global.AllItems[v.Type][v.Value]
				
				if type(item) == "table" and tonumber(item.Price) and type(item.Data) == "table" then
					newPassTier.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Utilities.ItemColors.Prices[tonumber(item.Price)])
					newPassTier.ImageLabel.Image = item.Image
				end
				
				newPassTier.ItemType.BackgroundColor3 = Utilities.ItemColors.Items[v.Type] or Color3.fromRGB(255, 255, 255)
				
				newPassTier.TextButton.MouseEnter:Connect(function()
					ShopDescription.Text = item.Description

					if currentShopSoundPlaying then
						currentShopSoundPlaying:Stop()
						currentShopSoundPlaying = nil
					end
					
					local randomSound

					if item.Type == "Voices" then
						local sounds = CreateVoiceFolderFor(item)
						randomSound = sounds and sounds:GetChildren()[math.random(1, #sounds:GetChildren())]
					elseif item.Type == "Victories" then
						randomSound = CreateVictorySoundFor(item)
					end
					
					if randomSound and ShopDescription.Text == item.Description and ShopFrame.Visible then
						randomSound:Play()
						currentShopSoundPlaying = randomSound
					end
				end)

				newPassTier.TextButton.MouseLeave:Connect(function()
					if ShopDescription.Text == item.Description then
						ShopDescription.Text = ""

						if currentShopSoundPlaying and ShopFrame.Visible then
							currentShopSoundPlaying:Stop()
							currentShopSoundPlaying = nil
						end
					end
				end)
			else
				newPassTier.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(55, 155, 55))
				newPassTier.ImageLabel.Image = "rbxassetid://108667083303574"
				newPassTier.ItemType.BackgroundColor3 = Color3.fromRGB(55, 255, 55)
			end
			
			newPassTier.TextButton.MouseButton1Click:Connect(function()
				if newPassTier.Lock.Visible then
					Services.ShopService:PromptLowestProduct("Beach Balls", v.Price)
				end
			end)
			
			newPassTier.Parent = CurrentEventBattlePassFrame
		end
		
		loadedBattlePass = true
	end

	if not loadedBattlePass then repeat task.wait() until loadedBattlePass end
	
	for i, v in pairs(CurrentEventBattlePassFrame:GetChildren()) do
		if v:IsA("Frame") then
			local passItem = Utilities.BattlePassItems[v.LayoutOrder]
			local lockImage = v:FindFirstChild("Lock")
			
			if passItem and lockImage then
				if passItem.Price <= currencyAmount then
					lockImage.Dark.BackgroundTransparency = 1
					lockImage.Image = "rbxassetid://72789803893424"
				else
					lockImage.Dark.BackgroundTransparency = 0.6
					lockImage.Image = "rbxassetid://99645832396378"
				end
			end
		end
	end
end

function InputBegan(keyCode : Enum.KeyCode, gameProcessed)
	local enumCode = Enum.KeyCode

	if (not gameProcessed or Utilities.Utils.getLastInput() == "controller" or Services.VRService.VREnabled) and (Player.Character) and (Player.Character.Parent == workspace) then
		if not Services.VRService.VREnabled then	
			if keyCode == enumCode.Space or keyCode == enumCode.ButtonY then
				if global.Values["CurrentTurn"].Value == Player.UserId and global.Values["CurrentState"].Value == "TURN START" and CurrentSelected then
					SelectingCard()
				else
					AnimationController:Play(Player.UserId .. "_Hold")
					
					task.spawn(function()
						Services.GameplayService:UpdateAnimation("Hold", "Play")
					end)
				end
			elseif keyCode == enumCode.A or keyCode == enumCode.Left or keyCode == enumCode.DPadLeft or keyCode == enumCode.ButtonL1 then
				if global.Values["CurrentTurn"].Value == Player.UserId and global.Values["CurrentState"].Value == "TURN START" then
					SwitchCards(false)
				elseif isSpectating and currentSpectate then
					ChangeSpectate()
				end
			elseif keyCode == enumCode.D or keyCode == enumCode.Right or keyCode == enumCode.DPadRight or keyCode == enumCode.ButtonR1 then
				if global.Values["CurrentTurn"].Value == Player.UserId and global.Values["CurrentState"].Value == "TURN START"  then
					SwitchCards(true)
				elseif isSpectating and currentSpectate then
					ChangeSpectate(true)
				end
			elseif keyCode == enumCode.E or keyCode == enumCode.ButtonA then			
				if global.SelectedCards then
					if #global.SelectedCards > 0 then
						local success, result = Services.GameplayService:AttemptPlayCard(global.SelectedCards)

						if success then
							PlayCard()
						else
							--warn(result)
						end
					end
				end
			elseif keyCode == enumCode.X or keyCode == enumCode.ButtonX then
				local success, result = Services.GameplayService:AttemptCallOut()

				if success then
					AnimationController:Play(Player.UserId .. "_Fist")
					AnimationController:Stop(Player.UserId .. "_Hold")
					
					task.spawn(function()
						Services.GameplayService:UpdateAnimation("Hold", "Stop")
					end)
					
					enableMobileGui()
					enableMobileCards()
					EnableHighlights(Player.Character, false)
					table.clear(global.SelectedCards)
				else
					--warn(result)
				end
			elseif keyCode == enumCode.Q and gameEffectsIcon.isEnabled and gameInProgress then
				if gameEffectsIcon.isSelected then
					gameEffectsIcon:deselect()
				else
					gameEffectsIcon:select()
				end
			elseif keyCode == enumCode.P and currentSettingsIcon.isEnabled and gameInProgress then
				if currentSettingsIcon.isSelected then
					currentSettingsIcon:deselect()
				else
					currentSettingsIcon:select()
				end
			end
		else
			if keyCode == enumCode.ButtonA or keyCode == enumCode.ButtonR2 then
				if global.Values["CurrentTurn"].Value == Player.UserId and global.Values["CurrentState"].Value == "TURN START" and CurrentSelected and not grabbingCardVR then
					for _, v in pairs(global.CurrentHeldCards) do
						if v then 
							return
						end
					end
					
					SelectingCard()
				end
			elseif keyCode == enumCode.ButtonX then
				local success, result = Services.GameplayService:AttemptCallOut(true)
				
				if not success then
					warn(result)
				end
			elseif keyCode == enumCode.ButtonR1 then
				-- grab card
				grabbingCardVR = true
				
				if not global.Values["CurrentTurn"].Value or tostring(global.Values["CurrentTurn"].Value) ~= tostring(Player.UserId) then return end
				if #global.SelectedCards <= 0 then return end
				if #global.CurrentHeldCards > 0 then return end
				
				local character = Player.Character
				local characterCards = character and character:FindFirstChild("Cards")
				local rightHand = character and character:FindFirstChild("RightHand")
				local leftHand = character and character:FindFirstChild("LeftHand")

				if not rightHand or not leftHand or (rightHand.Position - leftHand.Position).Magnitude > 1.2 then return end
				
				if characterCards then
					for i = 1, 5 do
						local currentCard = characterCards:FindFirstChild("Card" .. i)

						if currentCard.Transparency ~= 1 and not table.find(global.SelectedCards, i) then
							global.CurrentHeldCards[i] = true
						else
							global.CurrentHeldCards[i] = false
						end
					end
					
					Services.GameplayService:UpdateVR("CARD_GRAB", global.CurrentHeldCards, global.SelectedCards)

					UpdateCards(Player, global.CurrentHeldCards)

					local getCard = character and character:FindFirstChild("RightHandCard")

					if getCard then
						getCard.Transparency = 0

						local backOfCard = getCard:FindFirstChild("Back")

						if backOfCard then
							backOfCard.Face = Enum.NormalId.Top
							backOfCard.Transparency = 0
						end
					end
				end
			end
		end
	end
end

function InputEnded(keyCode : Enum.KeyCode)
	local enumCode = Enum.KeyCode

	if Player.Character and Player.Character.Parent == workspace then
		if not Services.VRService.VREnabled then	
			if (keyCode == enumCode.Space or keyCode == enumCode.ButtonY) and (global.Values["CurrentTurn"].Value ~= Player.UserId or global.Values["CurrentState"].Value ~= "TURN START") then
				AnimationController:Stop(Player.UserId .. "_Hold")
				
				task.spawn(function()
					Services.GameplayService:UpdateAnimation("Hold", "Stop")
				end)
			end
		else
			if keyCode == enumCode.ButtonR1 then
				-- release card
				
				local success, err = pcall(function()
					if not global.Values["CurrentTurn"].Value or tostring(global.Values["CurrentTurn"].Value) ~= tostring(Player.UserId) then return end
					if #global.SelectedCards <= 0 then return end
					if #global.CurrentHeldCards <= 0 then return end
					
					local character = Player.Character
					local rightHand = character and character:FindFirstChild("RightHand")
					local leftHand = character and character:FindFirstChild("LeftHand")
					
					if false then--not rightHand or not leftHand or (rightHand.Position - leftHand.Position).Magnitude < 1.2 then
						local characterCards = character and character:FindFirstChild("Cards")

						if characterCards then
							local currentCardsInHand = {}
							local personalCardsInHand = {}
							
							for i = 1, 5 do
								local currentCard = characterCards:FindFirstChild("Card" .. i)

								if currentCard.Transparency ~= 1 or global.CurrentHeldCards[i] or table.find(global.SelectedCards, i) then
									currentCardsInHand[i] = true
									personalCardsInHand[i] = currentPersonalCards[i]
								else
									currentCardsInHand[i] = false
								end
							end
							
							table.clear(global.CurrentHeldCards)
							
							Services.GameplayService:UpdateVR("CARD_RELEASE", currentCardsInHand)

							UpdateCards(Player, currentCardsInHand)
						end
						
						local getCard = character and character:FindFirstChild("RightHandCard")

						if getCard then
							getCard.Transparency = 1

							local backOfCard = getCard:FindFirstChild("Back")

							if backOfCard then
								backOfCard.Face = Enum.NormalId.Top
								backOfCard.Transparency = 1
							end
						end
					else
						local success, result = Services.GameplayService:AttemptPlayCard(global.SelectedCards, true)

						if not success then
							warn(result)
						end
					end
				end)
				
				if not success then warn(err) end
				
				grabbingCardVR = false
			end
		end
	end
end

totalLoaded += 1

Services.UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
	InputBegan(inputObject.KeyCode, gameProcessed)
end)

Services.UserInputService.InputEnded:Connect(function(inputObject)
	InputEnded(inputObject.KeyCode)
end)

BindableCallback.OnInvoke = function(answer)
	if answer == "Purchase" then
		if not global.CachedPasses[Utilities.ProductIds.Passes.VIP.Id] then
			Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes.VIP.Id, "GamePass")
		elseif not global.CachedPasses[Utilities.ProductIds.Passes["x2 Beach Balls"].Id] then
			Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["x2 Beach Balls"].Id, "GamePass")
		end
	end
end

GamePassOwned.OnInvoke = function(passId)
	return global.CachedPasses[passId]
end

allTweens.groupTween2.Completed:Connect(function()
	TopMiddleLastClaim.Text = "LAST CLAIM: " .. PlayerClaimInfo.Text
	VRTableClaim.LastClaim.Text = TopMiddleLastClaim.Text
	PlayerClaimGroup.GroupTransparency = 1
end)

allTweens.eyeShutTween.Completed:Connect(function()
	BlackFadeImage.BackgroundTransparency = 0
end)

Services.EmoteService.EmotePlayed:Connect(function(emoteName, emoteImage)
	local newImage = EmoteLabel:Clone()
	
	newImage.Visible = false
	newImage.Size = UDim2.new(0, 0, 0, 0)
	newImage.Position = UDim2.new(0.005, 0, 1, 0)
	newImage.Image = emoteImage
	newImage.Visible = true
	newImage.Parent = EmoteGui
	
	local emoteTweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local newTween = Services.TweenService:Create(newImage, emoteTweenInfo, {Size = UDim2.new(0.1, 0, 0.235, 0), Position = UDim2.new(0.005, 0, 0.99, 0)})
	
	newTween.Completed:Once(function()
		newTween:Destroy()
		
		task.delay(3, function()
			newImage:Destroy()
		end)
	end)
	
	newTween:Play()
end)

Services.QuestsService.DataChanged:Connect(function(questData)
	UpdateQuests(questData)
end)

Services.InventoryService.DataChanged:Connect(function(inventoryData)
	if type(inventoryData) == "table" and inventoryData.Inventories then
		global.playerItemData = inventoryData.Inventories
	end
end)

Services.InventoryService.InventoryChanged:Connect(function(inventoryName, inventory, equipped, updateType)
	if updateType == "DataLoaded" or updateType == "ItemAdded" or updateType == "ItemRemoved" then
		UpdateInventory(inventoryName, inventory, equipped)
	end
end)

Services.CurrencyService.CurrencyChanged:Connect(function(currencyName, currencyAmount)
	if currencyName == "Cash" then
		ShopCashLabel.Text = "$" ..Utilities.Utils.formatNumber(currencyAmount, 1000000)
		EffectCashLabel.Text = "$" .. Utilities.Utils.formatNumber(currencyAmount, 1000000)
		cashIcon:setLabel(ShopCashLabel.Text)
	elseif currencyName == "Beach Balls" then
		if not allItemsLoaded then
			local timePassed = 0
			
			repeat task.wait()
				timePassed += Services.RunService.Heartbeat:Wait()
			until allItemsLoaded or timePassed >= 30
		end
		
		UpdateBattlePass(currencyAmount)
	elseif currencyName == "Wins" then
		--LoadProServerIcon(currencyAmount)
	end
	
	UpdateStatsFrame(currencyName, currencyAmount)
end)

allTweens.cashEarnedTween2.Completed:Connect(function()
	CashEarnedGui.Enabled = false
end)

allTweens.cashEarnedTween1.Completed:Connect(function()
	task.wait(2)
	allTweens.cashEarnedTween2:Play()
end)

Services.CurrencyService.AddedCurrency:Connect(function(currencyName, amountAdded)
	if currencyName == "Cash" and not ShopGui.Enabled and not PromoCodesGui.Enabled then
		task.delay(5, function()
			cashEarnedLabel.Text = "+$" .. Utilities.Utils.formatNumber(amountAdded, 1000000)
			cashEarnedLabel.TextTransparency = 1
			CashEarnedGui.Enabled = true
			allTweens.cashEarnedTween1:Play()
		end)
	end
end)

Services.GameplayService.MovementUpdate:Connect(function(object, newCFrame)
	if object and newCFrame then
		Services.TweenService:Create(object, allTweenInfos.movementTweenFo, {C0 = newCFrame}):Play()
	end
end)

Services.GameplayService.RadioUpdated:Connect(function(fromPlayer, updateType, ...)
	local args = table.pack(...)
	
	if updateType == "SONG" then
		local radiosFolder = ClientStorage:FindFirstChild("RADIOS")
		local radioModel = radiosFolder and radiosFolder:FindFirstChild(fromPlayer.UserId .. "_RADIO")
		local soundObject = radioModel and radioModel:FindFirstChildWhichIsA("Sound", true)
		local newId = tonumber(args[1]) or 0
		
		if soundObject and newId then
			if newId == 0 then
				soundObject:Stop()
			else
				soundObject.SoundId = "rbxassetid://" .. newId
				soundObject:Play()
			end
		end
	end
end)

Services.GameplayService.ServerForced:Connect(function(method, ...)
	local args = table.pack(...)
	
	if method == "AttemptPlayCard" then
		PlayCard()
	elseif method == "AttemptDrinkPotion" then
		DrinkPotion(args[1])
	elseif method == "AttemptLeaveTable" then
		LobbyListFrame.Visible = true
		LobbyScreenFrame.Visible = false

		local lobbyFrame = args[1] and ListFrame:FindFirstChild(args[1])
		
		if lobbyFrame then
			lobbyFrame:Destroy()
		end
	elseif method == "AttemptCallOut" then
		AnimationController:Play(Player.UserId .. "_Fist")
		AnimationController:Stop(Player.UserId .. "_Hold")
		
		task.spawn(function()
			Services.GameplayService:UpdateAnimation("Hold", "Stop")
		end)

		enableMobileGui()
		enableMobileCards()
		EnableHighlights(Player.Character, false)
		table.clear(global.SelectedCards)
	end
end)

Services.GameplayService.LivingParticipantsChanged:Connect(function(participants)
	currentParticipants = participants
	
	if isSpectating then
		local stillAlive = false
		
		for _, v in pairs(currentParticipants) do
			if v.UserId == currentSpectate.UserId then
				stillAlive = true
			end
		end
		
		if not stillAlive and not Services.VRService.VREnabled then
			ChangeSpectate(true)
		end
	end
end)

Services.GameplayService.CardsPlayed:Connect(function(player, cards, cardAmount, adminCards, isVR)
	lastCardAmounts = cards
	PlayCard(player, cardAmount, adminCards, isVR)
end)

Services.GameplayService.PotionAdded:Connect(AddDrink)

Services.GameplayService.PotionDrank:Connect(function(playerDrinking, chosenPotion, shouldKnockout, isVR)
	global.ChosenPotions[tostring(playerDrinking.UserId)] = chosenPotion
	
	if playerDrinking.UserId and tostring(playerDrinking.UserId) ~= tostring(Player.UserId) then
		local knockout = global.AllItems["Knockouts"][currentItems[tostring(playerDrinking.UserId)]["Knockouts"] or "Default"]
		
		AnimationController:Stop(playerDrinking.UserId .. "_Potions")
		
		local animTrack = (not isVR and AnimationController:Play(playerDrinking.UserId .. "_Drink")) or (AnimationController:GetTrack(playerDrinking.UserId .. "_Drink"))
		
		if isVR then
			DrinkPickUp(playerDrinking, animTrack.Length)
			DrinkTopOff(playerDrinking)
			
			local character = playerDrinking and playerDrinking.Character
			local head = character and character:FindFirstChild("Head")
			local hand = character and character:FindFirstChild("RightHand")
			
			if head and head:IsA("BasePart") and hand and hand:IsA("BasePart") then
				local timePassed = 0
				local nearHead = false
				
				repeat
					timePassed += Services.RunService.Heartbeat:Wait()
					
					if (head.Position - hand.Position).Magnitude < 0.8 then
						nearHead = true
					end
				until timePassed > animTrack.Length or nearHead
				
				DrinkSound:Play()
				
				task.wait(0.8)
			else
				task.wait(animTrack.Length / 2)
				
				DrinkSound:Play()
					
				task.wait(animTrack.Length / 2 + 0.8)
			end
		else
			task.wait(animTrack.Length + 0.8)
		end
		
		if shouldKnockout then
			AnimationController:Play(playerDrinking.UserId .. "_Knockout_" .. knockout.Name)

			task.delay(0.1, function()
				BonkSound:Play()
			end)
		end
	end
end)

Services.GameplayService.PlayerCalledOut:Connect(function(participantCalledOut, participantCalling, lastPlayed, currentCard, isVR)	
	if type(participantCalling) == "table" and participantCalling.UserId then
		if tostring(participantCalling.UserId) ~= tostring(Player.UserId) and not isVR then
			AnimationController:Play(participantCalling.UserId .. "_Fist")
			AnimationController:Stop(participantCalling.UserId .. "_Hold")
		end
	end
	
	task.delay(1, function()
		AnimationController:Stop(Player.UserId .. "_Hold")

		task.spawn(function()
			Services.GameplayService:UpdateAnimation("Hold", "Stop")
		end)
	end)
	
	enableMobileGui()
	enableMobileCards()
	EnableHighlights(Player.Character, false)
	table.clear(global.SelectedCards)
	
	if isVR then
		local success, err = pcall(function()
			local voice = currentItems and global.AllItems["Voices"][currentItems[participantCalling.UserId]["Voices"] or "Default"]
			local voiceName = voice and voice.Name
			local soundFolder = SoundStorage:FindFirstChild(voiceName)
			local currentSound = soundFolder and soundFolder:FindFirstChild("Liar")

			if currentSound then
				currentSound:Play()
				TriggerHaptics()
			end
		end)
		
		if not success then
			warn(err)
		end
	end
	
	local character = participantCalledOut.Player and participantCalledOut.Player.Character
	local rightHandCard = character and character:FindFirstChild("RightHandCard")
	local stackedCards = ClientStorage:FindFirstChild("STACKED_CARDS")
	local primaryPart = stackedCards and stackedCards.PrimaryPart
	
	if primaryPart and rightHandCard then
		local centerCFrame = CFrame.new(primaryPart.Position)
		local primarySizeX = primaryPart.Size.X / 1.8
		local totalSize = primarySizeX * #lastPlayed
		local newTween = Services.TweenService:Create(primaryPart, allTweenInfos.cardTweenInfo, {CFrame = centerCFrame * CFrame.new(totalSize + primarySizeX, 0, 0)})
		
		newTween.Completed:Once(function()
			newTween:Destroy()
		end)
		
		for _, v in pairs(stackedCards:GetChildren()) do
			task.spawn(function()
				if v ~= primaryPart then
					local yDiff = v.Position.Y - primaryPart.Position.Y
					local newStackedTween = Services.TweenService:Create(v, allTweenInfos.cardTweenInfo, {CFrame = centerCFrame * CFrame.new(totalSize + primarySizeX, yDiff, 0)})
					
					newStackedTween.Completed:Once(function()
						newStackedTween:Destroy()
					end)
					
					newStackedTween:Play()	
				end
			end)
		end
		
		newTween:Play()
		
		task.wait(1)
		
		local currentCFrame = centerCFrame * CFrame.new(-totalSize / 2, 0, 0)
		local cardsFolder = Instance.new("Folder")
		
		cardsFolder.Name = "FLIPPED_CARDS"
		cardsFolder.Parent = ClientStorage
		
		for i, v in pairs(lastPlayed) do
			local cardCFrame = currentCFrame * CFrame.new((i - 1) * (totalSize / #lastPlayed), (i - 1) * (primaryPart.Size.Y), 0)
			local newCard = rightHandCard:Clone()
			local motor6D = newCard:FindFirstChildWhichIsA("Motor6D")
			
			if motor6D then
				motor6D:Destroy()
			end
			
			newCard.Anchored = true
			newCard.CFrame = cardCFrame
			newCard.Parent = cardsFolder
			
			local cardColor =  (v == "Demon" and Color3.fromRGB(35, 35, 35)) or (v == "Angel" and Color3.fromRGB(220, 220, 220)) or ((v == currentCard or v == "Joker") and Color3.fromRGB(0, 255, 0)) or (Color3.fromRGB(255, 0, 0))
		
			newCard.Color = cardColor
			
			if v ~= "Demon" and v ~= "Angel" then
				local newHighlight = Instance.new("Highlight")
				
				newHighlight.FillColor = cardColor
				newHighlight.FillTransparency = 0.6
				newHighlight.OutlineTransparency = 0.2
				newHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				newHighlight.Enabled = true
				newHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
				newHighlight.Adornee = newCard
				newHighlight.Parent = newCard
			end
			
			for _, d in pairs(newCard:GetChildren()) do
				if d:IsA("Decal") then
					if (d.Name == v) or ((v == "Demon" or v == "Angel") and v == global.Values["CurrentCard"].Value) then
						d.Transparency = 0
						
						if v ~= "Demon" and v ~= "Angel" then
							d.Color3 = cardColor
						end
					else
						d.Transparency = 1
					end
				end
			end
			
			newCard.Transparency = 0
		end
		
		task.wait(3)
		
		for _, v in pairs(cardsFolder:GetChildren()) do
			v:Destroy()
		end
	end

	Services.GameplayService:ClientLoaded("CALL OUT")
end)

Services.GameplayService.RoundStarted:Connect(function(plyrs, personalCards, multipleCards, claimedCard, cardDeck, includeDemon, includeAngel, adminCards)
	potionChoiceStarted = false
	
	local success, err = pcall(function()
		local defaultCard = global.AllItems["Cards"]["Default"]
		local cardModel = defaultCard and defaultCard.Model
		
		if cardModel and currentPlacementCFrame then
			local newCard = cardModel:Clone()
			
			newCard.Transparency = 0
			newCard.Color = Color3.fromRGB(255, 255, 255)
			
			for _, v in pairs(newCard:GetChildren()) do
				if v:IsA("Decal") then
					if v.Name == claimedCard or v.Name == "Back" then
						v.Transparency = 0
						v.Color3 = Color3.fromRGB(255, 255, 255)
					else
						v.Transparency = 1
					end
				end
			end
			
			local newHighlight = Instance.new("Highlight")

			newHighlight.FillTransparency = 0.8
			newHighlight.FillColor = Color3.fromRGB(255, 255, 255)
			newHighlight.OutlineTransparency = 0
			newHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			newHighlight.Enabled = true
			newHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
			newHighlight.Adornee = newCard
			newHighlight.Parent = newCard
			
			local newBillboard = Instance.new("BillboardGui")

			newBillboard.Size = UDim2.new(4, 0, 2, 0)
			newBillboard.StudsOffsetWorldSpace = Vector3.new(0, 0, -1.65)
			newBillboard.Brightness = 100
			newBillboard.LightInfluence = 0
			newBillboard.Enabled = true
			newBillboard.AlwaysOnTop = true
			newBillboard.Parent = newCard
			
			local UIListLayout = Instance.new("UIListLayout")
			
			UIListLayout.Parent = newBillboard
			UIListLayout.SortOrder = Enum.SortOrder.Name
			
			local newLabel = TableClaimLabel:Clone()
			local aspectRatio = newLabel:FindFirstChildWhichIsA("UIAspectRatioConstraint")
			
			if aspectRatio then
				aspectRatio:Destroy()
			end
			
			newLabel.Size = UDim2.new(1, 0, 0.25, 0)
			newLabel.Position = UDim2.new(0, 0, 0, 0)
			newLabel.TextXAlignment = Enum.TextXAlignment.Center
			newLabel.Visible = true
			newLabel.Text = string.upper(claimedCard) .. "'S CLAIM"
			newLabel.Name = "1"
			newLabel.Parent = newBillboard
			
			local newContains = DeckContainsTemplate:Clone()
			
			for _, v in pairs(newContains.Cards:GetChildren()) do
				if v:IsA("TextLabel") then
					local cardAmount = cardDeck[v.Name]
					
					if cardAmount then
						if cardAmount == "1" or cardAmount == 1 then
							v.Text = cardAmount .. " x " .. v.Name
						else
							v.Text = cardAmount .. " x " .. v.Name .. "s"
						end
						
						v.Visible = true
					else
						v.Visible = false
					end
				end
			end
			
			newContains.Name = "2"
			newContains.Parent = newBillboard
			
			local placementPos = currentPlacementCFrame.Position + Vector3.new(0, 0.5, 0)
			local pos = type(currentPositions) == "table" and currentPositions[tostring(Player.UserId)]
			local lookAt = (placementPos and pos) and (Vector3.new(pos.X, placementPos.Y, pos.Z))
			
			newCard.Anchored = true
			
			if lookAt then
				newCard.CFrame = CFrame.new(placementPos, lookAt) * CFrame.Angles(math.rad(90), 0, 0)
			else
				newCard.CFrame = CFrame.new(placementPos) * CFrame.Angles(math.rad(90), 0, 0)
			end
			
			newCard.Parent = ClientStorage
			
			local timePassed = 0
			local endTime = 7
			local changedToDemon = false
			local changedToAngel = false
			
			repeat
				local dt = Services.RunService.Heartbeat:Wait()
				newCard.CFrame *= CFrame.Angles(0, 0, math.rad(90 * dt))
				timePassed += dt
				
				if includeAngel and not changedToAngel then
					changedToAngel = true

					newCard.Color = Color3.fromRGB(0, 0, 0)

					local cardImage = newCard:FindFirstChild(claimedCard, true)

					if cardImage then
						cardImage.Texture = Utilities.CardImages.Angel[claimedCard]
					end
				elseif includeDemon and not changedToDemon and timePassed >= endTime / 2 then
					changedToDemon = true
					
					newCard.Color = Color3.fromRGB(0, 0, 0)
					
					local cardImage = newCard:FindFirstChild(claimedCard, true)
					
					if cardImage then
						cardImage.Texture = Utilities.CardImages.Demon[claimedCard]
					end
				end
			until timePassed >= endTime
			
			newCard:Destroy()
		end
	end)
	
	if not success then
		warn(err)
	end
	
	lastStackedPos = nil
	
	TableClaimLabel.Text = string.upper(claimedCard) .. "'S CLAIM"
	TopMiddleClaimLabel.Text = string.upper(claimedCard) .. "'S CLAIM"
	VRTableClaim.CurrentClaim.Text = TopMiddleClaimLabel.Text
	TopMiddleLastClaim.Text = "WAITING FOR FIRST CLAIM"
	VRTableClaim.LastClaim.Text = TopMiddleLastClaim.Text

	if personalCards then
		currentPersonalCards = personalCards
		
		UpdateCards(Player, personalCards, true)
	end

	if multipleCards then
		for _, v in pairs(plyrs) do
			if multipleCards[tostring(v.UserId)] then
				UpdateCards(v, multipleCards[tostring(v.UserId)])
			end
			
			if adminCards and type(adminCards) == "table" and adminCards[tostring(v.UserId)] then
				for _, cParticipant in pairs(currentParticipants) do
					if cParticipant.UserId and tonumber(cParticipant.UserId) == tonumber(v.UserId) then
						cParticipant.Cards = adminCards[tostring(v.UserId)]
					end
				end
			end

			EnableHighlights(v.Character, false)
		end
	end

	Services.GameplayService:ClientLoaded("ROUND START")
end)

Services.GameplayService.GameEnded:Connect(function(winner, numOfParticipants, participantsStartedWith, participant, isInGroup, canPlayAgain)
	GameEnded(winner, numOfParticipants, participantsStartedWith, participant, isInGroup, canPlayAgain, true)
end)

Services.GameplayService.UpdateEndGame:Connect(function(updateType, ...)
	local args = table.pack(...)
	
	if updateType == "Participants" and type(args) == "table" and args[1] then
		EndScreenButtons.PlayAgainButton.Title.Text = "Play Again (" .. args[1] .. ")"
	elseif updateType == "Ended" then
		EndScreenButtons.PlayAgainButton.Visible = false
		EndScreenButtons.PlayAgainButton.Timer.Visible = false
	end
end)

allTweens.effectNotificationTween1.Completed:Connect(function()
	task.delay(2, function()
		allTweens.effectNotificationTween2:Play()
	end)
end)

Services.GameplayService.GameEffect:Connect(function(enable, effectName, enabledBy)
	if global.AllItems["Effects"] and global.AllItems["Effects"][effectName] then
		if enable and gameInProgress then
			global.AllItems["Effects"][effectName].Data.Load(currentParticipants)
			
			table.insert(global.ActiveEffects, effectName)
			
			local effectFrame = MainEffectFrame:FindFirstChild(effectName)
			local button = effectFrame and effectFrame:FindFirstChildWhichIsA("TextButton")
			
			task.spawn(function()
				EffectNotificationLabel.Text = "+ " .. effectName .. " (activated by " .. enabledBy .. ")"
				allTweens.effectNotificationTween1:Play()
			end)
			
			local toNum = tonumber(global.AllItems["Effects"][effectName].Data.TimeLength)
			
			if toNum then
				for i = toNum, 1, -1 do
					task.wait(1)
					
					if button then
						button.Interactable = false
						button.AutoButtonColor = false
						button.BackgroundColor3 = Color3.fromRGB(115, 115, 115)
						button.Text = i
					end
					
					if not table.find(global.ActiveEffects, effectName) then
						break
					else
					end
				end
			end
			
			local findEffect = table.find(global.ActiveEffects, effectName)
			
			if findEffect then
				table.remove(global.ActiveEffects, findEffect)
			end
			
			if button then
				button.Interactable = true
				button.AutoButtonColor = true
				button.BackgroundColor3 = Color3.fromRGB(55, 155, 55)
				button.Text = "$" .. Utilities.Utils.formatNumber(global.AllItems["Effects"][effectName].Price, 10000)
			end
			
			if currentParticipants then
				global.AllItems["Effects"][effectName].Data.Unload(currentParticipants)
			end
			
			--[[table.insert(global.EffectUnloads, task.delay(global.AllItems["Effects"][effectName].Data.TimeLength, function()
				if currentParticipants then
					global.AllItems["Effects"][effectName].Data.Unload(currentParticipants)
				end
			end))]]
		else
			global.AllItems["Effects"][effectName].Data.Unload(currentParticipants)
		end
	end
end)

Services.GameplayService.LoadingGame:Connect(function(playingAgain)
	if not gameInProgress then
		LoadingScreenGui.Enabled = true
		
		if Services.VRService.VREnabled then
			Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0)
		end
	end
	
	if playingAgain then
		GameEnded(nil, nil, nil, nil, nil, nil, nil, true)
		Services.GameplayService:ClientLoaded("PLAYING AGAIN")
	end
end)

Services.GameplayService.TurnStarted:Connect(function(currentTurn, timer)
	--potionChoiceStarted = false
	
	TimerLabel.Text = timer or "15"
	TimerGui.Enabled = true
	
	if tostring(currentTurn.UserId) == tostring(Player.UserId) then
		Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer
		
		table.clear(global.CurrentHeldCards)
		table.clear(global.SelectedCards)
		
		if not Services.VRService.VREnabled then
			AnimationController:Play(Player.UserId .. "_Hold")

			task.spawn(function()
				Services.GameplayService:UpdateAnimation("Hold", "Play")
			end)
		end
		
		enableMobileCards(true)
		enableMobileGui("5", "6")

		SwitchCards(true, 1)
	else
		--AnimationController:Play(currentTurn.UserId .. "_Hold")
		
		Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Disabled
		
		enableMobileCards()
		enableMobileGui("4", ((isAnyLiar and not isSpectating) and ("6")))
		EnableHighlights(Player.Character, false)
	end

	if currentRotationPart then
		local pos = currentPositions and currentPositions[tostring(currentTurn.UserId)]

		if pos then
			pos = Vector3.new(pos.X, currentRotationPart.Position.Y, pos.Z)

			local newTween = Services.TweenService:Create(currentRotationPart, allTweenInfos.cardTweenInfo, {CFrame = CFrame.new(currentRotationPart.Position, pos) * CFrame.Angles(0, math.rad(180), 0)})

			newTween.Completed:Once(function()
				newTween:Destroy()
			end)

			newTween:Play()
		end
	end
end)

Services.GameplayService.SpectatorsChanged:Connect(function(amount : number)
	local toNum = tonumber(amount)
	
	if toNum and toNum > 0 then
		spectatingIcon:setLabel("👁️ " .. amount)
		spectatingIcon:setEnabled(true)
	else
		spectatingIcon:setLabel("")
		spectatingIcon:setEnabled(false)
	end
end)

Services.GameplayService.GameLoaded:Connect(function(placementCFrame, positions, roomType, items, passes, values, biggerTable, tableSettings, playingAgain)
	LoadingScreenGui.Enabled = true
	LobbyListFrame.Visible = false
	LobbyScreenFrame.Visible = false
	
	TopMiddleClaimLabel.Text = ""
	TopMiddleLastClaim.Text = ""
	VRTableClaim.CurrentClaim.Text = ""
	VRTableClaim.LastClaim.Text = ""
	
	mouseCurrentlyEnabled = false
	Services.UserInputService.MouseIconEnabled = false
	Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Disabled
	Services.GamepadService:DisableGamepadCursor()
	Services.GuiService.SelectedObject = nil
	
	isAnyLiar = tableSettings.AnyLiar
	
	gameEffectsIcon:setEnabled((tableSettings.EffectsEnabled and true) or (false))
	
	for _, settingFrame in CurrentTableSettingsFrame:GetChildren() do
		if settingFrame:IsA("Frame") then
			local settingValue = tableSettings[settingFrame.Name]
			
			if settingValue then
				settingFrame.SettingValue.Text = if settingValue == true then "enabled" else settingValue
			else
				settingFrame.SettingValue.Text = "disabled"
			end
		end
	end
	
	currentSettingsIcon:setEnabled(true)
	
	if voiceChatIcon then
		voiceChatIcon:setEnabled(false)
	end
	
	if proServerIcon then
		proServerIcon:setEnabled(false)
	end
	
	--if seventeenPlusIcon then
	--	seventeenPlusIcon:setEnabled(false)
	--end
	
	spectatingIcon:setEnabled(false)
	spectatingIcon:setLabel("")
	
	updateLogsIcon:deselect()
	updateLogsIcon:setEnabled(false)
	
	local serversIcon = Utilities.Icon.getIcon("Servers")
	local vcServersIcon = Utilities.Icon.getIcon("VC Servers")

	if serversIcon then
		serversIcon:setEnabled(false)
	end

	if vcServersIcon then
		vcServersIcon:setEnabled(false)
	end
	
	promoCodesIcon:deselect()
	promoCodesIcon:setEnabled(false)
	
	MainMusic:Stop()
	
	enableMobileCards()
	enableMobileGui()
	gameInProgress = true
	lastStackedPos = nil
	currentPlacementCFrame = placementCFrame
	currentPositions = positions
	currentItems = items
	
	local success, err = pcall(function()
		for i, v in pairs(values:GetChildren()) do
			Disconnect("VALUE_CHANGED_" .. i)
			
			global.Values[v.Name] = v
			
			global.Connections["VALUE_CHANGED_" .. i] = v.Changed:Connect(function(newVal)
				if v.Name == "CurrentState" then
					if newVal ~= "DRINK POTION CHOICE" and newVal ~= "TURN START" then
						TimerGui.Enabled = false
					end
				elseif v.Name == "Status" then
					if global.Values["CurrentState"].Value == "DRINK POTION CHOICE" or global.Values["CurrentState"].Value == "TURN START" then
						local toNum = tonumber(newVal)
						
						if toNum then
							TimerLabel.Text = toNum
						end
					elseif global.Values["CurrentState"].Value == "GAME END" then
						local toNum = tonumber(newVal)

						if toNum then
							EndScreenButtons.PlayAgainButton.Timer.Text = toNum
							EndScreenButtons.PlayAgainButton.Timer.Visible = true
						end
					elseif LoadingScreenGui.Enabled then
						LoadingCenteredText.Text = "Waiting for players... (" .. newVal .. ")"
					end
				end
			end)
		end
		
		BlurEffect.Size = 2
		
		for _, v in pairs(ClientStorage:GetChildren()) do
			v:Destroy()
		end
		
		local newStack = Instance.new("Model")
		
		newStack.Name = "STACKED_CARDS"
		newStack.Parent = ClientStorage
		
		local room = require(ItemStorage.Rooms[roomType] or ItemStorage.Rooms["Default"])
		local model = room and room.Model
		
		if model then
			local newRoom = model:Clone()
			newRoom.Name = "CURRENT_ROOM"
			newRoom.Parent = ClientStorage
			
			if room.Data and room.Data.OnLoad then
				room.Data.OnLoad(newRoom, Sliders.AmbienceSlider:GetValue())
			end
			
			if biggerTable then
				for _, v in pairs(newRoom.PrimaryPart.Parent:GetChildren()) do
					if v.Name ~= "Placement" then
						v.Size *= Vector3.new(2, 1, 2)
					end
				end
			end
			
			if Services.VRService.VREnabled then
				VRTableClaim.CurrentClaim.Text = ""
				VRTableClaim.LastClaim.Text = ""
				VRTableClaim.Enabled = false
				VRTableClaim.Parent = newRoom.PrimaryPart
			else
				VRTableClaim.Enabled = false
			end
			
			newRoom:PivotTo(placementCFrame)
			
			local findRotation = newRoom:FindFirstChild("Rotation", true)
			
			if findRotation and findRotation:IsA("BasePart") then
				currentRotationPart = findRotation
			end
			
			local RadiosFolder = ClientStorage:FindFirstChild("RADIOS") or Instance.new("Folder")
			
			RadiosFolder.Name = "RADIOS"
			RadiosFolder.Parent = ClientStorage
			
			for id, pos in pairs(positions) do
				local posSuccess, posError = pcall(function()
					if not items[tostring(id)] then return end
					
					local chair = global.AllItems["Chairs"][items[tostring(id)]["Chairs"] or "Default"]
					local voice = global.AllItems["Voices"][items[tostring(id)]["Voices"] or "Default"]
					local victory = global.AllItems["Victories"][items[tostring(id)]["Victories"] or "Default"]
					local potion = global.AllItems["Potions"][items[tostring(id)]["Potions"] or "Default"]
					local knockout = global.AllItems["Knockouts"][items[tostring(id)]["Knockouts"] or "Default"]
					local chairModel = chair and chair.Model
					local potionModel = potion and potion.Model
					
					if chairModel then
						local newChair = chairModel:Clone()
						
						newChair.Name = tostring(id)
						newChair.Parent = ClientStorage
						newChair:PivotTo(CFrame.new(Vector3.new(pos.X, SeatExample.Position.Y, pos.Z), Vector3.new(placementCFrame.Position.X, SeatExample.Position.Y, placementCFrame.Position.Z)))
					end
					
					local placementPosition = placementCFrame.Position + Vector3.new(0, potionModel.Size.Y / 2, 0)
					local playerPosition = pos + Vector3.new(0, potionModel.Size.Y / 2, 0)
					local lerp = (biggerTable and placementPosition:Lerp(playerPosition, 0.75)) or (placementPosition:Lerp(playerPosition, 0.575))
					local inBetween = CFrame.new(lerp, playerPosition)
					
					if potionModel then
						local potionModels = Instance.new("Folder")
						
						potionModels.Name = tostring(id) .. "_POTIONS"
						potionModels.Parent = ClientStorage

						local toNum = tonumber(tableSettings.MaxPotions)
						local potionCFrame = inBetween * CFrame.new(-1.1, 0, (toNum > 4 and -0.65) or (-0.3))
						
						for i = 1, toNum do
							local rounded = math.floor(i / 5)
							local extra = rounded + 1
							local newPotion = potionModel:Clone()
							local comp = i - 4 * rounded
							
							newPotion.Anchored = true
							newPotion.Name = i
							newPotion.CFrame = potionCFrame * CFrame.new((comp - 1) * 0.45, 0, (comp - 1) * 0.18) * CFrame.new(0, 0, 0.5 * extra)
							newPotion.Parent = potionModels
							
							if tostring(Player.UserId) == tostring(id) then
								local highlight = Instance.new("Highlight")

								highlight.FillColor = Color3.fromRGB(35, 255, 155)
								highlight.FillTransparency = 1
								highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
								highlight.OutlineTransparency = 0.4
								highlight.DepthMode = Enum.HighlightDepthMode.Occluded
								highlight.Enabled = false
								highlight.Adornee = newPotion
								highlight.Parent = newPotion
								
								local newBillboard = Instance.new("BillboardGui")
								
								newBillboard.Size = UDim2.new(0.6, 0, 0.6, 0)
								newBillboard.StudsOffsetWorldSpace = Vector3.new(0, 0.95, 0)
								newBillboard.Brightness = 100
								newBillboard.LightInfluence = 0
								newBillboard.Enabled = false
								newBillboard.AlwaysOnTop = true
								newBillboard.Name = "ARROW_GUI"
								newBillboard.Parent = newPotion
								
								task.spawn(function()
									local newTween = Services.TweenService:Create(newBillboard, allTweenInfos.billboardTweenInfo, {StudsOffsetWorldSpace = Vector3.new(0, 1.05, 0)})
									
									newBillboard.Destroying:Once(function()
										newTween:Cancel()
										newTween:Destroy()
									end)
									
									newTween:Play()
								end)
								
								if (toNum <= 1 and i == 1) or (i == 2) then
									local otherBillboard = newBillboard:Clone()

									otherBillboard.Size = UDim2.new(2, 0, 0.5, 0)
									otherBillboard.StudsOffsetWorldSpace = Vector3.new(0, 1.7, 0)
									otherBillboard.Name = "CENTER_GUI"
									otherBillboard.Parent = newPotion
									
									local newText = Instance.new("TextLabel")

									newText.Text = "CHOOSE A POTION TO DRINK"
									newText.TextColor3 = Color3.fromRGB(255, 255, 255)
									newText.Font = Enum.Font.Merriweather
									newText.TextScaled = true
									newText.Size = UDim2.new(1, 0, 1, 0)
									newText.BackgroundTransparency = 1
									newText.Parent = otherBillboard
									
									local newStroke = Instance.new("UIStroke")
									
									newStroke.Thickness = 2.5
									newStroke.Parent = newText
								end
								
								local newImage = Instance.new("ImageLabel")
								
								newImage.Image = "rbxassetid://76082211222877"
								newImage.Size = UDim2.new(1, 0, 1, 0)
								newImage.BackgroundTransparency = 1
								newImage.Parent = newBillboard
								
								local newClick = Instance.new("ClickDetector")
								
								--[[newClick.MouseClick:Connect(function(playerWhoClicked)
									if playerWhoClicked.UserId == Player.UserId then
										local success, result = Services.GameplayService:AttemptDrinkPotion(i, Services.VRService.VREnabled)
										
										if success then
											global.ChosenPotions[tostring(Player.UserId)] = i
											DrinkPotion((result and true) or (false))
										else
											--warn(result)
										end
									end
								end)]]
								
								newClick.MouseHoverEnter:Connect(function(playerWhoHovered)
									if playerWhoHovered.UserId == Player.UserId then
										highlight.FillTransparency = 0.7
										highlight.OutlineTransparency = 0
									end
								end)
								
								newClick.MouseHoverLeave:Connect(function(playerWhoHovered)
									if playerWhoHovered.UserId == Player.UserId then
										highlight.FillTransparency = 1
										highlight.OutlineTransparency = 0.4
									end
								end)
								
								newClick.MaxActivationDistance = 0
								newClick.Parent = newPotion
							end
						end
					end
					
					if type(passes) == "table" and type(passes[tostring(id)]) == "table" and passes[tostring(id)]["Radio"] then 
						local radio = Objects:FindFirstChild("Radio")
						local newRadio = radio and radio:Clone()
						local toNumId = tonumber(id)
						local radioOwned = Player.UserId == toNumId
						
						if newRadio then
							local lookCFrame = CFrame.new((inBetween * CFrame.new(0.8, 0, 0)).Position, inBetween.Position) * CFrame.new(0, 0, 0.1) * CFrame.Angles(0, -math.rad(90), 0)
							lookCFrame = lookCFrame * CFrame.new(0, -potionModel.Size.Y / 2, 0) * CFrame.new(0, newRadio.PrimaryPart.Size.Y / 2, 0)
							
							newRadio:PivotTo(lookCFrame)
							newRadio.Name = id .. "_RADIO"
							
							local prompt = newRadio:FindFirstChildWhichIsA("ProximityPrompt")
							local sound = newRadio:FindFirstChildWhichIsA("Sound", true)
							
							if prompt and sound then
								prompt.Triggered:Connect(function()
									if radioOwned then
										if not EffectShopGui.Enabled and not RadioGui.Enabled and not EndScreenGui.Enabled then
											RadioSearchBar.Text = ""
											RadioSongBar.Text = ""
											RadioGui.Enabled = true
											
											if Utilities.Utils.getLastInput() == "controller" then
												Services.GamepadService:EnableGamepadCursor(nil)
											end

											Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and true) or (false)
										end
									else
										if sound.Volume ~= 0 then
											sound.Volume = 0
											global.MutedRadios[toNumId] = true
											prompt.ActionText = "Unmute"
										else
											sound.Volume = Sliders.RadioSlider:GetValue() * 0.05
											global.MutedRadios[toNumId] = nil
											prompt.ActionText = "Mute"
										end
									end
								end)
								
								if radioOwned then
									prompt.ActionText = "Change"
								else
									if global.MutedRadios[toNumId] then
										sound.Volume = 0
										prompt.ActionText = "Unmute"
									else
										sound.Volume = Sliders.RadioSlider:GetValue() * 0.05
										prompt.ActionText = "Mute"
									end
								end
							end
							
							newRadio.Parent = RadiosFolder
						end
					end
					
					if voice then
						CreateVoiceFolderFor(voice)
					end
					
					if victory then
						CreateVictorySoundFor(victory)
					end
				end)
				
				if not posSuccess then
					warn(posError)
				end
			end
		end
	end)
	
	if not success then
		warn(err)
	end
	
	Services.GameplayService:ClientLoaded("GAME")
end)

Services.GameplayService.GameStarted:Connect(function()
	Services.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
	MainMenuGui.Enabled = false
	InventoryGui.Enabled = false
	CurrentEventGui.Enabled = false
	ShopGui.Enabled = false
	HowToPlayGui.Enabled = false
	CreditsGui.Enabled = false
	SettingsGui.Enabled = false
	LeaderboardsGui.Enabled  = false
	LoadingScreenGui.Enabled = false
end)

Services.GameplayService.RoundEnded:Connect(function()
	TableClaimLabel.Text = ""
	TopMiddleClaimLabel.Text = ""
	TopMiddleLastClaim.Text = ""

	local stackedCards = ClientStorage:FindFirstChild("STACKED_CARDS")

	if stackedCards then
		for _, c in pairs(stackedCards:GetChildren()) do
			c:Destroy()
		end
	end

	for _, v in pairs(Services.Players:GetPlayers()) do
		UpdateCards(v, {})
		EnableHighlights(v.Character, false)
	end

	Services.GameplayService:ClientLoaded("ROUND END")
end)

Services.GameplayService.StartPotionChoice:Connect(function(potionDrinkers, timer)
	potionChoiceStarted = true
	
	local success, err = pcall(function()
		TimerLabel.Text = timer or "10"
		TimerGui.Enabled = true
		
		for _, potionDrinker in pairs(potionDrinkers) do
			if tostring(potionDrinker.UserId) == tostring(Player.UserId) then
				mouseCurrentlyEnabled = true
				Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and true) or (false)
				Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer

				local potions = ClientStorage:FindFirstChild(tostring(Player.UserId) .. "_POTIONS")

				if potions then
					AnimationController:Stop(Player.UserId .. "_Hold")
					
					task.spawn(function()
						Services.GameplayService:UpdateAnimation("Hold", "Stop")
					end)
					
					if not Services.VRService.VREnabled then
						AnimationController:Play(Player.UserId .. "_Potions")
					end

					for _, v in potions:GetChildren() do
						if not potionChoiceStarted then continue end
						
						local clickDetector = v:FindFirstChildWhichIsA("ClickDetector")
						local highlight = v:FindFirstChildWhichIsA("Highlight")
						local arrowGui = v:FindFirstChild("ARROW_GUI")
						local centerGui = v:FindFirstChild("CENTER_GUI")

						if v.Transparency ~= 1 then
							if highlight then
								highlight.FillTransparency = 1
								highlight.OutlineTransparency = 0.4
								highlight.Enabled = true
							end

							if clickDetector then
								clickDetector.MaxActivationDistance = 50
							end

							if arrowGui then
								arrowGui.Enabled = true
							end
						end

						if centerGui then
							centerGui.Enabled = true
						end
					end
				end
			else
				AnimationController:Stop(potionDrinker.UserId .. "_Hold")
				
				if not potionDrinker.Player or not potionDrinker.Player:FindFirstChild("isVR") then
					AnimationController:Play(potionDrinker.UserId .. "_Potions")
				end
			end
		end
	end)
	
	if not success then warn(err) end
end)

Services.GameplayService.TableCancelled:Connect(function(host, participants)
	for _, v in pairs(participants) do
		if v.UserId == Player.UserId then
			LobbyListFrame.Visible = true
			LobbyScreenFrame.Visible = false
		end
	end
	
	UpdateLobbyList(false, host)
end)

Services.GameplayService.TableChanged:Connect(function(host, participants, inProgress, tableSettings)
	for _, v in pairs(participants) do
		if v.UserId == Player.UserId then
			UpdateLobbyScreen(participants, host)
		end
	end
	
	if #participants > 0 and not inProgress then
		UpdateLobbyList(true, host, participants, tableSettings)
	else
		UpdateLobbyList(false, host)
	end
end)

Services.GameplayService.TableTimerChanged:Connect(function(timePassed)
	if timePassed == 0 then
		LobbyScreenTimer.Visible = false
	else
		LobbyScreenTimer.Text = 10 - timePassed
		LobbyScreenTimer.Visible = true
	end
end)

Services.GameplayService.UpdatedAnimation:Connect(function(forPlayer, animName, animStatus)
	local toNum = tonumber(forPlayer.UserId)
	
	if toNum and toNum == Player.UserId then return end
	
	if animStatus == "Play" and not forPlayer:FindFirstChild("isVR") then
		AnimationController:Play(forPlayer.UserId .. "_" .. animName)
	elseif animStatus == "Stop" then
		AnimationController:Stop(forPlayer.UserId .. "_" .. animName)
	end
end)

Services.GameplayService.UpdatedVR:Connect(function(forPlayer, updateType, ...)
	local args = table.pack(...)

	if forPlayer == Player then return end
	if not args then return end

	if updateType == "CARD_RELEASE" then
		if type(args[1]) ~= "table" then return end

		UpdateCards(forPlayer, args[1])
	elseif updateType == "CARD_GRAB" then 
		if type(args[1]) ~= "table" then return end

		local character = forPlayer and forPlayer.Character
		local getCard = character and character:FindFirstChild("RightHandCard")

		UpdateCards(forPlayer, args[1])

		if getCard then
			getCard.Transparency = 0

			local backOfCard = getCard:FindFirstChild("Back")

			if backOfCard then
				backOfCard.Face = Enum.NormalId.Top
				backOfCard.Transparency = 0
			end
		end
	end
end)

Services.SettingsService.SettingsLoaded:Connect(function(plyrSettings)
	for i, v in pairs(plyrSettings) do
		local toNum = tonumber(v)
		
		if PlayerSettings[i] then
			PlayerSettings[i](v)
		end
		
		if i == "InGameMusic" then
			if toNum then
				Sliders.AmbienceSlider:OverrideValue(toNum)
			end
		elseif i == "MainMusic" then
			if toNum then
				Sliders.MusicSlider:OverrideValue(toNum)
			end
		elseif i == "VoiceCalls" then
			if toNum then
				Sliders.VoiceSlider:OverrideValue(toNum)
			end
		elseif i == "Radios" then
			if toNum then
				Sliders.RadioSlider:OverrideValue(toNum)
			end
		end
	end
end)

Services.LeaderboardService.LeaderboardUpdate:Connect(function(leaderboardName, page)
	UpdateLeaderboard(leaderboardName, page)
end)

Services.ModerationService.PlayerMuted:Connect(function(isMuted, reason)
	if isMuted then
		if reason then
			Services.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("You have been muted for " .. reason .. ".")
		else
			Services.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("You have been muted.")
		end
	else
		Services.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("You have been unmuted.")
	end
end)

Services.ShopService.UpdateUserGamePasses:Connect(function(ownedPasses)
	if type(ownedPasses) == "table" then
		for i, v in pairs(ownedPasses) do
			global.CachedPasses[tonumber(i)] = v
		end
	end

	if global.CachedPasses[Utilities.ProductIds.Passes["Bigger Table"].Id]  then
		tableCreationChoices.MaxParticipants = {
			[1] = 2,
			[2] = 3,
			[3] = 4,
			[4] = 5,
			[5] = 6,
			[6] = 7,
			[7] = 8,
			[8] = 9,
			[9] = 10,
			[10] = 11,
			[11] = 12
		}
	end
	
	if global.CachedPasses[Utilities.ProductIds.Passes["Too Many Potions"].Id] then
		tableCreationChoices.MaxPotions = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
			[8] = 8
		}
	end
end)

Services.ShopService.PlayerGifted:Connect(function(plyrName, productName, Type)
	if Type == "SUCCESS" then
		Utilities.Utils.sendNotification("Gift Success", "Successfully gifted " .. productName .. " to " .. plyrName .. "!", "rbxassetid://132954918768208")
	else
		Utilities.Utils.sendNotification("Gift Received", plyrName .. " just gifted you " .. productName .. "!", "rbxassetid://132954918768208")
	end
end)

Services.ShopService.ShopItemsChanged:Connect(function(newItems)
	ChangeShop(newItems)
end)

Services.ShopService.UserOwnsGamePassChanged:Connect(function(passId, isOwned)
	passId = tonumber(passId)
	
	if passId == tonumber(Utilities.ProductIds.Passes["Bigger Table"].Id) and isOwned then
		tableCreationChoices.MaxParticipants = {
			[1] = 2,
			[2] = 3,
			[3] = 4,
			[4] = 5,
			[5] = 6,
			[6] = 7,
			[7] = 8,
			[8] = 9,
			[9] = 10,
			[10] = 11,
			[11] = 12
		}
	end
	
	if passId == tonumber(Utilities.ProductIds.Passes["Too Many Potions"].Id) and isOwned then
		tableCreationChoices.MaxPotions = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
			[8] = 8
		}
	end
	
	if isOwned then
		global.CachedPasses[passId] = true
	else
		global.CachedPasses[passId] = nil
	end
end)

EventTimer.Changed:Connect(function(newVal)
	CurrentEventTimer.Text = Utilities.Utils.convertToDHMS(newVal)
end)

TimeUntilReset.Changed:Connect(function(newVal)
	ShopTimer.Text = "Resets in " .. Utilities.Utils.convertToHMS(newVal)
end)

CurrentTick.Changed:Connect(function(newVal)
	if type(global.CurrentQuestData) == "table" and global.CurrentQuestData.LastRefresh then
		CurrentEventQuestsTimer.Text = Utilities.Utils.convertToHMS(math.max(86400 - (newVal - global.CurrentQuestData.LastRefresh), 0))
	end
end)

Services.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		CharacterAdded(player, character)
	end)
end)

for _, v in pairs(Services.Players:GetPlayers()) do
	v.CharacterAdded:Connect(function(character)
		CharacterAdded(v, character)
	end)
end

Services.GameplayService.PlayerLeaving:Connect(function(player)
	local toStringId = tostring(player.UserId)
	
	if global.Connections[toStringId] then
		for _, v in pairs(global.Connections[toStringId]) do
			pcall(function()
				v:Disconnect()
			end)
		end

		table.clear(global.Connections[toStringId])
	end
	
	global.Connections[toStringId] = nil
end)

Services.Players.PlayerRemoving:Connect(function(player)
	local toStringId = tostring(player.UserId)

	if global.Connections[toStringId] then
		for _, v in pairs(global.Connections[toStringId]) do
			pcall(function()
				v:Disconnect()
			end)
		end

		table.clear(global.Connections[toStringId])
	end
	
	global.Connections[toStringId] = nil
end)

Sliders.MusicSlider.Changed:Connect(function(newVal)
	MainMusic.Volume = 0.05 * newVal
	
	Services.SettingsService:Update("MainMusic", newVal)
end)

Sliders.AmbienceSlider.Changed:Connect(function(newVal)
	BonkSound.Volume = 0.1 * newVal
	Services.SettingsService:Update("InGameMusic", newVal)
end)

Sliders.VoiceSlider.Changed:Connect(function(newVal)
	for _, v in pairs(SoundStorage:GetDescendants()) do
		local startVal = v:FindFirstChild("StartVolume")

		if v:IsA("Sound") and startVal and startVal:IsA("NumberValue") then
			v.Volume = newVal * startVal.Value
		end
	end
	
	local victoriesFolder = Services.SoundService:FindFirstChild("Victories")
	
	if victoriesFolder then
		for _, v in pairs(victoriesFolder:GetDescendants()) do
			local startVal = v:FindFirstChild("StartVolume")
			
			if v:IsA("Sound") and startVal and startVal:IsA("NumberValue") then
				v.Volume = newVal * startVal.Value
			end
		end
	end
	
	Services.SettingsService:Update("VoiceCalls", newVal)
end)

Sliders.RadioSlider.Changed:Connect(function(newVal)
	local currentRadios = ClientStorage:FindFirstChild("RADIOS")
	
	if currentRadios and currentRadios:IsA("Folder") then
		for _, v in pairs(currentRadios:GetChildren()) do
			local sound = v:FindFirstChildWhichIsA("Sound", true)
			
			if sound then
				sound.Volume = newVal * 0.05
			end
		end
	end
	
	Services.SettingsService:Update("Radios", newVal)
end)

VRNoticeGui:WaitForChild("MainFrame"):WaitForChild("ConfirmButton").MouseButton1Click:Connect(function()
	VRNoticeGui.Enabled = false
	MainMenuGui.Enabled = true
end)

EndScreenButtons:WaitForChild("PlayAgainButton").MouseButton1Click:Connect(function()
	local success, result = Services.GameplayService:AttemptPlayAgain()
	
	if success then
		if result and type(result) == "string" then
			EndScreenButtons.PlayAgainButton.Title.Text = "Play Again (" .. result .. ")"
		end
	else
		warn(result)
	end
end)

EndScreenButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	local success, err = Services.GameplayService:AttemptBackToMenu()
	
	if success or err == "Player is not currently in a game for back to menu" then
		GameEnded()
	else
		warn(err)
	end
end)

LobbyListFrame:WaitForChild("CreateButton").MouseButton1Click:Connect(function()
	LobbyListFrame.Visible = false
	CreateLobbyFrame.Visible = true
end)

LobbyListFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	MainMenuGui.Enabled = true
	LobbyGui.Enabled = false
end)

CreateLobbyFrame:WaitForChild("CreateButton").MouseButton1Click:Connect(function()
	local success, result = Services.GameplayService:AttemptCreateTable(tableCreationData)

	if success then
		if result then
			LobbyPassLabel.Text = "Password: " .. result
		else
			LobbyPassLabel.Text = ""
		end
		
		LobbyScreenTitle.Text = Player.Name .. "'s Table"
		CreateLobbyFrame.Visible = false
		LobbyScreenTimer.Visible = false
		LobbyScreenFrame.Visible = true
		LobbyScreenButtons.StartButton.Visible = true
		LobbyScreenButtons.LeaveButton.Visible = true
	else
		--warn(result)
	end
end)

CreateLobbyFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	LobbyListFrame.Visible = true
	CreateLobbyFrame.Visible = false
end)

LobbyScreenButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	local success, result = Services.GameplayService:AttemptLeaveTable()
	
	if success then
		LobbyListFrame.Visible = true
		LobbyScreenFrame.Visible = false
		LobbyPassLabel.Text = ""
	else
		--warn(result)
	end
end)

LobbyScreenButtons:WaitForChild("StartButton").MouseButton1Click:Connect(function()
	local success, result = Services.GameplayService:AttemptStartGame()
	
	if success then
		LoadingScreenGui.Enabled = true
		LobbyListFrame.Visible = false
		LobbyScreenFrame.Visible = false
		LobbyPassLabel.Text = ""
	else
		--warn(result)
	end
end)

MainSpectateFrame:WaitForChild("Left").MouseButton1Click:Connect(function()
	if Services.VRService.VREnabled then return end
	ChangeSpectate()
end)

MainSpectateFrame:WaitForChild("Right").MouseButton1Click:Connect(function()
	if Services.VRService.VREnabled then return end
	ChangeSpectate(true)
end)

SpectateGui:WaitForChild("MainMenu").MouseButton1Click:Connect(function()
	local success, result = Services.GameplayService:AttemptBackToMenu()
	
	if success then
		GameEnded()
	else
		--warn(result)
	end
end)

MainMenuFrame:WaitForChild("PLAY").MouseButton1Click:Connect(function()
	ExpandTableFrame()
	LobbyListFrame.Visible = true
	LobbyScreenFrame.Visible = false
	MainMenuGui.Enabled = false
	LobbyGui.Enabled = true
end)

MainMenuFrame:WaitForChild("EVENT").MouseButton1Click:Connect(function()
	MainMenuGui.Enabled = false
	CurrentEventMainArea.Visible = true
	CurrentEventGui.Enabled = true
end)

CurrentEventMainFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	CurrentEventGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MainMenuFrame:WaitForChild("HOWTOPLAY").MouseButton1Click:Connect(function()
	if Services.VRService.VREnabled then
		HowToPlayButtons.Visible = true
		HowToPlayGui.MainFrame.Visible = false	
	else
		HowToPlayGui.MainFrame.Visible = true
		HowToPlayButtons.Visible = false
	end
	
	HowToPlayGui.VRTutorial.Visible = false
	
	MainMenuGui.Enabled = false
	HowToPlayGui.Enabled = true
end)

HowToPlayGui:WaitForChild("MainFrame"):WaitForChild("Back").MouseButton1Click:Connect(function()
	if Services.VRService.VREnabled then
		HowToPlayGui.MainFrame.Visible = false
		HowToPlayButtons.Visible = true
	else
		HowToPlayGui.Enabled = false
		MainMenuGui.Enabled = true
	end
end)

HowToPlayButtons:WaitForChild("Back").MouseButton1Click:Connect(function()
	HowToPlayGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MainMenuFrame:WaitForChild("SHOP").MouseButton1Click:Connect(function()
	for _, v in pairs(GamePassBuyScreens:GetChildren()) do
		if v:IsA("Frame") then
			v.Visible = false
		end
	end
	
	MainMenuGui.Enabled = false
	ShopBuyScreen.Visible = false
	ShopFrame.Visible = true
	ShopGui.Enabled = true
	
	local medalCollabFrame = ShopScrollingFrame:FindFirstChild("MedalCollab")
	local claimButton = medalCollabFrame and medalCollabFrame:FindFirstChildWhichIsA("GuiButton")
	local claimText = claimButton and claimButton:FindFirstChildWhichIsA("TextLabel")

	if claimText then
		local isClaimed = Services.MedalService:IsQuestClaimed()

		if isClaimed then
			claimText.Text = "Claimed"
			claimButton.Interactable = false
		end
	end
end)

ShopScrollingFrame:WaitForChild("UGC"):WaitForChild("HatButton").MouseButton1Click:Connect(function()
	Services.MarketplaceService:PromptPurchase(Player, 126471417363502)
end)

ShopScrollingFrame:WaitForChild("UGC"):WaitForChild("ChatBubbleButton").MouseButton1Click:Connect(function()
	Services.MarketplaceService:PromptPurchase(Player, 105568933118675)
end)

BackgroundEffectFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	if gameEffectsIcon.isSelected then
		gameEffectsIcon:deselect()
	end
end)

CurrentTableSettingsBackground:WaitForChild("Back").MouseButton1Click:Connect(function()
	if currentSettingsIcon.isSelected then
		currentSettingsIcon:deselect()
	end
end)

EffectCashFrame:WaitForChild("TextButton").MouseButton1Click:Connect(function()
	MainEffectFrame.Visible = false
	EffectCashFrame.TextButton.Visible = false
	BackgroundEffectFrame.Back.Visible = false
	CashEffectBackground.Visible = true
end)

CashEffectButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	CashEffectBackground.Visible = false
	MainEffectFrame.Visible = true
	EffectCashFrame.TextButton.Visible = true
	BackgroundEffectFrame.Back.Visible = true
end)

ShopBackground:WaitForChild("Back").MouseButton1Click:Connect(function()
	ShopGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MainMenuFrame:WaitForChild("INVENTORY").MouseButton1Click:Connect(function()
	MainMenuGui.Enabled = false
	InventoryGui.Enabled = true
end)

MainInventoryFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	InventoryGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MainMenuFrame:WaitForChild("LEADERBOARDS").MouseButton1Click:Connect(function()
	MainMenuGui.Enabled = false
	LeaderboardsGui.Enabled = true
end)

LeaderboardsFrame.Parent:WaitForChild("Back").MouseButton1Click:Connect(function()
	LeaderboardsGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MainMenuFrame:WaitForChild("SETTINGS").MouseButton1Click:Connect(function()
	MainMenuGui.Enabled = false
	SettingsGui.Enabled = true
end)

BackgroundSettingsFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	SettingsGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MainMenuFrame:WaitForChild("CREDITS").MouseButton1Click:Connect(function()
	MainMenuGui.Enabled = false
	CreditsGui.Enabled = true
end)

CreditsGui:WaitForChild("MainFrame"):WaitForChild("Back").MouseButton1Click:Connect(function()
	CreditsGui.Enabled = false
	MainMenuGui.Enabled = true
end)

MobileFrame:WaitForChild("6").MouseButton1Click:Connect(function()
	InputBegan(Enum.KeyCode.X, false)
end)

--[[MobileFrame:WaitForChild("3").MouseButton1Click:Connect(function()
	InputBegan(Enum.KeyCode.Space, false)
end)]]

MobileFrame:WaitForChild("4").MouseButton1Down:Connect(function()
	InputBegan(Enum.KeyCode.Space, false)
end)

MobileFrame:WaitForChild("4").MouseButton1Up:Connect(function()
	InputEnded(Enum.KeyCode.Space)
end)

MobileFrame:WaitForChild("5").MouseButton1Click:Connect(function()
	InputBegan(Enum.KeyCode.E, false)
end)

--[[MobileFrame:WaitForChild("1").MouseButton1Click:Connect(function()
	InputBegan(Enum.KeyCode.A, false)
end)

MobileFrame:WaitForChild("2").MouseButton1Click:Connect(function()
	InputBegan(Enum.KeyCode.D, false)
end)]]

CurrentEventCurrency:WaitForChild("TextButton").MouseButton1Click:Connect(function()
	CurrentEventMainArea.Visible = false
	CurrentEventCurrency.TextButton.Visible = false
	CurrentEventMainFrame.Back.Visible = false
	CurrentEventCurrencyShop.Visible = true
end)

CurrentEventCurrencyButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	CurrentEventCurrencyShop.Visible = false
	CurrentEventMainFrame.Back.Visible = true
	CurrentEventCurrency.TextButton.Visible = true
	CurrentEventMainArea.Visible = true
end)

ShopCashFrame:WaitForChild("TextButton").MouseButton1Click:Connect(function()
	ShopFrame.Visible = false
	ShopBuyScreen.Visible = false
	ShopCashFrame.TextButton.Visible = false
	ShopBackground.Back.Visible = false
	CashShopBackground.Visible = true
end)

CashShopButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	CashShopBackground.Visible = false
	ShopBackground.Back.Visible = true
	ShopCashFrame.TextButton.Visible = true
	ShopFrame.Visible = true
end)

--[[ChristmasBuyButtons:WaitForChild("StartButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(ProductIds.Passes["Winter Pack"].Id, "GamePass")
end)

ChristmasBuyButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	ChristmasBuyScreen.Visible = false

	if currentShopSoundPlaying then
		currentShopSoundPlaying:Stop()
		currentShopSoundPlaying = nil
	end

	ChristmasMainFrame.Back.Visible = true
	ChristmasMainArea.Visible = true
end)]]

ShopBuyButtons:WaitForChild("StartButton").MouseButton1Click:Connect(function()
	if ShopBuyScreen.ItemType.Text == "Game Pass" then
		Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes[ShopBuyScreen.ItemName.Text].Id, "GamePass")
	else
		local success, result = Services.ShopService:AttemptPurchaseShopItem(ShopBuyScreen.ItemType.Text, ShopBuyScreen.ItemName.Text, true)
		
		if success then
			local buyButton = ShopBuyButtons:FindFirstChild("StartButton")
			buyButton.Active = false
			buyButton.Interactable = false
			buyButton.Title.TextColor3 = Color3.fromRGB(135, 135, 135)
			buyButton.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
			buyButton.UIGradient.Enabled = false
			buyButton.Title.Text = "Owned"
		else
			if result ~= "Insufficient funds" then
				warn(result)
			end
		end
	end
end)

ShopBuyButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	ShopBuyScreen.Visible = false
	
	if currentShopSoundPlaying then
		currentShopSoundPlaying:Stop()
		currentShopSoundPlaying = nil
	end
	
	ShopBackground.Back.Visible = true
	ShopFrame.Visible = true
end)

CashShopVIP:WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes.VIP.Id, "GamePass")
end)

CashShopVIP:WaitForChild("GiftButton").MouseButton1Click:Connect(function()
	CashShopBackground.Visible = false
	ShopBackground.Back.Visible = false
	ShopGiftDetails.ImageLabel.Image = Utilities.ProductIds.Passes.VIP.Image
	ShopGiftDetails.ItemName.Text = "VIP"
	ShopGiftDetails.ItemPrice.Text = "" .. Utilities.ProductIds.Passes.VIP.Price
	ShopGiftDetails.ItemType.Text = "Game Pass"
	ShopGiftScreen.Visible = true
	lastGiftScreen = "Product"
end)

CurrentEvent2xOption:WaitForChild("GiftButton").MouseButton1Click:Connect(function()
	CurrentEventGui.Enabled = false
	CashShopBackground.Visible = false
	ShopBackground.Back.Visible = false
	ShopGiftDetails.ImageLabel.Image = Utilities.ProductIds.Passes["x2 Beach Balls"].Image
	ShopGiftDetails.ItemName.Text = "x2 Beach Balls"
	ShopGiftDetails.ItemPrice.Text = "" .. Utilities.ProductIds.Passes["x2 Beach Balls"].Price
	ShopGiftDetails.ItemType.Text = "Game Pass"
	ShopFrame.Visible = false
	ShopBuyScreen.Visible = false
	ShopCashFrame.TextButton.Visible = false
	ShopGiftScreen.Visible = true
	ShopGui.Enabled = true
	lastGiftScreen = "Event"
end)

CurrentEvent2xOption:WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["x2 Beach Balls"].Id, "GamePass")
end)

--[[ChristmasMainArea:WaitForChild("Left"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["Hot Chocolate (Card)"].Id, "GamePass")
end)

ChristmasMainArea:WaitForChild("Right"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["Hot Chocolate (Potion)"].Id, "GamePass")
end)

ChristmasMainArea:WaitForChild("Middle"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	EasterMainArea.Visible = false
	EasterMainFrame.Back.Visible = false
	
	--Services.ShopService:AttemptPromptPurchase(ProductIds.Passes["Winter Pack"].Id, "GamePass")
end)

ChristmasMainArea:WaitForChild("Middle"):WaitForChild("GiftButton").MouseButton1Click:Connect(function()
	EasterEventGui.Enabled = false
	CashShopBackground.Visible = false
	ShopBackground.Back.Visible = false
	ShopGiftDetails.ImageLabel.Image = Utilities.ProductIds.Passes[EasterMainArea.Middle.ItemName.Text].Image
	ShopGiftDetails.ItemName.Text = EasterMainArea.Middle.ItemName.Text
	ShopGiftDetails.ItemPrice.Text = EasterMainArea.Middle.ItemPrice.Text
	ShopGiftDetails.ItemType.Text = "Game Pass"
	ShopFrame.Visible = false
	ShopBuyScreen.Visible = false
	ShopCashFrame.TextButton.Visible = false
	ShopGiftScreen.Visible = true
	ShopGui.Enabled = true
	lastGiftScreen = "Event"
end)]]

GiftCreditFrame:WaitForChild("StartButton").MouseButton1Click:Connect(function()
	if not global.currentCreditsRedeem.Gifted or not global.currentCreditsRedeem.Id then return end
	
	local success, err = Services.ShopService:AttemptGiftPurchase(global.currentCreditsRedeem.Gifted, global.currentCreditsRedeem.Id, global.currentCreditsRedeem.Type)
	
	print(success, err)
	
	GiftRedeemGui.Enabled = false
	
	global.currentCreditsRedeem.Gifted = nil
	global.currentCreditsRedeem.Id = nil
	global.currentCreditsRedeem.Type = nil
end)

GiftCreditFrame:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	GiftRedeemGui.Enabled = false
	
	global.currentCreditsRedeem.Gifted = nil
	global.currentCreditsRedeem.Id = nil
	global.currentCreditsRedeem.Type = nil
end)

ShopGiftButton.MouseButton1Click:Connect(function()
	local product
	local pass = Utilities.ProductIds.Passes[ShopGiftDetails.ItemName.Text]
	
	if not pass then
		local currencyType = (string.find(ShopGiftDetails.ItemName.Text, "%$") and "Cash") or ("")
		
		if currencyType == "Cash" then
			local cashName = ShopGiftDetails.ItemName.Text:gsub("%$", ""):gsub(",", "")
			local toNum = tonumber(cashName)
			
			if toNum then
				for _, v in pairs(Utilities.ProductIds.Cash) do
					if v.Amount == toNum then
						product = v
						break
					end
				end
			end
		else
			local eggName = ShopGiftDetails.ItemName.Text:gsub(" Beach Balls", ""):gsub(",", "")
			local toNum = tonumber(eggName)

			if toNum then
				for _, v in pairs(Utilities.ProductIds["Beach Balls"]) do
					if v.Amount == toNum then
						product = v
						break
					end
				end
			end
		end
	end

	local userBeingGifted = tonumber(ShopSelectedPlayer.PlayerId.Value)
	local userNameBeingGIfted = ShopSelectedPlayer.PlayerName.Text
	local playerBeingGifted = Services.Players:GetPlayerByUserId(userBeingGifted)
	
	if playerBeingGifted and playerBeingGifted.Name == userNameBeingGIfted then
		if type(pass) == "table" and pass.Gift then
			local totalCredits = Services.ShopService:GetGiftCreditsFor(pass.Gift)
			local toNum = totalCredits and tonumber(totalCredits)
			
			if toNum and toNum > 0 then
				GiftCreditFrame.TopTitle.Text = "You have " .. toNum .. " gift credit(s) for this item. Would you like to redeem 1 gift credit?"
				global.currentCreditsRedeem.Gifted = playerBeingGifted.UserId
				global.currentCreditsRedeem.Id = pass.Gift
				global.currentCreditsRedeem.Type = "GamePass"
				GiftRedeemGui.Enabled = true
			else
				local s, e = Services.ShopService:AttemptGiftPurchase(playerBeingGifted.UserId, pass.Gift, "GamePass")

				print(s, e)
			end
		elseif type(product) == "table" and product.Gift then
			local totalCredits = Services.ShopService:GetGiftCreditsFor(product.Gift)
			local toNum = totalCredits and tonumber(totalCredits)

			if toNum and toNum > 0 then
				GiftCreditFrame.TopTitle.Text = "You have " .. toNum .. " gift credit(s) for this item. Would you like to redeem 1 gift credit?"
				global.currentCreditsRedeem.Gifted = playerBeingGifted.UserId
				global.currentCreditsRedeem.Id = product.Gift
				global.currentCreditsRedeem.Type = "GamePass"
				GiftRedeemGui.Enabled = true
			else
				local s, e = Services.ShopService:AttemptGiftPurchase(playerBeingGifted.UserId, product.Gift)

				print(s, e)
			end
		end
	end
end)

ShopGiftBackButton.MouseButton1Click:Connect(function()
	ShopGiftScreen.Visible = false
	EffectShopGiftScreen.Visible = false
	
	if lastGiftScreen == "Event" then
		ShopGui.Enabled = false
		CurrentEventGui.Enabled = true
		CashShopBackground.Visible = false
		ShopBackground.Back.Visible = true
		ShopCashFrame.TextButton.Visible = true
	elseif lastGiftScreen == "GamePass" then
		ShopFrame.Visible = true
		ShopBackground.Back.Visible = true
		ShopCashFrame.TextButton.Visible = true
	else
		CashShopBackground.Visible = true
	end
end)

EffectShopGiftButton.MouseButton1Click:Connect(function()
	local pass = Utilities.ProductIds.Passes[EffectShopGiftDetails.ItemName.Text]
	local product = Utilities.ProductIds.Cash[EffectShopGiftDetails.ItemName.Text] or Utilities.ProductIds["Beach Balls"][EffectShopGiftDetails.ItemName.Text]
	local userBeingGifted = tonumber(EffectShopSelectedPlayer.PlayerId.Value)
	local userNameBeingGIfted = EffectShopSelectedPlayer.PlayerName.Text
	local playerBeingGifted = Services.Players:GetPlayerByUserId(userBeingGifted)

	if playerBeingGifted and playerBeingGifted.Name == userNameBeingGIfted then
		if type(pass) == "table" and pass.Gift then
			local totalCredits = Services.ShopService:GetGiftCreditsFor(pass.Gift)
			local toNum = totalCredits and tonumber(totalCredits)

			if toNum and toNum > 0 then
				GiftCreditFrame.TopTitle.Text = "You have " .. toNum .. " gift credit(s) for this item. Would you like to redeem 1 gift credit?"
				global.currentCreditsRedeem.Gifted = playerBeingGifted.UserId
				global.currentCreditsRedeem.Id = pass.Gift
				global.currentCreditsRedeem.Type = nil
				GiftRedeemGui.Enabled = true
			else
				local s, e = Services.ShopService:AttemptGiftPurchase(userBeingGifted, pass.Gift, "GamePass")

				if not s then warn(e) end
			end
		elseif type(product) == "table" and product.Gift then
			local totalCredits = Services.ShopService:GetGiftCreditsFor(product.Gift)
			local toNum = totalCredits and tonumber(totalCredits)

			if toNum and toNum > 0 then
				GiftCreditFrame.TopTitle.Text = "You have " .. toNum .. " gift credit(s) for this item. Would you like to redeem 1 gift credit?"
				global.currentCreditsRedeem.Gifted = playerBeingGifted.UserId
				global.currentCreditsRedeem.Id = product.Gift
				global.currentCreditsRedeem.Type = nil
				GiftRedeemGui.Enabled = true	
			else
				local s, e = Services.ShopService:AttemptGiftPurchase(userBeingGifted, product.Gift)

				if not s then warn(e) end
			end
		end
	end
end)

EffectShopGiftBackButton.MouseButton1Click:Connect(function()
	ShopGiftScreen.Visible = false
	EffectShopGiftScreen.Visible = false
	
	if lastGiftScreen == "GamePass" then
		ShopBackground.Back.Visible = true
		ShopCashFrame.TextButton.Visible = true
		ShopFrame.Visible = true
	else
		CashEffectBackground.Visible = true
	end
end)

CashEffectButtons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
	CashEffectBackground.Visible = false
	BackgroundEffectFrame.Back.Visible = true
	EffectCashFrame.TextButton.Visible = true
	MainEffectFrame.Visible = true
end)

CashEffectVIP:WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes.VIP.Id, "GamePass")
end)

CashEffectVIP:WaitForChild("GiftButton").MouseButton1Click:Connect(function()
	CashEffectBackground.Visible = false
	BackgroundEffectFrame.Back.Visible = false
	EffectShopGiftDetails.ImageLabel.Image = Utilities.ProductIds.Passes.VIP.Image
	EffectShopGiftDetails.ItemName.Text = CashShopVIP.ItemName.Text
	EffectShopGiftDetails.ItemPrice.Text = CashShopVIP.TextButton.Text
	EffectShopGiftDetails.ItemType.Text = "Game Pass"
	EffectShopGiftScreen.Visible = true
end)

RadioBackground:WaitForChild("Back").MouseButton1Click:Connect(function()
	RadioGui.Enabled = false
	
	if not RadioGui.Enabled and not EffectShopGui.Enabled and not EndScreenGui.Enabled then
		Services.GamepadService:DisableGamepadCursor()
	end
	
	Services.UserInputService.MouseIconEnabled = (Utilities.Utils.getLastInput() ~= "controller" and (RadioGui.Enabled or EffectShopGui.Enabled or mouseCurrentlyEnabled)) or (false)
end)

RadioSearchFrame:WaitForChild("Search").MouseButton1Click:Connect(function()
	if RadioSearchBar.Text ~= "" and not searching then
		searching = true
		
		local toLookUp = RadioSearchBar.Text
		
		for _, v in pairs(RadioSearchList:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end
		
		RadioSearchBar.Text = "Loading..."
		
		local songList = Services.GameplayService:SearchForAudio(toLookUp)
		
		if type(songList) == "table" and songList[1] then
			RadioSearchBar.Text = ""
			
			for _, v in pairs(songList) do
				if type(v) == "table" then
					local newTemplate = SongTemplate:Clone()
					
					newTemplate.Name = v.Id
					newTemplate.SongName.Text = v.Name
					newTemplate.Buttons.Delete:Destroy()
					
					newTemplate.Buttons.Add.MouseButton1Click:Connect(function()
						UpdateRadioWith(v.Id, "ADD")
					end)
					
					newTemplate.Buttons.Play.MouseButton1Click:Connect(function()
						local radiosFolder = ClientStorage:FindFirstChild("RADIOS")
						local radioModel = radiosFolder and radiosFolder:FindFirstChild(Player.UserId .. "_RADIO")
						local soundObject = radioModel and radioModel:FindFirstChildWhichIsA("Sound", true)

						if soundObject and soundObject.IsPlaying and soundObject.SoundId == "rbxassetid://" .. v.Id then
							Services.GameplayService:UpdateRadio("SONG", 0)
						else
							Services.GameplayService:UpdateRadio("SONG", v.Id)
						end
					end)
					
					newTemplate.Parent = RadioSearchList
				end
			end
		else
			RadioSearchBar.Text = "Unable to find what you're looking for"
		end
		
		searching = false
	end
end)

Services.GameplayService.UpdateRadioSongList:Connect(function(songList)
	UpdateRadioSongList(songList)
end)

RadioSongsFrame:WaitForChild("Add").MouseButton1Click:Connect(function()
	if RadioSongBar.Text ~= "" then
		UpdateRadioWith(RadioSongBar.Text, "ADD")
	end
end)

RadioMainArea:WaitForChild("SearchButton").MouseButton1Click:Connect(function()
	RadioSearchFrame.Visible = true
	RadioSongsFrame.Visible = false
	RadioMainArea.SearchButton.BackgroundColor3 = Color3.fromRGB(188, 188, 188)
	RadioMainArea.SongsButton.BackgroundColor3 = Color3.fromRGB(144, 144, 144)
end)

RadioMainArea:WaitForChild("SongsButton").MouseButton1Click:Connect(function()
	RadioSearchFrame.Visible = false
	RadioSongsFrame.Visible = true
	RadioMainArea.SongsButton.BackgroundColor3 = Color3.fromRGB(188, 188, 188)
	RadioMainArea.SearchButton.BackgroundColor3 = Color3.fromRGB(144, 144, 144)
end)

EndCashStats:WaitForChild("MainFrame"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes.VIP.Id, "GamePass")
end)

EndCashStats:WaitForChild("EventCurrency"):WaitForChild("TextButton").MouseButton1Click:Connect(function()
	Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["x2 Beach Balls"].Id, "GamePass")
end)

updateLogsIcon.toggled:Connect(function()
	MainMenuUpdateLog.Visible = not MainMenuUpdateLog.Visible
end)

promoCodesIcon.toggled:Connect(function()
	PromoCodesGui.Enabled = not PromoCodesGui.Enabled
end)

gameEffectsIcon.toggled:Connect(function()
	if not EffectShopGui.Enabled and EndScreenGui.Enabled then
		return
	end
	
	RadioGui.Enabled = false
	EffectShopGui.Enabled = not EffectShopGui.Enabled
	Services.UserInputService.MouseIconEnabled = (CurrentTableSettingsGui.Enabled or EffectShopGui.Enabled or RadioGui.Enabled or mouseCurrentlyEnabled) or (false)
end)

currentSettingsIcon.toggled:Connect(function()
	if not CurrentTableSettingsGui.Enabled and EndScreenGui.Enabled then
		return
	end
	
	RadioGui.Enabled = false
	CurrentTableSettingsGui.Enabled = not CurrentTableSettingsGui.Enabled
	Services.UserInputService.MouseIconEnabled = (CurrentTableSettingsGui.Enabled or EffectShopGui.Enabled or RadioGui.Enabled or mouseCurrentlyEnabled) or (false)
end)

PromoCodesBox.FocusLost:Connect(function()
	if PromoCodesBox.Text ~= "" then
		local success, result = Services.RewardsService:AttemptClaim("PromoCodes", PromoCodesBox.Text)
		PromoCodesBox.Text = result or "Unknown Error"
	end
end)

VRTutorialFrame:WaitForChild("Back").MouseButton1Click:Connect(function()
	VRTutorialFrame.Visible = false
	HowToPlayButtons.Visible = true
	
	for _, v in pairs(VRTutorialVideos:GetChildren()) do
		if v:IsA("VideoFrame") then
			v:Pause()
			v.TimePosition = 0
		end
	end
end)

VRTutorialVideos:WaitForChild("1").Ended:Connect(function()
	if VRTutorialFrame.Visible then
		VRTutorialVideos["2"].TimePosition = 0
		VRTutorialVideos["2"]:Play()
		VRTutorialVideos["2"].Visible = true
		VRTutorialVideos["3"].Visible = false
		VRTutorialVideos["1"].Visible = false
	end
end)

VRTutorialVideos:WaitForChild("2").Ended:Connect(function()
	if VRTutorialFrame.Visible then
		VRTutorialVideos["3"].TimePosition = 0
		VRTutorialVideos["3"]:Play()
		VRTutorialVideos["2"].Visible = false
		VRTutorialVideos["3"].Visible = true
		VRTutorialVideos["1"].Visible = false
	end
end)

VRTutorialVideos:WaitForChild("3").Ended:Connect(function()
	if VRTutorialFrame.Visible then
		VRTutorialVideos["1"].TimePosition = 0
		VRTutorialVideos["1"]:Play()
		VRTutorialVideos["2"].Visible = false
		VRTutorialVideos["3"].Visible = false
		VRTutorialVideos["1"].Visible = true
	end
end)

totalLoaded += 1

task.spawn(function()
	for _, frame in pairs(ShopScrollingFrame:GetChildren()) do
		if frame:IsA("Frame") then
			if string.find(frame.Name, "LimitedTimeItems") then
				local shopFrame = frame:FindFirstChild("ShopFrame")
				local Left = shopFrame and shopFrame:FindFirstChild("Left")
				local Middle = shopFrame and shopFrame:FindFirstChild("Middle")
				local Right = shopFrame and shopFrame:FindFirstChild("Right")

				if Left then
					ManageLimitedButtons(Left)
				end

				if Middle then
					ManageLimitedButtons(Middle)

					local giftButton = Middle:FindFirstChild("GiftButton")

					if giftButton then
						giftButton.MouseButton1Click:Connect(function()
							CashShopBackground.Visible = false
							ShopBackground.Back.Visible = false
							ShopGiftDetails.ImageLabel.Image = Middle.ImageLabel.Image
							ShopGiftDetails.ItemName.Text = Middle.ItemName.Text
							ShopGiftDetails.ItemPrice.Text = Middle.ItemPrice.Text
							ShopGiftDetails.ItemType.Text = "Game Pass"
							ShopGiftScreen.Visible = true
							ShopFrame.Visible = false
							ShopBuyScreen.Visible = false
							ShopCashFrame.TextButton.Visible = false
							lastGiftScreen = "GamePass"
						end)
					end
				end

				if Right then
					ManageLimitedButtons(Right)
				end
			elseif string.find(frame.Name, "MedalCollab") then
				local button = frame:FindFirstChildWhichIsA("GuiButton")
				
				if button then
					button.MouseButton1Click:Connect(function()
						if button.Title.Text == "Claimed" then return end
						
						local success = Services.MedalService:AttemptClaim()
						
						if success then
							if button.Title.Text ~= "Success" then
								button.Title.Text = "Success"
								
								task.delay(1, function()
									if button.Title.Text ~= "Claimed" then
										button.Title.Text = "Claimed"
										button.Interactable = false
									end
								end)
							end
						end
					end)
				end
			end
		end
	end
	
	for _, v in pairs(HowToPlayButtons:WaitForChild("Buttons"):GetChildren()) do
		if v:IsA("GuiButton") then
			local findFrame = HowToPlayGui:FindFirstChild(v.Name)
			
			if findFrame and findFrame:IsA("Frame") then
				v.MouseButton1Click:Connect(function()
					HowToPlayButtons.Visible = false
					findFrame.Visible = true
					
					if v.Name == "VRTutorial" then
						findFrame.Videos["1"]:Play()
						VRTutorialVideos["2"].Visible = false
						VRTutorialVideos["3"].Visible = false
						VRTutorialVideos["1"].Visible = true
					end
				end)
			end
		end
	end
	
	for _, v in pairs(InventoryButtons:GetChildren()) do
		if v:IsA("GuiButton") then
			v.MouseButton1Click:Connect(function()
				for _, frame in pairs(InventoryFrames:GetChildren()) do
					if frame.Name == v.Name then
						frame.Visible = true
					else
						frame.Visible = false
					end
				end
			end)
		end
	end
	
	for _, v in pairs(GamePassBuyScreens:GetChildren()) do
		if v:IsA("Frame") then
			local buttons = v:FindFirstChild("Buttons")

			if buttons then
				buttons:WaitForChild("StartButton").MouseButton1Click:Connect(function()
					Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes[v.Name].Id, "GamePass")
				end)

				buttons:WaitForChild("LeaveButton").MouseButton1Click:Connect(function()
					v.Visible = false

					if currentShopSoundPlaying then
						currentShopSoundPlaying:Stop()
						currentShopSoundPlaying = nil
					end

					ShopBackground.Back.Visible = true
					ShopFrame.Visible = true
				end)
			end
		end
	end
	
	for _, v in pairs(MainSettingsFrame:WaitForChild("ControllerType"):GetChildren()) do
		if v:IsA("GuiButton") then
			v.MouseButton1Click:Connect(function()
				PlayerSettings.ControllerType(v.Name)
				Services.SettingsService:Update("ControllerType", v.Name)
			end)
		end
	end
	
	for _, v in pairs(MainSettingsFrame:WaitForChild("RadioEnabled"):GetChildren()) do
		if v:IsA("GuiButton") then
			v.MouseButton1Click:Connect(function()
				if Services.ShopService:UserOwnsGamePass(Utilities.ProductIds.Passes["Radio"].Id, true) then
					PlayerSettings.RadioEnabled(v.Name)
					Services.SettingsService:Update("RadioEnabled", v.Name)
				end
			end)
		end
	end
	
	for _, v in pairs(CashShopFrame:GetChildren()) do
		if v:IsA("Frame") then
			local product = Utilities.ProductIds.Cash[tonumber(v.Name)]
			local button = product and v:FindFirstChild("TextButton")
			
			if button then
				button.MouseButton1Click:Connect(function()
					Services.ShopService:AttemptPromptPurchase(product.Id, "Product")
				end)
				
				local giftButton = v:FindFirstChild("GiftButton")

				giftButton.MouseButton1Click:Connect(function()
					CashShopBackground.Visible = false
					ShopBackground.Back.Visible = false
					ShopGiftDetails.ImageLabel.Image = "rbxassetid://108667083303574"
					ShopGiftDetails.ItemName.Text = v.ItemName.Text
					ShopGiftDetails.ItemPrice.Text = v.TextButton.Text
					ShopGiftDetails.ItemType.Text = "Product"
					ShopGiftScreen.Visible = true
					lastGiftScreen = "Product"
				end)
			end
		end
	end

	for _, v in pairs(CashEffectFrame:GetChildren()) do
		if v:IsA("Frame") then
			local product = Utilities.ProductIds.Cash[tonumber(v.Name)]
			local button = product and v:FindFirstChild("TextButton")

			if button then
				button.MouseButton1Click:Connect(function()
					Services.ShopService:AttemptPromptPurchase(product.Id, "Product")
				end)
				
				local giftButton = v:FindFirstChild("GiftButton")
				
				giftButton.MouseButton1Click:Connect(function()
					CashEffectBackground.Visible = false
					BackgroundEffectFrame.Back.Visible = false
					EffectShopGiftDetails.ImageLabel.Image = "rbxassetid://108667083303574"
					EffectShopGiftDetails.ItemName.Text = v.ItemName.Text
					EffectShopGiftDetails.ItemPrice.Text = v.TextButton.Text
					EffectShopGiftDetails.ItemType.Text = "Product"
					EffectShopGiftScreen.Visible = true
					lastGiftScreen = "Product"
				end)
			end
		end
	end
	
	for _, v in pairs(CurrentEventCurrencyShopFrame:GetChildren()) do
		if v:IsA("Frame") then
			local product = Utilities.ProductIds["Beach Balls"][tonumber(v.Name)]
			local button = product and v:FindFirstChild("TextButton")

			if button then
				button.MouseButton1Click:Connect(function()
					Services.ShopService:AttemptPromptPurchase(product.Id, "Product")
				end)

				local giftButton = v:FindFirstChild("GiftButton")

				giftButton.MouseButton1Click:Connect(function()
					CurrentEventGui.Enabled = false
					CashShopBackground.Visible = false
					ShopBackground.Back.Visible = false
					ShopGiftDetails.ImageLabel.Image = "rbxassetid://106432558355449"
					ShopGiftDetails.ItemName.Text = v.ItemName.Text .. " Beach Balls"
					ShopGiftDetails.ItemPrice.Text = v.TextButton.Text
					ShopGiftDetails.ItemType.Text = "Product"
					ShopFrame.Visible = false
					ShopBuyScreen.Visible = false
					ShopCashFrame.TextButton.Visible = false
					ShopGiftScreen.Visible = true
					ShopGui.Enabled = true
					lastGiftScreen = "Event"
				end)
			end
		end
	end
	
	for _, v in pairs(LobbySettingsFrame:GetChildren()) do
		if v:IsA("Frame") then
			local leftButton = v:FindFirstChild("Left")
			local rightButton = v:FindFirstChild("Right")
			local valueLabel = v:FindFirstChild("ValueLabel")
			
			if leftButton and rightButton and valueLabel then
				leftButton.MouseButton1Click:Connect(function()
					if not changingChoice then
						changingChoice = true
						
						local currentChoice = table.find(tableCreationChoices[v.Name], tableCreationData[v.Name])
						local nextChoice = currentChoice and currentChoice - 1
						
						if tableCreationChoices[v.Name][nextChoice] then
							tableCreationData[v.Name] = tableCreationChoices[v.Name][nextChoice]

							valueLabel.Text = tableCreationData[v.Name]
						end
						
						changingChoice = false
					end
				end)
				
				rightButton.MouseButton1Click:Connect(function()
					if not changingChoice then
						changingChoice = true
					
						local currentChoice = table.find(tableCreationChoices[v.Name], tableCreationData[v.Name])
						local nextChoice = currentChoice and currentChoice + 1

						if tableCreationChoices[v.Name][nextChoice] then
							tableCreationData[v.Name] = tableCreationChoices[v.Name][nextChoice]
							
							valueLabel.Text = tableCreationData[v.Name]
						elseif v.Name == "MaxParticipants" and nextChoice >= 6 and nextChoice < 12 then
							Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["Bigger Table"].Id, "GamePass")
						elseif v.Name == "MaxPotions" and nextChoice >= 4 and nextChoice < 8 then
							Services.ShopService:AttemptPromptPurchase(Utilities.ProductIds.Passes["Too Many Potions"].Id, "GamePass")
						end
						
						changingChoice = false
					end
				end)
			end
			
			v.MouseEnter:Connect(function()
				LobbySettingsFrame.SettingDescription.Text = tableCreationDescriptions[v.Name] or ""
			end)
			
			v.MouseLeave:Connect(function()
				if LobbySettingsFrame.SettingDescription.Text == tableCreationDescriptions[v.Name] then
					LobbySettingsFrame.SettingDescription.Text = ""
				end
			end)
		end
	end
end)

totalLoaded += 1

Services.TextChatService.OnIncomingMessage = function(msg : TextChatMessage)
	local p = Instance.new("TextChatMessageProperties")

	if msg.TextSource then
		if msg.TextSource.CanSend then
			local tags = Services.ChatTagService:GetTags(msg.TextSource.UserId)

			if type(tags) == "table" and #tags > 0 then
				local newTags = ""

				for i,v in pairs(tags) do
					newTags = newTags .. "<font color='rgb(" .. math.round(v.Color.R * 255) .. "," .. math.round(v.Color.G * 255) .. "," .. math.round(v.Color.B * 255) .. ")'>[" .. v.Name .. "]</font> "
				end

				p.PrefixText = newTags .. msg.PrefixText
			end

			return p
		else
			Services.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("You are currently muted.")

			return msg
		end
	end
end

-- TODO: try raycasting for click

mouse.Button1Down:Connect(function()
	--if not potionChoiceStarted then return end
	if sendingAttemptDrinkPotion then return end
	
	sendingAttemptDrinkPotion = true
	
	local success, err = pcall(function()
		local mousePos = mouse.Hit.Position
		local cameraPos = camera.CFrame.Position
		local potionsFolder = ClientStorage:FindFirstChild(tostring(Player.UserId) .. "_POTIONS")
		
		if mousePos and cameraPos and potionsFolder then
			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Include
			raycastParams.FilterDescendantsInstances = {potionsFolder}
			
			local direction = mousePos - cameraPos
			local result = workspace:Raycast(cameraPos, direction * 10, raycastParams)
			
			if result and result.Instance then
				local potionPart = (result.Instance.Parent:IsA("BasePart") and result.Instance.Parent) or (result.Instance)
				local potionNum = potionPart and potionPart.Parent == potionsFolder and tonumber(potionPart.Name)
				
				if potionNum then
					local success2, result2 = Services.GameplayService:AttemptDrinkPotion(potionNum, Services.VRService.VREnabled)

					if success2 then
						potionChoiceStarted = false
						global.ChosenPotions[tostring(Player.UserId)] = potionNum
						task.spawn(DrinkPotion, (result2 and true) or (false))
					else
						--warn(result2)
					end
				end
			end
		end
	end)
	
	--[[local success, err = pcall(function()
		local target = mouse.Target
		local potionsFolder = ClientStorage:FindFirstChild(tostring(Player.UserId) .. "_POTIONS")
		local potionPart = (target.Parent:IsA("BasePart") and target.Parent) or (target)
		local potionNum = potionPart and potionPart.Parent == potionsFolder and tonumber(potionPart.Name)
		
		if potionsFolder and potionNum then
			local success, result = Services.GameplayService:AttemptDrinkPotion(potionNum, Services.VRService.VREnabled)

			if success then
				potionChoiceStarted = false
				global.ChosenPotions[tostring(Player.UserId)] = potionNum
				task.spawn(DrinkPotion, (result and true) or (false))
			else
				--warn(result)
			end
		end
	end)]]
	
	if not success then warn(err) end
	
	sendingAttemptDrinkPotion = false
end)

mouse.Move:Connect(function()
	if not gameInProgress and not isSpectating and not Services.VRService.VREnabled then
		local X = mouse.X
		local Y = mouse.Y
		local screenSize = camera.ViewportSize
		local xDistance = (X / screenSize.X) - 0.5
		local yDistance = ((Y + 36) / screenSize.Y) - 0.5
		
		if not camPart then
			camPart = LobbyRoomClone and LobbyRoomClone:FindFirstChild("CameraPart")
		end

		if camPart then
			camera.CFrame = camPart.CFrame * CFrame.Angles(-math.rad(yDistance * 15), 0, 0) * CFrame.Angles(0, -math.rad(xDistance * 15), 0)
		end
	end
end)

Services.VRService.UserCFrameChanged:Connect(function()
	local character = Player.Character
	local cardsFolder = character and character:FindFirstChild("Cards")
	local rightHand = character and character:FindFirstChild("RightHand")

	if cardsFolder and rightHand and global.Values["CurrentTurn"].Value == Player.UserId and global.Values["CurrentState"].Value == "TURN START" then
		local raycastParams = RaycastParams.new()
		
		raycastParams.FilterType = Enum.RaycastFilterType.Include
		raycastParams.FilterDescendantsInstances = {cardsFolder}
		raycastParams.RespectCanCollide = false
		
		local pos = rightHand.Position
		local dir = (rightHand.CFrame * CFrame.Angles(math.rad(-90), 0, 0)).LookVector * 20
		local raycast = workspace:Raycast(pos, dir, raycastParams)

		if raycast and raycast.Instance then
			for _, v in pairs(cardsFolder:GetChildren()) do
				if v:IsA("BasePart") then
					local cardSplit = string.split(v.Name, "Card")
					local cardNum = cardSplit[2] and tonumber(cardSplit[2])
					
					if cardNum then
						if v == raycast.Instance then
							local indexs = {}

							for i = 1, #cardsFolder:GetChildren() do
								local child = cardsFolder:FindFirstChild("Card" .. i)

								if child.Transparency ~= 1 then
									table.insert(indexs, i)
								end
							end

							local cardToSwitch = table.find(indexs, cardNum)
							
							SwitchCards(true, cardToSwitch)
							
							return
						end
					end
				end
			end
			
			SwitchCards(true, 0)
		end
	end
end)

Services.RunService.Heartbeat:Connect(function(dt)
	if gameInProgress and Player.Character and Player.Character.Parent then
		MainMenuGui.Enabled = false
	end
	
	if isSpectating and not Services.VRService.VREnabled and currentSpectate and camera.CameraType == Enum.CameraType.Scriptable then
		local character = currentSpectate.Character
		
		MainSpectateFrame.TextLabel.Text = (currentSpectate.Name) or ("")
		
		if character then
			for _, v in pairs(character:GetDescendants()) do
				if (v:IsA("BasePart")) and (v:FindFirstAncestorWhichIsA("Accessory") or v.Name == "Head") then
					v.Transparency = 1
					v.LocalTransparencyModifier = 1
				end
			end
			
			local lastCharacter = lastSpectate and lastSpectate.Character
			
			if lastCharacter and lastCharacter ~= character then
				for _, d in pairs(lastCharacter:GetDescendants()) do
					if (d:IsA("BasePart")) and (d:FindFirstAncestorWhichIsA("Accessory") or d.Name == "Head") then
						d.Transparency = 0
						d.LocalTransparencyModifier = 0
					end
				end
			end
			
			local head = character:FindFirstChild("Head")
			
			if head then
				camera.CFrame = head.CFrame
			end
		end
	end
	
	if LobbyRoomClone then
		local currentRoom = ClientStorage:FindFirstChild("CURRENT_ROOM")
		local fans = (currentRoom and currentRoom:FindFirstChild("Fans")) or (LobbyRoomClone:FindFirstChild("Fans"))
		
		if fans then
			for _, v in pairs(fans:GetChildren()) do
				local blades = v:FindFirstChild("Blades")
				
				if blades then
					blades.CFrame *= CFrame.Angles(0, math.rad(85 * dt), 0)
				end
			end
		end
	end
	
	TopMiddleClaimLabel.Visible = gameInProgress
	TopMiddleLastClaim.Visible = gameInProgress
	
	if gameInProgress then
		local lastInput = Utilities.Utils.getLastInput()

		if lastInput then
			for _, v in pairs(KeybindsIcons:GetChildren()) do
				for _, k in pairs(v:GetChildren()) do
					if k:IsA("Frame") then
						if v.Name == lastInput then
							k.Visible = true
						else
							k.Visible = false
						end
					end
				end
			end
			
			MainSpectateFrame.Left.Controller.Visible = lastInput == "controller"
			MainSpectateFrame.Right.Controller.Visible = lastInput == "controller"
			MainSpectateFrame.Left.Normal.Visible = lastInput ~= "controller"
			MainSpectateFrame.Right.Normal.Visible = lastInput ~= "controller"
			
			MobileGui.Enabled = lastInput == "touch"

			if lastInput == "mouse" then
				gameEffectsIcon:setImage("rbxassetid://74815357031079")
				currentSettingsIcon:setImage("rbxassetid://79530386758431")
			else
				gameEffectsIcon:setImage("")
				currentSettingsIcon:setImage("")
			end
			
			KeybindsGui.Enabled = lastInput ~= "touch"
		end
		
		if Player.Character then
			mouse.TargetFilter = Player.Character
		end
		
		local currentTarget = mouse.Target
		
		if isAdmin then
			local cheatsEnabled = Services.ReplicatedStorage:FindFirstChild("CheatsEnabled")
			
			if cheatsEnabled and cheatsEnabled.Value then
				local makeVisible = false
				
				if currentTarget and currentParticipants then
					for _, v in pairs(currentParticipants) do
						if v.Player and v.Player.Character and currentTarget:IsDescendantOf(v.Player.Character) then
							for i, b in pairs(AdminCurrent.Cards:GetChildren()) do
								if b:IsA("ImageButton") then
									if v.Cards[tonumber(b.Name)] then
										b.Image = ((b.Name == "Demon" or b.Name == "Angel") and Utilities.CardImages[b.Name][global.Values["CurrentCard"].Value]) or (Utilities.CardImages.Normal[v.Cards[tonumber(b.Name)]])
										b.Visible = true
									else
										b.Visible = false
									end
								end
							end
							
							AdminCurrent.TextLabel.Text = v.Name .. "'s Cards"
							
							makeVisible = true
							
							break
						end
					end
				end
				
				AdminCurrent.Visible = makeVisible
			else
				AdminCurrent.Visible = false
				AdminLast.Visible = false
			end
		else
			AdminCurrent.Visible = false
			AdminLast.Visible = false
		end
		
		local radios = ClientStorage:FindFirstChild("RADIOS")
		
		if radios then
			if Utilities.Utils.getLastInput() == "touch" then
				local params = RaycastParams.new()
				
				params.FilterType = Enum.RaycastFilterType.Include
				params.FilterDescendantsInstances = {radios}
				
				local raycast = workspace:Raycast(camera.CFrame.Position, camera.CFrame.LookVector * 100, params)
				
				if raycast and raycast.Instance then
					currentTarget = raycast.Instance
				else
					currentTarget = nil
				end
			end
			
			for _, v in pairs(radios:GetChildren()) do
				local prompt = v:FindFirstChildWhichIsA("ProximityPrompt")
				
				if currentTarget and currentTarget.Parent == v then
					prompt.Enabled = true
				else
					prompt.Enabled = false
				end
			end
		end
	else
		KeybindsGui.Enabled = false
		MobileGui.Enabled = false
		AdminCurrent.Visible = false
		AdminLast.Visible = false
	end
	
	if Services.VRService.VREnabled then
		local character = Player.Character
		local rightHand = character and character:FindFirstChild("RightHand")
		local handSpeed = rightHand and rightHand:FindFirstChild("HandSpeed")
		local handSpeedLabel = handSpeed and handSpeed:FindFirstChild("TextLabel")

		if rightHand then
			local currentHandPosition = rightHand.Position
			local handDifference = (lastHandPosition and currentHandPosition) and (lastHandPosition.Y - currentHandPosition.Y)
			local currentVelocity = handDifference and handDifference / dt

			if currentVelocity then
				if #global.lastHandVelocities > math.min(0.1 / dt, 100) then
					table.remove(global.lastHandVelocities, 1)
				else
					table.insert(global.lastHandVelocities, currentVelocity)

					local total = #global.lastHandVelocities
					local sum = 0

					for _, v in pairs(global.lastHandVelocities) do
						sum += v
					end

					lastVelocityCheck = sum / total

					if handSpeedLabel then
						handSpeedLabel.Text = lastVelocityCheck
					end

					if lastVelocityCheck >= 5 and not grabbingCardVR and not liarVRDebounce and global.Values["CurrentState"].Value == "TURN START" and global.Values["CurrentTurn"].Value == Player.UserId then
						liarVRDebounce = true

						local s, e = pcall(function()
							local voice = currentItems and global.AllItems["Voices"][currentItems[tostring(Player.UserId)]["Voices"] or "Default"]
							local voiceName = voice and voice.Name
							local soundFolder = voiceName and SoundStorage:FindFirstChild(voiceName)
							local currentSound = soundFolder and soundFolder:FindFirstChild("Liar")

							if currentSound then
								currentSound:Play()
								HitSound.TimePosition = 0.7
								HitSound:Play()
								TriggerHaptics()
							end
						end)

						if not s then warn(e) end

						local success, result = Services.GameplayService:AttemptCallOut(true)

						if not success then
							warn(result)
						end

						task.delay(1, function()
							liarVRDebounce = false
						end)
					end
				end
			end

			lastHandPosition = currentHandPosition
		else
			table.clear(global.lastHandVelocities)
		end
	end
	
	if global.Values["CurrentState"].Value ~= "TURN START" then
		waitingTurnTick = tick()
		
		if Services.VRService.VREnabled then
			table.clear(global.lastHandVelocities)
		end
	else
		if tick() - waitingTurnTick >= 10 and global.Values["CurrentTurn"].Value and global.AllItems and currentItems then
			waitingTurnTick = tick()

			local voice = global.AllItems["Voices"][currentItems[tostring(global.Values["CurrentTurn"].Value)]["Voices"] or "Default"]
			local voiceName = voice and voice.Name
			local soundFolder = voiceName and SoundStorage:FindFirstChild(voiceName)
			local currentSound = soundFolder and soundFolder:FindFirstChild("Hmm")
			
			if currentSound then
				currentSound:Play()
			end
		end
	end
end)

totalLoaded += 1

task.spawn(function()
	pcall(function()
		Services.VRService.LaserPointer = Enum.VRLaserPointerMode.Pointer
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local Cmdr = require(Services.ReplicatedStorage:WaitForChild("CmdrClient"))
		
		isAdmin = Services.ModerationService:IsPlayerWhitelisted()

		if isAdmin then
			Cmdr:SetActivationKeys({Enum.KeyCode.F2})
		else
			Cmdr:SetActivationKeys({})
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		BlurEffect.Size = 8
		BlurEffect.Enabled = true
	end)
	
	totalLoaded += 1
	
	pcall(function()
		camPart = LobbyRoomClone and LobbyRoomClone:FindFirstChild("CameraPart")
		
		if LobbyRoomClone then
			LobbyRoomClone.Parent = workspace
			LobbyRoomClone:PivotTo(LobbyRoomClone:GetPivot() * CFrame.new(0, 1000, 0))
		end
		
		if camPart then
			camera.CameraType = Enum.CameraType.Scriptable
			camera.CFrame = camPart.CFrame
		end
	end)
	
	totalLoaded += 1
	
	local s, e = pcall(function()
		for i, v in pairs(ItemStorage:GetChildren()) do
			global.AllItems[v.Name] = {}
			
			for _, item in pairs(v:GetChildren()) do
				global.AllItems[v.Name][item.Name] = require(item)
			end
		end
		
		allItemsLoaded = true
	end)
	
	if not s then warn(e) end
	
	totalLoaded += 1
	
	local s, e = pcall(function()
		local tbls = Services.GameplayService:GetTableData({"Host", "Participants", "MaxParticipants", "JoinType", "MaxPotions", "MaxCards", "IncludeJokers", "IncludeDemon", "IncludeAngel", "AutoLiar", "AnyLiar", "OnLastPotion", "EffectsEnabled", "Room"})

		if tbls then
			for i, tbl in pairs(tbls) do
				for _, participant in pairs(tbl.Participants) do
					if participant.UserId == Player.UserId then
						UpdateLobbyScreen(tbl.Participants)
					end
				end

				local tableSettings = {
					MaxPotions = tbl.MaxPotions,
					MaxPlayers = tbl.MaxParticipants,
					MaxCards = tbl.MaxCards,
					JoinType = tbl.JoinType,
					IncludeJokers = tbl.IncludeJokers,
					IncludeDemon = tbl.IncludeDemon,
					IncludeAngel = tbl.IncludeAngel,
					AutoLiar = tbl.AutoLiar,
					AnyLiar = tbl.AnyLiar,
					OnLastPotion = tbl.OnLastPotion,
					EffectsEnabled = tbl.EffectsEnabled,
					Room = tbl.Room
				}
				
				task.spawn(function()
					if #tbl.Participants > 0 then
						UpdateLobbyList(true, tbl.Host, tbl.Participants, tableSettings)
					else
						UpdateLobbyList(false, tbl.Host)
					end
				end)
			end
		end
	end)

	if not s then warn(e) end

	totalLoaded += 1
	
	pcall(function()
		local voices = global.AllItems["Voices"]
		local default = voices and voices["Default"]

		if default then
			CreateVoiceFolderFor(default)
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local victories = global.AllItems["Victories"]
		local default = victories and victories["Default"]

		if default then
			CreateVictorySoundFor(default)
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local knockouts = global.AllItems["Knockouts"]
		local Knockout = knockouts and knockouts["Default"]
		
		if Knockout and type(Knockout.Data) == "table" then
			Utilities.Animations["Knockout_" .. Knockout.Name] = Knockout.Data.AnimationId
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local effects = global.AllItems["Effects"]

		if effects then
			for _, v in pairs(effects) do
				local newTemplate = EffectTemplate:Clone()

				newTemplate.EffectName.Text = v.Name
				newTemplate.Description.Text = v.Description
				newTemplate.TextButton.Text = "$" .. Utilities.Utils.formatNumber(v.Price, 10000)
				newTemplate.Name = v.Name
				newTemplate.Parent = MainEffectFrame

				newTemplate.TextButton.MouseButton1Click:Connect(function()
					if newTemplate.TextButton.Text == "Success" or newTemplate.TextButton.Text == "Active" then return end
					
					local success, result = Services.GameplayService:AttemptPurchaseEffect(v.Name)
					
					if success then
						if newTemplate.TextButton.Text ~= "Success" then
							newTemplate.TextButton.Text = "Success"
							
							task.delay(2, function()
								if newTemplate.TextButton.Text == "Success" then
									newTemplate.TextButton.Text = "$" .. Utilities.Utils.formatNumber(v.Price, 10000)
								end
							end)
						end
					else
						if result == "Effect already active" then
							if newTemplate.TextButton.Text ~= "Active" then
								newTemplate.TextButton.Text = "Active"

								task.delay(2, function()
									if newTemplate.TextButton.Text == "Active" then
										newTemplate.TextButton.Text = "$" .. Utilities.Utils.formatNumber(v.Price, 10000)
									end
								end)
							end
						end
						
						warn(result)
					end
				end)
			end
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local leaderboards = Services.LeaderboardService:GetLeaderboards()
		
		if leaderboards then
			for i, v in pairs(leaderboards) do
				UpdateLeaderboard(i, v)
			end
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local currentShopItems = Services.ShopService:GetCurrentShopItems()
		
		if currentShopItems then
			repeat task.wait() until not changingShop
			ChangeShop(currentShopItems)
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local currencyData = Services.CurrencyService:GetData()
		
		if type(currencyData) == "table" then
			if currencyData["Beach Balls"] then
				UpdateBattlePass(currencyData["Beach Balls"])
			end
			
			if currencyData.Cash then
				ShopCashLabel.Text = "$" .. Utilities.Utils.formatNumber(currencyData.Cash, 1000000)
				EffectCashLabel.Text = "$" .. Utilities.Utils.formatNumber(currencyData.Cash, 1000000)
				cashIcon:setLabel(ShopCashLabel.Text)
			end
			
			for i, v in pairs(currencyData) do
				if type(i) ~= "string" then continue end
				UpdateStatsFrame(i, v)
			end
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local inventoryData = Services.InventoryService:GetData()
		
		if type(inventoryData) == "table" and inventoryData.Inventories then
			global.playerItemData = inventoryData.Inventories
		end
		
		for i, v in pairs(inventoryData.Inventories) do
			UpdateInventory(i, v, inventoryData.Equipped[i])
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local questData = Services.QuestsService:GetData()
		
		if questData then
			UpdateQuests(questData)
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local songList = Services.GameplayService:GetRadioSongList()
		
		if type(songList) == "table" and #songList > 0 then
			UpdateRadioSongList(songList)
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local ownedPasses = Services.ShopService:GetUserOwnedGamePasses()
		
		if type(ownedPasses) == "table" then
			for i, v in pairs(ownedPasses) do
				global.CachedPasses[tonumber(i)] = v
			end
		end
		
		local ownsBiggerTable = Services.ShopService:UserOwnsGamePass(Utilities.ProductIds.Passes["Bigger Table"].Id)
		local ownsVIP = Services.ShopService:UserOwnsGamePass(Utilities.ProductIds.Passes.VIP.Id)
		local ownsDoubleEventCurrency = Services.ShopService:UserOwnsGamePass(Utilities.ProductIds.Passes["x2 Beach Balls"].Id)
		
		global.CachedPasses[Utilities.ProductIds.Passes["Bigger Table"].Id] = ownsBiggerTable or nil
		global.CachedPasses[Utilities.ProductIds.Passes.VIP.Id] = ownsVIP or nil
		global.CachedPasses[Utilities.ProductIds.Passes["x2 Beach Balls"].Id] = ownsDoubleEventCurrency or nil
		
		if global.CachedPasses[Utilities.ProductIds.Passes["Bigger Table"].Id]  then
			tableCreationChoices.MaxParticipants = {
				[1] = 2,
				[2] = 3,
				[3] = 4,
				[4] = 5,
				[5] = 6,
				[6] = 7,
				[7] = 8,
				[8] = 9,
				[9] = 10,
				[10] = 11,
				[11] = 12
			}
		end
		
		if global.CachedPasses[Utilities.ProductIds.Passes["Too Many Potions"].Id] then
			tableCreationChoices.MaxPotions = {
				[1] = 1,
				[2] = 2,
				[3] = 3,
				[4] = 4,
				[5] = 5,
				[6] = 6,
				[7] = 7,
				[8] = 8
			}
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local plyrSettings = Services.SettingsService:Get()
		
		if plyrSettings then
			for i, v in pairs(plyrSettings) do
				local toNum = tonumber(v)
				
				if PlayerSettings[i] then
					PlayerSettings[i](v)
				end

				if i == "InGameMusic" then
					if toNum then
						Sliders.AmbienceSlider:OverrideValue(toNum)
					end
				elseif i == "MainMusic" then
					if toNum then
						Sliders.MusicSlider:OverrideValue(toNum)
					end
				elseif i == "VoiceCalls" then
					if toNum then
						Sliders.VoiceSlider:OverrideValue(toNum)
					end
				end
			end
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local MAX_RETRIES = 5
		local RETRY_TIME = 1
		local CurrentRetries = {}
		
		local function checkFailed(contentId, Status)
			if Status == Enum.AssetFetchStatus.Failure then
				if not CurrentRetries[contentId] then
					CurrentRetries[contentId] = 0
				end
				
				if CurrentRetries[contentId] >= MAX_RETRIES then
					warn("Failed to load", contentId, "; retry limit reached")
				else
					CurrentRetries[contentId] += 1
					
					warn("Failed to load", contentId, "; trying again (" .. CurrentRetries[contentId] .. "/" .. MAX_RETRIES .. ")")
					
					task.wait(RETRY_TIME)
					
					Services.ContentProvider:PreloadAsync({contentId}, checkFailed)
				end
			end
		end
		
		local images = {}
		
		for _, v in pairs(Utilities.CardImages.Normal) do
			table.insert(images, v)
		end
		
		for _, v in pairs(Utilities.CardImages.Demon) do
			table.insert(images, v)
		end
		
		local cards = ItemStorage and ItemStorage:FindFirstChild("Cards")
		
		if cards then
			for i, v in pairs(cards:GetChildren()) do
				local cardObject = v:FindFirstChildWhichIsA("BasePart") or v:FindFirstChildWhichIsA("Model")
				local cardBack = cardObject and cardObject:FindFirstChild("Back")
				
				if cardBack and cardBack:IsA("Decal") then
					table.insert(images, cardBack.Texture)
				end
			end
		end
		
		Services.ContentProvider:PreloadAsync(images, checkFailed)
	end)
	
	totalLoaded += 1
	
	pcall(function()
		local isVCServer = game.PlaceId == Utilities.UtilSettings.VC_Only_Server
		local currentLabel
		local delayTask
		
		if isVCServer or Services.VoiceChatService:IsVoiceEnabledForUserIdAsync(Player.UserId) then
			voiceChatIcon = Utilities.Icon.new()
			
			if not isVCServer then
				currentLabel = "VC Only Server"
				voiceChatIcon:setLabel("VC Only Server")
				voiceChatIcon:setImage("rbxassetid://71879367287389")
			else
				currentLabel = "Back To Main Server"
				voiceChatIcon:setLabel("Back To Main Server")
			end

			voiceChatIcon:setOrder(1)
			voiceChatIcon:setTextFont(Enum.Font.Merriweather)
			
			voiceChatIcon.toggled:Connect(function(enabled)
				if not enabled then return end
				
				if delayTask then
					task.cancel(delayTask)
					delayTask = nil
				end
				
				if currentLabel == "VC Only Server" or currentLabel == "Back To Main Server" then
					currentLabel = "Are you sure?"
					voiceChatIcon:setLabel("Are you sure?")
					voiceChatIcon:deselect()
					
					delayTask = task.delay(3, function()
						if currentLabel ~= "VC Only Server" and currentLabel ~= "Back To Main Server" and currentLabel == "Are you sure?" then
							if not isVCServer then
								currentLabel = "VC Only Server"
								voiceChatIcon:setLabel("VC Only Server")
							else
								currentLabel = "Back To Main Server"
								voiceChatIcon:setLabel("Back To Main Server")
							end
						end
					end)
				elseif currentLabel == "Are you sure?" then
					voiceChatIcon:lock()
					currentLabel = "Teleporting..."
					voiceChatIcon:setLabel("Teleporting...")

					if not isVCServer then
						Services.TeleportService:Teleport(Utilities.UtilSettings.VC_Only_Server)
					else
						Services.TeleportService:Teleport(Utilities.UtilSettings.Main_Server)
					end
				end
			end)
			
			Services.TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMsg, placeId, teleportOptions)
				if player == Player and teleportResult ~= Enum.TeleportResult.Success then
					currentLabel = "Teleport Failed"
					voiceChatIcon:setLabel("Teleport Failed")
					
					task.delay(1, function()
						voiceChatIcon:unlock()
						voiceChatIcon:deselect()
						
						if not isVCServer then
							currentLabel = "VC Only Server"
							voiceChatIcon:setLabel("VC Only Server")
						else
							currentLabel = "Back To Main Server"
							voiceChatIcon:setLabel("Back To Main Server")
						end
					end)
				end
			end)
		end
	end)
	
	totalLoaded += 1

	pcall(function()
		local wins = Services.CurrencyService:GetAmount("Wins")
		
		if wins then
			--LoadProServerIcon(wins)
		end
	end)
	
	totalLoaded += 1
	
	--[[pcall(function()
		local isSeventeenPlus = game.PlaceId == 132313578914910
		local currentLabel
		local delayTask
		
		if not isSeventeenPlus then
			seventeenPlusIcon = Utilities.Icon.new()

			currentLabel = "17+ Server"
			seventeenPlusIcon:setLabel("17+ Server")

			seventeenPlusIcon:setOrder(1)
			seventeenPlusIcon:setTextFont(Enum.Font.Merriweather)

			seventeenPlusIcon.toggled:Connect(function(enabled)
				if not enabled then return end

				if delayTask then
					task.cancel(delayTask)
					delayTask = nil
				end

				if currentLabel == "17+ Server" then
					currentLabel = "Are you sure?"
					seventeenPlusIcon:setLabel("Are you sure?")
					seventeenPlusIcon:deselect()

					delayTask = task.delay(3, function()
						if currentLabel ~= "17+ Server" and currentLabel == "Are you sure?" then
							currentLabel = "17+ Server"
							seventeenPlusIcon:setLabel("17+ Server")
						end
					end)
				elseif currentLabel == "Are you sure?" then
					seventeenPlusIcon:lock()
					currentLabel = "Teleporting..."
					seventeenPlusIcon:setLabel("Teleporting...")

					Services.TeleportService:Teleport(132313578914910)
				end

				Services.TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMsg, placeId, teleportOptions)
					if player == Player and teleportResult ~= Enum.TeleportResult.Success then
						currentLabel = "Teleport Failed"
						seventeenPlusIcon:setLabel("Teleport Failed")

						task.delay(1, function()
							seventeenPlusIcon:unlock()
							seventeenPlusIcon:deselect()

							currentLabel = "17+ Server"
							seventeenPlusIcon:setLabel("17+ Server")
						end)
					end
				end)
			end)
		end
	end)]]
	
	totalLoaded += 1
	
	pcall(function()
		if Services.VRService.VREnabled then
			Services.GameplayService:ActivateVR()
		end
	end)
	
	totalLoaded += 1
	
	pcall(function()
		if Services.VRService.VREnabled then
			VRNoticeGui.Enabled = true
		else
			MainMenuGui.Enabled = true
		end
	end)
	
	totalLoaded += 1
	
	MainMusic:Play()
end)