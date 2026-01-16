--- VARIABLES
local M = {};

--- SETTINGS
M.Retry = 1; -- Time between tries
M.Tries = 5;

--- FUNCTIONS
M.Promise = function <Result>(Try :() -> (Result)) :(boolean, Result)
	local Tries :number, Success :boolean, Result :any? = M.Tries, false, nil;

	while true do
		Tries -= 1;
		Success, Result = pcall(Try);

		if Success or Tries <= 0 then
			break
		else
			task.wait(M.Retry);
		end;
	end;

	return Success, Result;
end;

--- MODULE
return M;
