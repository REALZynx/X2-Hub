if not game:IsLoaded() then
    game.Loaded:Wait()
end

if getgenv().XTwoTwoTwoTwoLoaded then
    return
end
getgenv().XTwoTwoTwoTwoLoaded = true

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local placeId = game.PlaceId

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0
TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Size = 20}):Play()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "X2Loader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999

local bg = Instance.new("Frame", screenGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
bg.BackgroundTransparency = 1
bg.ZIndex = 1
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

local bgGradient = Instance.new("UIGradient", bg)
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10)),
})
bgGradient.Rotation = 135

local container = Instance.new("Frame", bg)
container.Size = UDim2.new(0, 500, 0, 100)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.48, 0)
container.BackgroundTransparency = 1
container.ZIndex = 2

local subtitle = Instance.new("TextLabel", bg)
subtitle.Text = "Loading your experience..."
subtitle.Font = Enum.Font.GothamBold
subtitle.TextColor3 = Color3.fromRGB(255, 160, 40)
subtitle.TextTransparency = 1
subtitle.TextSize = 15
subtitle.Size = UDim2.new(0, 400, 0, 30)
subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
subtitle.Position = UDim2.new(0.5, 0, 0.58, 0)
subtitle.BackgroundTransparency = 1
subtitle.ZIndex = 3

local credit = Instance.new("TextLabel", bg)
credit.Text = "This Loading Screen Originally From Stellar. I Just Modifying It."
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(120, 120, 140)
credit.TextTransparency = 1
credit.TextSize = 11
credit.Size = UDim2.new(0, 500, 0, 20)
credit.AnchorPoint = Vector2.new(0, 1)
credit.Position = UDim2.new(0.02, 0, 0.98, 0)  -- pojok kiri bawah
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Left
credit.ZIndex = 3

local Sound = Instance.new("Sound", screenGui)
Sound.SoundId = "rbxassetid://231731980"
Sound.Volume = 0.4
Sound.RollOffMaxDistance = 0

local word = "X2HUB"
local letters = {}
local charWidth = 70
local totalWidth = #word * charWidth

for i = 1, #word do
	local char = word:sub(i, i)
	local offsetX = (i - 1) * charWidth - (totalWidth / 2) + (charWidth / 2)

	local label = Instance.new("TextLabel", container)
	label.Text = char
	label.Font = Enum.Font.GothamBlack
	label.TextColor3 = Color3.fromRGB(245, 245, 245)
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(25, 25, 25)
	label.TextTransparency = 1
	label.TextScaled = false
	label.TextSize = 24
	label.Size = UDim2.new(0, charWidth, 0, 90)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.new(0.5, offsetX, 0.7, 0)
	label.BackgroundTransparency = 1
	label.ZIndex = 3

	local gradient = Instance.new("UIGradient", label)
	gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190, 190, 190)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 90, 90)),
    })
	gradient.Rotation = 90

	TweenService:Create(label,
		TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{
			TextTransparency = 0,
			TextSize = 62,
			Position = UDim2.new(0.5, offsetX, 0.5, 0),
		}
	):Play()
	
    local s = Sound:Clone()
    s.Parent = screenGui
    s:Play()
    game:GetService("Debris"):AddItem(s, 2)
    
	table.insert(letters, {label = label, gradient = gradient})
	task.wait(0.12)
end

local chime = Instance.new("Sound", screenGui)
chime.SoundId = "rbxassetid://7128958209"
chime.Volume = 0.4
chime:Play()

task.wait(0.1)
TweenService:Create(subtitle, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 0.2}):Play()
TweenService:Create(credit, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {TextTransparency = 0.5}):Play()

task.spawn(function()
	local t = 0
	while bg.Parent do
		t += 0.03
		for _, data in ipairs(letters) do
			data.gradient.Rotation = 90 + math.sin(t) * 15
		end
		task.wait(0.05)
	end
end)

task.wait(2.8)

TweenService:Create(subtitle, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
TweenService:Create(credit, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
task.wait(0.1)

local mid = math.ceil(#letters / 2)
for i = 0, mid - 1 do
	local leftIdx = mid - i
	local rightIdx = mid + i + 1

	if letters[leftIdx] then
		TweenService:Create(letters[leftIdx].label,
			TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
			{TextTransparency = 1, TextSize = 80, Position = letters[leftIdx].label.Position + UDim2.new(0, -10, 0, -20)}
		):Play()
	end
	if rightIdx <= #letters and letters[rightIdx] then
		TweenService:Create(letters[rightIdx].label,
			TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
			{TextTransparency = 1, TextSize = 80, Position = letters[rightIdx].label.Position + UDim2.new(0, 10, 0, -20)}
		):Play()
	end
	task.wait(0.07)
end

TweenService:Create(bg, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = 0}):Play()

task.wait(0.6)
screenGui:Destroy()
blur:Destroy()

local Games = {
    [11137575513] = "https://raw.githubusercontent.com/REALZynx/X2-Hub/refs/heads/main/tcotcotcotcotco.lua",
}

local scriptUrl = Games[placeId]

local success, err = pcall(function()
    loadstring(game:HttpGet(scriptUrl))()
end)

if not success then
    warn("[X2HUB] Failed to load:", err)
end
