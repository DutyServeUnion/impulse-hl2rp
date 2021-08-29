-- Framework related
impulse.Config.SchemaName = "Half-Life 2 Roleplay"
impulse.Config.SchemaVersion = 1.61
impulse.Config.SchemaCredits = [[<font=Impulse-Elements23>vin
aLoneWitness</font>

Powered by
<font=Impulse-Elements23>vin - Longsword weapon base</font>

Special thanks
<font=Impulse-Elements23>nutscript - great examples of HL2:RP systems
zepla - Enhanced Citizens v4
DPotatoman - Metropolice pack</font>]]

impulse.Config.MainColour = Color(51, 153, 255, 255)
impulse.Config.InteractColour = Color(251, 197, 49)

impulse.Config.UserSlots = 74 -- any other slots will be donator slots

impulse.Config.IntroMusic = "music/hl1_song20.mp3"

impulse.Config.SignalsUpdateTime = 2

impulse.Config.WalkSpeed = 100
impulse.Config.JogSpeed = 200
impulse.Config.SlowWalkRatio = 0.6

impulse.Config.TalkDistance = 300
impulse.Config.WhisperDistance = 90
impulse.Config.YellDistance = 550
impulse.Config.VoiceDistance = 550

impulse.Config.OOCLimit = 16
impulse.Config.OOCLimitVIP = 28

impulse.Config.PropLimit = 90
impulse.Config.PropLimitDonator = 170

impulse.Config.BuyableSpawnLimit = 6
impulse.Config.DroppedItemsLimit = 20
impulse.Config.DroppedMoneyLimit = 10
impulse.Config.ChairsLimit = 3

impulse.Config.StartingMoney = 50
impulse.Config.StartingBankMoney = 450
impulse.Config.CurrencyPrefix = "T"
impulse.Config.CurrencyName = "tokens"
impulse.Config.ATMModel = "models/props_combine/combine_intwallunit.mdl"

impulse.Config.XPTime = 600
impulse.Config.XPGet = 5 -- double xp (normal: 5)
impulse.Config.XPGetVIP = 10 -- double xp (normal: 10)

impulse.Config.RationTime = 3600

impulse.Config.AFKTime = 360 -- 6 mins
impulse.Config.AFKKickRatio = 0.95

impulse.Config.TeamChangeTime = 120
impulse.Config.TeamChangeTimeDonator = 15

impulse.Config.ClassChangeTime = 60
impulse.Config.QuizWaitTime = 20 -- in mins

impulse.Config.RespawnTime = 50
impulse.Config.RespawnTimeDonator = 20

impulse.Config.BodyDeSpawnTime = 360 -- 6 mins

impulse.Config.BrokenLegsHealTime = 300 -- 5 mins

impulse.Config.PropPrice = 5
impulse.Config.PropPriceDonator = 2

impulse.Config.RPNameChangePrice = 60

impulse.Config.CosmeticGenderPrice = 600
impulse.Config.CosmeticModelSkinPrice = 120

impulse.Config.MaxLetters = 3

impulse.Config.HungerTime = 60
impulse.Config.HungerHealTime = 25

impulse.Config.InventoryMaxWeight = 20 -- in kg
impulse.Config.InventoryStorageMaxWeight = 80
impulse.Config.InventoryStorageMaxWeightVIP = 160
impulse.Config.InventoryItemDeSpawnTime = 300
impulse.Config.InventoryStorageModel = "models/props/cs_militia/footlocker01_closed.mdl"
impulse.Config.InventoryStoragePublicModel = "models/props_c17/lockers001a.mdl"

impulse.Config.GroupMakeCost = 10000
impulse.Config.GroupXPRequirement = 1500
impulse.Config.GroupMaxMembers = 20
impulse.Config.GroupMaxMembersVIP = 100

impulse.Config.CommunityURL = "https://impulse-community.com"
impulse.Config.PanelURL = "https://panel.impulse-community.com"
impulse.Config.DonateURL = "https://panel.impulse-community.com/index.php?t=shop"
impulse.Config.DiscordURL = "https://discordapp.com/invite/8QZsS6Q"
impulse.Config.SupportURL = "https://support.impulse-community.com" -- this can just be the forum url

impulse.Config.RulesURL = "https://docs.google.com/document/d/13CU712-kqcB-2J2NjkqYB8Z4EI50OJrepxlkk5SDTqo/pub?embedded=true"
impulse.Config.TutorialURL = "https://docs.google.com/document/d/1HgLso6BuzzFSAbPdRIPA-ZTIRIRG4akaR2_iyMixi_8/pub?embedded=true"

-- Optional, if you don't have it delete the line below. Used for newsfeed. Requires: https://wordpress.org/plugins/better-rest-api-featured-images/
impulse.Config.WordPressURL = "https://news.impulse-community.com"
impulse.Config.DefaultWordPressImage = "https://raw.githubusercontent.com/vingard/impulse-issues/master/announcement.png"

impulse.Config.DisabledPlugins = {
	["season_xmas"] = true,
	["season_halloween"] = true,
	["season_aprilfools"] = true,
	["ending"] = true
}

impulse.Config.DoorPrice = 10
impulse.Config.DoorGroups = {
	[1] = "Universal Union Access L1",
	[2] = "Universal Union Access L2",
	[3] = "Civil Workers Union",
	[4] = "Civil Medical Authority"
}

impulse.Config.RankColours = {
	["superadmin"] = Color(201, 15, 12),
	["communitymanager"] = Color(84, 204, 5),
	["leadadmin"] = Color(128, 0, 128),
	["admin"] = Color(34, 88, 216),
	["moderator"] = Color(34, 88, 216),
	["donator"] = Color(212, 185, 9)
}

impulse.Config.SaveableAmmo = {
	["Pistol"] = true,
	["SMG1"] = true,
	["357"] = true,
	["Buckshot"] = true,
	["AR2"] = true,
	["Rifle"] = true
}

impulse.Config.Achievements = {
	["ach_apt"] = {
		Name = "Home Sweet Home",
		Desc = "Purchase your first apartment",
		Icon = Material("impulse/icons/house-128.png")
	},
	["ach_fromthegrave"] = {
		Name = "From The Grave",
		Desc = "Kill a player while dead",
		Icon = Material("impulse/icons/toxic-256.png")
	},
	["ach_greatescape"] = {
		Name = "The Great Escape",
		Desc = "Break out of jail",
		Icon = Material("impulse/icons/exit-128.png")
	},
	["ach_deadweight"] = {
		Name = "Dead Weight",
		Desc = "Lose 15+ kilograms of items on death",
		Icon = Material("impulse/icons/weight-128.png")
	},
	["ach_jackofalltrades"] = {
		Name = "Jack Of All Trades",
		Desc = "Master every skill",
		Icon = Material("impulse/icons/bar-chart-5-128.png"),
		OnJoin = true,
		Check = function(ply)
			for v,k in pairs(impulse.Skills.Skills) do
				if ply:GetSkillXP(v) < 4500 then
					return false
				end
			end

			return true
		end
	},
	["ach_dayone"] = {
		Name = "Veteran",
		Desc = "Play the server from day 1",
		Icon = Material("impulse/icons/star-128.png"),
		OnJoin = true,
		Check = function(ply)
			if ply.impulseFirstJoin and ply.impulseFirstJoin < 1574553600 then -- unix epoch of 11/24/2019 (release first 30ish hours)
				return true
			end
		end
	},
	["ach_ourhouse"] = {
		Name = "Our House",
		Desc = "Add 9 people to your door",
		Icon = Material("impulse/icons/group-256.png")
	},
	["ach_pickupthatcan"] = {
		Name = "Pick Up That Can",
		Desc = "Complete Pick Up That Can",
		Icon = Material("impulse/icons/check-mark-128.png")
	},
	["ach_party"] = {
		Name = "Party",
		Desc = "Dance with 15 other players",
		Icon = Material("impulse/icons/party-hat-3-256.png")
	},
	["ach_quickshot"] = {
		Name = "Quick Shot-",
		Desc = "Kill a player that is 100 meters or more away",
		Icon = Material("impulse/icons/gun-2-128.png")
	},
	["ach_donator"] = {
		Name = "<3",
		Desc = "Donate to the server",
		Icon = Material("impulse/icons/heart-128.png"),
		OnJoin = true,
		Check = function(ply)
			if ply:IsDonator() then
				return true
			end
		end
	},
	["ach_vin"] = {
		Name = "Yes, I was the real vin!",
		Desc = "Kill vin",
		Icon = Material("impulse/icons/vin.png"),
		Points = 100
	},
	["ach_unknownkiller"] = {
		Name = "Unknown Killer",
		Desc = "Execute the City Administrator with a face wrap on",
		Icon = Material("impulse/icons/decision-256.png")
	},
	["ach_costlydeath"] = {
		Name = "Costly Death",
		Desc = "Die to a player with 20000 tokens on you",
		Icon = Material("impulse/icons/banknotes-128.png")
	},
	["ach_bambikiller"] = {
		Name = "Bambi Killer",
		Desc = "Kill a player with less than 30XP",
		Icon = Material("impulse/icons/sad.png")
	},
	["ach_closeshave"] = {
		Name = "Close Shave",
		Desc = "Kill an OTA when you have only 1 HP left",
		Icon = Material("impulse/icons/clenched-fist-256.png")
	},
	["ach_axe"] = {
		Name = "Gotta Start Somewhere...",
		Desc = "Craft an Axe",
		Icon = Material("impulse/icons/cog-128.png")
	},
	["ach_brains"] = {
		Name = "Brainsssss",
		Desc = "Rise up from the dead on the 31st of October",
		Icon = Material("impulse/icons/zombie-256.png")
	},
	["ach_clobberer"] = {
		Name = "The Clobberer",
		Desc = "Kill 3 CPs with the Pickaxe in 4 minutes",
		Icon = Material("impulse/icons/weightlift-128.png")
	},
	["ach_addict"] = {
		Name = "Addict",
		Desc = "Earn over 25000XP",
		Icon = Material("impulse/icons/stop-3-256.png"),
		OnJoin = true,
		Check = function(ply)
			if ply:GetXP() > 25000 then
				return true
			end
		end
	},
	["ach_hardtimes"] = {
		Name = "Hard Times",
		Desc = "Buy the Mysterious Fisherman's hat",
		Icon = Material("impulse/icons/sad.png")
	},
	["ach_forum"] = {
		Name = "Community Connection",
		Desc = "Register on the forums",
		Icon = Material("impulse/icons/social/forum-256.png")
	},
	["ach_insane"] = {
		Name = "The Voices...",
		Desc = "Go insane",
		Icon = Material("impulse/icons/brain-3-256.png")
	},
	["ach_stresstest"] = {
		Name = "The Test",
		Desc = "Take part in the 128 slot stress test",
		Icon = Material("impulse/icons/test-tube-2-128.png"),
		NoPoints = true
	},
	["event_c17_volatileelements"] = {
		Name = "Event Award - Volatile Elements",
		Desc = "Take part in the season 1 'Volatile Elements' event",
		Icon = Material("impulse/icons/radioactive-256.png"),
		NoPoints = true
	},
	["event_s1_uncontrolledvariables"] = {
		Name = "Event Award - Uncontrolled Variables",
		Desc = "Take part in the season 1 'Uncontrolled Variables' event",
		Icon = Material("impulse/icons/fire-128.png"),
		NoPoints = true
	},
	["event_c17_sandtraps"] = {
		Name = "Event Award - Sandtraps",
		Desc = "Take part in the season 2 'Sandtraps' event",
		Icon = Material("impulse/icons/radioactive-256.png")
	}
}

impulse.Config.ModQuickReplies = {
	"Thanks for submitting this report. I'll need some more information about what your problem is to solve this issue.",
	"Unfortunately we can not help with this type of issue. If you have any issues with rule-breakers feel free to send another report.",
	"Unfortunately I can not help with compensation requests. Goto support.impulse-community.com for to submit one.",
	"We can help you further if you submit at ticket at support.impulse-community.com",
	"We have decided to not grant you rogue permission, please do not make another request for at least 1 hour.",
	"You have been granted rogue permission. Please remember, you may not go as the JURY division AND you may only be an i3 or i4. Furthermore, you may only kill in absolute self-defence situations.",
	"Apologies for the delay in responding to this report.",
	"Thank you for your report.",
	"Unfortunately I will have to close this report as it is too old to be dealt with. Feel free to submit a ban request at impulse-community.com"
}

impulse.Config.AutoModDict = {
	{
		Terms = {"AJ", "AUTONOMOUS JUDGEMENT"},
		Specific = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Thanks for the report! Autonomous Judgement (AJ) can only be activated in major events which are planned by the staff team. We can't activate it on request. Sorry!"
	},
	{
		Terms = {"HI DALE", "HELLO DALE", "DALE", "WHAT IS DALE", "WHO IS DALE"},
		Specific = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hi! I'm Dale, the >>automated<< chipmunk moderator! I'll try to answer your questions before you speak to a staff member to solve your issue!"
	},
	{
		Terms = {"HELP", "JUST HELP", "HELP ME", "ADMIN HELP", "ADMIN", "COME HERE", "COME", "NEED STAFF", "NEED ADMIN", "ADMIN COME HERE", "ADMIN TO ME", "I NEED A ADMIN", "I NEED ADMIN", "TO ME", "MINGE", "HEY"},
		Specific = true,
		IgnorePunc = true,
		Reply = "Hi! I've noticed your report doesn't contain much detail about the situation. We'd really appricate it if you could provide some more information for us by updating the report! Thanks!"
	},
	{
		Terms = {"E2", "HELP"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hey there! We can't provide any specific assistance with how to use E2. To learn about E2 take a look at the tutorials here: https://github.com/wiremod/wire/wiki/Expression-2#Tutorials"
	},
	{
		Terms = {"E2", "HOW"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hey there! We can't provide any specific assistance with how to use E2. To learn about E2 take a look at the tutorials here: https://github.com/wiremod/wire/wiki/Expression-2#Tutorials"
	},
	{
		Terms = {"XP REFUND", "REFUND XP"},
		Specific = false,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hello! We don't offer XP refunds under any circumstances, sorry!"
	},
	{
		Terms = {"CAN I GO ROUGE", "ROUGE PERM", "ROUGE", "ROGUE", "ROGUE PERM", "CAN I GO ROGUE", "ROGUE PERM", "ROUGEPERM", "PERM TO GO ROUGE", "PERM TO GO ROGUE", "ROGUE PERMISSION", "ROUGE PERMISSION"},
		Specific = true,
		IgnorePunc = true,
		Reply = "Hi! I've detected you've submitted a report regarding permission to go rouge, please be aware, that in busy times this report will be low priority for response. Please also be aware that only i3's and i4's can go rouge. JURY units can not go rouge."
	},
	{
		Terms = {"HOW", "DONATE"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hi! Thanks for considering donating! You can donate by pressing F1 and selecting 'Donate'! If you have any issues regarding donating contact us at support.impulse-community.com"
	},
	{
		Terms = {"HOW", "VIP"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "Hi! Thanks for considering donating! You can donate by pressing F1 and selecting 'Donate'! If you have any issues regarding donating contact us at support.impulse-community.com"
	},
	{
		Terms = {"HOW", "GET", "XP"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "You can gain XP by just playing the server! Every 10 minutes you will gain 5XP. If you are a donator you will gain 10XP."
	},
	{
		Terms = {"HOW", "GAIN", "XP"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "You can gain XP by just playing the server! Every 10 minutes you will gain 5XP. If you are a donator you will gain 10XP."
	},
	{
		Terms = {"HOW", "GET", "TOKEN"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "You can get tokens in your ration. Every hour you'll get a ration which you can collect in the Trainstation. You can also get tokens by working in the factory, or trading with other players!"
	},
	{
		Terms = {"HOW", "GET", "MONEY"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "You can get tokens in your ration. Every hour you'll get a ration which you can collect in the Trainstation. You can also get tokens by working in the factory, or trading with other players!"
	},
	{
		Terms = {"CONTENT"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "To download the content press ESC > Options > Other > Allow all custom files from server and click 'Apply'. Then rejoin the server. If you have any other issues press ESC > Addons > Enable All."
	},
	{
		Terms = {"FAILED", "QUIZ"},
		TermsTogether = true,
		IgnorePunc = true,
		RequestClose = true,
		Reply = "I'm sorry to hear that :( -  you can retry the quiz again in 20 minutes. We can't tell you any answers unfortunatley. Good luck next time!"
	},
	{
		Terms = {"STUCK"},
		IgnorePunc = true,
		RequestClose = true,
		Reply = "I've tried to get you un-stuck. This automated system might not always work, however. You can activate this by typing /unstuck in chat. If you are still stuck, just hang in there and we'll be with you shortly!",
		Command = "say /unstuck"
	}
}

impulse.Config.DefaultTeam = TEAM_CITIZEN

impulse.Config.DefaultMaleModels = {
	Model("models/player/impulse_zelpa/male_01.mdl"),
	Model("models/player/impulse_zelpa/male_02.mdl"),
	Model("models/player/impulse_zelpa/male_03.mdl"),
	Model("models/player/impulse_zelpa/male_04.mdl"),
	Model("models/player/impulse_zelpa/male_05.mdl"),
	Model("models/player/impulse_zelpa/male_06.mdl"),
	Model("models/player/impulse_zelpa/male_07.mdl"),
	Model("models/player/impulse_zelpa/male_08.mdl"),
	Model("models/player/impulse_zelpa/male_09.mdl"),
	Model("models/player/impulse_zelpa/male_10.mdl"),
	Model("models/player/impulse_zelpa/male_11.mdl")
}

impulse.Config.DefaultFemaleModels = {
	Model("models/player/impulse_zelpa/female_01.mdl"),
	Model("models/player/impulse_zelpa/female_02.mdl"),
	Model("models/player/impulse_zelpa/female_03.mdl"),
	Model("models/player/impulse_zelpa/female_04.mdl"),
	Model("models/player/impulse_zelpa/female_06.mdl"),
	Model("models/player/impulse_zelpa/female_07.mdl")
}

impulse.Config.DefaultSkinBlacklist = {
	["models/player/impulse_zelpa/male_02.mdl"] = {14, 22, 6} -- bloody eye skins
}

--
-- Half Life 2: Roleplay Schema:
--

impulse.Config.ArrestCharges = {
	{name = "10-103m, disturbance by mentally unfit", severity = 5, sound = "npc/overwatch/radiovoice/disturbancemental10-103m.wav"},
	{name = "27, attempted crime", severity = 2, sound = "npc/overwatch/radiovoice/attemptedcrime27.wav"},
	{name = "51, non-sanctioned arson", severity = 5, sound = "npc/overwatch/radiovoice/nonsanctionedarson51.wav"},
	{name = "51B, threat to property", severity = 3, sound = "npc/overwatch/radiovoice/threattoproperty51b.wav"},
	{name = "63, criminal trespass", severity = 5, sound = "npc/overwatch/radiovoice/criminaltrespass63.wav"},
	{name = "69, possession of (contraband) resources", severity = 3, sound = "npc/overwatch/radiovoice/posession69.wav"},
	{name = "95, illegal carrying (weaponry)", severity = 6, sound = "npc/overwatch/radiovoice/illegalcarrying95.wav"},
	{name = "99, reckless operation", severity = 2, sound = "npc/overwatch/radiovoice/recklessoperation99.wav"},
	{name = "148, resisting arrest", severity = 4, sound = "npc/overwatch/radiovoice/resistingpacification148.wav"},
	{name = "243, assault on protection team", severity = 14, sound = "npc/overwatch/radiovoice/assault243.wav"},
	{name = "404, riot", severity = 4, sound = "npc/overwatch/radiovoice/riot404.wav"},
	{name = "507, public non-compliance", severity = 2, sound = "npc/overwatch/radiovoice/publicnoncompliance507.wav"},
	{name = "603, unlawful entry", severity = 4, sound = "npc/overwatch/radiovoice/unlawfulentry603.wav"},
	{name = "Disassociation from the civic populous", severity = 7, sound = "npc/overwatch/radiovoice/disassociationfromcivic.wav"},
	{name = "Promoting communal unrest", severity = 7, sound = "npc/overwatch/radiovoice/promotingcommunalunrest.wav"}
}

impulse.Config.DispatchLines = {
    {name = "Anti-citizen reported in this community", text = "Attention, ground-units: Anti-citizen reported in this community. Code: LOCK, CAUTERIZE, STABILIZE.", sound = "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav", volume = 80},
    {name = "Anti-civil activity level 1", text = "You are charged with anti-civil activity level: ONE. Protection-unit prosecution code: DUTY, SWORD, OPERATE.", sound = "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav", volume = 85},
	{name = "Block search", text = "Attention, residents: This blocks contains potential civil infection. INFORM, CO-OPERATE, ASSEMBLE.", sound = "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav", volume = 90},
	{name = "Inspection positions", text = "Attention, please: All citizens in local residential block, assume your inspection-positions.", sound = "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav", volume = 90},
	{name = "Unidentified person of interest", text="Attention please. Unidentified person of interest, confirm your civil status with local protection team immediately.", sound = "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav", volume = 75},
	{name = "Status evasion in progress", text="Attention, protection-team, status evasion in progress in this community. RESPOND, ISOLATE, INQUIRE.", sound="npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav", volume = 85},
	{name = "Anti-civil evidence", text = "Protection team alert: Evidence of anti-civil activity in this community. Code: ASSEMBLE, CLAMP, CONTAIN.", sound = "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav", volume = 85},
	{name = "Socio-endagerment level 5", text = "Individual, you are now charged with Socio-Endangerment level: FIVE. Cease evasion immediately, receive your verdict.", sound = "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav", volume = 85}
}

impulse.Config.MaxJailTime = 900
impulse.Config.MaxJailTimeGrunt = 420
impulse.Config.MinJailTime = 60
impulse.Config.MaxArrestCharges = 4

impulse.Config.DefaultBOLTime = 2700

impulse.Config.CameraRepairTime = 2400

impulse.Config.ManhackTime = 160

impulse.Config.MaxSquadsCP = 9
impulse.Config.MaxSquadsOTA = 4
impulse.Config.MaxSquadSizeCP = 3
impulse.Config.MaxSquadSizeOTA = 4
impulse.Config.SquadExpiryTime = 240

impulse.Config.DealerTeleportTimeMin = 1500
impulse.Config.DealerTeleportTimeMax = 1900

impulse.Config.MaxBarrels = 2
impulse.Config.BrewingTime = 900

impulse.Config.FactoryLaundryReward = 8
impulse.Config.VendingRefillReward = 15

impulse.Config.ApartmentCost = 15 -- one time purchase amount

impulse.Config.ExplosionDoorRespawnTime = 230

impulse.Config.AmmoDrillTime = 180 -- 3 mins

impulse.Config.VortessenceRange = 900
impulse.Config.VortessenceTime = 1200

impulse.Config.BeepSounds = {
	[TEAM_CP] = {
		on = {
			"npc/overwatch/radiovoice/on1.wav",
			"npc/overwatch/radiovoice/on3.wav",
			"npc/metropolice/vo/on2.wav"
		},
		off = {
			"npc/metropolice/vo/off1.wav",
			"npc/metropolice/vo/off2.wav",
			"npc/metropolice/vo/off3.wav",
			"npc/metropolice/vo/off4.wav",
			"npc/overwatch/radiovoice/off2.wav",
			"npc/overwatch/radiovoice/off2.wav"
		}
	},

	[TEAM_OTA] = {
		on = {
			"npc/combine_soldier/vo/on1.wav",
			"npc/combine_soldier/vo/on2.wav"
		},
		off = {
			"npc/combine_soldier/vo/off1.wav",
			"npc/combine_soldier/vo/off2.wav",
			"npc/combine_soldier/vo/off3.wav"
		}
	}
}

impulse.Config.DeathSounds = {
	[TEAM_CP] = {
		"npc/metropolice/die1.wav",
		"npc/metropolice/die2.wav",
		"npc/metropolice/die3.wav",
		"npc/metropolice/die4.wav"
	},

	[TEAM_OTA] = {
		"npc/combine_soldier/die1.wav",
		"npc/combine_soldier/die2.wav",
		"npc/combine_soldier/die3.wav"
	}
}

impulse.Config.PainSounds = {
	[TEAM_CP] = {
		"npc/metropolice/pain1.wav",
		"npc/metropolice/pain2.wav",
		"npc/metropolice/pain3.wav",
		"npc/metropolice/pain4.wav"
	},

	[TEAM_OTA] = {
		"npc/combine_soldier/pain1.wav",
		"npc/combine_soldier/pain2.wav",
		"npc/combine_soldier/pain3.wav"
	}
}

impulse.Config.LootPools = {
	["generic"] = {
		Items = {
			["util_cloth"] = {Rarity = 680, Rep = 3},
			["util_gunpowder"] = {Rarity = 680},
			["util_metalplate"] = {Rarity = 600, Rep = 3},
			["util_plastic"] = {Rarity = 900},
			["util_glue"] = {Rarity = 750, Rep = 2},
			["util_paint"] = {Rarity = 920},
			["item_vortessence"] = {Rarity = 970},
			["util_fuel"] = {Rarity = 999}
		},
		MaxRarity = 1700,
		MaxItems = 4,
		MaxWait = 700,
		MinWait = 210
	},
	["metal"] = {
		Items = {
			["util_metalplate"] = {Rarity = 680, Rep = 4},
			["util_refinedmetalplate"] = {Rarity = 980},
			["util_pipe"] = {Rarity = 810},
			["util_gear"] = {Rarity = 890}
		},
		MaxItems = 4,
		MaxWait = 800,
		MinWait = 200
	},
	["electronic"] = {
		Items = {
			["util_plastic"] = {Rarity = 700, Rep = 3},
			["util_electronics"] = {Rarity = 850},
			["item_vortessence"] = {Rarity = 960},
			["util_refinedmetalplate"] = {Rarity = 990}
		},
		MaxItems = 3,
		MaxWait = 860,
		MinWait = 430
	},
	["ammobox"] = {
		Items = {
			["wep_smg"] = {Rarity = 300, Rep = 2},
			["ammo_ar2"] = {Rarity = 600, Rep = 4},
			["ammo_smg"] = {Rarity = 600, Rep = 3},
			["ammo_buckshot"] = {Rarity = 600, Rep = 3},
			["ammo_rifle"] = {Rarity = 600, Rep = 2},
			["wep_smg"] = {Rarity = 600},
			["wep_ar2"] = {Rarity = 620, Rep = 2},
			["cos_elitevest"] = {Rarity = 720, Rep = 2},
			["wep_pistol"] = {Rarity = 860, Rep = 2},
			["util_ceramicplate"] = {Rarity = 900}
		},
		MaxItems = 16,
		MinItems = 7
	}
}

impulse.Config.TheatreMusic = {
	["CP Violation"] = "music/HL2_song20_submix4.mp3",
	["Triage at Dawn"] = "music/hl2_song23_suitsong3.mp3",
	["Beautiful Creature"] = "industrial17/namtran_beautifulcreature.mp3",
	["Blue Collar Citizen"] = "industrial17/namtran_bluecollarcitizen.mp3",
	["Carpenter Tribute"] = "industrial17/namtran_jctribute.mp3",
	["Metro 5-0"] = "industrial17/namtran_metro.mp3",
	["Rust Belt"] = "industrial17/namtran_rustbelt.mp3"
}

--
-- Plugins
--

impulse.Config.PassiveMusic = {
	{"music/HL2_song0.mp3", 39},
	{"music/HL2_song1.mp3", 98},
	{"music/HL2_song10.mp3", 29},
	{"music/HL2_song13.mp3", 53},
	{"music/HL2_song17.mp3", 61},
	{"music/HL2_song19.mp3", 115},
	{"music/HL2_song26.mp3", 69},
	{"music/HL2_song26_trainstation1.mp3", 90},
    {"music/HL2_song33.mp3", 84},
    {"music/HL2_song8.mp3", 59}
}

impulse.Config.CombatMusic = {
	{"music/HL2_song12_long.mp3", 73},
	{"music/HL2_song14.mp3", 159},
	{"music/HL2_song15.mp3", 69},
	{"music/HL2_song16.mp3", 170},
	{"music/HL2_song20_submix0.mp3", 103},
	{"music/HL2_song20_submix4.mp3", 139},
	{"music/HL2_song29.mp3", 135},
	{"music/HL2_song3.mp3", 90},
	{"music/HL2_song31.mp3", 98},
	{"music/HL2_song4.mp3", 65},
	{"music/HL2_song6.mp3", 45}
}

impulse.Config.Chairs = {
	["models/props_trainstation/traincar_seats001.mdl"] = {
		{ pos = Vector(4.6150, 41.7277, 18.5313) },
		{ pos = Vector(4.7320, 14.4948, 18.5313) },
		{ pos = Vector(4.5561, -13.3913, 18.5313) },
		{ pos = Vector(5.4507, -40.9903, 18.5313) },
	},
	["models/props_warehouse/office_furniture_couch.mdl"] = {
		{ pos = Vector(4.6150, 36, -4) },
		{ pos = Vector(4.7320, 0, -4) },
		{ pos = Vector(5.4507, -36, -4) },
	},
	["models/props_warehouse/office_furniture_couch.mdl"] = {
		{ pos = Vector(4.6150, 36, -4) },
		{ pos = Vector(4.7320, 0, -4) },
		{ pos = Vector(5.4507, -36, -4) },
	},
	["models/props_c17/furniturechair001a.mdl"] = {
		{ pos = Vector(0.30538135766983, 0.14535087347031, -6.69970703125) },
	},
	["models/props_combine/breenchair.mdl"] = {
		{ pos = Vector(6.8169813156128, -2.8282260894775, 16.551658630371) },
	},
	["models/props_trainstation/bench_indoor001a.mdl"] = {
		{ pos = Vector(17.38335609436, 1.022953748703, 7) },
		{ pos = Vector(-16.71875, 1.3125007152557, 6.71875) }
	}
}

