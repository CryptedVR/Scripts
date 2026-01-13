return function <Result>(Try :() -> (Result)) :(boolean, Result)
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
