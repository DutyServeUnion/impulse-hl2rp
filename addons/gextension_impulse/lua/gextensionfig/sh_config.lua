//////////////////////////////////////
//     	  GExtension (c) 2019       //
//                                  //
//  Created by Jakob 'ibot3' Müller //
//                                  //
//  You are not permitted to share, //
//   	 trade, give away, sell     //
//      or otherwise distribute     //
//////////////////////////////////////

-- The ID of the server. Assign a new ID for each server!
-- Set to -1 if you want to use the ConVar "gex_serverid"
GExtension.ServerID = 1

-- URL to GmodWeb (with http(s)://)
-- Must end with a "/"
-- Example: https://www.mycommunity.com/gextension/
GExtension.WebURL = "https://panel.impulse-community.com/"

-- TimeFormat | https://www.lua.org/pil/22.1.html
GExtension.TimeFormat = "%d/%m/%Y %H:%M"

-- Every X seconds, the server checks for new rewards
GExtension.RewardRefreshTime = 30

-- Commands, that will open the donate page
GExtension.DonateCmds = {}

-- Commands, that will open the ticket page
GExtension.TicketCmds = {}

-- Number of reserved slots. 0 to disable.
-- Players with the reserved slot permission can use these slots.
GExtension.RSlotsNumber = 0

-- Whether or not to kick a player if a reserved slot is used.
-- Keeps the maximum amount of players to (ServerSlots - RSlotsNumber)
-- If this option is enabled and reserved slots should be used, RSlotsNumber should be 1 or higher;
--  Players need some time to connect, so it's useful to have multiple RSlots.
GExtension.KeepReservedSlotsFree = true

-- Whether or not to hide the reserved slots
-- Example: 34 slot server, RSlotsNumber = 2. The server will be visible as 32 slot server.
--          But it is still possible for more players to connect.
GExtension.HideReserdedSlots = true

-- Use ChatTags (Tag = Display Name of the group)
-- You need to disable the ServerGuard ChatTags plugin
-- NOT COMPATIBLE WITH DARKRP, DISABLE
GExtension.ChatTags = false

-- Makes the ULX banlist functional again.
-- The ULib import will NOT work if enabled.
-- New ULib bans will be GExtension bans, EVEN IF IT'S DISABLED!
GExtension.EnableReplaceULibBans = false

-- Language Code
-- Available: ch, en, de, fr, pl, ru & more (Check https://customercenter.ibot3.de/index.php?t=languagecenter)
GExtension.LanguageCode = "en"

-- Print executed rewards to console
GExtension.PrintExecutedRewards = true
