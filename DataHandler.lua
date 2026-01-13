--- SERVICES
local SS = game:GetService("ServerStorage");

--- DIRECTORIES
local Dependencies = SS.Dependencies;

--- DEPENDENCIES
local Promise = require(Dependencies.Promise);

--- STRUCTURES
local Blueprint = {};
Blueprint.__index = Blueprint;

--- TYPES
type self = {
	DataStore :DataStore,
	Success :boolean,
	Key :any,
	Data :any,
};

--- FUNCTIONS
function Blueprint.Save(self :Handler) :boolean
	local Success = Promise(function()
		self.DataStore:SetAsync(self.Key, self.Data);
	end);
	
	return Success;
end;

--- MODULE
export type Handler = typeof(setmetatable({} :: self, Blueprint));

return function(DataStore :DataStore, Key :any) :Handler
	local Success, Result = Promise(function()
		return DataStore:GetAsync(Key);
	end);
	
	return setmetatable({
		DataStore = DataStore,
		Success = Success,
		Key = Key,
		Data = Result,
	} :: self, Blueprint);
end;
