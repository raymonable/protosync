-- ProtoSYNC for v1.0.0

if not plugin:GetSetting('RunBefore') then
	plugin:SetSetting('RunBefore', true)
	print('Welcome to ProtoSYNC!')
end
local port = plugin:GetSetting('ProtoPORT')
if not port then
	plugin:SetSetting('ProtoPORT', 4400)
	print('ProtoPORT has been set to 4400. This can\'t be changed later.')
end

local tunnelinfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, true, false, 150, 150, 150, 150)
local tunnelwidget = plugin:CreateDockWidgetPluginGui("TestWidget", tunnelinfo)
tunnelwidget.Title = "Tunnel URL"

local tunneltext = Instance.new('TextBox', tunnelwidget)
tunneltext.Size = UDim2.new(1, 0, 0.85, 0)
tunneltext.Position = UDim2.new(0, 0, 0.15, 0)
tunneltext.Font = Enum.Font.GothamSemibold
tunneltext.ClearTextOnFocus = false
tunneltext.TextEditable = false
tunneltext.Selectable = true
tunneltext.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
tunneltext.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
tunneltext.BorderSizePixel = 0
tunneltext.Parent = tunnelwidget
tunneltext.Text = "Unable to fetch"
tunneltext.TextSize = 16
tunneltext.TextWrapped = true

local tunneldesc = Instance.new('TextLabel', tunnelwidget)
tunneldesc.Size = UDim2.new(1, 0, 0.15, 0)
tunneldesc.Position = UDim2.new(0, 0, 0, 0)
tunneldesc.Font = Enum.Font.GothamSemibold
tunneldesc.TextSize = 10
tunneldesc.TextWrapped = true
tunneldesc.Parent = tunnelwidget
tunneldesc.Text = "Here's your tunneled URL!"
tunneldesc.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
tunneldesc.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)

tunneldesc.BorderSizePixel = 0
tunnelwidget.Enabled = false

local http = game:GetService('HttpService')
local toolbar = plugin:CreateToolbar("ProtoSYNC")
local btn = toolbar:CreateButton('Sync To Game', 'Syncs the selected script to the ProtoSYNC server', 'rbxassetid://5650881780')
local url = toolbar:CreateButton('Fetch Tunnel URL', 'Get the URL for the tunnel server', 'rbxassetid://2038225630')
btn.ClickableWhenViewportHidden = true
btn.Click:Connect(function()
	local selection = game:GetService('Selection'):Get()
	if selection[1] ~= nil then
		if selection[1]:IsA('Script') == false then
			print('ProtoSYNC: Can\'t sync something that isn\'t a script!')
			return
		end
		print('ProtoSYNC: Syncing '..selection[1].Name)
		local success, data = pcall(function()
			return http:PostAsync('http://localhost:4400/plugin', http:JSONEncode({
				script = selection[1].Source,
				pwd = 'super roblox'
			}))
		end)
		if success then
			print('ProtoSYNC: Successfully synced.')
		else
			print('Unable to sync: '..data)
		end
	else
		print('ProtoSYNC: Something went wrong. Try again later.')
	end
	btn.Enabled = false
	wait()
	btn.Enabled = true
end)
url.ClickableWhenViewportHidden = true
url.Click:Connect(function()
	local success, data = pcall(function()
		return http:GetAsync('http://localhost:4400/tunnel')
	end)
	if success then
		print('ProtoSYNC: Got URL.')
		tunneltext.Text = data
		tunnelwidget.Enabled = true
	else
		print('Unable to fetch URL: '..data)
	end
	url.Enabled = false
	wait()
	url.Enabled = true
end)
