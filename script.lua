-- ==========================================
-- TÜMÜ BİR ARADA ADMIN GUI & KÖMÜR IŞINLAMA
-- ==========================================

local ReplicatedStorage = game:GetService("GetService" and "ReplicatedStorage")
local Players = game:GetService("Players")

-- 1. UZAKTAN TETİKLEME (REMOTE EVENT) OLUŞTURMA
local KomurEtkinligi = ReplicatedStorage:FindFirstChild("KomurEtkinligi")
if not KomurEtkinligi then
	KomurEtkinligi = Instance.new("RemoteEvent")
	KomurEtkinligi.Name = "KomurEtkinligi"
	KomurEtkinligi.Parent = ReplicatedStorage
end

-- Sadece kurucuya (sana) yetki veriyoruz
local Adminler = {
	[game.CreatorId] = true,
}

-- 2. SUNUCU TARAFI: BUTONA BASILINCA KÖMÜRLERİ GETİREN KOD
KomurEtkinligi.OnServerEvent:Connect(function(player)
	if Adminler[player.UserId] then
		local karakter = player.Character
		if karakter and karakter:FindFirstChild("HumanoidRootPart") then
			local adminPozisyon = karakter.HumanoidRootPart.CFrame
			local sayac = 0
			
			-- Haritadaki tüm Coal modellerini bulup ışınlar
			for _, obje in ipairs(workspace:GetDescendants()) do
				if obje.Name == "Coal" and obje:IsA("Model") then
					obje:PivotTo(adminPozisyon + Vector3.new(0, 4, 0))
					sayac = sayac + 1
				end
			end
			print("[Admin GUI]: " .. sayac .. " adet kömür modeli getirildi!")
		end
	end
end)

-- 3. ARAYÜZ TARAFI: OYUNA GİREN ADMİNE OTOMATİK BUTON ÇİZEN KOD
Players.PlayerAdded:Connect(function(player)
	if Adminler[player.UserId] then
		
		-- Oyuncunun ekran arayüzü klasörünü bul
		local playerGui = player:WaitForChild("PlayerGui")
		
		-- ScreenGui Oluştur
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "AdminAbuseGui"
		screenGui.ResetOnSpawn = false -- Karakter ölünce buton ekrandan gitmesin
		screenGui.Parent = playerGui
		
		-- Bring Coal Butonunu Oluştur
		local buton = Instance.new("TextButton")
		buton.Name = "BringCoalButton"
		buton.Size = UDim2.new(0, 180, 0, 50)          -- Buton boyutu
		buton.Position = UDim2.new(0, 20, 0.5, -25)     -- Ekranın sol ortasında durur
		buton.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Koyu gri arka plan
		buton.TextColor3 = Color3.fromRGB(255, 215, 0)     -- Altın sarısı yazı
		buton.Text = "Bring Coal"
		buton.TextSize = 20
		buton.Font = Enum.Font.SourceSansBold
		buton.BorderSizePixel = 2
		buton.Parent = screenGui
		
		-- Buton Köşelerini Yuvarlama (Havalı dursun diye)
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 8)
		uiCorner.Parent = buton
		
		-- Butona tıklama algısını yöneten LocalScript'i dinamik olarak oluşturuyoruz
		local localScript = Instance.new("LocalScript")
		localScript.Name = "ButtonHandler"
		localScript.Source = [[
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local KomurEtkinligi = ReplicatedStorage:WaitForChild("KomurEtkinligi")
			local buton = script.Parent

			buton.MouseButton1Click:Connect(function()
				-- Sunucuya sinyal gönder
				KomurEtkinligi:FireServer()
			end)
		]]
		localScript.Parent = buton
	end
end)
