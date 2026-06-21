local HttpService = game:GetService("HttpService")

local MedalAPIWrapper = {}
MedalAPIWrapper.__index = MedalAPIWrapper

local BASE_URL = "https://medal.tv/api";

local Endpoints = {
	["GetRobloxConnectionStatus"] = "/partners/robloxGame/user",
	["PostCompletionForClaim"] = "/partners/quests/QUEST_ID/reward/claim"
}

export type MedalAPIWrapperConfig = {
	APIKey: string
}

type self = {
	APIKey: string
}

export type MedalAPIWrapper = typeof(setmetatable({} :: self, MedalAPIWrapper))

type HttpRequestData = {
	Url: string;
	Method: string?;
	Headers: {
		[string]: any?
	}?;

	Body: string;
	Compress: Enum.HttpCompression;
};

type HttpResultData = {
	Body: string;
	Headers: {
		[string]: any?
	};
	StatusCode: number;
	StatusMessage: string;
	Success: boolean;
}

local function ValidateAPIKey(APIKey: string): boolean
	local Pattern = "^%d+,[a-f0-9%-]+$"
	return APIKey:match(Pattern) ~= nil
end

local function ParseDataIntoURLArg(BaseURL, Data)
	BaseURL ..= "?";

	local IsFirst = true;

	for Name, Value in Data do
		local GeneratedString = `{Name}=`;

		if type(Value) == "table" then
			local SizeOfTable = #Value
			local OneArg = SizeOfTable == 1;

			for Index, SecondValue in Value do
				GeneratedString ..= (SizeOfTable == Index or OneArg) and `{SecondValue}` or `{SecondValue},`
			end
		else
			GeneratedString ..= Value;
		end

		if IsFirst then
			IsFirst = false;

			BaseURL ..= GeneratedString
		else
			BaseURL ..= `&{GeneratedString}`
		end
	end

	return BaseURL;
end

function MedalAPIWrapper.new(MedalAPIWrapperConfig: MedalAPIWrapperConfig): MedalAPIWrapper
	if not ValidateAPIKey(MedalAPIWrapperConfig.APIKey) then
		error(`MedalAPIWrapper.new({MedalAPIWrapperConfig}) failed to create MedalAPIWrapper because MedalAPIWrapperConfig.APIKey is an invalid APIKey.`)
	end

	local self = setmetatable(MedalAPIWrapperConfig :: self, MedalAPIWrapper)

	return self
end

function MedalAPIWrapper.MakeAuthorizedRequest(self: MedalAPIWrapper, Data: HttpRequestData)
	if not self.APIKey then
		error(`MedalAPIWrapper:MakeAuthorizedRequest({Data}) failed to make request because MedalAPIWrapper has no APIKey.`)
	end

	local Headers = Data.Headers or {}
	Headers["x-authentication"] = self.APIKey
	Data.Headers = Headers

	return HttpService:RequestAsync(Data) :: HttpResultData
end

function MedalAPIWrapper.PostCompletion(self: MedalAPIWrapper, MedalUserId: number): any?
	local Result = self:MakeAuthorizedRequest({
		Url = `{BASE_URL}{Endpoints.PostCompletionForClaim}`;
		Method = "POST";
		Body = HttpService:JSONEncode({userId = MedalUserId})
	})

	return Result
end

function MedalAPIWrapper.GetQuestData(self: MedalAPIWrapper, UserId: number, QuestId: string): {[string]: any}?
	local Url = ParseDataIntoURLArg(`{BASE_URL}{Endpoints.GetRobloxConnectionStatus}`, {
		robloxUserId = UserId;
		questId = QuestId;
	});

	local Result = self:MakeAuthorizedRequest({
		Url = Url;
		Method = "GET"
	})

	local Body = Result.Body;
	Body = Body and HttpService:JSONDecode(Body);
	
	return Body or nil
end

function MedalAPIWrapper.GetMedalUserIdFromRobloxUserId(self: MedalAPIWrapper, UserId: number) : string
	local Url = ParseDataIntoURLArg(`{BASE_URL}{Endpoints.GetRobloxConnectionStatus}`, {
		robloxUserId = UserId;
	});

	local Result = self:MakeAuthorizedRequest({
		Url = Url;
		Method = "GET"
	})

	local Body = Result.Body;
	Body = Body and HttpService:JSONDecode(Body);

	return (type(Body) == "table" and Body.userId) or (nil)
end

function MedalAPIWrapper.GetRobloxConnectionStatus(self: MedalAPIWrapper, UserId: number): boolean
	local Url = ParseDataIntoURLArg(`{BASE_URL}{Endpoints.GetRobloxConnectionStatus}`, {
		robloxUserId = UserId;
	});

	local Result = self:MakeAuthorizedRequest({
		Url = Url;
		Method = "GET"
	})

	local Body = Result.Body;
	Body = Body and HttpService:JSONDecode(Body);

	return if Body and Body.hasMedalUser then true else false ;
end

return MedalAPIWrapper;