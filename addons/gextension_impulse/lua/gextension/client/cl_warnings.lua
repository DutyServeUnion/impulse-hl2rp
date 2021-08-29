//////////////////////////////////////
//     	  GExtension (c) 2019       //
//                                  //
//  Created by Jakob 'ibot3' Müller //
//                                  //
//  You are not permitted to share, //
//   	 trade, give away, sell     //
//      or otherwise distribute     //
//////////////////////////////////////

GExtension.Colors.Background = Color(180, 180, 180, 255)--background
GExtension.Colors.Bar = Color(51, 122, 183, 255)--bar
GExtension.Colors.Foreground = Color(255, 255, 255, 255)--foreground

local xsize = ScrW() - ScrW()/4
local ysize = ScrH() - ScrH()/4
local xpos  = ScrW()/2 - xsize/2
local ypos  = ScrH()/2 - ysize/2
local title = "ops Warnings"

function GExtension:GetHeaderHTML()
	local html_head = [[
		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			
			<!-- Botstrap CSS -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
			<!-- FontAwesome CSS -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
			<!-- Touchspin CSS -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-touchspin/3.1.1/jquery.bootstrap-touchspin.min.css">
		
			<style>
				body{
					overflow-x: hidden;
				}

				/*!
				 * bootstrap-vertical-tabs - v1.2.1
				 * https://dbtek.github.io/bootstrap-vertical-tabs
				 * 2014-11-07
				 * Copyright (c) 2014 İsmail Demirbilek
				 * License: MIT
				 */
				.tabs-left, .tabs-right {
				  border-bottom: none;
				  padding-top: 2px;
				}
				.tabs-left {
				  border-right: 1px solid #ddd;
				}
				.tabs-right {
				  border-left: 1px solid #ddd;
				}
				.tabs-left>li, .tabs-right>li {
				  float: none;
				  margin-bottom: 2px;
				}
				.tabs-left>li {
				  margin-right: -1px;
				}
				.tabs-right>li {
				  margin-left: -1px;
				}
				.tabs-left>li.active>a,
				.tabs-left>li.active>a:hover,
				.tabs-left>li.active>a:focus {
				  border-bottom-color: #ddd;
				  border-right-color: transparent;
				}

				.tabs-right>li.active>a,
				.tabs-right>li.active>a:hover,
				.tabs-right>li.active>a:focus {
				  border-bottom: 1px solid #ddd;
				  border-left-color: transparent;
				}
				.tabs-left>li>a {
				  border-radius: 4px 0 0 4px;
				  margin-right: 0;
				  display:block;
				}
				.tabs-right>li>a {
				  border-radius: 0 4px 4px 0;
				  margin-right: 0;
				}
				.sideways {
				  margin-top:50px;
				  border: none;
				  position: relative;
				}
				.sideways>li {
				  height: 20px;
				  width: 120px;
				  margin-bottom: 100px;
				}
				.sideways>li>a {
				  border-bottom: 1px solid #ddd;
				  border-right-color: transparent;
				  text-align: center;
				  border-radius: 4px 4px 0px 0px;
				}
				.sideways>li.active>a,
				.sideways>li.active>a:hover,
				.sideways>li.active>a:focus {
				  border-bottom-color: transparent;
				  border-right-color: #ddd;
				  border-left-color: #ddd;
				}
				.sideways.tabs-left {
				  left: -50px;
				}
				.sideways.tabs-right {
				  right: -50px;
				}
				.sideways.tabs-right>li {
				  -webkit-transform: rotate(90deg);
				  -moz-transform: rotate(90deg);
				  -ms-transform: rotate(90deg);
				  -o-transform: rotate(90deg);
				  transform: rotate(90deg);
				}
				.sideways.tabs-left>li {
				  -webkit-transform: rotate(-90deg);
				  -moz-transform: rotate(-90deg);
				  -ms-transform: rotate(-90deg);
				  -o-transform: rotate(-90deg);
				  transform: rotate(-90deg);
				}

				//FunkyRadio
				.funkyradio div {
				  clear: both;
				  overflow: hidden;
				}

				.funkyradio label {
				  width: 100%;
				  border-radius: 3px;
				  border: 1px solid #D1D3D4;
				  font-weight: normal;
				}

				.funkyradio input[type="radio"]:empty,
				.funkyradio input[type="checkbox"]:empty {
				  display: none;
				}

				.funkyradio input[type="radio"]:empty ~ label,
				.funkyradio input[type="checkbox"]:empty ~ label {
				  position: relative;
				  line-height: 2.33em;
				  text-indent: 3.25em;
				  cursor: pointer;
				  -webkit-user-select: none;
				     -moz-user-select: none;
				      -ms-user-select: none;
				          user-select: none;
				}

				.funkyradio input[type="radio"]:empty ~ label:before,
				.funkyradio input[type="checkbox"]:empty ~ label:before {
				  position: absolute;
				  display: block;
				  top: 0;
				  bottom: 0;
				  left: 0;
				  content: '';
				  width: 2.5em;
				  background: #D1D3D4;
				  border-radius: 3px 0 0 3px;
				}

				.funkyradio input[type="radio"]:hover:not(:checked) ~ label,
				.funkyradio input[type="checkbox"]:hover:not(:checked) ~ label {
				  color: #888;
				}

				.funkyradio input[type="radio"]:hover:not(:checked) ~ label:before,
				.funkyradio input[type="checkbox"]:hover:not(:checked) ~ label:before {
				  content: '\2714';
				  text-indent: .9em;
				  color: #C2C2C2;
				}

				.funkyradio input[type="radio"]:checked ~ label,
				.funkyradio input[type="checkbox"]:checked ~ label {
				  color: #777;
				}

				.funkyradio input[type="radio"]:checked ~ label:before,
				.funkyradio input[type="checkbox"]:checked ~ label:before {
				  content: '\2714';
				  text-indent: .9em;
				  color: #333;
				  background-color: #ccc;
				}

				.funkyradio input[type="radio"]:focus ~ label:before,
				.funkyradio input[type="checkbox"]:focus ~ label:before {
				  box-shadow: 0 0 0 3px #999;
				}

				.funkyradio-primary input[type="radio"]:checked ~ label:before,
				.funkyradio-primary input[type="checkbox"]:checked ~ label:before {
				  color: #fff;
				  background-color: #337ab7;
				}


			</style>
		</head>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-touchspin/3.1.1/jquery.bootstrap-touchspin.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

		<script>
			var admin_steamid64_selected = false;

			function HTMLSpecialChars(text) {
			  var map = {
			    '&': '&amp;',
			    '<': '&lt;',
			    '>': '&gt;',
			    '"': '&quot;',
			    "'": '&#039;'
			  };

			  return text.replace(/[&<>"']/g, function(m) { return map[m]; });
			}

			function SetWarningInactive(id, steamid64){
				/*$('.warning-' + id).removeClass('success');
				$('.warning-' + id).addClass('danger');

				$('.warning-button-' + id).html('<button class="btn btn-xs btn-danger" onclick="DeleteWarning(' + id + ');">]] .. GExtension:Lang("delete") .. [[</button>')

				var warncount = $('.player-warncount-' + steamid64).html();

				if(warncount > 1){
					$('.player-warncount-' + steamid64).html(warncount - 1);
				}else if(warncount > 0){
					$('.player-warncount-' + steamid64).hide();
				}*/

				GExtension.SetWarningInactive(id);
			}

			function DeleteWarning(id){
				//$('.warning-' + id).hide();
				GExtension.DeleteWarning(id);
			}

			function SaveSettings(){
				var kick = $('#settings_warnings_kick').prop("checked");
				var ban = $('#settings_warnings_ban').prop("checked");
				var kick_threshold = $('#settings_warnings_kick_threshold').val();
				var ban_threshold = $('#settings_warnings_ban_threshold').val();
				var decay = $('#settings_warnings_decay').val();
				var ban_length = $('#settings_warnings_ban_length').val();

				GExtension.SaveSettings(kick, ban, kick_threshold, ban_threshold, decay, ban_length);
			}

			function MyWarnings_Set(warnings){
				//var warnings = JSON.parse(warnings);

				if(warnings){
					$('#mywarnings_list').html('');

					Object.keys(warnings).reverse().forEach(function(key){
						if (warnings.hasOwnProperty(key)){
							var warning = warnings[key];

							var tclass = "danger";

							if(warning["active"]){
								tclass = "success";
							}

							var html_row = '<tr class="warning-' + warning["id"] + ' ' + tclass + '"><td>' + warning["id"] + '</td><td>' + warning["reason"] + '</td><td>' + warning["nick_admin"] + '</td><td class="text-right">' + warning["date_f"] + '</td><tr>';

							$('#mywarnings_list').append(html_row);
						}
					});
				}
			}

			function Admin_Set(warnings, players){
				//var players = JSON.parse(players);
				//var warnings = JSON.parse(warnings);

				if(players && warnings){
					var first = true;

					$('#admin_playerlist').html('');
					$('#admin_warnings').html('');

					for (var key in players){
						if (!players.hasOwnProperty(key)) continue;

						var nick = HTMLSpecialChars(players[key]["nick"]);
						var icon = players[key]["icon"];
						var warncount = players[key]["warncount"];

						var html_warncount = '<span style="background-color: red;" class="badge">' + warncount + '</span>';

						if(!warncount){
							html_warncount = '';
						}

						var tclass = '';

						if(first){
							first = false;
							tclass = "active";
						}
 
						var html_tab = '<li id="admin_player_' + key + '" class="' + tclass + ' admin_player"><a onclick="admin_steamid64_selected = \'' + key + '\';" href="#tab_' + key + '" data-toggle="tab"><i class="fa fa-' + icon + '"></i> ' + nick + '<span class="pull-right">' + html_warncount + ' <span onclick="OpenWarnModal(\'' + key + '\', \'' + HTMLSpecialChars(nick) + '\');" style="cursor: pointer;" class="badge">+</span></span></a></li>';

						$('#admin_playerlist').append(html_tab);

						var warnings_rows = '';

						if(warnings.hasOwnProperty(key)){
							Object.keys(warnings[key]).reverse().forEach(function(index){
								var warning = warnings[key][index];
								var tclass2 = "success";

								var button = '<button class="btn btn-xs btn-warning" onclick="SetWarningInactive(' + warning["id"] + ');">]] .. GExtension:Lang("set_inactive") .. [[</button>'

								if(!warning["active"]){
									tclass2 = "danger"
									button = '<button class="btn btn-xs btn-danger" onclick="DeleteWarning(' + warning["id"] + ');">]] .. GExtension:Lang("delete") .. [[</button>';
								}	

								warnings_rows = warnings_rows + '<tr class="warning-' + warning["id"] + ' ' + tclass2 + '"><td>' + warning["id"] + '</td><td>' + warning["reason"] + '</td><td>' + warning["nick_admin"] + '</td><td>' + warning["date_f"] + '</td><td class="text-right">' + button + '</td></tr>';
							});
						}

						$('#admin_warnings').append('<div role="tabpanel" class="tab-pane ' + tclass + '" id="tab_' + key + '"><table class="table table-condensed"><tr><th>#</th><th >]] .. GExtension:Lang("reason") .. [[</th><th>]] .. GExtension:Lang("admin") .. [[</th><th>]] .. GExtension:Lang("date") .. [[</th><th class="text-right"><i class="fa fa-wrench fa-lg"></i></th></tr><tbody>' + warnings_rows + '</tbody></table></div>');
					}
				}

				if(admin_steamid64_selected){
					$('#admin_player_' + admin_steamid64_selected).find('a').click();
				}
			}

			function Settings_Set(settings){
				//var settings = JSON.parse(settings);
				var checkboxes = ['settings_warnings_kick', 'settings_warnings_ban'];

				for(var key in settings){
					if(checkboxes.indexOf(key) == -1){
						$('#' + key).val(settings[key]);
					}else{
						if(settings[key] == "1"){
							$('#' + key).prop('checked', true);
						}else{
							$('#' + key).prop('checked', false);
						}
					}
				}
			}

			function OpenWarnModal(steamid64, nick){
				$('#warn_modal_steamid64').val(steamid64);
				$('#warn_modal_nick').html(nick);
				$('#warn_modal_reason').val('');

				$('#warn_modal').modal('show');
				$('.modal-backdrop').removeClass("modal-backdrop");    

				setTimeout(function(){
					$('#warn_modal_reason').focus();
				}, 500);
			}

			function Warn(){
				var steamid64 = $('#warn_modal_steamid64').val();
				var reason = $('#warn_modal_reason').val();

				reason = reason.replace(/\\/g, '');

				if(reason.trim() != ""){
					$('#warn_modal').modal('hide');

					$('#warn_modal_steamid64').val('');

					GExtension.Warn(steamid64, reason);
				}
			}
		</script>
	]]

	return html_head
end

function GExtension:CreateWarningsPanel()
	GExtension_Warnings_Panel = vgui.Create("DFrame")
	GExtension_Warnings_Panel:SetSize(xsize, ysize)
	GExtension_Warnings_Panel:SetPos(xpos, ypos)
	GExtension_Warnings_Panel:SetDraggable(true)
	GExtension_Warnings_Panel:SetTitle("Warnings")
	function GExtension_Warnings_Panel.Paint(self, w, h)
		//draw.RoundedBox(0, 0, 0, w, 24, GExtension.Colors.Bar)
		//draw.RoundedBox(0, 0, 24, w, h - 24, GExtension.Colors.Background)
		draw.RoundedBox(0, 0, 24, w, h - 24, GExtension.Colors.Foreground)
	end

	GExtension_Warnings_Panel_Html = vgui.Create("DHTML", GExtension_Warnings_Panel)
	GExtension_Warnings_Panel_Html:SetSize(xsize - 20, ysize - 44)
	GExtension_Warnings_Panel_Html:SetPos(10, 34)
	GExtension_Warnings_Panel_Html:SetHTML([[
		<html>
			]] .. GExtension:GetHeaderHTML() .. [[

			<body>
				<i class="fa fa-spinner fa-pulse fa-lg fa-fw"></i> Loading...
			</body>
		</html>
	]])

	local html_main = [[
		<html>
			]] .. GExtension:GetHeaderHTML() .. [[

			<body>
				<ul class="nav nav-tabs">
					<li role="presentation" class="active"><a href="#tab_warnings" role="tab" data-toggle="tab"><i class="fa fa-user"></i> ]] .. GExtension:Lang("your_warnings") .. [[</a></li>
					<li id="tab_li_admin" role="presentation"><a href="#tab_admin" role="tab" data-toggle="tab"><i class="fa fa-gavel"></i> ]] .. GExtension:Lang("admin") .. [[</a></li>
					<li id="tab_li_settings" class="pull-right" role="presentation"><a href="#tab_settings" role="tab" data-toggle="tab"><i class="fa fa-cogs fa-lg"></i></a></li>
				</ul>

				<br>

				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="tab_warnings">
						<table class="table table-condensed">
							<tr>
								<th>#</th>
								<th>]] .. GExtension:Lang("reason") .. [[</th>
								<th>]] .. GExtension:Lang("admin") .. [[</th>
								<th class="text-right">]] .. GExtension:Lang("date") .. [[</th>
							</tr>

							<tbody id="mywarnings_list">
							</tbody>
						</table>
					</div>

					<div role="tabpanel" class="tab-pane" id="tab_admin">
						<div class="row">
							<div class="col-xs-9">
								<div class="tab-content" id="admin_warnings">
									
								</div>
							</div>
							<div class="col-xs-3">
								<input id="admin_search" class="form-control" placeholder="..." />
								<hr>
								<ul class="nav nav-tabs tabs-right" id="admin_playerlist">

								</ul>
							</div>
						</div>
					</div>

					<div role="tabpanel" class="tab-pane" id="tab_settings">
						<div class="row">
							<div class="col-xs-6 col-xs-offset-3">
								<div class="row">
									<div class="col-xs-6">
										<label>]] .. GExtension:Lang("kick_on_threshold") .. [[</label>
										<div class="funkyradio funkyradio-primary">
								            <input type="checkbox" id="settings_warnings_kick" />
								            <label for="settings_warnings_kick">]] .. GExtension:Lang("kick_enable") .. [[</label>
								        </div>
									</div>

									<div class="col-xs-6">
										<label>]] .. GExtension:Lang("kick_threshold") .. [[</label>
										<input id="settings_warnings_kick_threshold" class="form-control" value="2" />
									</div>
								</div>

								<br>

								<div class="row">
									<div class="col-xs-6">
										<label>]] .. GExtension:Lang("ban_on_threshold") .. [[</label>
										<div class="funkyradio funkyradio-primary">
								            <input type="checkbox" id="settings_warnings_ban" />
								            <label for="settings_warnings_ban">]] .. GExtension:Lang("ban_enable") .. [[</label>
								        </div>
									</div>

									<div class="col-xs-6">
										<label>]] .. GExtension:Lang("ban_threshold") .. [[</label>
										<input id="settings_warnings_ban_threshold" class="form-control" value="4" />
									</div>
								</div>

								<br>

								<div class="row">
									<div class="col-xs-6">
										<label>]] .. GExtension:Lang("length_ban") .. [[</label>
										<input id="settings_warnings_ban_length" class="form-control" value="180" />
									</div>

									<div class="col-xs-6">
										<label>]] .. GExtension:Lang("time_decay") .. [[</label>
										<input id="settings_warnings_decay" class="form-control" value="1440" />
									</div>
								</div>

								<br>

								<div class="row">
									<div class="col-xs-12">
										<button class="btn btn-primary" onclick="SaveSettings();">]] .. GExtension:Lang("save") .. [[</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Add Warning Modal -->
				<div class="modal fade" id="warn_modal" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
								<h4 class="modal-title"><i class="fa fa-exclamation-triangle"></i> &nbsp;]] .. GExtension:Lang("warn") .. [[: <span id="warn_modal_nick"></span></h4>
							</div>

							<div class="modal-body">
								<input id="warn_modal_steamid64" type="hidden" />

								<label>]] .. GExtension:Lang("reason") .. [[</label>
								<input id="warn_modal_reason" class="form-control" />
							</div>

							<div class="modal-footer">
								<button type="button" onclick="Warn();" class="btn btn-danger">]] .. GExtension:Lang("warn") .. [[</button>
							</div>
						</div>
					</div>
				</div>

				<script>
					$("#settings_warnings_kick_threshold, #settings_warnings_ban_threshold").TouchSpin({
				        min: 0,
				        max: 100,
				    	step: 1,
				    	forcestepdivisibility: 'none',
				        decimals: 0,
				        verticalbuttons: true
				    });

				    $("#settings_warnings_ban_length, #settings_warnings_decay").TouchSpin({
				        min: 0,
				        max: 1000000,
				    	step: 60,
				    	forcestepdivisibility: 'none',
				        decimals: 0,
				        verticalbuttons: true,
				        postfix: ']] .. GExtension:Lang("minutes") .. [['
				    });

				    $('#admin_search').on("change keyup paste", function(){
						$('.admin_player').each(function(key, player){
							if(($(player).html().toLowerCase().indexOf($('#admin_search').val()) >= 0 ) || $('#admin_search').val() == ''){
								$(player).show();
							}else{
								$(player).hide();
							}
						});
					});
				</script>
			</body>
		</html>
	]]

	GExtension_Warnings_Panel_Html:AddFunction("GExtension", "SetWarningInactive", function(id)
		if isnumber(id) then
			RunConsoleCommand("gex_warnings_inactive", id)
		end
	end)

	GExtension_Warnings_Panel_Html:AddFunction("GExtension", "DebugPrint", function(msg)
		GExtension:Debug(msg)
	end)

	GExtension_Warnings_Panel_Html:AddFunction("GExtension", "DeleteWarning", function(id)
		if isnumber(id) then
			RunConsoleCommand("gex_warnings_delete", id)
		end
	end)

	GExtension_Warnings_Panel_Html:AddFunction("GExtension", "SaveSettings", function(kick, ban, kick_threshold, ban_threshold, decay, ban_length)
		if tobool(kick) then
			kick = 1
		else
			kick = 0
		end

		if tobool(ban) then
			ban = 1
		else
			ban = 0
		end

		RunConsoleCommand("gex_settings_warnings", kick, ban, kick_threshold, ban_threshold, decay, ban_length)
	end)

	GExtension_Warnings_Panel_Html:AddFunction("GExtension", "Warn", function(steamid64, reason)
		RunConsoleCommand("gex_warn", steamid64, reason)
	end)

	GExtension_Warnings_Panel_Html:SetHTML(html_main)
end

net.Receive("GExtension_Net_WarningsData", function()
	if GExtension_Warnings_Panel and GExtension_Warnings_Panel:IsValid() then
		local length_warnings = net.ReadUInt(16)
		local data_warnings = net.ReadData(length_warnings)
		local warnings = GExtension:FromJson(util.Decompress(data_warnings))

		local length_admin = net.ReadUInt(16)
		local data_admin = net.ReadData(length_admin)
		local admin_raw = GExtension:FromJson(util.Decompress(data_admin))
		local admin = {}

		for steam, pwarnings in pairs(admin_raw) do
			admin[string.Split(steam, "_")[2]] = pwarnings
		end
		
		local length_settings = net.ReadUInt(16)
		local data_settings = net.ReadData(length_settings)
		local settings = GExtension:FromJson(util.Decompress(data_settings))

		GExtension_Warnings_Panel_Html:RunJavascript([[MyWarnings_Set(]] .. GExtension:ToJson(warnings) .. [[);]])
		
		if LocalPlayer():GE_HasPermission("settings_warnings") then
			GExtension_Warnings_Panel_Html:RunJavascript([[Settings_Set(]] .. GExtension:ToJson(settings) .. [[);]])
		else
			GExtension_Warnings_Panel_Html:RunJavascript([[$('#tab_li_settings').hide();]])
		end

		if LocalPlayer():GE_HasPermission("warnings_add") then
			local players = {}

			for _, ply in pairs(player.GetHumans()) do
				local warncount = 0
				local icon = "user"

				if table.HasValue(table.GetKeys(admin), ply:SteamID64()) then
					if istable(admin[ply:SteamID64()]) then
						for _, warning in pairs(admin[ply:SteamID64()]) do
							if warning["active"] then
								warncount = warncount + 1
							end 
						end
					end
				end

				if ply:GE_HasPermission("warnings_delete") then
					icon = "star"
				elseif ply:GE_HasPermission("warnings_add") then
					icon = "star-half-o"
				end

				players[ply:SteamID64()] = {["nick"] = ply:Nick(), ["icon"] = icon, ["warncount"] = warncount}

				GExtension_Warnings_Panel_Html:RunJavascript([[Admin_Set(]] .. GExtension:ToJson(admin) .. [[, ]] .. GExtension:ToJson(players) .. [[);]])
			end
		else
			GExtension_Warnings_Panel_Html:RunJavascript([[$('#tab_li_admin').hide();]])
		end
	end
end)

net.Receive("GExtension_Net_WarningsPanelShow", function()
	if IsValid(GExtension_Warnings_Panel) then
		GExtension_Warnings_Panel:Remove()
	else
		GExtension:CreateWarningsPanel()

		function GExtension_Warnings_Panel:Show()
			GExtension_Warnings_Panel:MakePopup()
			RunConsoleCommand("gex_warnings_panel_loaded")
		end

		GExtension_Warnings_Panel:Show()
	end
end)
