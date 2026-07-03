-- Sadece senin (veya admin yapmak istediğin arkadaşının) UserId'si
local Adminler = {
    [10519495369] = true,
    
}

game.Players.PlayerAdded:Connect(function(player)
    
    if Adminler[player.UserId] then
        
        
        player.Chatted:Connect(function(mesaj)
            local karakter = player.Character
            
            
            if mesaj:lower() == "!bring coal" then
                if karakter and karakter:FindFirstChild("HumanoidRootPart") then
                    local adminPozisyon = karakter.HumanoidRootPart.CFrame
                    local sayac = 0
                    
                    -- Haritadaki tüm nesneleri tarar
                    for _, obje in ipairs(workspace:GetDescendants()) do
                        
                        if obje.Name == "Coal" and obje:IsA("BasePart") then
                            
                            obje.CFrame = adminPozisyon + Vector3.new(0, 3, 0)
                            sayac = sayac + 1
                        end
                    end
                    
                    print("[Admin Abuse]: " .. sayac .. " adet kömür yanına getirildi!")
                end
            end
            
        end)
    end
end)
