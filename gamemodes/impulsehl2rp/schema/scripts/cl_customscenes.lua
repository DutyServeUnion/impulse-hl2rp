function SCHEMA:OpsSetup()
	impulse.Ops.EventManager.Scenes["s1_ending"] = {
		{
			pos = Vector(2924.3630371094, -1002.9119262695, 403.0380859375),
	     	endpos = Vector(2715.080078125, -990.65710449219, 424.93301391602),
	     	posSpeed = 0.1,
	     	posNoLerp = true,
		    ang = Angle(-5.26220703125, -177.79650878906, 0),
	     	endang = Angle(-5.9382653236389, -176.92724609375, 0),
		    text = "This is a roleplay server set in the Half-Life 2 Universe. You play as an oppressed citizen.",
		    time = 10,
		    hidePlayers = true,
		    fadeIn = true,
		    fadeOut = true
		}
	}
end
