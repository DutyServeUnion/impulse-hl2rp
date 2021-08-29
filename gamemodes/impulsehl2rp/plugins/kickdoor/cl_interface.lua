hook.Add("DoorMenuAddOptions", "impulseHL2RPDoorKickDoorOption", function(panel, door, doorOwners, doorGroup, doorBuyable)
	if (door:IsPropDoor() or not LocalPlayer():CanLockUnlockDoor(doorOwners, doorGroup)) and LocalPlayer():Team() == TEAM_CP then
		panel:AddAction("impulse/icons/clenched-fist-256.png", "Kick Door", function()
			LocalPlayer():ConCommand("say /kickdoor")

			panel:Remove()
		end)
	end
end)
