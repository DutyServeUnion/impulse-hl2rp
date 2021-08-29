--[[
	mysql - 1.0.2
	A simple MySQL wrapper for Garry's Mod.

	Alexander Grist-Hucker
	http://www.alexgrist.com
--]]

mysql = mysql or {};

local QueueTable = {};
local Module = "mysqloo";
local Connected = false;
local type = type;
local tostring = tostring;
local table = table;

--[[
	Phrases
--]]

local MODULE_NOT_EXIST = "[mysql] The %s module does not exist!\n";

--[[
	Begin Query Class.
--]]

local QUERY_CLASS = {};
QUERY_CLASS.__index = QUERY_CLASS;

function QUERY_CLASS:New(tableName, queryType)
	local newObject = setmetatable({}, QUERY_CLASS);
		newObject.queryType = queryType;
		newObject.tableName = tableName;
		newObject.selectList = {};
		newObject.insertList = {};
		newObject.updateList = {};
		newObject.createList = {};
		newObject.whereList = {};
		newObject.orderByList = {};
	return newObject;
end;

function QUERY_CLASS:Escape(text)
	return mysql:Escape(tostring(text));
end;

function QUERY_CLASS:ForTable(tableName)
	self.tableName = tableName;
end;

function QUERY_CLASS:Where(key, value)
	self:WhereEqual(key, value);
end;

function QUERY_CLASS:WhereEqual(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` = \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereNotEqual(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` != \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereLike(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` LIKE \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereNotLike(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` NOT LIKE \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereGT(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` > \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereLT(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` < \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereGTE(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` >= \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:WhereLTE(key, value)
	self.whereList[#self.whereList + 1] = "`"..key.."` <= \""..self:Escape(value).."\"";
end;

function QUERY_CLASS:OrderByDesc(key)
	self.orderByList[#self.orderByList + 1] = "`"..key.."` DESC";
end;

function QUERY_CLASS:OrderByAsc(key)
	self.orderByList[#self.orderByList + 1] = "`"..key.."` ASC";
end;

function QUERY_CLASS:Callback(queryCallback)
	self.callback = queryCallback;
end;

function QUERY_CLASS:Select(fieldName)
	self.selectList[#self.selectList + 1] = "`"..fieldName.."`";
end;

function QUERY_CLASS:Insert(key, value)
	self.insertList[#self.insertList + 1] = {"`"..key.."`", "\""..self:Escape(value).."\""};
end;

function QUERY_CLASS:Update(key, value)
	self.updateList[#self.updateList + 1] = {"`"..key.."`", "\""..self:Escape(value).."\""};
end;

function QUERY_CLASS:Create(key, value)
	self.createList[#self.createList + 1] = {"`"..key.."`", value};
end;

function QUERY_CLASS:PrimaryKey(key)
	self.primaryKey = "`"..key.."`";
end;

function QUERY_CLASS:Limit(value)
	self.limit = value;
end;

function QUERY_CLASS:Offset(value)
	self.offset = value;
end;

local function BuildSelectQuery(queryObj)
	local queryString = {"SELECT"};

	if (type(queryObj.selectList) != "table" or #queryObj.selectList == 0) then
		queryString[#queryString + 1] = " *";
	else
		queryString[#queryString + 1] = " "..table.concat(queryObj.selectList, ", ");
	end;

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " FROM `"..queryObj.tableName.."` ";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	if (type(queryObj.whereList) == "table" and #queryObj.whereList > 0) then
		queryString[#queryString + 1] = " WHERE ";
		queryString[#queryString + 1] = table.concat(queryObj.whereList, " AND ");
	end;

	if (type(queryObj.orderByList) == "table" and #queryObj.orderByList > 0) then
		queryString[#queryString + 1] = " ORDER BY ";
		queryString[#queryString + 1] = table.concat(queryObj.orderByList, ", ");
	end;

	if (type(queryObj.limit) == "number") then
		queryString[#queryString + 1] = " LIMIT ";
		queryString[#queryString + 1] = queryObj.limit;
	end;

	return table.concat(queryString);
end;

local function BuildInsertQuery(queryObj)
	local queryString = {"INSERT INTO"};
	local keyList = {};
	local valueList = {};

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " `"..queryObj.tableName.."`";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	for i = 1, #queryObj.insertList do
		keyList[#keyList + 1] = queryObj.insertList[i][1];
		valueList[#valueList + 1] = queryObj.insertList[i][2];
	end;

	if (#keyList == 0) then
		return;
	end;

	queryString[#queryString + 1] = " ("..table.concat(keyList, ", ")..")";
	queryString[#queryString + 1] = " VALUES ("..table.concat(valueList, ", ")..")";

	return table.concat(queryString);
end;

local function BuildUpdateQuery(queryObj)
	local queryString = {"UPDATE"};

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " `"..queryObj.tableName.."`";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	if (type(queryObj.updateList) == "table" and #queryObj.updateList > 0) then
		local updateList = {};

		queryString[#queryString + 1] = " SET";

		for i = 1, #queryObj.updateList do
			updateList[#updateList + 1] = queryObj.updateList[i][1].." = "..queryObj.updateList[i][2];
		end;

		queryString[#queryString + 1] = " "..table.concat(updateList, ", ");
	end;

	if (type(queryObj.whereList) == "table" and #queryObj.whereList > 0) then
		queryString[#queryString + 1] = " WHERE ";
		queryString[#queryString + 1] = table.concat(queryObj.whereList, " AND ");
	end;

	if (type(queryObj.offset) == "number") then
		queryString[#queryString + 1] = " OFFSET ";
		queryString[#queryString + 1] = queryObj.offset;
	end;

	return table.concat(queryString);
end;

local function BuildDeleteQuery(queryObj)
	local queryString = {"DELETE FROM"}

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " `"..queryObj.tableName.."`";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	if (type(queryObj.whereList) == "table" and #queryObj.whereList > 0) then
		queryString[#queryString + 1] = " WHERE ";
		queryString[#queryString + 1] = table.concat(queryObj.whereList, " AND ");
	end;

	if (type(queryObj.limit) == "number") then
		queryString[#queryString + 1] = " LIMIT ";
		queryString[#queryString + 1] = queryObj.limit;
	end;

	return table.concat(queryString);
end;

local function BuildDropQuery(queryObj)
	local queryString = {"DROP TABLE"}

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " `"..queryObj.tableName.."`";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	return table.concat(queryString);
end;

local function BuildTruncateQuery(queryObj)
	local queryString = {"TRUNCATE TABLE"}

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " `"..queryObj.tableName.."`";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	return table.concat(queryString);
end;

local function BuildCreateQuery(queryObj)
	local queryString = {"CREATE TABLE IF NOT EXISTS"};

	if (type(queryObj.tableName) == "string") then
		queryString[#queryString + 1] = " `"..queryObj.tableName.."`";
	else
		ErrorNoHalt("[mysql] No table name specified!\n");
		return;
	end;

	queryString[#queryString + 1] = " (";

	if (type(queryObj.createList) == "table" and #queryObj.createList > 0) then
		local createList = {};

		for i = 1, #queryObj.createList do
			if (Module == "sqlite") then
				createList[#createList + 1] = queryObj.createList[i][1].." "..string.gsub(string.gsub(string.gsub(queryObj.createList[i][2], "AUTO_INCREMENT", ""), "AUTOINCREMENT", ""), "INT ", "INTEGER ");
			else
				createList[#createList + 1] = queryObj.createList[i][1].." "..queryObj.createList[i][2];
			end;
		end;

		queryString[#queryString + 1] = " "..table.concat(createList, ", ");
	end;

	if (type(queryObj.primaryKey) == "string") then
		queryString[#queryString + 1] = ", PRIMARY KEY";
		queryString[#queryString + 1] = " ("..queryObj.primaryKey..")";
	end;

	queryString[#queryString + 1] = " )";

	return table.concat(queryString); 
end;

function QUERY_CLASS:Execute(bQueueQuery)
	local queryString = nil;
	local queryType = string.lower(self.queryType);

	if (queryType == "select") then
		queryString = BuildSelectQuery(self);
	elseif (queryType == "insert") then
		queryString = BuildInsertQuery(self);
	elseif (queryType == "update") then
		queryString = BuildUpdateQuery(self);
	elseif (queryType == "delete") then
		queryString = BuildDeleteQuery(self);
	elseif (queryType == "drop") then
		queryString = BuildDropQuery(self);
	elseif (queryType == "truncate") then
		queryString = BuildTruncateQuery(self);
	elseif (queryType == "create") then
		queryString = BuildCreateQuery(self);
	end;

	if (type(queryString) == "string") then
		if (!bQueueQuery) then
			return mysql:RawQuery(queryString, self.callback);
		else
			return mysql:Queue(queryString, self.callback);
		end;
	end;
end;

--[[
	End Query Class.
--]]

function mysql:Select(tableName)
	return QUERY_CLASS:New(tableName, "SELECT");
end;

function mysql:Insert(tableName)
	return QUERY_CLASS:New(tableName, "INSERT");
end;

function mysql:Update(tableName)
	return QUERY_CLASS:New(tableName, "UPDATE");
end;

function mysql:Delete(tableName)
	return QUERY_CLASS:New(tableName, "DELETE");
end;

function mysql:Drop(tableName)
	return QUERY_CLASS:New(tableName, "DROP");
end;

function mysql:Truncate(tableName)
	return QUERY_CLASS:New(tableName, "TRUNCATE");
end;

function mysql:Create(tableName)
	return QUERY_CLASS:New(tableName, "CREATE");
end;

-- A function to connect to the MySQL database.
function mysql:Connect(host, username, password, database, port, socket, flags)
	if (!port) then
		port = 3306;
	end;

	if (Module == "tmysql4") then
		if (type(tmysql) != "table") then
			require("tmysql4");
		end;

		if (tmysql) then
			local errorText = nil;

			self.connection, errorText = tmysql.initialize(host, username, password, database, port, socket, flags);

			if (!self.connection) then
				self:OnConnectionFailed(errorText);
			else
				self:OnConnected();
			end;
		else
			ErrorNoHalt(string.format(MODULE_NOT_EXIST, Module));
		end;
	elseif (Module == "mysqloo") then
		if (type(mysqloo) != "table") then
			require("mysqloo");
		end;
	
		if (mysqloo) then
			local clientFlag = flags or 0;

			if (type(socket) ~= "string") then
				self.connection = mysqloo.connect(host, username, password, database, port);
			else
				self.connection = mysqloo.connect(host, username, password, database, port, socket, clientFlag);
			end;

			self.connection.onConnected = function(database)
				mysql:OnConnected();
			end;

			self.connection.onConnectionFailed = function(database, errorText)
				mysql:OnConnectionFailed(errorText);
			end;		

			self.connection:connect();
		else
			ErrorNoHalt(string.format(MODULE_NOT_EXIST, Module));
		end;
	elseif (Module == "sqlite") then
		mysql:OnConnected();
	end;
end;

-- A function to query the MySQL database.
function mysql:RawQuery(query, callback, flags, ...)
	if (!self.connection and Module != "sqlite") then
		self:Queue(query);
	end;

	if (Module == "tmysql4") then
		local queryFlag = flags or QUERY_FLAG_ASSOC;

		self.connection:Query(query, function(result)
			local queryStatus = result[1]["status"];

			if (queryStatus) then
				if (type(callback) == "function") then
					local bStatus, value = pcall(callback, result[1]["data"], queryStatus, result[1]["lastid"]);

					if (!bStatus) then
						ErrorNoHalt(string.format("[mysql] MySQL Callback Error!\n%s\n", value));
					end;
				end;
			else
				ErrorNoHalt(string.format("[mysql] MySQL Query Error!\nQuery: %s\n%s\n", query, result[1]["error"]));
			end;
		end, queryFlag, ...);
	elseif (Module == "mysqloo") then
		local queryObj = self.connection:query(query);

		queryObj:setOption(mysqloo.OPTION_NAMED_FIELDS);

		queryObj.onSuccess = function(queryObj, result)
			if (callback) then
				local bStatus, value = pcall(callback, result, true, queryObj:lastInsert());

				if (!bStatus) then
					ErrorNoHalt(string.format("[mysql] MySQL Callback Error!\n%s\n", value));
				end;
			end;
		end;

		queryObj.onError = function(queryObj, errorText)
			ErrorNoHalt(string.format("[mysql] MySQL Query Error!\nQuery: %s\n%s\n", query, errorText));
		end;

		queryObj:start();
	elseif (Module == "sqlite") then
		local result = sql.Query(query);

		if (result == false) then
			ErrorNoHalt(string.format("[mysql] SQL Query Error!\nQuery: %s\n%s\n", query, sql.LastError()));
		else
			if (callback) then
				local bStatus, value = pcall(callback, result);

				if (!bStatus) then
					ErrorNoHalt(string.format("[mysql] SQL Callback Error!\n%s\n", value));
				end;
			end;
		end;
	else
		ErrorNoHalt(string.format("[mysql] Unsupported module \"%s\"!\n", Module));
	end;
end;

-- A function to add a query to the queue.
function mysql:Queue(queryString, callback)
	if (type(queryString) == "string") then
		QueueTable[#QueueTable + 1] = {queryString, callback};
	end;
end;

-- A function to escape a string for MySQL.
function mysql:Escape(text)
	if (self.connection) then
		if (Module == "tmysql4") then
			return self.connection:Escape(text);
		elseif (Module == "mysqloo") then
			return self.connection:escape(text);
		end;
	else
		return sql.SQLStr(string.gsub(text, "\"", "'"), true);
	end;
end;

-- A function to disconnect from the MySQL database.
function mysql:Disconnect()
	if (self.connection) then
		if (Module == "tmysql4") then
			return self.connection:Disconnect();	
		end;
	end;

	Connected = false;
end;

function mysql:Think()
	if (#QueueTable > 0) then
		if (type(QueueTable[1]) == "table") then
			local queueObj = QueueTable[1];
			local queryString = queueObj[1];
			local callback = queueObj[2];
			
			if (type(queryString) == "string") then
				self:RawQuery(queryString, callback);
			end;

			table.remove(QueueTable, 1);
		end;
	end;
end;

-- A function to set the module that should be used.
function mysql:SetModule(moduleName)
	Module = moduleName;
end;

-- Called when the database connects sucessfully.
function mysql:OnConnected()
	MsgC(Color(25, 235, 25), "[mysql] Connected to the database!\n");

	Connected = true;
	hook.Run("DatabaseConnected");
end;

-- Called when the database connection fails.
function mysql:OnConnectionFailed(errorText)
	ErrorNoHalt("[mysql] Unable to connect to the database!\n"..errorText.."\n");

	hook.Run("DatabaseConnectionFailed", errorText);
end;

-- A function to check whether or not the module is connected to a database.
function mysql:IsConnected()
	return Connected;
end;

return mysql;
