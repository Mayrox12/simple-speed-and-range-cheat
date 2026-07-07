local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

local Premium = player:WaitForChild("Premium", 10)
local Perks = player:WaitForChild("Perks", 10)

-- Ui setup
local screenGui = Instance.new("ScreenGui", pGui)
screenGui.Name = "ModMenuGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 180, 0, 140)
frame.Position = UDim2.new(1, -200, 1, -160)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center

local function createBtn(text)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 160, 0, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    return btn
end

local btnSpeedX2 = createBtn("Speed X2: OFF")
local btnMagnet = createBtn("Magnet: OFF")
local btnSpeed175 = createBtn("Speed 175: OFF")

local function setBtnState(btn, name, isOn)
    btn.Text = name .. ": " .. (isOn and "ON" or "OFF")
    btn.BackgroundColor3 = isOn and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end

-- Speed X2
if Premium then
    local SpeedX2 = Premium:FindFirstChild("SpeedX2")
    if SpeedX2 then
        local function checkSpeedX2()
            local isOn = (SpeedX2.Value == true or SpeedX2.Value == 2)
            setBtnState(btnSpeedX2, "Speed X2", isOn)
        end
        SpeedX2.Changed:Connect(checkSpeedX2)
        checkSpeedX2()

        btnSpeedX2.MouseButton1Click:Connect(function()
            local currentOn = (SpeedX2.Value == true or SpeedX2.Value == 2)
            if SpeedX2:IsA("BoolValue") then
                SpeedX2.Value = not currentOn
            elseif SpeedX2:IsA("NumberValue") then
                SpeedX2.Value = currentOn and 0 or 2
            end
        end)
    end
end

-- Magnet 
if Perks then
    local Magnes = Perks:FindFirstChild("Magnes")
    if not Magnes then
        Magnes = Instance.new("BoolValue")
        Magnes.Name = "Magnes"
        Magnes.Value = false
        Magnes.Parent = Perks
    end

    local function checkMagnes()
        setBtnState(btnMagnet, "Magnet", Magnes.Value)
    end
    Magnes.Changed:Connect(checkMagnes)
    checkMagnes()

    btnMagnet.MouseButton1Click:Connect(function()
        Magnes.Value = not Magnes.Value
    end)
end

-- Speed 175
if Perks then
    local Speed175 = Perks:FindFirstChild("Speed175")
    if Speed175 then
        local function checkSpeed175()
            setBtnState(btnSpeed175, "Speed 175", Speed175.Value)
        end
        Speed175.Changed:Connect(checkSpeed175)
        checkSpeed175()

        btnSpeed175.MouseButton1Click:Connect(function()
            Speed175.Value = not Speed175.Value
        end)
    end
end
