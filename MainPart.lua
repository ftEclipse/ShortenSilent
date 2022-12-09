--[[Eclipse Soft aim]]

--\\ Silent Aim 
local Aiming = loadstring(game:HttpGet(("https://raw.githubusercontent.com/ftEclipse/Slient/main/SilentEclipseScript.Lua"), true))()
Aiming.TeamCheck(false)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local EclipseSets = {
    SilentAim = true,
    Prediction = 0.125443282, --[[0.133, 0.125443282 | best Predictions ]]
}
getgenv().EclipseSets = EclipseSets

--\\ AA Resolver
RunService.Heartbeat:Connect(function()
    pcall(function()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local hrp = v.Character.HumanoidRootPart
                 hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
            end
        end
    end)
end)

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (EclipseSets.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * EclipseSets.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (EclipseSets.AimLock and Aiming.Check() and UserInputService:IsKeyDown(EclipseSets.AimLockKeybind)) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * EclipseSets.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
end)

local RunService = game:GetService("RunService")
--\\ AA Resolver (repeat btw) KEEP!!!!!
RunService.Heartbeat:Connect(function()
    pcall(function()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local hrp = v.Character.HumanoidRootPart
            	hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
				hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
            end
        end
    end)
end)

game.Players.LocalPlayer.Chatted:Connect(function(ChatRe)
	if ChatRe == "/e resolve" or "/e res" or "/e re" then
	local RunService = game:GetService("RunService")
		RunService.Heartbeat:Connect(function()
			pcall(function()
				for i,v in pairs(game.Players:GetChildren()) do
					if v.Name ~= game.Players.LocalPlayer.Name then
						local hrp = v.Character.HumanoidRootPart
						hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
						hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)   
					end
				end
			end)
		end)
	end
end)

game.Players.LocalPlayer.Chatted:Connect(function(ReV)
	if ReV == "/e resv2" or "/e rev2" or "/e v2" then
	local RunService = game:GetService("RunService")
		RunService.Heartbeat:Connect(function()
			pcall(function()
				for i,v in pairs(game.Players:GetChildren()) do
					if v.Name ~= game.Players.LocalPlayer.Name then
						local hrp = v.Character.HumanoidRootPart
						hrp.Velocity = Vector3.new(EclipseSets.Prediction, 0, EclipseSets.Prediction)    
						hrp.AssemblyLinearVelocity = Vector3.new(EclipseSets.Prediction, 0, EclipseSets.Prediction)   
					end
				end
			end)
		end)
	end
end)
