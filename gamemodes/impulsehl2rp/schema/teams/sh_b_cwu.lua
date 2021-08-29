TEAM_CWU = impulse.Teams.Define({
	name = "Civil Workers Union",
	color = Color(123, 147, 163, 255),
	description = [[A citizen who has been recruited or signed up
	to work for the UU. CWU receive many benefits, with access to
	better food and medical supplies. Most CWU operate business in 
	the city, selling resources to other citizens in return for 
	tokens, and some may be hired by the City Administrator to work
	for him. Most CWU believe that the goal of the Combine is good
	and do their best to support it.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 150,
	doorGroup = {3},
	xp = 25,
	cp = false,
	canAdvert = true,

	classes = {
		{
			name = "Industrial Worker",
			description = "wip",
			bodygroups = {{1, 4}, {2, 2}, {3, 2}},
			xp = 30
		},
		{
			name = "Commercial Worker",
			description = "wip",
			bodygroups = {{1, 3}},
			xp = 250
		},
		{
			name = "Medical Worker",
			description = "wip",
			limit = 3,
			bodygroups = {{1, 9}, {2, 1}},
			doorGroup = {3, 4},
			xp = 380
		}
		-- {
		-- 	name = "Minister of the CWU",
		-- 	description = "wip",
		-- 	limit = 1,
		-- 	bodygroups = {{1, 12}, {2, 1}},
		-- 	xp = 2500
		-- }
	}
})

CLASS_INDUST = 1
CLASS_COMMERCE = 2
CLASS_MEDIC = 3
CLASS_MINISTER = 4

