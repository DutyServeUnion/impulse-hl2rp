TEAM_OTA = impulse.Teams.Define({
	name = "Overwatch Transhuman Arm",
	color = Color(60, 60, 60, 255),
	description = [[The OTA are the military wing of the Universal Union’s forces.
	They are highly trained and extensively modified super soldiers, far stronger
	than any normal human. They are entirely without fear or emotion of any kind,
	called on to the streets only when circumstances are at their most dire.
	Otherwise, they remain in the Nexus or guarding hardpoints around the city.
	They are completely obedient to their commander, following orders without
	regard to their own safety. Operating in small squads, the OTA are a force
	to be reckoned with, and haunt the dreams of any citizen with common sense.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 300,
	model = "models/player/soldier_stripped.mdl",
	handModel = "models/weapons/c_arms_combine.mdl",
	percentLimit = true,
	limit = 0.15,
	xp = 500,
	cp = true,
	doorGroup = {1, 2, 3, 4},
	blockNameChange = true,

	quiz = {
		{
			question = "What is the name of the main overwatch division?",
			answers = {
				{"SENTINEL", false},
				{"RANGER", false},
				{"ECHO", true}
			}
		},
		{
			question = "What does the overwatch code 'amputate' mean?",
			answers = {
				{"To amputate a limb from the target.", false},
				{"To kill a target.", true},
				{"To arrest the target.", false}
			}
		},
		{
			question = "You are guarding the nexus when you see a Civil Protection team taking heavy losses raiding a nearby apartment. What do you do?",
			answers = {
				{"Charge in and provide fire support for the Civil Protection units.", false},
				{"Keep extra alert but remain at your post until a Civil Unrest code is activated.", false},
				{"Radio in, asking for support, then move in to assist the Civil Protection team.", false},
				{"Remain at your post until Judgement Waiver is activated.", true}
			}
		},
		{
			question = "You find yourself isolated in the sewers after losing sight of your squad. What do you do?",
			answers = {
				{"Continue sweeping the sewers until Judgement Waiver is disabled.", false},
				{"Radio in to your squad to get their location and regroup.", true},
				{"Return to the nexus.", true}
			}
		},
		{
			question = "Civil Protection are arresting rebels in a Judgement Waiver. What do you do?",
			answers = {
				{"Approach the rebels and amputate them.", false},
				{"Leave the Civil Protection teams to handle arrests themselves.", true},
				{"Take command of the Civil Protection team and get them to round up more rebels.", false}
			}
		},
		{
			question = "You are guarding the City Administrator as a SENTINEL unit, when Judgement Waiver activates. What do you do?",
			answers = {
				{"Group up with a squad and move out to sweep the city.", false},
				{"Stay with the City Administrator, ensuring they remain inside the Nexus at all times.", true},
				{"Let the other SENTINEL unit stay with the City Administrator and move out to sweep the city.", false},
				{"Move out with the City Administrator to the sewers to provide additional fire support to overwatch squads.", false}
			}
		},
		{
			question = "What city code lets overwatch units leave the nexus?",
			answers = {
				{"Civil", false},
				{"Civil Unrest", false},
				{"Judgement Waiver", true},
				{"Autonomous Judgement", true}
			}
		},
		{
			question = "Do you understand that you must be able to provide reason to game moderators for all IC punishments (charges, re-education, killing) to citizens?",
			answers = {
				{"Yes", true},
				{"No", false}
			}
		}
	},

	classes = {
		{
			name = "ECHO",
			description = "ECHO units are highly trained medium-range combat units. ECHO units are a jack of all trades, master of none. They have access to a mix of close and medium range weaponry.",
			model = "models/Combine_Soldier.mdl",
			skin = 0,
			xp = 500,
			armour = 100,
			noMenu = true
		},
		{
			name = "MACE",
			description = "MACE units are close-quaters engagement specialists. They are ineffective at medium and long ranges however they excel at close-quaters due to their SPAS-12 shotgun and heavy armour. MACE units are excellent at performing raids and bruteforcing into enemy strongholds.",
			model = "models/Combine_Soldier.mdl",
			skin = 1,
			itemsAdd = {
				{class = "wep_shotgun", amount = 1}
			},
			xp = 1000,
			armour = 130,
			percentLimit = true,
			limit = 0.05,
			noMenu = true
		},
		{
			name = "SENTINEL",
			description = "SENTINEL units are elite, disiplined units that act as close protection for the City Administrator or any high value political figures. They are equipped with heavy armour and medium range weaponry. They do not attach to a normal OTA squad and instead stay with the City Administrator at all times.",
			model = "models/Combine_Super_Soldier.mdl",
			skin = 0,
			itemsAdd = {
				{class = "wep_ar2", amount = 1}
			},
			xp = 1800,
			armour = 130,
			limit = 2,
			noMenu = true
		},
		{
			name = "RANGER",
			description = "RANGER units are hand-picked from the units in overwatch. They are specialists in long range engagements with the advanced EVR scope attached to their AR2. They also have the flexibility to remove this scope to fight efficiently in medium range engagements too. RANGER units are often considered overwatch's greatest strategic asset.",
			model = "models/Combine_Super_Soldier.mdl",
			skin = 0,
			itemsAdd = {
				{class = "wep_ar2", amount = 1}
			},
			xp = 4200,
			armour = 120,
			percentLimit = true,
			limit = 0.07,
			noMenu = true
		}
	},

	ranks = {
		{
			name = "OWS",
			description = "ows",
			xp = 500,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_ECHO then
					ply:GiveInventoryItem("wep_smg", 1, true)
				end
			end
		},
		{
			name = "EOW",
			description = "eow",
			xp = 1500,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_ECHO then
					ply:GiveInventoryItem("wep_ar2", 1, true)
				end
			end
		},
		{
			name = "LDR",
			description = "ldr",
			xp = 3000,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_ECHO then
					ply:GiveInventoryItem("wep_ar2", 1, true)
				end
			end,
			percentLimit = true,
			limit = 0.04
		}
	}
})

CLASS_ECHO = 1
CLASS_MACE = 2
CLASS_SENTINEL = 3
CLASS_RANGER = 4

RANK_OWS = 1
RANK_EOW = 2
RANK_LDR = 3
