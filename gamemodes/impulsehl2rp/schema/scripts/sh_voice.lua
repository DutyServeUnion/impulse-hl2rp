impulse.Voice = {}
impulse.Voice.List = {}
impulse.Voice.Checks = impulse.Voice.Checks or {}
impulse.Voice.ChatTypes = {}

function impulse.Voice.DefineClass(class, onCheck, onModify, global)
	impulse.Voice.Checks[class] = {class = class:lower(), onCheck = onCheck, onModify = onModify, isGlobal = global}
end

function impulse.Voice.GetClass(ply)
	local def = {}

	for v,k in pairs(impulse.Voice.Checks) do
		if (k.onCheck(ply)) then
			def[#def + 1] = k
		end
	end

	return def
end

function impulse.Voice.Register(class, key, replacement, source, max)
	class = class:lower()

	impulse.Voice.List[class] = impulse.Voice.List[class] or {}
	impulse.Voice.List[class][key:lower()] = {replacement = replacement, source = source}
end

function impulse.Voice.GetVoiceList(class, text, delay)
	local info = impulse.Voice.List[class]

	if (!info) then
		return
	end

	local output = {}
	local original = string.Explode(" ", text)
	local exploded = string.Explode(" ", text:lower())
	local phrase = ""
	local skip = 0
	local current = 0

	max = max or 5

	for k, v in ipairs(exploded) do
		if (k < skip) then
			continue
		end

		if (current < max) then
			local i = k
			local key = v

			local nextValue, nextKey

			while (true) do
				i = i + 1
				nextValue = exploded[i]

				if (!nextValue) then
					break
				end

				nextKey = key.." "..nextValue

				if (!info[nextKey]) then
					i = i + 1

					local nextValue2 = exploded[i]
					local nextKey2 = nextKey.." "..(nextValue2 or "")

					if (!nextValue2 or !info[nextKey2]) then
						i = i - 1

						break
					end

					nextKey = nextKey2
				end

				key = nextKey
			end

			if (info[key]) then
				local source = info[key].source
				
				if (type(source) == "table") then
					source = table.Random(source)
				else
					source = tostring(source)
				end
				
				output[#output + 1] = {source, delay or 0.1}
				phrase = phrase..info[key].replacement.." "
				skip = i
				current = current + 1

				continue
			end
		end

		phrase = phrase..original[k].." "
	end
	
	if (phrase:sub(#phrase, #phrase) == " ") then
		phrase = phrase:sub(1, -2)
	end

	return #output > 0 and output or nil, phrase
end

impulse.Voice.ChatTypes[1] = true -- says
impulse.Voice.ChatTypes[6] = true -- yells
impulse.Voice.ChatTypes[7] = true -- whisper
impulse.Voice.ChatTypes[8] = true -- radio

impulse.Voice.DefineClass("combine", function(ply)
	return ply:Team() == TEAM_CP or ply:Team() == TEAM_OTA
end, function(client, sounds, chatType)
	local beeps = impulse.Config.BeepSounds[client:Team()] or impulse.Config.BeepSounds[TEAM_CP]

	table.insert(sounds, 1, {(table.Random(beeps.on)), 0.25})
	sounds[#sounds + 1] = {(table.Random(beeps.off)), nil, 0.25}
end)

impulse.Voice.DefineClass("vort", function(ply)
	return ply:Team() == TEAM_VORT
end)

impulse.Voice.Register("combine", "0", "0", "npc/metropolice/vo/zero.wav")
impulse.Voice.Register("combine", "1", "1", "npc/metropolice/vo/one.wav")
impulse.Voice.Register("combine", "10", "10", "npc/metropolice/vo/ten.wav")
impulse.Voice.Register("combine", "10-0 HUNTING", "10-0, 10-0, viscerator is hunting!", "npc/metropolice/vo/tenzerovisceratorishunting.wav")
impulse.Voice.Register("combine", "100", "One-hundred.", "npc/metropolice/vo/onehundred.wav")
impulse.Voice.Register("combine", "10-103 TAG", "Possible 10-103, my location, alert TAG units.", "npc/metropolice/vo/possible10-103alerttagunits.wav")
impulse.Voice.Register("combine", "10-107", "I have a 10-107 here, send AirWatch for tag.", "npc/metropolice/vo/gota10-107sendairwatch.wav")
impulse.Voice.Register("combine", "10-108", "We have a 10-108!", "npc/metropolice/vo/wehavea10-108.wav")
impulse.Voice.Register("combine", "10-14", "Holding on 10-14 duty, eh, code four.", "npc/metropolice/vo/holdingon10-14duty.wav")
impulse.Voice.Register("combine", "10-15", "Prepare for 10-15.", "npc/metropolice/vo/preparefor1015.wav")
impulse.Voice.Register("combine", "10-2", "10-2.", "npc/metropolice/vo/ten2.wav")
impulse.Voice.Register("combine", "10-25", "Any unit, report in with 10-25 as suspect.", "npc/metropolice/vo/unitreportinwith10-25suspect.wav")
impulse.Voice.Register("combine", "10-30", "I have a 10-30, my 10-20, responding, code two.", "npc/metropolice/vo/Ihave10-30my10-20responding.wav")
impulse.Voice.Register("combine", "10-4", "10-4.", "npc/metropolice/vo/ten4.wav")
impulse.Voice.Register("combine", "10-65", "Unit is 10-65.", "npc/metropolice/vo/unitis10-65.wav")
impulse.Voice.Register("combine", "10-78", "Dispatch, I need 10-78, officer in trouble!", "npc/metropolice/vo/dispatchIneed10-78.wav")
impulse.Voice.Register("combine", "10-8 standing by", "10-8, standing by.", "npc/metropolice/vo/ten8standingby.wav")
impulse.Voice.Register("combine", "10-8", "Unit is on-duty, 10-8.", "npc/metropolice/vo/unitisonduty10-8.wav")
impulse.Voice.Register("combine", "10-91D", "10-91d count is...", "npc/metropolice/vo/ten91dcountis.wav")
impulse.Voice.Register("combine", "10-97 GOA", "10-97, that suspect is GOA.", "npc/metropolice/vo/ten97suspectisgoa.wav")
impulse.Voice.Register("combine", "10-97", "10-97.", "npc/metropolice/vo/ten97.wav")
impulse.Voice.Register("combine", "10-99", "Officer down, I am 10-99, I repeat, I am 10-99!", "npc/metropolice/vo/officerdownIam10-99.wav")
impulse.Voice.Register("combine", "11-44", "Get that 11-44 inbound, we're cleaning up now.", "npc/metropolice/vo/get11-44inboundcleaningup.wav")
impulse.Voice.Register("combine", "11-6", "Suspect 11-6, my 10-20 is...", "npc/metropolice/vo/suspect11-6my1020is.wav")
impulse.Voice.Register("combine", "11-99", "11-99, officer needs assistance!", "npc/metropolice/vo/11-99officerneedsassistance.wav")
impulse.Voice.Register("combine", "2", "2", "npc/metropolice/vo/two.wav")
impulse.Voice.Register("combine", "20", "20", "npc/metropolice/vo/twenty.wav")
impulse.Voice.Register("combine", "200", "Two-hundred.", "npc/metropolice/vo/twohundred.wav")
impulse.Voice.Register("combine", "3", "3", "npc/metropolice/vo/three.wav")
impulse.Voice.Register("combine", "30", "30", "npc/metropolice/vo/thirty.wav")
impulse.Voice.Register("combine", "300", "Three-hundred.", "npc/metropolice/vo/threehundred.wav")
impulse.Voice.Register("combine", "34S AT", "All units, BOL, we have 34-S at...", "npc/metropolice/vo/allunitsbol34sat.wav")
impulse.Voice.Register("combine", "4", "4", "npc/metropolice/vo/four.wav")
impulse.Voice.Register("combine", "40", "40", "npc/metropolice/vo/fourty.wav")
impulse.Voice.Register("combine", "404", "404 zone.", "npc/metropolice/vo/404zone.wav")
impulse.Voice.Register("combine", "408", "I've got a 408 here at location.", "npc/metropolice/vo/Ivegot408hereatlocation.wav")
impulse.Voice.Register("combine", "415B", "Is 415b.", "npc/metropolice/vo/is415b.wav")
impulse.Voice.Register("combine", "5", "5", "npc/metropolice/vo/five.wav")
impulse.Voice.Register("combine", "50", "50", "npc/metropolice/vo/fifty.wav")
impulse.Voice.Register("combine", "505", "Dispatch, we need AirWatch, subject is 505!", "npc/metropolice/vo/airwatchsubjectis505.wav")
impulse.Voice.Register("combine", "6", "6", "npc/metropolice/vo/six.wav")
impulse.Voice.Register("combine", "60", "60", "npc/metropolice/vo/sixty.wav")
impulse.Voice.Register("combine", "603", "603, unlawful entry.", "npc/metropolice/vo/unlawfulentry603.wav")
impulse.Voice.Register("combine", "63", "63, criminal trespass.", "npc/metropolice/vo/criminaltrespass63.wav")
impulse.Voice.Register("combine", "7", "7", "npc/metropolice/vo/seven.wav")
impulse.Voice.Register("combine", "70", "70", "npc/metropolice/vo/seventy.wav")
impulse.Voice.Register("combine", "8", "8", "npc/metropolice/vo/eight.wav")
impulse.Voice.Register("combine", "80", "80", "npc/metropolice/vo/eighty.wav")
impulse.Voice.Register("combine", "9", "9", "npc/metropolice/vo/nine.wav")
impulse.Voice.Register("combine", "90", "90", "npc/metropolice/vo/ninety.wav")
impulse.Voice.Register("combine", "THAT'S A GRENADE", "That's a grenade!", "npc/metropolice/vo/thatsagrenade.wav")
impulse.Voice.Register("combine", "ACQUIRING", "Acquiring on visual!", "npc/metropolice/vo/acquiringonvisual.wav")
impulse.Voice.Register("combine", "ADMINISTER", "Administer.", "npc/metropolice/vo/administer.wav")
impulse.Voice.Register("combine", "CONFIRMED ADW", "Confirmed as ADW on that suspect, 10-0.", "npc/metropolice/vo/confirmadw.wav")
impulse.Voice.Register("combine", "AFFIRMATIVE", "Affirmative.", "npc/metropolice/vo/affirmative.wav")
impulse.Voice.Register("combine", "ALL UNITS MOVE", "All units, move in!", "npc/metropolice/vo/allunitsmovein.wav")
impulse.Voice.Register("combine", "AMPUTATE", "Amputate.", "npc/metropolice/vo/amputate.wav")
impulse.Voice.Register("combine", "ANTICITIZEN", "Anti-citizen.", "npc/metropolice/vo/anticitizen.wav")
impulse.Voice.Register("combine", "ANTISEPTIC", "Antiseptic.", "npc/combine_soldier/vo/antiseptic.wav")
impulse.Voice.Register("combine", "APEX", "Apex.", "npc/combine_soldier/vo/apex.wav")
impulse.Voice.Register("combine", "APPLY", "Apply.", "npc/metropolice/vo/apply.wav")
impulse.Voice.Register("combine", "ARREST POSITIONS", "All units, move to arrest positions!", "npc/metropolice/vo/movetoarrestpositions.wav")
impulse.Voice.Register("combine", "AT CHECKPOINT", "At checkpoint.", "npc/metropolice/vo/atcheckpoint.wav")
impulse.Voice.Register("combine", "AT LOCATION REPORT", "Protection-teams at location, report in.", "npc/metropolice/vo/ptatlocationreport.wav")
impulse.Voice.Register("combine", "BACK ME UP", "Back me up, I'm out!", "npc/metropolice/vo/backmeupImout.wav")
impulse.Voice.Register("combine", "BACKUP", "Backup!", "npc/metropolice/vo/backup.wav")
impulse.Voice.Register("combine", "BLADE", "Blade.", "npc/combine_soldier/vo/blade.wav")
impulse.Voice.Register("combine", "BLEEDING", "Suspect is bleeding from multiple wounds!", "npc/metropolice/vo/suspectisbleeding.wav")
impulse.Voice.Register("combine", "BLIP", "Catch that blip on the stabilization readout?", "npc/metropolice/vo/catchthatbliponstabilization.wav")
impulse.Voice.Register("combine", "BLOCK HOLDING", "Block is holding, cohesive.", "npc/metropolice/vo/blockisholdingcohesive.wav")
impulse.Voice.Register("combine", "BLOCK", "Block!", "npc/metropolice/vo/block.wav")
impulse.Voice.Register("combine", "BOL 243", "CP, we need AirWatch to BOL for that 243.", "npc/metropolice/vo/cpbolforthat243.wav")
impulse.Voice.Register("combine", "BREAK COVER", "Break his cover!", "npc/metropolice/vo/breakhiscover.wav")
impulse.Voice.Register("combine", "CAN1", "Pick up that can.", "npc/metropolice/vo/pickupthecan1.wav")
impulse.Voice.Register("combine", "CAN2", "Pick up the can!", "npc/metropolice/vo/pickupthecan2.wav")
impulse.Voice.Register("combine", "CAN3", "I said, pick up the can!", "npc/metropolice/vo/pickupthecan3.wav")
impulse.Voice.Register("combine", "CAN4", "Now, put it in the trash-can.", "npc/metropolice/vo/putitinthetrash1.wav")
impulse.Voice.Register("combine", "CAN5", "I said, put it in the trash-can!", "npc/metropolice/vo/putitinthetrash2.wav")
impulse.Voice.Register("combine", "CAN6", "You knocked it over, pick it up!", "npc/metropolice/vo/youknockeditover.wav")
impulse.Voice.Register("combine", "CANAL", "Canal.", "npc/metropolice/vo/canal.wav")
impulse.Voice.Register("combine", "CANALBLOCK", "Canalblock!", "npc/metropolice/vo/canalblock.wav")
impulse.Voice.Register("combine", "CAUTERIZE", "Cauterize.", "npc/metropolice/vo/cauterize.wav")
impulse.Voice.Register("combine", "CHECK MISCOUNT", "Check for miscount.", "npc/metropolice/vo/checkformiscount.wav")
impulse.Voice.Register("combine", "CHECKPOINTS", "Proceed to designated checkpoints.", "npc/metropolice/vo/proceedtocheckpoints.wav")
impulse.Voice.Register("combine", "CITIZEN SUMMONED", "Reporting citizen summoned into voluntary conscription for channel open service detail T94-332.", "npc/metropolice/vo/citizensummoned.wav")
impulse.Voice.Register("combine", "CITIZEN", "Citizen.", "npc/metropolice/vo/citizen.wav")
impulse.Voice.Register("combine", "CLASSIFY DB", "Classify subject name as 'DB'; this block ready for clean-out.", "npc/metropolice/vo/classifyasdbthisblockready.wav")
impulse.Voice.Register("combine", "CLEANED", "Cleaned.", "npc/combine_soldier/vo/cleaned.wav")
impulse.Voice.Register("combine", "CLEAR CODE 100", "Clear and code one-hundred.", "npc/metropolice/vo/clearandcode100.wav")
impulse.Voice.Register("combine", "CLOSE ON SUSPECT", "All units, close on suspect!", "npc/metropolice/vo/allunitscloseonsuspect.wav")
impulse.Voice.Register("combine", "CLOSING", "Closing!", {"npc/combine_soldier/vo/closing.wav", "npc/combine_soldier/vo/closing2.wav"})
impulse.Voice.Register("combine", "CODE 100", "Code one-hundred.", "npc/metropolice/vo/code100.wav")
impulse.Voice.Register("combine", "CODE 2", "All units, code two!", "npc/metropolice/vo/allunitscode2.wav")
impulse.Voice.Register("combine", "CODE 3", "Officer down, request all units, code three to my 10-20!", "npc/metropolice/vo/officerdowncode3tomy10-20.wav")
impulse.Voice.Register("combine", "CODE 7", "Code seven.", "npc/metropolice/vo/code7.wav")
impulse.Voice.Register("combine", "CONDEMNED", "Condemned zone!", "npc/metropolice/vo/condemnedzone.wav")
impulse.Voice.Register("combine", "CONTACT 243", "Contact with 243 suspect, my 10-20 is...", "npc/metropolice/vo/contactwith243suspect.wav")
impulse.Voice.Register("combine", "CONTACT PRIORITY", "I have contact with a priority two!", "npc/metropolice/vo/contactwithpriority2.wav")
impulse.Voice.Register("combine", "CONTACT", "Contact!", "npc/combine_soldier/vo/contact.wav")
impulse.Voice.Register("combine", "CONTAINED", "Contained.", "npc/combine_soldier/vo/contained.wav")
impulse.Voice.Register("combine", "CONTROL 100", "Control is one-hundred percent this location, no sign of that 647-E.", "npc/metropolice/vo/control100percent.wav")
impulse.Voice.Register("combine", "CONTROLSECTION", "Control-section!", "npc/metropolice/vo/controlsection.wav")
impulse.Voice.Register("combine", "CONVERGING", "Converging.", "npc/metropolice/vo/converging.wav")
impulse.Voice.Register("combine", "COPY THAT", "Copy that.", "npc/combine_soldier/vo/copythat.wav")
impulse.Voice.Register("combine", "COPY", "Copy.", "npc/metropolice/vo/copy.wav")
impulse.Voice.Register("combine", "COVER", "Cover!", "npc/combine_soldier/vo/coverhurt.wav")
impulse.Voice.Register("combine", "CP COMPROMISED", "CP is compromised, re-establish!", "npc/metropolice/vo/cpiscompromised.wav")
impulse.Voice.Register("combine", "CP ESTABLISH", "CP, we need to establish our perimeter at...", "npc/metropolice/vo/cpweneedtoestablishaperimeterat.wav")
impulse.Voice.Register("combine", "CP OVERRUN", "CP is overrun, we have no containment!", "npc/metropolice/vo/cpisoverrunwehavenocontainment.wav")
impulse.Voice.Register("combine", "DAGGER", "Dagger.", "npc/combine_soldier/vo/dagger.wav")
impulse.Voice.Register("combine", "DASH", "Dash.", "npc/combine_soldier/vo/dash.wav")
impulse.Voice.Register("combine", "DB COUNT", "DB count is...", "npc/metropolice/vo/dbcountis.wav")
impulse.Voice.Register("combine", "DEFENDER", "Defender!", "npc/metropolice/vo/defender.wav")
impulse.Voice.Register("combine", "DESERVICED AREA", "Deserviced area.", "npc/metropolice/vo/deservicedarea.wav")
impulse.Voice.Register("combine", "DESIGNATE SUSPECT", "Designate suspect as...", "npc/metropolice/vo/designatesuspectas.wav")
impulse.Voice.Register("combine", "DESTROY COVER", "Destroy that cover!", "npc/metropolice/vo/destroythatcover.wav")
impulse.Voice.Register("combine", "DISLOCATE INTERPOSE", "Fire to dislocate that interpose!", "npc/metropolice/vo/firetodislocateinterpose.wav")
impulse.Voice.Register("combine", "DISMOUNTING HARDPOINT", "Dismounting hardpoint.", "npc/metropolice/vo/dismountinghardpoint.wav")
impulse.Voice.Register("combine", "DISP APB", "Disp updating APB likeness.", "npc/metropolice/vo/dispupdatingapb.wav")
impulse.Voice.Register("combine", "DISTRIBUTION BLOCK", "Distribution block.", "npc/metropolice/vo/distributionblock.wav")
impulse.Voice.Register("combine", "DOCUMENT", "Document.", "npc/metropolice/vo/document.wav")
impulse.Voice.Register("combine", "DONT MOVE", "Don't move!", "npc/metropolice/vo/dontmove.wav")
impulse.Voice.Register("combine", "ECHO", "Echo.", "npc/combine_soldier/vo/echo.wav")
impulse.Voice.Register("combine", "ENGAGING", "Engaging!", "npc/combine_soldier/vo/engaging.wav")
impulse.Voice.Register("combine", "ESTABLISH NEW CP", "Fall down, establish a new CP!", "npc/metropolice/vo/establishnewcp.wav")
impulse.Voice.Register("combine", "EXPOSE TARGET", "Firing to expose target!", "npc/metropolice/vo/firingtoexposetarget.wav")
impulse.Voice.Register("combine", "EXTERNAL", "External jurisdiction.", "npc/metropolice/vo/externaljurisdiction.wav")
impulse.Voice.Register("combine", "FINAL VERDICT", "Final verdict administered.", "npc/metropolice/vo/finalverdictadministered.wav")
impulse.Voice.Register("combine", "FINAL WARNING", "Final warning!", "npc/metropolice/vo/finalwarning.wav")
impulse.Voice.Register("combine", "FIRST WARNING", "First warning, move away!", "npc/metropolice/vo/firstwarningmove.wav")
impulse.Voice.Register("combine", "FIST", "Fist.", "npc/combine_soldier/vo/fist.wav")
impulse.Voice.Register("combine", "FLASH", "Flash.", "npc/combine_soldier/vo/flash.wav")
impulse.Voice.Register("combine", "FLATLINE", "Flatline.", "npc/combine_soldier/vo/flatline.wav")
impulse.Voice.Register("combine", "FLUSH", "Flush.", "npc/combine_soldier/vo/flush.wav")
impulse.Voice.Register("combine", "FREE NECROTICS", "I have free necrotics!", "npc/metropolice/vo/freenecrotics.wav")
impulse.Voice.Register("combine", "GET DOWN", "Get down!", "npc/metropolice/vo/getdown.wav")
impulse.Voice.Register("combine", "GET OUT", "Get out of here!", "npc/metropolice/vo/getoutofhere.wav")
impulse.Voice.Register("combine", "GETTING 647E", "Still getting that 647-E from local surveillance.", "npc/metropolice/vo/stillgetting647e.wav")
impulse.Voice.Register("combine", "GHOST", "Ghost.", "npc/combine_soldier/vo/ghost.wav")
impulse.Voice.Register("combine", "GO AGAIN", "PT, go again.", "npc/metropolice/vo/ptgoagain.wav")
impulse.Voice.Register("combine", "GO SHARP", "Go sharp!", "npc/combine_soldier/vo/gosharp.wav")
impulse.Voice.Register("combine", "GOING IN", "Cover me, I'm going in!", "npc/metropolice/vo/covermegoingin.wav")
impulse.Voice.Register("combine", "GOT A DB", "Uh, we got a DB here, cancel that 11-42.", "npc/metropolice/vo/wegotadbherecancel10-102.wav")
impulse.Voice.Register("combine", "GOT HIM AGAIN", "Got him again, suspect is 10-20 at...", "npc/metropolice/vo/gothimagainsuspect10-20at.wav")
impulse.Voice.Register("combine", "GOT ONE ACCOMPLICE", "I got one accomplice here!", "npc/metropolice/vo/gotoneaccompliceherea.wav")
impulse.Voice.Register("combine", "GOT SUSPECT ONE", "I got suspect one here!", "npc/metropolice/vo/gotsuspect1here.wav")
impulse.Voice.Register("combine", "GRENADE", "Grenade!", "npc/metropolice/vo/grenade.wav")
impulse.Voice.Register("combine", "GRID", "Grid.", "npc/combine_soldier/vo/grid.wav")
impulse.Voice.Register("combine", "HAHA", "Haha.", "npc/metropolice/vo/chuckle.wav")
impulse.Voice.Register("combine", "HAMMER", "Hammer.", "npc/combine_soldier/vo/hammer.wav")
impulse.Voice.Register("combine", "HARDPOINT PROSECUTE", "Is at hardpoint, ready to prosecute!", "npc/metropolice/vo/isathardpointreadytoprosecute.wav")
impulse.Voice.Register("combine", "HARDPOINT SCANNING", "Hardpoint scanning.", "npc/metropolice/vo/hardpointscanning.wav")
impulse.Voice.Register("combine", "HELIX", "Helix.", "npc/combine_soldier/vo/helix.wav")
impulse.Voice.Register("combine", "HELP", "Help!", "npc/metropolice/vo/help.wav")
impulse.Voice.Register("combine", "HERO", "Hero!", "npc/metropolice/vo/hero.wav")
impulse.Voice.Register("combine", "HES 148", "He's gone 148!", "npc/metropolice/vo/hesgone148.wav")
impulse.Voice.Register("combine", "HIGH PRIORITY", "High-priority region.", "npc/metropolice/vo/highpriorityregion.wav")
impulse.Voice.Register("combine", "HOLD IT", "Hold it right there!", "npc/metropolice/vo/holditrightthere.wav")
impulse.Voice.Register("combine", "HOLD POSITION", "Protection-team, hold this position.", "npc/metropolice/vo/holdthisposition.wav")
impulse.Voice.Register("combine", "HOLD", "Hold it!", "npc/metropolice/vo/holdit.wav")
impulse.Voice.Register("combine", "HUNTER", "Hunter.", "npc/combine_soldier/vo/hunter.wav")
impulse.Voice.Register("combine", "HURRICANE", "Hurricane.", "npc/combine_soldier/vo/hurricane.wav")
impulse.Voice.Register("combine", "I SAID MOVE", "I said move along.", "npc/metropolice/vo/Isaidmovealong.wav")
impulse.Voice.Register("combine", "ICE", "Ice.", "npc/combine_soldier/vo/ice.wav")
impulse.Voice.Register("combine", "IN POSITION", "In position.", "npc/metropolice/vo/inposition.wav")
impulse.Voice.Register("combine", "INBOUND", "Inbound.", "npc/combine_soldier/vo/inbound.wav")
impulse.Voice.Register("combine", "INFECTED", "Infected.", "npc/combine_soldier/vo/infected.wav")
impulse.Voice.Register("combine", "INFECTION", "Infection!", "npc/metropolice/vo/infection.wav")
impulse.Voice.Register("combine", "INFESTED", "Infested zone.", "npc/metropolice/vo/infestedzone.wav")
impulse.Voice.Register("combine", "INJECT", "Inject!", "npc/metropolice/vo/inject.wav")
impulse.Voice.Register("combine", "INOCULATE", "Inoculate.", "npc/metropolice/vo/innoculate.wav")
impulse.Voice.Register("combine", "INTERCEDE", "Intercede!", "npc/metropolice/vo/intercede.wav")
impulse.Voice.Register("combine", "INTERLOCK", "Interlock!", "npc/metropolice/vo/interlock.wav")
impulse.Voice.Register("combine", "INVESTIGATE", "Investigate.", "npc/metropolice/vo/investigate.wav")
impulse.Voice.Register("combine", "INVESTIGATING", "Investigating 10-103.", "npc/metropolice/vo/investigating10-103.wav")
impulse.Voice.Register("combine", "ION", "Ion.", "npc/combine_soldier/vo/ion.wav")
impulse.Voice.Register("combine", "IS 10-108", "Is 10-108!", "npc/metropolice/vo/is10-108.wav")
impulse.Voice.Register("combine", "IS 10-8", "Unit is 10-8, standing by.", "npc/metropolice/vo/unitis10-8standingby.wav")
impulse.Voice.Register("combine", "IS CLOSING", "Is closing on suspect!", "npc/metropolice/vo/isclosingonsuspect.wav")
impulse.Voice.Register("combine", "IS DOWN", "Is down!", "npc/metropolice/vo/isdown.wav")
impulse.Voice.Register("combine", "IS INBOUND", "Unit is inbound.", "npc/combine_soldier/vo/unitisinbound.wav")
impulse.Voice.Register("combine", "IS MOVING IN", "Unit is moving in.", "npc/combine_soldier/vo/unitismovingin.wav")
impulse.Voice.Register("combine", "IS MOVING", "Unit is moving in!", "npc/metropolice/vo/ismovingin.wav")
impulse.Voice.Register("combine", "IS PASSIVE", "Is passive.", "npc/metropolice/vo/ispassive.wav")
impulse.Voice.Register("combine", "IS READY TO GO", "Is ready to go!", "npc/metropolice/vo/isreadytogo.wav")
impulse.Voice.Register("combine", "ISOLATE", "Isolate!", "npc/metropolice/vo/isolate.wav")
impulse.Voice.Register("combine", "JET", "Jet.", "npc/combine_soldier/vo/jet.wav")
impulse.Voice.Register("combine", "JUDGE", "Judge!", "npc/combine_soldier/vo/judge.wav")
impulse.Voice.Register("combine", "JUDGE", "Judge.", "npc/combine_soldier/vo/judge.wav")
impulse.Voice.Register("combine", "JUDGEMENT", "Suspect, prepare to receive civil judgement!", "npc/metropolice/vo/prepareforjudgement.wav")
impulse.Voice.Register("combine", "JUDGMENT", "Suspect, prepare to receive civil judgement!", "npc/metropolice/vo/prepareforjudgement.wav")
impulse.Voice.Register("combine", "JURISDICTION", "Stabilization-jurisdiction.", "npc/metropolice/vo/stabilizationjurisdiction.wav")
impulse.Voice.Register("combine", "JURY", "Jury!", "npc/metropolice/vo/jury.wav")
impulse.Voice.Register("combine", "KEEP MOVING", "Keep moving!", "npc/metropolice/vo/keepmoving.wav")
impulse.Voice.Register("combine", "KILO", "Kilo.", "npc/combine_soldier/vo/kilo.wav")
impulse.Voice.Register("combine", "KING", "King!", "npc/metropolice/vo/king.wav")
impulse.Voice.Register("combine", "LAST SEEN AT", "Hiding, last seen at range...", "npc/metropolice/vo/hidinglastseenatrange.wav")
impulse.Voice.Register("combine", "LEADER", "Leader.", "npc/combine_soldier/vo/leader.wav")
impulse.Voice.Register("combine", "LEVEL 3", "I have a level three civil-privacy violator here!", "npc/metropolice/vo/level3civilprivacyviolator.wav")
impulse.Voice.Register("combine", "LINE", "Line!", "npc/metropolice/vo/line.wav")
impulse.Voice.Register("combine", "LOCATION", "Location?", "npc/metropolice/vo/location.wav")
impulse.Voice.Register("combine", "LOCK POSITION", "All units, lock your position!", "npc/metropolice/vo/lockyourposition.wav")
impulse.Voice.Register("combine", "LOCK", "Lock!", "npc/metropolice/vo/lock.wav")
impulse.Voice.Register("combine", "LOOK OUT", "Look out!", "npc/metropolice/vo/lookout.wav")
impulse.Voice.Register("combine", "LOOSE PARASITICS", "Loose parasitics!", "npc/metropolice/vo/looseparasitics.wav")
impulse.Voice.Register("combine", "LOST CONTACT", "Lost contact!", "npc/combine_soldier/vo/lostcontact.wav")
impulse.Voice.Register("combine", "LOW ON", "Running low on verdicts, taking cover!", "npc/metropolice/vo/runninglowonverdicts.wav")
impulse.Voice.Register("combine", "MACE", "Mace.", "npc/combine_soldier/vo/mace.wav")
impulse.Voice.Register("combine", "MAINTAIN CP", "All units, maintain this CP!", "npc/metropolice/vo/allunitsmaintainthiscp.wav")
impulse.Voice.Register("combine", "MALCOMPLIANCE", "Issuing malcompliance citation.", "npc/metropolice/vo/issuingmalcompliantcitation.wav")
impulse.Voice.Register("combine", "MALCOMPLIANT 10-107", "Malcompliant 10-107 at my 10-20, preparing to prosecute.", "npc/metropolice/vo/malcompliant10107my1020.wav")
impulse.Voice.Register("combine", "MALIGNANT", "Malignant!", "npc/metropolice/vo/malignant.wav")
impulse.Voice.Register("combine", "MATCH ON APB", "I have a match on APB likeness.", "npc/metropolice/vo/matchonapblikeness.wav")
impulse.Voice.Register("combine", "MINOR HITS", "Minor hits, continuing prosecution!", "npc/metropolice/vo/minorhitscontinuing.wav")
impulse.Voice.Register("combine", "MOVE ALONG", "Move along!", "npc/metropolice/vo/movealong.wav")
impulse.Voice.Register("combine", "MOVE BACK", "Move back, right now!", "npc/metropolice/vo/movebackrightnow.wav")
impulse.Voice.Register("combine", "MOVE IN", "Move in!", "npc/combine_soldier/vo/movein.wav")
impulse.Voice.Register("combine", "MOVE IT", "Move it!", "npc/metropolice/vo/moveit.wav")
impulse.Voice.Register("combine", "MOVE", "Move!", "npc/metropolice/vo/move.wav")
impulse.Voice.Register("combine", "MOVING TO COVER", "Moving to cover!", "npc/metropolice/vo/movingtocover.wav")
impulse.Voice.Register("combine", "MOVING TO HARDPOINT", "Moving to hardpoint!", "npc/metropolice/vo/movingtohardpoint.wav")
impulse.Voice.Register("combine", "NECROTICS", "Necrotics!", "npc/metropolice/vo/necrotics.wav")
impulse.Voice.Register("combine", "NEED ANY HELP", "Need any help with this one?", "npc/metropolice/vo/needanyhelpwiththisone.wav")
impulse.Voice.Register("combine", "NEEDS ASSISTANCE", "Officer needs assistance, I am 11-99!", "npc/metropolice/vo/officerneedsassistance.wav")
impulse.Voice.Register("combine", "NEEDS HELP", "Officer needs help!", "npc/metropolice/vo/officerneedshelp.wav")
impulse.Voice.Register("combine", "NO 647", "Clear, no 647, no 10-107.", "npc/metropolice/vo/clearno647no10-107.wav")
impulse.Voice.Register("combine", "NO CONTACT", "No contact!", "npc/metropolice/vo/nocontact.wav")
impulse.Voice.Register("combine", "NO I'M GOOD", "No, I'm good.", "vo/trainyard/ba_noimgood.wav")
impulse.Voice.Register("combine", "NO VISUAL ON", "No visual on UPI at this time.", "npc/metropolice/vo/novisualonupi.wav")
impulse.Voice.Register("combine", "NOMAD", "Nomad.", "npc/combine_soldier/vo/nomad.wav")
impulse.Voice.Register("combine", "NONCITIZEN", "Noncitizen.", "npc/metropolice/vo/noncitizen.wav")
impulse.Voice.Register("combine", "NONPATROL", "Non-patrol region.", "npc/metropolice/vo/nonpatrolregion.wav")
impulse.Voice.Register("combine", "NONTAGGED VIROMES", "Non-tagged viromes here!", "npc/metropolice/vo/non-taggedviromeshere.wav")
impulse.Voice.Register("combine", "NOVA", "Nova.", "npc/combine_soldier/vo/nova.wav")
impulse.Voice.Register("combine", "NOW GET OUT", "Now, get out of here!", "npc/metropolice/vo/nowgetoutofhere.wav")
impulse.Voice.Register("combine", "NOW", "Now.", "vo/trainyard/ba_thatbeer01.wav")
impulse.Voice.Register("combine", "OUTBREAK", "Outbreak!", "npc/combine_soldier/vo/outbreak.wav")
impulse.Voice.Register("combine", "OUTBREAK", "Outbreak!", "npc/metropolice/vo/outbreak.wav")
impulse.Voice.Register("combine", "OVERWATCH", "Overwatch.", "npc/combine_soldier/vo/overwatch.wav")
impulse.Voice.Register("combine", "PACIFYING", "Pacifying!", "npc/metropolice/vo/pacifying.wav")
impulse.Voice.Register("combine", "PAIN1", "Ugh!", "npc/metropolice/pain1.wav")
impulse.Voice.Register("combine", "PAIN2", "Uagh!", "npc/metropolice/pain2.wav")
impulse.Voice.Register("combine", "PAIN3", "Augh!", "npc/metropolice/pain3.wav")
impulse.Voice.Register("combine", "PAIN4", "Agh!", "npc/metropolice/pain4.wav")
impulse.Voice.Register("combine", "PATROL", "Patrol!", "npc/metropolice/vo/patrol.wav")
impulse.Voice.Register("combine", "PAYBACK", "Payback.", "npc/combine_soldier/vo/payback.wav")
impulse.Voice.Register("combine", "PHANTOM", "Phantom.", "npc/combine_soldier/vo/phantom.wav")
impulse.Voice.Register("combine", "PICKUP 647E", "Anyone else pick up a, uh... 647-E reading?", "npc/metropolice/vo/anyonepickup647e.wav")
impulse.Voice.Register("combine", "POSITION AT HARDPOINT", "In position at hardpoint.", "npc/metropolice/vo/inpositionathardpoint.wav")
impulse.Voice.Register("combine", "POSITION TO CONTAIN", "Position to contain.", "npc/metropolice/vo/positiontocontain.wav")
impulse.Voice.Register("combine", "POSSIBLE 404", "Possible 404 here!", "npc/metropolice/vo/possible404here.wav")
impulse.Voice.Register("combine", "POSSIBLE 647E", "Possible 647-E here, request AirWatch tag.", "npc/metropolice/vo/possible647erequestairwatch.wav")
impulse.Voice.Register("combine", "POSSIBLE ACCOMPLICE", "Report sightings of possible accomplice.", "npc/metropolice/vo/reportsightingsaccomplices.wav")
impulse.Voice.Register("combine", "POSSIBLE LEVEL 3", "Possible level three civil-privacy violator here!", "npc/metropolice/vo/possiblelevel3civilprivacyviolator.wav")
impulse.Voice.Register("combine", "PREPARING TO JUDGE", "Preparing to judge a 10-107, be advised.", "npc/metropolice/vo/preparingtojudge10-107.wav")
impulse.Voice.Register("combine", "PRESERVE", "Preserve!", "npc/metropolice/vo/preserve.wav")
impulse.Voice.Register("combine", "PRESSURE", "Pressure!", "npc/metropolice/vo/pressure.wav")
impulse.Voice.Register("combine", "PRIORITY 1", "Confirm, priority-one sighted.", "npc/metropolice/vo/confirmpriority1sighted.wav")
impulse.Voice.Register("combine", "PRIORITY 2", "I have a priority-two anti-citizen here!", "npc/metropolice/vo/priority2anticitizenhere.wav")
impulse.Voice.Register("combine", "PRODUCTION BLOCK", "Production-block.", "npc/metropolice/vo/productionblock.wav")
impulse.Voice.Register("combine", "PROSECUTE MALCOMPLIANT", "Ready to prosecute malcompliant citizen, final warning issued!", "npc/metropolice/vo/readytoprosecutefinalwarning.wav")
impulse.Voice.Register("combine", "PROSECUTE", "Prosecute!", "npc/metropolice/vo/prosecute.wav")
impulse.Voice.Register("combine", "PROSECUTING", "Prosecuting.", "npc/combine_soldier/vo/procecuting.")
impulse.Voice.Register("combine", "PROTECTION COMPLETE", "Protection complete.", "npc/metropolice/vo/protectioncomplete.wav")
impulse.Voice.Register("combine", "QUICK", "Quick!", "npc/metropolice/vo/quick.wav")
impulse.Voice.Register("combine", "QUICKSAND", "Quicksand.", "npc/combine_soldier/vo/quicksand.wav")
impulse.Voice.Register("combine", "RANGE", "Range.", "npc/combine_soldier/vo/range.wav")
impulse.Voice.Register("combine", "RANGER", "Ranger.", "npc/combine_soldier/vo/ranger.wav")
impulse.Voice.Register("combine", "RAZOR", "Razor.", "npc/combine_soldier/vo/razor.wav")
impulse.Voice.Register("combine", "READY AMPUTATE", "Ready to amputate!", "npc/metropolice/vo/readytoamputate.wav")
impulse.Voice.Register("combine", "READY CHARGES", "Ready charges!", "npc/combine_soldier/vo/readycharges.wav")
impulse.Voice.Register("combine", "READY JUDGE", "Ready to judge.", "npc/metropolice/vo/readytojudge.wav")
impulse.Voice.Register("combine", "READY PROSECUTE", "Ready to prosecute!", "npc/metropolice/vo/readytoprosecute.wav")
impulse.Voice.Register("combine", "READY WEAPONS", "Ready weapons!", "npc/combine_soldier/vo/readyweapons.wav")
impulse.Voice.Register("combine", "REAPER", "Reaper.", "npc/combine_soldier/vo/reaper.wav")
impulse.Voice.Register("combine", "REINFORCEMENT TEAMS", "Reinforcement-teams, code three!", "npc/metropolice/vo/reinforcementteamscode3.wav")
impulse.Voice.Register("combine", "REPORT CLEAR", "Reporting clear.", "npc/combine_soldier/vo/reportingclear.wav")
impulse.Voice.Register("combine", "REPORT IN", "CP requests all units, uhh... Location report-in.", "npc/metropolice/vo/cprequestsallunitsreportin.wav")
impulse.Voice.Register("combine", "REPORT LOCATION", "All units, report location suspect!", "npc/metropolice/vo/allunitsreportlocationsuspect.wav")
impulse.Voice.Register("combine", "REPORT STATUS", "Local CP-teams, report status.", "npc/metropolice/vo/localcptreportstatus.wav")
impulse.Voice.Register("combine", "REPURPOSED", "Repurposed area.", "npc/metropolice/vo/repurposedarea.wav")
impulse.Voice.Register("combine", "RESIDENTIAL BLOCK", "Residential block.", "npc/metropolice/vo/residentialblock.wav")
impulse.Voice.Register("combine", "RESPOND CODE 3", "All units at location, responding code three!", "npc/metropolice/vo/allunitsrespondcode3.wav")
impulse.Voice.Register("combine", "RESPONDING", "Responding.", "npc/metropolice/vo/responding2.wav")
impulse.Voice.Register("combine", "RESTRICT", "Restrict!", "npc/metropolice/vo/restrict.wav")
impulse.Voice.Register("combine", "RESTRICTED", "Restricted block.", "npc/metropolice/vo/restrictedblock.wav")
impulse.Voice.Register("combine", "RESTRICTION ZONE", "Terminal restriction-zone!", "npc/metropolice/vo/terminalrestrictionzone.wav")
impulse.Voice.Register("combine", "RIPCORD", "Ripcord!", "npc/combine_soldier/vo/ripcord.wav")
impulse.Voice.Register("combine", "RODGER THAT", "Rodger that!", "npc/metropolice/vo/rodgerthat.wav")
impulse.Voice.Register("combine", "ROLLER", "Roller!", "npc/metropolice/vo/roller.wav")
impulse.Voice.Register("combine", "RUNNING", "He's running!", "npc/metropolice/vo/hesrunning.wav")
impulse.Voice.Register("combine", "SACRIFICE CODE", "All units, sacrifice code one and maintain this CP!", "npc/metropolice/vo/sacrificecode1maintaincp.wav")
impulse.Voice.Register("combine", "SAVAGE", "Savage.", "npc/combine_soldier/vo/savage.wav")
impulse.Voice.Register("combine", "SCAR", "Scar.", "npc/combine_soldier/vo/scar.wav")
impulse.Voice.Register("combine", "SEARCH", "Search!", "npc/metropolice/vo/search.wav")
impulse.Voice.Register("combine", "SEARCHING FOR SUSPECT", "Searching for suspect.", "npc/metropolice/vo/searchingforsuspect.wav")
impulse.Voice.Register("combine", "SECOND WARNING", "This is your second warning!", "npc/metropolice/vo/thisisyoursecondwarning.wav")
impulse.Voice.Register("combine", "SECTOR NOT STERILE", "Confirmed- sector not sterile.", "npc/combine_soldier/vo/confirmsectornotsterile.wav")
impulse.Voice.Register("combine", "SECTOR NOT SECURE", "Sector is not secure.", "npc/combine_soldier/vo/sectorisnotsecure.wav")
impulse.Voice.Register("combine", "SECTOR", "Sector", "npc/combine_soldier/vo/sector.wav")
impulse.Voice.Register("combine", "SECURE ADVANCE", "Assault-point secured, advance!", "npc/metropolice/vo/assaultpointsecureadvance.wav")
impulse.Voice.Register("combine", "SECURE", "Secure.", "npc/combine_soldier/vo/secure.wav")
impulse.Voice.Register("combine", "SENTENCE", "Sentence delivered.", "npc/metropolice/vo/sentencedelivered.wav")
impulse.Voice.Register("combine", "SERVE", "Serve.", "npc/metropolice/vo/serve.wav")
impulse.Voice.Register("combine", "SHADOW", "Shadow.", "npc/combine_soldier/vo/shadow.wav")
impulse.Voice.Register("combine", "SHARPZONE", "Sharpzone.", "npc/combine_soldier/vo/sharpzone.wav")
impulse.Voice.Register("combine", "SHIT", "Shit!", "npc/metropolice/vo/shit.wav")
impulse.Voice.Register("combine", "SHOTS FIRED", "Shots fired, hostile malignants here!", "npc/metropolice/vo/shotsfiredhostilemalignants.wav")
impulse.Voice.Register("combine", "SLAM", "Slam.", "npc/combine_soldier/vo/slam.wav")
impulse.Voice.Register("combine", "SLASH", "Slash.", "npc/combine_soldier/vo/slash.wav")
impulse.Voice.Register("combine", "SOCIOCIDE", "Sociocide.", "npc/metropolice/vo/sociocide.wav")
impulse.Voice.Register("combine", "SOCIOSTABLE", "We are socio-stable at this location.", "npc/metropolice/vo/wearesociostablethislocation.wav")
impulse.Voice.Register("combine", "SPEAR", "Spear.", "npc/combine_soldier/vo/spear.wav")
impulse.Voice.Register("combine", "STAB", "Stab.", "npc/combine_soldier/vo/stab.wav")
impulse.Voice.Register("combine", "STANDING BY", "Standing by.", "npc/combine_soldier/vo/standingby].wav")
impulse.Voice.Register("combine", "STAR", "Star.", "npc/combine_soldier/vo/star.wav")
impulse.Voice.Register("combine", "STATIONBLOCK", "Stationblock.", "npc/metropolice/vo/stationblock.wav")
impulse.Voice.Register("combine", "STAY ALERT", "Stay alert.", "npc/combine_soldier/vo/stayalert.wav")
impulse.Voice.Register("combine", "STERILIZE", "Sterilize!", "npc/metropolice/vo/sterilize.wav")
impulse.Voice.Register("combine", "STINGER", "Stinger.", "npc/combine_soldier/vo/stinger.wav")
impulse.Voice.Register("combine", "STORM", "Storm.", "npc/combine_soldier/vo/storm.wav")
impulse.Voice.Register("combine", "STRIKE", "Striker.", "npc/combine_soldier/vo/striker.wav")
impulse.Voice.Register("combine", "SUBJECT 505", "Subject is 505!", "npc/metropolice/vo/subjectis505.wav")
impulse.Voice.Register("combine", "SUBJECT HIGH SPEED", "All units, be advised, subject is now high-speed!", "npc/metropolice/vo/subjectisnowhighspeed.wav")
impulse.Voice.Register("combine", "SUBJECT", "Subject!", "npc/metropolice/vo/subject.wav")
impulse.Voice.Register("combine", "SUNDOWN", "Sundown.", "npc/combine_soldier/vo/sundown.wav")
impulse.Voice.Register("combine", "SUSPECT INCURSION", "Disp reports suspect-incursion at location.", "npc/metropolice/vo/dispreportssuspectincursion.wav")
impulse.Voice.Register("combine", "SUSPECT MOVED TO", "Suspect has moved now to...", "npc/metropolice/vo/supsecthasnowmovedto.wav")
impulse.Voice.Register("combine", "SUSPECT RESTRICTED CANALS", "Suspect is using restricted canals at...", "npc/metropolice/vo/suspectusingrestrictedcanals.wav")
impulse.Voice.Register("combine", "SUSPEND", "Suspend!", "npc/metropolice/vo/suspend.wav")
impulse.Voice.Register("combine", "SWEEPER", "Sweeper.", "npc/combine_soldier/vo/sweeper.wav")
impulse.Voice.Register("combine", "SWEEPING IN", "Sweeping in!", "npc/combine_soldier/vo/sweepingin.wav")
impulse.Voice.Register("combine", "SWEEPING SUSPECT", "Sweeping for suspect!", "npc/metropolice/vo/sweepingforsuspect.wav")
impulse.Voice.Register("combine", "SWIFT", "Swift.", "npc/combine_soldier/vo/swift.wav")
impulse.Voice.Register("combine", "SWORD", "Sword.", "npc/combine_soldier/vo/sword.wav")
impulse.Voice.Register("combine", "TAG 10-91D", "Tag 10-91d!", "npc/metropolice/vo/tag10-91d.wav")
impulse.Voice.Register("combine", "TAG BUG", "Tag one bug!", "npc/metropolice/vo/tagonebug.wav")
impulse.Voice.Register("combine", "TAG NECROTIC", "Tag one necrotic!", "npc/metropolice/vo/tagonenecrotic.wav")
impulse.Voice.Register("combine", "TAG PARASITIC", "Tag one parasitic!", "npc/metropolice/vo/tagoneparasitic.wav")
impulse.Voice.Register("combine", "TAKE A LOOK", "Going to take a look!", "npc/metropolice/vo/goingtotakealook.wav")
impulse.Voice.Register("combine", "TAKE COVER", "Take cover!", "npc/metropolice/vo/takecover.wav")
impulse.Voice.Register("combine", "TAP", "Tap!", "npc/metropolice/vo/tap.wav")
impulse.Voice.Register("combine", "TARGET", "Target.", "npc/combine_soldier/vo/target.wav")
impulse.Voice.Register("combine", "TEAM ADVANCE", "Team in position, advance!.", "npc/metropolice/vo/teaminpositionadvance.wav")
impulse.Voice.Register("combine", "TEAM HOLDING", "Stabilization team holding in position.", "npc/combine_soldier/vo/stabilizationteamholding.wav")
impulse.Voice.Register("combine", "THERE HE GOES", "There he goes! He's at...", "npc/metropolice/vo/therehegoeshesat.wav")
impulse.Voice.Register("combine", "THERE HE IS", "There he is!", "npc/metropolice/vo/thereheis.wav")
impulse.Voice.Register("combine", "TRACKER", "Tracker.", "npc/combine_soldier/vo/tracker.wav")
impulse.Voice.Register("combine", "TRANSITBLOCK", "Transit-block.", "npc/metropolice/vo/transitblock.wav")
impulse.Voice.Register("combine", "TROUBLE", "Lookin' for trouble?", "npc/metropolice/vo/lookingfortrouble.wav")
impulse.Voice.Register("combine", "UNDER FIRE", "Officer under fire, taking cover!", "npc/metropolice/vo/officerunderfiretakingcover.wav")
impulse.Voice.Register("combine", "UNIFORM", "Uniform.", "npc/combine_soldier/vo/uniform.wav")
impulse.Voice.Register("combine", "UNION", "Union!", "npc/metropolice/vo/union.wav")
impulse.Voice.Register("combine", "UNKNOWN", "Suspect location unknown.", "npc/metropolice/vo/suspectlocationunknown.wav")
impulse.Voice.Register("combine", "UP THERE", "He's up there!", "npc/metropolice/vo/hesupthere.wav")
impulse.Voice.Register("combine", "UPI", "UPI.", "npc/metropolice/vo/upi.wav")
impulse.Voice.Register("combine", "UTL SUSPECT", "UTL that suspect.", "npc/metropolice/vo/utlthatsuspect.wav")
impulse.Voice.Register("combine", "UTL", "UTL suspect.", "npc/metropolice/vo/utlsuspect.wav")
impulse.Voice.Register("combine", "VACATE", "Vacate, citizen!", "npc/metropolice/vo/vacatecitizen.wav")
impulse.Voice.Register("combine", "VAMP", "Vamp.", "npc/combine_soldier/vo/vamp.wav")
impulse.Voice.Register("combine", "VERDICT", "You want a malcompliance verdict?", "npc/metropolice/vo/youwantamalcomplianceverdict.wav")
impulse.Voice.Register("combine", "VICE", "Vice!", "npc/metropolice/vo/vice.wav")
impulse.Voice.Register("combine", "VICTOR", "Victor!", "npc/metropolice/vo/victor.wav")
impulse.Voice.Register("combine", "VISCON", "Viscon.", "npc/combine_soldier/vo/viscon.wav")
impulse.Voice.Register("combine", "VISUAL EXOGEN", "Visual on exogen.", "npc/combine_soldier/vo/visualonexogen.wav")
impulse.Voice.Register("combine", "WARNING GIVEN", "Second warning given!", "npc/metropolice/vo/secondwarning.wav")
impulse.Voice.Register("combine", "WASTERIVER", "Wasteriver.", "npc/metropolice/vo/wasteriver.wav")
impulse.Voice.Register("combine", "WATCH IT", "Watch it!", "npc/metropolice/vo/watchit.wav")
impulse.Voice.Register("combine", "WINDER", "Winder.", "npc/combine_soldier/vo/winder.wav")
impulse.Voice.Register("combine", "WORKFORCE", "Workforce intake.", "npc/metropolice/vo/workforceintake.wav")
impulse.Voice.Register("combine", "WRAP IT UP", "That's it, wrap it up.", "npc/combine_soldier/vo/thatsitwrapitup.wav")
impulse.Voice.Register("combine", "XRAY", "XRay!", "npc/metropolice/vo/xray.wav")
impulse.Voice.Register("combine", "YEAH", "Yeah.", "npc/metropolice/mc1ans_yeah.wav")
impulse.Voice.Register("combine", "YELLOW", "Yellow!", "npc/metropolice/vo/yellow.wav")
impulse.Voice.Register("combine", "YOU CAN GO", "Alright, you can go.", "npc/metropolice/vo/allrightyoucango.wav")
impulse.Voice.Register("combine", "ZONE", "Zone!", "npc/metropolice/vo/zone.wav")
impulse.Voice.Register("combine", "DEGREES", "Degrees", "npc/combine_soldier/vo/degrees.wav")
impulse.Voice.Register("combine", "BEARING", "Bearing", "npc/combine_soldier/vo/bearing.wav")
impulse.Voice.Register("combine", "METERS", "Meters", "npc/combine_soldier/vo/meters.wav")
impulse.Voice.Register("combine", "FLARE DOWN", "Flare down!", "npc/combine_soldier/vo/flaredown.wav")
impulse.Voice.Register("combine", "TARGET BLACKOUT", "Target blackout, sweep to resume.", "npc/combine_soldier/vo/targetblackout.wav")
impulse.Voice.Register("combine", "OVERTWATCH REQUEST RESERVE ACTIVATION", "Overwatch request reserve activation.", "npc/combine_soldier/vo/overwatchrequestreserveactivation.wav")
impulse.Voice.Register("combine", "TARGET IS AT", "Target is at", "npc/combine_soldier/vo/targetisat.wav")
impulse.Voice.Register("combine", "BOUNCER", "Bouncer bouncer!", "npc/combine_soldier/vo/bouncerbouncer.wav")
impulse.Voice.Register("combine", "REQUEST MEDICAL", "Request medical.", "npc/combine_soldier/vo/requestmedical.wav")
impulse.Voice.Register("combine", "REQUEST STIM", "Request stim dose.", "npc/combine_soldier/vo/requeststimdose.wav")
impulse.Voice.Register("combine", "COME WITH ME", "You, citizen, come with me.", "vo/trainyard/ba_youcomewith.wav")
impulse.Voice.Register("combine", "GET IN", "Get in.", "vo/trainyard/ba_getin.wav")
impulse.Voice.Register("combine", "GO ACTIVE INTERCEPT", "Go active intercept.", "npc/combine_soldier/vo/goactiveintercept.wav")
impulse.Voice.Register("combine", "FULL ACTIVE", "Full active.", "npc/combine_soldier/vo/fullactive.wav")
impulse.Voice.Register("combine", "SIGHT LINES", "Stay alert report sightlines.", "npc/combine_soldier/vo/stayalertreportsightlines.wav")
impulse.Voice.Register("combine", "HEAVY RESISTANCE", "Overwatch, be advised, we have heavy resistance.", "npc/combine_soldier/vo/heavyresistance.wav")

impulse.Voice.Register("vort", "ACCOMPANY", "Gladly we accompany.", "vo/npc/vortigaunt/accompany.wav")
impulse.Voice.Register("vort", "AFFIRMED", "Affirmed.", "vo/npc/vortigaunt/affirmed.wav")
impulse.Voice.Register("vort", "ALL IN ONE", "All in one then one in all.", "vo/npc/vortigaunt/allinoneinall.wav")
impulse.Voice.Register("vort", "ALLOW ME", "Allow me.", "vo/npc/vortigaunt/allowme.wav")
impulse.Voice.Register("vort", "AS YOU WISH", "As you wish.", "vo/npc/vortigaunt/asyouwish.wav")
impulse.Voice.Register("vort", "BE OF SERVICE", "Can we be of service?", "vo/npc/vortigaunt/beofservice.wav")
impulse.Voice.Register("vort", "CAUTION", "Caution.", "vo/npc/vortigaunt/caution.wav")
impulse.Voice.Register("vort", "CERTAINLY", "Certainly.", "vo/npc/vortigaunt/certainly.wav")
impulse.Voice.Register("vort", "DONE", "Done.", "vo/npc/vortigaunt/done.wav")
impulse.Voice.Register("vort", "DREAMED", "We have dreamed of this moment.", "vo/npc/vortigaunt/dreamed.wav")
impulse.Voice.Register("vort", "EMPOWER US", "Empower us.", "vo/npc/vortigaunt/empowerus.wav")
impulse.Voice.Register("vort", "GLADLY", "Gladly.", "vo/npc/vortigaunt/gladly.wav")
impulse.Voice.Register("vort", "HALT", "Halt.", "vo/npc/vortigaunt/halt.wav")
impulse.Voice.Register("vort", "HERE", "Here.", "vo/npc/vortigaunt/here.wav")
impulse.Voice.Register("vort", "FEAR FAILED", "We fear we have failed.", "vo/npc/vortigaunt/fearfailed.wav")
impulse.Voice.Register("vort", "FREEMAN", "Freeman.", "vo/npc/vortigaunt/freeman.wav")
impulse.Voice.Register("vort", "GLADLY", "Gladly.", "vo/npc/vortigaunt/gladly.wav")
impulse.Voice.Register("vort", "AN HONOR", "It is an honor.", "vo/npc/vortigaunt/itishonor.wav")
impulse.Voice.Register("vort", "YES", "Yes.", "vo/npc/vortigaunt/yes.wav")
impulse.Voice.Register("vort", "TAKE US", "Freeman take us with you.", "vo/npc/vortigaunt/takeus.wav")
impulse.Voice.Register("vort", "FOR FREEDOM", "For freedom.", "vo/npc/vortigaunt/forfreedom.wav")
impulse.Voice.Register("vort", "WITH PLEASURE", "With pleasure.", "vo/npc/vortigaunt/pleasure.wav")
impulse.Voice.Register("vort", "GLORIOUS END", "To our glorious end.", "vo/npc/vortigaunt/gloriousend.wav")
impulse.Voice.Register("vort", "HOLD STILL", "Hold still.", "vo/npc/vortigaunt/holdstill.wav")
impulse.Voice.Register("vort", "LEAD US", "Lead us.", "vo/npc/vortigaunt/leadus.wav")
impulse.Voice.Register("vort", "HONOR FOLLOW", "To our honor we follow you.", "vo/npc/vortigaunt/honorfollow.wav")
impulse.Voice.Register("vort", "TO THE VOID", "To the void with you.", "vo/npc/vortigaunt/tothevoid.wav")
impulse.Voice.Register("vort", "VORT1", "Ahg lah.", "vo/npc/vortigaunt/vortigese02.wav")
impulse.Voice.Register("vort", "VORT2", "Targh.", "vo/npc/vortigaunt/vortigese03.wav")
impulse.Voice.Register("vort", "VORT3", "Langh.", "vo/npc/vortigaunt/vortigese05.wav")
impulse.Voice.Register("vort", "VORT4", "Gahn.", "vo/npc/vortigaunt/vortigese07.wav")
impulse.Voice.Register("vort", "VORT5", "Galanga.", "vo/npc/vortigaunt/vortigese08.wav")
impulse.Voice.Register("vort", "VORT6", "Galalangh.", "vo/npc/vortigaunt/vortigese09.wav")
impulse.Voice.Register("vort", "VORT7", "Cher ganlahn cher alagahn.", "vo/npc/vortigaunt/vortigese11.wav")
impulse.Voice.Register("vort", "VORT8", "Cher langh gahn chaleng gur.", "vo/npc/vortigaunt/vortigese12.wav")
impulse.Voice.Register("vort", "VORT9", "Ter langh gur chaleng chur langh lerr.", "vo/npc/vortigaunt/vortigese13.wav")


if CLIENT then
	concommand.Add("impulse_hl2rp_printvcs", function(ply, cmd, args)
		if not args[1] then
			return print("Enter class as argument 1. (E.G. 'combine' or 'vort')")
		end

		if not impulse.Voice.List[args[1]] then
			return print("Class invalid.")
		end

		for v,k in pairs(impulse.Voice.List[args[1]]) do
			print(v:upper())
		end
	end)
end
