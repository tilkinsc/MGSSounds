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


local soundFile1 = "Interface\\AddOns\\MGSSounds\\mgsan.mp3"
local soundFile2 = "Interface\\AddOns\\MGSSounds\\mgsdeath.mp3"

local MGSSounds = CreateFrame("Frame", "MGSSounds")
	MGSSounds:RegisterEvent("PLAYER_REGEN_DISABLED")
	MGSSounds:RegisterEvent("PLAYER_DEAD")

	MGSSounds:SetScript("OnEvent", function(self, eventName, ...)
		print(self, eventName, ...)
		return self[eventName](self, eventName, ...)
	end)

function MGSSounds:PLAYER_DEAD(event)
	PlaySoundFile(soundFile2, "Master")
end

function MGSSounds:PLAYER_REGEN_DISABLED(event)
	PlaySoundFile(soundFile1, "Master")
end

