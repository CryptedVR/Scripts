local Blueprint = {};
Blueprint.__index = Blueprint;

type self = {
	DataStore :DataStore,
	Success :boolean,
	Key :any,
	Data :any,
};

function Promise<Result>(Try :() -> (Result)) :(boolean, Result)
	local Tries :number, Success :boolean, Result :any? = 0, false, nil;
	
	while true do
		Tries += 1;
		Success, Result = pcall(Try);
		
		if Success or Tries >= 5 then
			break
		else
			task.wait(1);
		end;
	end;
	
	return Success, Result;
end;

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
