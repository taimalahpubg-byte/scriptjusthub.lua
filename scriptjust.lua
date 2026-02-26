--// JUST HUB PREMIUM - FINAL WITH VIP PANEL

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character, hrp, humanoid

-- Character Setup
local function SetupCharacter()
	character = player.Character or player.CharacterAdded:Wait()
	hrp = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
end
SetupCharacter()
player.CharacterAdded:Connect(SetupCharacter)

-- GUI
local gui = Instance.new("ScreenGui",player.PlayerGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,300,0,430)
main.Position = UDim2.new(0.5,-150,0.5,-215)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true
Instance.new("UICorner",main).CornerRadius = UDim.new(0,25)

local stroke = Instance.new("UIStroke",main)
stroke.Thickness = 4
RunService.RenderStepped:Connect(function()
	stroke.Color = Color3.fromHSV((tick()%5)/5,1,1)
end)

-- Title
local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Just Hub Premium"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.new(1,1,1)

-- Sub RGB Text
local sub = Instance.new("TextLabel",main)
sub.Size = UDim2.new(1,0,0,20)
sub.Position = UDim2.new(0,0,0,40)
sub.BackgroundTransparency = 1
sub.Text = "صنع بواسطة Just"
sub.TextScaled = true
sub.Font = Enum.Font.Gotham
RunService.RenderStepped:Connect(function()
	sub.TextColor3 = Color3.fromHSV((tick()%5)/5,1,1)
end)

-- Admin Key
local unlocked = false
local adminKey = "Justbest"

local keyFrame = Instance.new("Frame",gui)
keyFrame.Size = UDim2.new(0,230,0,130)
keyFrame.Position = UDim2.new(0.5,-115,0.5,-65)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner",keyFrame).CornerRadius = UDim.new(0,15)

local keyBox = Instance.new("TextBox",keyFrame)
keyBox.Size = UDim2.new(0.8,0,0,40)
keyBox.Position = UDim2.new(0.1,0,0.25,0)
keyBox.PlaceholderText = "Enter Premium Key"
keyBox.TextScaled = true
keyBox.Font = Enum.Font.Gotham
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner",keyBox).CornerRadius = UDim.new(0,10)

local submit = Instance.new("TextButton",keyFrame)
submit.Size = UDim2.new(0.6,0,0,35)
submit.Position = UDim2.new(0.2,0,0.65,0)
submit.Text = "Unlock"
submit.TextScaled = true
submit.Font = Enum.Font.GothamBold
submit.BackgroundColor3 = Color3.fromRGB(50,50,50)
submit.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",submit).CornerRadius = UDim.new(0,10)

submit.MouseButton1Click:Connect(function()
	if keyBox.Text == adminKey then
		unlocked = true
		keyFrame:Destroy()
	end
end)

-- Button Creator
local function makeButton(text,posY)
	local btn = Instance.new("TextButton",main)
	btn.Size = UDim2.new(0.85,0,0,35)
	btn.Position = UDim2.new(0.075,0,posY,0)
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.Text = text
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,15)
	return btn
end

-- Buttons
local ghostBtn = makeButton("Ghost Mode",0.18)
local pathBtn = makeButton("Walk Path",0.30)
local noclipBtn = makeButton("No Clip",0.42)
local floatBtn = makeButton("Float",0.54)
local pushBtn = makeButton("Force Push",0.66)
local gapBtn = makeButton("Gap (100 Stud)",0.78)
local vipPanelBtn = makeButton("VIP Panel",0.88) -- زر جديد للـ VIP PANEL

-- Ghost Mode
local ghost = false
ghostBtn.MouseButton1Click:Connect(function()
	if not unlocked then return end
	ghost = not ghost
	if ghost then
		ghostBtn.Text = "Ghost ON"
		for _,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 0.6
				v.CanCollide = false
			end
		end
		hrp.CFrame = hrp.CFrame - Vector3.new(0,8,0)
	else
		ghostBtn.Text = "Ghost Mode"
		for _,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
				v.CanCollide = true
			end
		end
	end
end)

-- Walk Path
local path
local pathConn
local pathEnabled = false
local fixedHeight
pathBtn.MouseButton1Click:Connect(function()
	if not unlocked then return end
	pathEnabled = not pathEnabled
	if pathEnabled then
		pathBtn.Text = "Path ON"
		fixedHeight = hrp.Position.Y - 4
		path = Instance.new("Part")
		path.Size = Vector3.new(30,1,30)
		path.Anchored = true
		path.Transparency = 1
		path.CanCollide = true
		path.Parent = workspace
		pathConn = RunService.RenderStepped:Connect(function()
			if hrp then
				if hrp.Position.Y - 4 > fixedHeight then
					fixedHeight = hrp.Position.Y - 4
				end
				path.Position = Vector3.new(hrp.Position.X,fixedHeight,hrp.Position.Z)
			end
		end)
	else
		pathBtn.Text = "Walk Path"
		if path then path:Destroy() end
		if pathConn then pathConn:Disconnect() end
	end
end)

-- Gap
gapBtn.MouseButton1Click:Connect(function()
	if not unlocked then return end
	hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 100)
end)

-- VIP PANEL
vipPanelBtn.MouseButton1Click:Connect(function()
	if not unlocked then return end

	if player.PlayerGui:FindFirstChild("VIPTeleportGUI") then return end

	-- ================= VIP GUI =================
	local vipGui = Instance.new("ScreenGui")
	vipGui.Name = "VIPTeleportGUI"
	vipGui.Parent = player.PlayerGui
	vipGui.ResetOnSpawn = false

	local frame = Instance.new("Frame")
	frame.Parent = vipGui
	frame.Size = UDim2.new(0,280,0,200)
	frame.Position = UDim2.new(0.5,-140,0.3,0)
	frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	frame.Active = true
	frame.Draggable = true
	Instance.new("UICorner",frame).CornerRadius = UDim.new(0,20)

	local title = Instance.new("TextLabel",frame)
	title.Size = UDim2.new(1,0,0,40)
	title.BackgroundTransparency = 1
	title.Text = "VIP Panel"
	title.TextScaled = true
	title.Font = Enum.Font.GothamBold
	title.TextColor3 = Color3.new(1,1,1)

	local function makeBtn(name,posY)
		local btn = Instance.new("TextButton",frame)
		btn.Size = UDim2.new(0.8,0,0,40)
		btn.Position = UDim2.new(0.1,0,posY,0)
		btn.Text = name
		btn.TextScaled = true
		btn.Font = Enum.Font.GothamBold
		btn.BackgroundColor3 = Color3.fromRGB(45,45,60)
		btn.TextColor3 = Color3.new(1,1,1)
		Instance.new("UICorner",btn).CornerRadius = UDim.new(0,15)
		return btn
	end

	local vipTeleportBtn = makeBtn("VIP Teleport",0.3)
	local openVIPBtn = makeBtn("Open VIP",0.6)

	local lastVIP = nil
	local function getSortedVIPs()
		local vipList = {}
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and string.find(string.lower(v.Name),"vip") then
				table.insert(vipList,v)
			end
		end
		table.sort(vipList,function(a,b)
			return (hrp.Position - a.Position).Magnitude <
			       (hrp.Position - b.Position).Magnitude
		end)
		return vipList
	end

	-- VIP Teleport
	vipTeleportBtn.MouseButton1Click:Connect(function()
		local vipList = getSortedVIPs()
		if #vipList == 0 then return end

		local target = nil
		for _,vip in ipairs(vipList) do
			if vip ~= lastVIP then
				target = vip
				break
			end
		end
		if not target then target = vipList[1] end
		lastVIP = target

		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		hrp.CFrame = target.CFrame + Vector3.new(0,3,0)
	end)

	-- Open VIP
	openVIPBtn.MouseButton1Click:Connect(function()
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and string.find(string.lower(v.Name),"vip") then
				v.CanCollide = false
				v.Transparency = 0.7
			end
		end
	end)
end)
