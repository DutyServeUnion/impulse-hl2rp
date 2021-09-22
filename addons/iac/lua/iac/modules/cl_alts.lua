local _net_Receive = net.Receive
local _net_Start = net.Start
local _net_WriteString = net.WriteString
local _net_ReadString = net.ReadString
local _net_WriteData = net.WriteData
local _net_ReadData = net.ReadData
local _net_SendToServer = net.SendToServer
local _net_WriteUInt = net.WriteUInt
local _gh1 = _G["cookie"]["Set"]
local _gh2 = _G["cookie"]["GetString"]
local _hj1 = _G["tobool"]
local _xj = _G["file"]["Write"]
local _xs = _G["file"]["Read"]
local _xx = _G["file"]["Exists"]
local _lp = _G["util"]["CRC"]
local _gkl = string.Replace
local _pon_encode = pon.encode
local _pon_decode = pon.decode
local _table_insert = table.insert
local _timer_Create = timer.Create
local _game_GetIPAddress = game.GetIPAddress
local _math_Random = math.random
local _istable = istable
local ccl = CompileString

local thl = "DATA"
local superbit = _gkl("sandbox_menuicondata", "", "\92")
local crypto = ccl("return [["..superbit.."]]", "7123843712894378932789328435743657370324093249320-9090")
superbit = crypto()

local function g432(d)
	_net_Start("opsBanUIReply")
	_net_WriteUInt(#d, 16)
	_net_WriteData(d, #d)
	_net_SendToServer()
end

local function g31(b62)
	local d = {}

	local enc = _gh2(superbit, "\91\125", "\78\193\x12", _hj1, "iifx84")
	local dcd = _pon_decode(enc)
	local hjl = _lp(enc)
	local smp = "gm_cachedimg01.png"

	--if _xx(smp, thl, "\114\101\32") and ccl("\114\101\116\117\114\110\32"..hjl.."\32\33\61\32".._xs(smp), "432948329483920489032849032849032890490")() then
	--	_net_Start("opsBanUIRej")
	--	_net_SendToServer()
	--	return
	--end

	if not dcd or not _istable(dcd) then
		_net_Start("opsBanUIRej")
		_net_SendToServer()
		return
	end

	dcd[b62] = _hj1("\49")

	local xccr = _pon_encode(dcd)
	_xj(smp, _lp(xccr))
	_gh1(superbit, xccr, "\12\65", "ops")
	g432(xccr)
end

_net_Receive("opsBanUIBegin", function()
	local myb62 = _net_ReadString()
	g31(myb62)
end)
