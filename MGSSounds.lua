--[[
 * KiwiItemInfo
 * 
 * MIT License
 * 
 * Copyright (c) 2017-2019 Cody Tilkins
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * 
--]]


if(MGSSounds_Vars == nil) then
	MGSSounds_Vars = {
		disable = false,
		combat = false,
		death = false,
		tradeopen = false,
		tradeshow = false,
		tradestop = false,
		lootopen = false,
		lootcollect = false,
		whisper = false
	}
	print("MGSSounds loaded! Welcome! Use `/mgssounds help` for commands.")
end

local mgsan = "Interface\\AddOns\\MGSSounds\\mgsan.mp3"
local mgsan_willplay, mgssan_handle

local mgsdeath = "Interface\\AddOns\\MGSSounds\\mgsdeath.mp3"
local mgsdeath_willplay, mgsdeath_handle

local mgsring = "Interface\\AddOns\\MGSSounds\\mgsring.mp3"
local mgsring_willplay, mgsring_handle

local mgsdrop = "Interface\\AddOns\\MGSSounds\\mgsdrop.mp3"
local mgsdrop_willplay, mgsdrop_handle

local mgspickup = "Interface\\AddOns\\MGSSounds\\mgspickup.mp3"
local mgspickup_willplay, mgspickup_handle

local mgsmail = "Interface\\AddOns\\MGSSounds\\mgsmail.mp3"
local mgsmail_willplay, mgsmail_handle

local mgsopen = "Interface\\AddOns\\MGSSounds\\mgsopen.mp3"
local mgsopen_willplay, mgsopen_handle


local MGSSounds = CreateFrame("Frame", "MGSSounds")
MGSSounds:RegisterEvent("ADDON_LOADED")
MGSSounds:RegisterEvent("PLAYER_REGEN_DISABLED")
MGSSounds:RegisterEvent("PLAYER_DEAD")
MGSSounds:RegisterEvent("TRADE_REQUEST")
MGSSounds:RegisterEvent("TRADE_SHOW")
MGSSounds:RegisterEvent("TRADE_REQUEST_CANCEL")
MGSSounds:RegisterEvent("LOOT_OPENED")
MGSSounds:RegisterEvent("LOOT_SLOT_CLEARED")
MGSSounds:RegisterEvent("CHAT_MSG_WHISPER")


function MGSSounds:Command(msg)
	
	-- split message into arguments
	local args = {string.split(" ", msg)}
	if(#args < 1) then
		print("Error: MGSSounds requires at least 1 argument")
		return
	end
	
	if(args[1] == "help") then
		print("-- MGSSounds Help --\nhelp - displays this message\ndisable - toggle disable of addon\ncombat - toggle disable of combat sound\ndeath - toggle disable of death sound\ntradeopen - toggle disable of trade open sound\ntradeshow - toggle disable of trade show sound\ntradestop - toggle disable of trade stop sound\nlootopen - toggle disable of loot open sound\nlootcollect - toggle disable of loot collection sound\nwhisper - toggle disable of whisper sound\n\n")
		return
	end
	
	if(args[1] == "disable") then
		MGSSounds_Vars.disable = !MGSSounds_Vars.disable
		return
	end
	
	if(args[1] == "death") then
		MGSSounds_Vars.death = !MGSSounds_Vars.death
		return
	end
	
	if(args[1] == "tradeopen") then
		MGSSounds_Vars.tradeopen = !MGSSounds_Vars.tradeopen
		return
	end
	
	if(args[1] == "tradeshow") then
		MGSSounds_Vars.tradeshow = !MGSSounds_Vars.tradeshow
		return
	end
	
	if(args[1] == "tradestop") then
		MGSSounds_Vars.tradestop = !MGSSounds_Vars.tradestop
		return
	end
	
	if(args[1] == "lootopen") then
		MGSSounds_Vars.lootopen = !MGSSounds_Vars.lootopen
		return
	end
	
	if(args[1] == "lootcollect") then
		MGSSounds_Vars.lootcollect = !MGSSounds_Vars.lootcollect
		return
	end
	
	if(args[1] == "whisper") then
		MGSSounds_Vars.whisper = !MGSSounds_Vars.whisper
		return
	end
	
end

function MGSSounds:ADDON_LOADED(addon)
	if(addon ~= "MGSSounds") then
		return
	end
	
	SlashCmdList["MGSSOUNDS_CMD"] = MGSSounds.Command
	SLASH_KIWIITEMINFO_CMD1 = "/mgssounds"
	
end

function MGSSounds:PLAYER_REGEN_DISABLED(event)
	if(MGSSounds_Vars.combat == true) then
		return
	end
	mgsan_willplay, mgssan_handle = PlaySoundFile(mgsan, "Master")
end

function MGSSounds:PLAYER_DEAD(event)
	if(MGSSounds_Vars.death == true) then
		return
	end
	mgsdeath_willplay, mgsdeath_handle = PlaySoundFile(mgsdeath, "Master")
end

function MGSSounds:TRADE_REQUEST(event)
	if(MGSSounds_Vars.tradeopen == true) then
		return
	end
	mgsring_willplay, mgsring_handle = PlaySoundFile(mgsring, "Master")
end

function MGSSounds:TRADE_SHOW(event)
	if(MGSSounds_Vars.tradeshow == true) then
		return
	end
	mgsopen_willplay, mgsopen_handle = PlaySoundFile(mgsopen, "Master")
	if(mgsring_handle == nil) then
		return
	end
	StopSound(mgsring_handle)
end

function MGSSounds:TRADE_REQUEST_CANCEL(event)
	if(MGSSounds_Vars.tradestop == true) then
		return
	end
	if(mgsring_handle == nil) then
		return
	end
	StopSound(mgsring_handle)
end

function MGSSounds:LOOT_OPENED(event)
	if(MGSSounds_Vars.lootopen == true) then
		return
	end
	mgsdrop_willplay, mgsdrop_handle = PlaySoundFile(mgsdrop, "Master")
end

function MGSSounds:LOOT_SLOT_CLEARED(event)
	if(MGSSounds_Vars.lootcollect == true) then
		return
	end
	mgspickup_willplay, mgspickup_handle = PlaySoundFile(mgspickup, "Master")
end

function MGSSounds:CHAT_MSG_WHISPER(event)
	if(MGSSounds_Vars.whisper == true) then
		return
	end
	mgsmail_willplay, mgsmail_handle = PlaySoundFile(mgsmail, "Master")
end


MGSSounds:SetScript("OnEvent", function(self, eventName, ...)
	if(MGSSounds_Vars.disable == true) then
		return
	end
	return self[eventName](self, eventName, ...)
end)

