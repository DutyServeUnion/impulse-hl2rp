TEAM_CP = impulse.Teams.Define({
	name = "Civil Protection",
	color = Color(65, 105, 200, 255),
	description = [[The CCA are the Universal Union’s human police force.
	They are responsible for the enforcement of the UU’s laws, and 
	controlling the population. The CCA consists of multiple divisions, 
	each with a specific role. Many join the CCA in hopes of getting better
	rations, or simply for the power it brings over their fellow citizens.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 250,
	model = "models/dpfilms/metropolice/hdpolice.mdl",
	handModel = "models/weapons/c_metrocop_hands.mdl",
	percentLimit = true,
	limit = 0.3,
	xp = 100,
	cp = true,
	doorGroup = {1},
	blockNameChange = true,
	runSpeed = 210,

	quiz = {
		{
			question = "What is the name of the main patrol division?",
			answers = {
				{"UNION", true},
				{"HELIX", false},
				{"GRID", false}
			}
		},
		{
			question = "You are on patrol in the Plaza and there is no anti-civil activity occurring. What should you be holding?",
			answers = {
				{"Stunstick", true},
				{"Nothing", true},
				{"Pistol", false},
				{"SMG", false}
			}
		},
		{
			question = "You are told by your patrol team leader to inspect a house alone and you find suspicious weaponry inside, you then notice that rebels are hiding in a room. What do you do?",
			answers = {
				{"Kick down the door where the rebels are and shoot them.", false},
				{"Call for backup on the radio immediately, then run in and kill them.", false},
				{"Call for backup on the radio immediately,  then lock down the apartment and ensure they don’t leave. When backup arrives you can deal with them.", true}
			}
		},
		{
			question = "A citizen is acting suspiciously in the Plaza, what do you do?",
			answers = {
				{"Approach them and tell them to isolate, if they fail to do so re-educate them.", true},
				{"Do nothing.", false},
				{"Shoot them.", false}
			}
		},
		{
			question = "You respond to a request and find a citizen has broken into and entered a property, and is vandalising it. They do not resist arrest, what do you charge them with?",
			answers = {
				{"603, unlawful entry and 51B, threat to property.", true},
				{"63, criminal trespass.", false},
				{"95, illegal carrying and 51B threat to propety.", false}
			}
		},
		{
			question = "A citizen has been found carrying a weapon in the streets. When first apprehended by officers the citizen initially resisted arrest by running. You have now arrested the citizen and you have brought them back to a terminal. What do you charge them with?",
			answers = {
				{"404, riot.", false},
				{"404, riot and 148, resisting arrest.", false},
				{"95, illegal carrying and 148, resisting arrest.", true},
				{"27, attempted crime.", false}
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
			name = "UNION",
			description = "UNION is the main patrol force of the Civil Protection. UNION is often tasked with block searches, patrolling and general policing. In the event of civil unrest they can act as riot control units. For this reason UNION units are provided the most powerful weaponry out of all divisions.",
			model = "models/dpfilms/metropolice/hdpolice.mdl",
			itemsAdd = {
				{class = "wep_stunstick", amount = 1}
			},
			xp = 100,
			noMenu = true
		},
		{
			name = "HELIX",
			description = "HELIX is a specialist medical division. It's members are fully trained officers, however they have received additional medical training. HELIX is often tasked with acting as a supporting officer in a patrol or providing medical assistance to injured officers. Due to these requirements HELIX units carry specialist medical equipment.",
			model = "models/dpfilms/metropolice/civil_medic.mdl",
			itemsAdd = {
				{class = "wep_stunstick", amount = 1}
			},
			xp = 180,
			percentLimit = true,
			limit = 0.2,
			noMenu = true
		},
		{
			name = "GRID",
			description = "GRID is a specialist support division. GRID's job is to support UNION units/patrol teams, this includes activities such as guarding or blocking public spaces while UNION officers conduct a search or raid. GRID units are given additional civil unrest training and equipment. Furthermore they have the capability to operate remote scanners.",
			model = "models/dpfilms/metropolice/hl2concept.mdl",
			itemsAdd = {
				{class = "wep_stunstick", amount = 1}
			},
			xp = 300,
			percentLimit = true,
			limit = 0.2,
			noMenu = true
		},
		{
			name = "JURY",
			description = "JURY is a specialist investigation and interrogation division. JURY is often located inside Civil Protection buildings or prison blocks and rarely patrol. They are tasked with management of the UU detainment centres and suspect interrogation. For this reason they have been given specialist interrogation training and tools.",
			model = "models/dpfilms/metropolice/policetrench.mdl",
			itemsAdd = {
				{class = "wep_stunstick", amount = 1}
			},
			xp = 450,
			percentLimit = true,
			limit = 0.08,
			noMenu = true
		},
		{
			name = "VICE",
			description = "VICE is a small and highly prestigious specialist division within Civil Protection. VICE units are handpicked from the most combat capable units (OfC+), and go through intensive training focusing on close quaters combat, block raids and specialist counter terror training. VICE units are only seen when they are engaged in an operation as deployment of this division is authorized only through the upper echelons of the Civil Protection command.",
			model = "models/dpfilms/metropolice/blacop.mdl",
			itemsAdd = {
				{class = "wep_smg", amount = 1},
				{class = "cos_riothelmet", amount = 1},
				{class = "wep_teargas", amount = 2},
				{class = "item_breachingcharge", amount = 1}
			},
			xp = 2100,
			limit = 12,
			noMenu = true,
			noSubMats = true,
			whitelistUID = "CP_SpecOps",
			whitelistLevel = 1,
            whitelistFailMessage = "You must have be an OfC with the VICE training qualification to access the VICE special forces division."
		}
	},

	ranks = {
		{
			name = "i4",
			description = "i4",
			xp = 100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_i4"
			}
		},
		{
			name = "i3",
			description = "i3",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			xp = 240,
			subMaterial = {
				[1] = "models/impulse/cp/rank_i3"
			}
		},
		{
			name = "i2",
			description = "i2",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2},
			xp = 800,
			subMaterial = {
				[1] = "models/impulse/cp/rank_i2"
			}
		},
		{
			name = "i1",
			description = "i1",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 1500,
			subMaterial = {
				[1] = "models/impulse/cp/rank_i1"
			},
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
				end
			end
		},
		{
			name = "OfC",
			description = "OfC",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_ofc"
			},
			whitelistLevel = 1,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
				end
			end
		},
		{
			name = "DvL",
			description = "DvL",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_dvl"
			},
			whitelistLevel = 2,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			limit = 5,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
					ply:SetModel("models/dpfilms/metropolice/elite_police.mdl")
				end
			end
		},
		{
			name = "DcO",
			description = "DcO",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_dco"
			},
			whitelistLevel = 3,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			limit = 3,
			onBecome = function(ply, rank)
				if ply:GetTeamClass() == CLASS_UNION then
					ply:GiveInventoryItem("wep_smg", 1, true)
					ply:SetModel("models/dpfilms/metropolice/elite_police.mdl")
				end
			end
		},
		{
			name = "CmD",
			description = "CmD",
			itemsAdd = {
				{class = "wep_pistol", amount = 1}
			},
			model = "models/dpfilms/metropolice/elite_police.mdl",
			doorGroup = {1, 2, 3, 4},
			xp = 2100,
			subMaterial = {
				[1] = "models/impulse/cp/rank_cmd"
			},
			whitelistLevel = 4,
			whitelistFailMessage = "You can apply for access on our forums at www.impulse-community.com.",
			limit = 2
		}
	}
})

CLASS_UNION = 1
CLASS_HELIX = 2
CLASS_GRID = 3
CLASS_JURY = 4
CLASS_VICE = 5

RANK_I4 = 1
RANK_I3 = 2
RANK_I2 = 3
RANK_I1 = 4
RANK_OFC = 5
RANK_DVL = 6
RANK_DCO = 7
RANK_CMD = 8
