
local function align(i,v) 

local att0 = Instance.new("Attachment", i) 

att0.Position = Vector3.new(0,0,0) 

local att1 = Instance.new("Attachment", v) 

att1.Position = Vector3.new(0,5,0) 

att1.Rotation = Vector3.new(0,0,0) 

local AP = Instance.new("AlignPosition", i) 

AP.Attachment0 = att0 

AP.Attachment1 = att1 

AP.RigidityEnabled = false 

AP.ReactionForceEnabled = false 

AP.ApplyAtCenterOfMass = true 

AP.MaxForce = 9999999 

AP.MaxVelocity = math.huge 

AP.Responsiveness = 100000 

local AO = Instance.new("AlignOrientation", i) 

AO.Attachment0 = att0 

AO.Attachment1 = att1 

AO.ReactionTorqueEnabled = true 

AO.PrimaryAxisOnly = false 

AO.MaxTorque = 9999999 

AO.MaxAngularVelocity = math.huge 

AO.Responsiveness = 100000 

return att1 

end 

 

local Hats = {} 

local HatsPosition = {} 



function FindPlayer(Name) 

for _,player in pairs(game:GetService("Players"):GetPlayers()) do 

local PlayerName = string.lower(player.Name) 

Name = string.lower(Name) 

if string.find(PlayerName, Name) then 

return player 

end 

end 

end 



local Dick = false; 



local Connections = {} 



local Character = game.Players.LocalPlayer.Character 





for index,value in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 

if value:IsA("Accessory") then 

value.Handle.Massless = true 

value.Handle.AccessoryWeld:Destroy() 

pcall(function() 

value.Handle.SpecialMesh:Destroy() 

end) 

pcall(function() 

value.Handle.Mesh:Destroy() 

end) 

table.insert(Hats, value.Handle) 

local HatAtt = align(value.Handle, Character["Torso"]) 

table.insert(HatsPosition, HatAtt) 

end 

end 





for i,hat in pairs(Hats) do 

if Dick then 

if i == 1 then 

HatsPosition[i].Position = (CFrame.new(-0.55,-1.35,-1)).Position 

else 

if i == 2 then 

HatsPosition[i].Position = (CFrame.new(0.55,-1.35,-1)).Position 

else 

HatsPosition[i].Position = (CFrame.new(0,-1,(i - 2) * -1)).Position 

end 

end 

else 

HatsPosition[i].Position = Vector3.new(0,0,0) 

end 

end 



 

local Key = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent) 

if not gameProcessedEvent then 

if input.KeyCode == Enum.KeyCode.Q then -- Key bind to retract and pull out 

Dick = not Dick 

if not Dick then 

for i,hat in pairs(Hats) do 

HatsPosition[i].Position = Vector3.new(0,0,0) 

end 

else 

if Dick then 

for i,hat in pairs(Hats) do 

if Dick then 

if i == 1 then 

HatsPosition[i].Position = (CFrame.new(-0.55,-1.35,-1)).Position 

else 

if i == 2 then 

HatsPosition[i].Position = (CFrame.new(0.55,-1.35,-1)).Position 

else 

HatsPosition[i].Position = (CFrame.new(0,-1,(i - 2) * -1)).Position 

end 

end 

end 

end 

end 

end 

end 

end 

end) 

table.insert(Connections, Key) 

 

local ActivateNetless = true 





--[[Netless]]-- 

settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled 

settings().Physics.AllowSleep = false 

game.Players.LocalPlayer.ReplicationFocus = workspace 
 

for _,part in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do 

if part:IsA("BasePart") and part.Name ~="HumanoidRootPart" then 

Netless = game:GetService("RunService").Heartbeat:Connect(function() 

if ActivateNetless then 

part.Velocity = Vector3.new(-29.999,0,0) 

part.RotVelocity = Vector3.new(0,0,0) 

end 

end) 

table.insert(Connections, Netless) 

end 

end 



Character.Humanoid.Died:Connect(function() 

For index,connect in pairs(Connections) do 

connect:Disconnect() 

end 

end) 

 



game:GetService("StarterGui"):SetCore("SendNotification", { 



Title = "Notification"; 


Text = "Script by Atomic Scripter"; 



Icon = "rbxthumb://type=Asset&id=7317248129&w=150&h=150"}) 



Duration = 5;

