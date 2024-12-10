local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Orion Library Example",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ExampleConfig",
    IntroEnabled = true,
    IntroText = "Welcome to Orion Library",
    Icon = "rbxassetid://4483345998"
})

-- Creating a Tab
local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Adding a Section
local MainSection = MainTab:AddSection({
    Name = "UI Elements"
})

-- Adding a Button
MainTab:AddButton({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end    
})

-- Adding a Toggle
local Toggle = MainTab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Flag = "FeatureToggle", -- For saving in configs
    Save = true, -- Enable saving
    Callback = function(value)
        print("Toggle is now:", value)
    end    
})

-- Adding a Color Picker
local ColorPicker = MainTab:AddColorpicker({
    Name = "Pick a Color",
    Default = Color3.fromRGB(255, 0, 0),
    Flag = "ColorFlag", -- For saving in configs
    Save = true, -- Enable saving
    Callback = function(value)
        print("Selected Color:", value)
    end          
})

-- Adding a Slider
local Slider = MainTab:AddSlider({
    Name = "Adjust Value",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 5,
    ValueName = "Points",
    Flag = "SliderFlag", -- For saving in configs
    Save = true, -- Enable saving
    Callback = function(value)
        print("Slider Value:", value)
    end    
})

-- Adding a Label
local Label = MainTab:AddLabel("This is a Label")

-- Adding a Paragraph
local Paragraph = MainTab:AddParagraph("Paragraph Title", "This is the content of the paragraph.")

-- Adding an Adaptive Input (Textbox)
MainTab:AddTextbox({
    Name = "Enter Text",
    Default = "Hello World",
    TextDisappear = true,
    Callback = function(value)
        print("Textbox Input:", value)
    end          
})

-- Adding a Keybind
MainTab:AddBind({
    Name = "Keybind",
    Default = Enum.KeyCode.E,
    Hold = false,
    Flag = "KeybindFlag", -- For saving in configs
    Save = true, -- Enable saving
    Callback = function()
        print("Keybind Pressed!")
    end    
})

-- Adding a Dropdown
local Dropdown = MainTab:AddDropdown({
    Name = "Select an Option",
    Default = "Option 1",
    Options = {"Option 1", "Option 2", "Option 3"},
    Flag = "DropdownFlag", -- For saving in configs
    Save = true, -- Enable saving
    Callback = function(value)
        print("Selected Option:", value)
    end    
})

-- Adding a Notification
OrionLib:MakeNotification({
    Name = "Welcome!",
    Content = "This is an example notification.",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Finish the script
OrionLib:Init()
