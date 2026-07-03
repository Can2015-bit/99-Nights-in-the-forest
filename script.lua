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
                    
                    for _, obje in ipairs(workspace:GetDescendants()) do
                        -- image_e85d49.png dosyasındaki gibi Model olan Coal'ları yakalıyoruz
                        if obje.Name == "Coal" and obje:IsA("Model") then
                            obje:PivotTo(adminPozisyon + Vector3.new(0, 3, 0))
                            sayac = sayac + 1
                        end
                    end
                    
                    print("[Admin Abuse]: " .. sayac .. " adet kömür modeli yanına getirildi!")
                end
            end
            
        end)
    end
end)
