--- SERVICES
local DSS = game:GetService("DataStoreService");

local Blueprint = {};
Blueprint.__index = Blueprint;

type self = {
	DataStore :DataStore,
};

local Handler = require(script.Handler);

function Blueprint.GetHandler(self :Manager, Key :any) :Handler
	return Handler(self.DataStore, Key);
end;

--- MODULE
export type Manager = typeof(setmetatable({} :: self, Blueprint));
export type Handler = Handler.Handler;

return {
	RegisterGlobal = function() :Manager
		return setmetatable({
			DataStore = DSS:GetGlobalDataStore();
		} :: self, Blueprint);
	end,
	Register = function(Name :string) :Manager
		return setmetatable({
			DataStore = DSS:GetDataStore(Name);
		} :: self, Blueprint);
	end,
};
