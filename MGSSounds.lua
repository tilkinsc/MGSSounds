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
MGSSounds:RegisterEvent("PLAYER_REGEN_DISABLED")
MGSSounds:RegisterEvent("PLAYER_DEAD")
MGSSounds:RegisterEvent("TRADE_REQUEST")
MGSSounds:RegisterEvent("TRADE_SHOW")
MGSSounds:RegisterEvent("TRADE_REQUEST_CANCEL")
MGSSounds:RegisterEvent("LOOT_OPENED")
MGSSounds:RegisterEvent("LOOT_SLOT_CLEARED")
MGSSounds:RegisterEvent("CHAT_MSG_WHISPER")


MGSSounds:SetScript("OnEvent", function(self, eventName, ...)
	return self[eventName](self, eventName, ...)
end)



function MGSSounds:PLAYER_REGEN_DISABLED(event)
	mgsan_willplay, mgssan_handle = PlaySoundFile(mgsan, "Master")
end

function MGSSounds:PLAYER_DEAD(event)
	mgsdeath_willplay, mgsdeath_handle = PlaySoundFile(mgsdeath, "Master")
end

function MGSSounds:TRADE_REQUEST(event)
	mgsring_willplay, mgsring_handle = PlaySoundFile(mgsring, "Master")
end

function MGSSounds:TRADE_SHOW(event)
	mgsopen_willplay, mgsopen_handle = PlaySoundFile(mgsopen, "Master")
	if(mgsring_handle == nil) then
		return
	end
	StopSound(mgsring_handle)
end

function MGSSounds:TRADE_REQUEST_CANCEL(event)
	if(mgsring_handle == nil) then
		return
	end
	StopSound(mgsring_handle)
end

function MGSSounds:LOOT_OPENED(event)
	mgsdrop_willplay, mgsdrop_handle = PlaySoundFile(mgsdrop, "Master")
end

function MGSSounds:LOOT_SLOT_CLEARED(event)
	mgspickup_willplay, mgspickup_handle = PlaySoundFile(mgspickup, "Master")
end

function MGSSounds:CHAT_MSG_WHISPER(event)
	mgsmail_willplay, mgsmail_handle = PlaySoundFile(mgsmail, "Master")
end
