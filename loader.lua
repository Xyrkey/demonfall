local anticheat = game.Workspace:FindFirstChild("DirtsAntiExploit")
if (anticheat) then
   anticheat:Destroy()
end


local player = game.Players.LocalPlayer

function processState(oldState, newState)
   local character = player.Character or player.CharacterAdded:Wait()
   local humanoid = character:WaitForChild("Humanoid")
   if (newState == Enum.HumanoidStateType.FallingDown or newState == Enum.HumanoidStateType.Ragdoll) then
       humanoid:ChangeState(Enum.HumanoidStateType.Running)
   end
end

function initialize()
   local character = player.Character or player.CharacterAdded:Wait()
   local humanoid = character:WaitForChild("Humanoid")
   humanoid.StateChanged:Connect(processState)
end

initialize()
player.CharacterAdded:Connect(initialize)



local player = game.Players.LocalPlayer

function dequip()
   for index, part in ipairs(player.Character:GetDescendants()) do
       if (part.ClassName == "Tool") then
           player.Character.Humanoid:UnequipTools()
           return(part)
       end
   end
   return(nil)
end

function eatfood()
   for index, part in ipairs(player.Backpack:GetChildren()) do
       if (part.Name == "Udon" or part.Name == "Bento") then
           player.Character.Humanoid:EquipTool(part)
           part.Rem:FireServer()
           return(nil)
       end
   end
end

function heal()
   tool = dequip()
   eatfood()
   
   if (tool ~= nil) then
       player.Character.Humanoid:EquipTool(tool)
   else
       player.Character.Humanoid:UnequipTools()
   end
end

_G.autoheal = true
while _G.autoheal do
   wait()
   if player.Character then
       if (player.Character.Humanoid.Health < 40) then
           heal()
           wait(2)
       end
   end
end


function collect()
   local root = game.Players.LocalPlayer.Character.HumanoidRootPart
   local parts = game.Workspace:GetDescendants()
   
   for index, part in ipairs(parts) do
       if (part.Name == "Giver") then
           firetouchinterest(root, part, 0)
           wait(0.25)
           firetouchinterest(root, part, 1)
       end
   end
end

while true do
   collect()
   wait(10)
end
