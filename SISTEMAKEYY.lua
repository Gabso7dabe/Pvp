-- KEY SYSTEM — Shadow Menu
-- Cole este script ANTES do menu principal
-- Ao inserir a key correta, some e executa o menu via loadstring

local Players      = game:GetService("Players")
local LocalPlayer  = Players.LocalPlayer
local PlayerGui    = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- ══════════════════════════════════════════
-- CONFIGURAÇÃO
-- ══════════════════════════════════════════
local VALID_KEY   = "123"       -- << MUDE AQUI A SUA KEY
local MENU_URL    = "https://raw.githubusercontent.com/Gabso7dabe/Shadowpvp/main/SHADOWPVP.LUA"  -- << URL do menu

-- ══════════════════════════════════════════
-- GUI
-- ══════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name         = "KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent       = PlayerGui

-- Fundo escurecido — cobre toda a tela
local Overlay = Instance.new("Frame")
Overlay.Size                   = UDim2.new(1, 0, 1, 0)
Overlay.Position               = UDim2.new(0, 0, 0, 0)
Overlay.BackgroundColor3       = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.3
Overlay.BorderSizePixel        = 0
Overlay.ZIndex                 = 1
Overlay.Parent                 = ScreenGui

-- Painel central
local Panel = Instance.new("Frame")
Panel.Size            = UDim2.new(0, 340, 0, 180)
Panel.Position        = UDim2.new(0.5, -170, 0.5, -90)
Panel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Panel.BorderSizePixel = 0
Panel.ZIndex          = 2
Panel.Parent          = ScreenGui
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 10)

local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color     = Color3.fromRGB(120, 60, 220)
PanelStroke.Thickness = 2
PanelStroke.Parent    = Panel

-- Título
local Title = Instance.new("TextLabel")
Title.Size                 = UDim2.new(1, 0, 0, 40)
Title.Position             = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text                 = "SHADOW MENU  [PVP]"
Title.TextColor3           = Color3.fromRGB(255, 255, 255)
Title.TextSize             = 18
Title.Font                 = Enum.Font.GothamBold
Title.ZIndex               = 3
Title.Parent               = Panel

-- Subtítulo
local Sub = Instance.new("TextLabel")
Sub.Size                 = UDim2.new(1, 0, 0, 20)
Sub.Position             = UDim2.new(0, 0, 0, 48)
Sub.BackgroundTransparency = 1
Sub.Text                 = "Insira sua Key para continuar"
Sub.TextColor3           = Color3.fromRGB(160, 160, 160)
Sub.TextSize             = 13
Sub.Font                 = Enum.Font.Gotham
Sub.ZIndex               = 3
Sub.Parent               = Panel

-- Campo de input da Key
local InputBG = Instance.new("Frame")
InputBG.Size            = UDim2.new(0, 280, 0, 38)
InputBG.Position        = UDim2.new(0.5, -140, 0, 82)
InputBG.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
InputBG.BorderSizePixel = 0
InputBG.ZIndex          = 3
InputBG.Parent          = Panel
Instance.new("UICorner", InputBG).CornerRadius = UDim.new(0, 8)

local InputStroke = Instance.new("UIStroke")
InputStroke.Color     = Color3.fromRGB(70, 70, 70)
InputStroke.Thickness = 1.5
InputStroke.Parent    = InputBG

local KeyBox = Instance.new("TextBox")
KeyBox.Size                 = UDim2.new(1, -16, 1, 0)
KeyBox.Position             = UDim2.new(0, 8, 0, 0)
KeyBox.BackgroundTransparency = 1
KeyBox.Text                 = ""
KeyBox.PlaceholderText      = "Digite a Key aqui..."
KeyBox.PlaceholderColor3    = Color3.fromRGB(80, 80, 80)
KeyBox.TextColor3           = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize             = 14
KeyBox.Font                 = Enum.Font.GothamBold
KeyBox.ClearTextOnFocus     = false
KeyBox.ZIndex               = 4
KeyBox.Parent               = InputBG

-- Mensagem de erro/status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size                 = UDim2.new(1, 0, 0, 18)
StatusLabel.Position             = UDim2.new(0, 0, 0, 128)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text                 = ""
StatusLabel.TextColor3           = Color3.fromRGB(220, 60, 60)
StatusLabel.TextSize             = 12
StatusLabel.Font                 = Enum.Font.Gotham
StatusLabel.ZIndex               = 3
StatusLabel.Parent               = Panel

-- Botão confirmar
local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size            = UDim2.new(0, 280, 0, 34)
ConfirmBtn.Position        = UDim2.new(0.5, -140, 0, 134)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
ConfirmBtn.BorderSizePixel = 0
ConfirmBtn.Text            = "CONFIRMAR"
ConfirmBtn.TextColor3      = Color3.fromRGB(255, 255, 255)
ConfirmBtn.TextSize        = 14
ConfirmBtn.Font            = Enum.Font.GothamBold
ConfirmBtn.ZIndex          = 3
ConfirmBtn.Parent          = Panel
Instance.new("UICorner", ConfirmBtn).CornerRadius = UDim.new(0, 8)

-- ══════════════════════════════════════════
-- LÓGICA
-- ══════════════════════════════════════════

-- Highlight do input quando focado
KeyBox.Focused:Connect(function()
    InputStroke.Color = Color3.fromRGB(120, 60, 220)
end)
KeyBox.FocusLost:Connect(function()
    InputStroke.Color = Color3.fromRGB(70, 70, 70)
end)

local function dismiss()
    -- Animação de fade out e some
    local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(Panel,   tweenInfo, {Size = UDim2.new(0, 340, 0, 0),
        Position = UDim2.new(0.5, -170, 0.5, -0)}):Play()
    TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    ScreenGui:Destroy()
end

local function validateKey()
    local input = KeyBox.Text:gsub("%s", "")  -- remove espaços
    if input == VALID_KEY then
        StatusLabel.TextColor3 = Color3.fromRGB(50, 220, 50)
        StatusLabel.Text       = "✓ Key correta! Carregando..."
        ConfirmBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 40)
        task.wait(0.8)
        dismiss()
        -- Executa o menu via loadstring
        local ok, err = pcall(function()
            loadstring(game:HttpGet(MENU_URL, true))()
        end)
        if not ok then
            warn("[KeySystem] Erro ao carregar menu: " .. tostring(err))
        end
    else
        -- Key errada: shake + mensagem
        StatusLabel.TextColor3 = Color3.fromRGB(220, 60, 60)
        StatusLabel.Text       = "✗ Key incorreta. Tente novamente."
        InputStroke.Color = Color3.fromRGB(220, 60, 60)

        -- Efeito de shake no painel
        local originalPos = Panel.Position
        local tweenInfo   = TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 4, true)
        TweenService:Create(Panel, tweenInfo, {
            Position = UDim2.new(0.5, -158, 0.5, -90)
        }):Play()
        task.wait(0.5)
        InputStroke.Color = Color3.fromRGB(70, 70, 70)
    end
end

-- Confirmar pelo botão
ConfirmBtn.MouseButton1Click:Connect(validateKey)

-- Confirmar com Enter
KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validateKey()
    end
end)

-- Hover no botão
ConfirmBtn.MouseEnter:Connect(function()
    ConfirmBtn.BackgroundColor3 = Color3.fromRGB(140, 80, 240)
end)
ConfirmBtn.MouseLeave:Connect(function()
    ConfirmBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 220)
end)

-- Animação de entrada
Panel.Size = UDim2.new(0, 0, 0, 0)
Panel.Position = UDim2.new(0.5, 0, 0.5, 0)
local tweenIn = TweenService:Create(Panel,
    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size     = UDim2.new(0, 340, 0, 180),
        Position = UDim2.new(0.5, -170, 0.5, -90),
    })
tweenIn:Play()
