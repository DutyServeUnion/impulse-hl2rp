TEAM_CA = impulse.Teams.Define({
	name = "City Administrator",
	color = Color(150, 20, 20, 255),
	description = [[The City Administrator is an unmodified human appointed 
	to run the city by the Universal Union. He has been chosen because of
	his fierce support of and loyalty for the UU. He spends most of his time in his office, 
	managing the piles of paperwork a bustling city produces, 
	and rarely takes to the streets.]],
	loadout = {"impulse_hands", "weapon_physgun", "gmod_tool"},
	salary = 250,
	model = "models/player/breen.mdl",
	limit = 1,
	xp = 1300,
	cp = true,
	doorGroup = {1, 2, 3, 4}
})
