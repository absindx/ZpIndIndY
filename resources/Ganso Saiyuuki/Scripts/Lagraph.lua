--------------------------------------------------
-- Ganso Saiyuuki - Super Monkey Daibouken
--   Lag frame viewer for Mesen 0.9.9
--------------------------------------------------

--------------------------------------------------
-- Address
--------------------------------------------------

local fieldLoopAddress	= 0xB7D4
local nmiAddress	= 0xADF9
local lagFrameAddress	= 0xBA1B

--------------------------------------------------
-- Setting
--------------------------------------------------

local screenWidth	= 256
local screenHeight	= 240
local drawHeight	= (32 * 2) + 2

--------------------------------------------------
-- Draw
--------------------------------------------------

local textWidth		= 6
local textHeight	= 10
local frameDigit	= 2
local maxLog		= screenWidth - textWidth * frameDigit - 2
local rectY		= screenHeight - drawHeight
local graphY		= screenHeight - 2
local textLog		= math.floor(drawHeight / textHeight)

local colors		= {0x40FF9153, 0x00D2200E}
--local colors		= {0x40FF9153, 0x405391FF}

--------------------------------------------------

local unpack	= unpack	or table.unpack
local function drawLog(log)
	local n		= #log
	local dn	= math.max(n, textWidth * 2)

	local drawLine		= emu.drawLine
	local drawString	= emu.drawString
	local drawPixel		= emu.drawPixel
	local format		= string.format

	emu.clearScreen()

	-- text log
	for i=1,textLog do
		local v	= log[n - i + 1]
		if(not v)then
			break
		end
		drawString(0, screenHeight - i * textHeight, format("%2d", #v), 0xFFFFFF, 0x80000000, 0)
	end

	-- graph
	local rectX	= screenWidth - 2 - dn
	local centerY	= math.floor((rectY + screenHeight) / 2)

	emu.drawRectangle(rectX + 1, rectY, dn, drawHeight, 0x80000000, true, 0)
	emu.drawRectangle(rectX, rectY, dn + 2, drawHeight, 0x00FFFFFF, false, 0)
	emu.drawLine(rectX + 1, centerY, screenWidth - 2, centerY, 0x80FFFFFF, 0)

	drawString(rectX + 2, rectY + 2, "64", 0xFFFFFF, 0xFF000000, 0)
	drawString(rectX + 2, screenHeight - (drawHeight / 2) - textHeight + 1, "32", 0xFFFFFF, 0xFF000000, 0)
	drawString(rectX + 2, screenHeight - textHeight, " 0", 0xFFFFFF, 0xFF000000, 0)

	for i=1,n do
		local l = log[n - i + 1]
		local x	= screenWidth - i - 1
		for j=1,#l do
			local y	= screenHeight - j - 1
			drawPixel(x, y, colors[l[j]])
		end
	end
end

--------------------------------------------------
-- Logging
--------------------------------------------------

local frameLog		= {}

local function pushFrame(f)
	-- 1 = Normal
	-- 2 = Lag
	local l	= frameLog[#frameLog]	or {}
	l[#l + 1]	= f
end
local function fieldLoop()
	local n	= #frameLog - maxLog
	for i=1,n do
		table.remove(frameLog, 1)
	end
	frameLog[#frameLog + 1]	= {}
end
local function nmiFrame()
	pushFrame(1)
	drawLog(frameLog)
end
local function lagFrame()
	pushFrame(2)
	drawLog(frameLog)
end

emu.addMemoryCallback(fieldLoop, emu.memCallbackType.cpuExec, fieldLoopAddress)
emu.addMemoryCallback(nmiFrame, emu.memCallbackType.cpuExec, nmiAddress)
emu.addMemoryCallback(lagFrame, emu.memCallbackType.cpuExec, lagFrameAddress)
