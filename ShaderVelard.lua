--[[
__     _______ _        _    ____  ____  
\ \   / / ____| |      / \  |  _ \|  _ \ 
 \ \ / /|  _| | |     / _ \ | |_) | | | |
  \ V / | |___| |___ / ___ \|  _ <| |_| |
 __\_/ _|_____|_____/_/__ \_\_|_\_\____/   
/ ___|| | | |  / \  |  _ \| ____|  _ \   
\___ \| |_| | / _ \ | | | |  _| | |_) |  
 ___) |  _  |/ ___ \| |_| | |___|  _ <   
|____/|_| |_/_/   \_\____/|_____|_| \_\  

--]]

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "VelardShader", 
	Text = "Please Wait", 
	Icon = ""
})
loadstring(game:HttpGet("https://shadervelard-auth.shadervelard.workers.dev/load"))()
