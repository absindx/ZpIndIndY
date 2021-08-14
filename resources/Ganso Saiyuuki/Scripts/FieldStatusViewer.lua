--------------------------------------------------
-- Ganso Saiyuuki - Super Monkey Daibouken
--   Field status viewer for Mesen 0.9.9
--------------------------------------------------

--------------------------------------------------
-- Address
--------------------------------------------------

local pageXAddress		= 0x00BE	-- Byte
local pageYAddress		= 0x00BC	-- Byte
local chipXAddress		= 0x00D1	-- Byte
local chipYAddress		= 0x00D2	-- Byte
local cameraXAddress		= 0x0057	-- Word
local cameraYAddress		= 0x0059	-- Word
local timeAddress		= 0x03D4	-- Word
local processStateAddress	= 0x003D	-- Byte
local lagFrameDetectionAddress	= 0xBA1B	-- PRG Pointer



--------------------------------------------------
-- Setting
--------------------------------------------------

local screenWidth	= 256
local screenHeight	= 240
local drawHeight	= 12 * 16

local PageLineColor1	= 0xA0FFFFFF
local PageLineColor2	= 0x80008040

local PageWidth		= 16
local PageWidthPixel	= PageWidth * 16
local PageHeight	= 12
local PageHeightPixel	= PageHeight * 16

local CameraHeight	= 15

local drawPageXLineOffset	= 8
local drawPageXLineOffsetPixel	= drawPageXLineOffset * 16
local drawPageYLineOffset	= 6
local drawPageYLineOffsetPixel	= drawPageYLineOffset * 16



--------------------------------------------------
-- Utility
--------------------------------------------------

local function ReadByte(addr)
	return emu.read(addr, emu.memType.cpu)
end
local function ReadWordLittleEndian(addr)
	local low	= emu.read(addr, emu.memType.cpu)
	local high	= emu.read(addr + 1, emu.memType.cpu)
	return (high << 8) | low
end
local function ReadWordBigEndian(addr)
	local low	= emu.read(addr + 1, emu.memType.cpu)
	local high	= emu.read(addr, emu.memType.cpu)
	return (high << 8) | low
end
local ReadWord	= ReadWordLittleEndian	-- alias

local function SelectBoolean(bool, valueTrue, valueFalse)
	if(bool)then
		return valueTrue
	else
		return valueFalse
	end
end



--------------------------------------------------
-- String draw system
--------------------------------------------------

local stringColor		= 0x00FFFFFF
local stringBackgroundColor	= 0x80000000
local stringBaseXPosition	= 1
local stringBaseYPosition	= 1
local drawStringYPosition

local function resetDrawStringPosition()
	drawStringYPosition	= stringBaseYPosition
end
local function drawString(format, ...)
	local str	= string.format(format, ...)
	emu.drawString(stringBaseXPosition, drawStringYPosition, str, stringColor, stringBackgroundColor)
	drawStringYPosition	= drawStringYPosition + 9
end



--------------------------------------------------
-- Game utility
--------------------------------------------------

local function GetFieldPosition()
	local x	= (ReadByte(pageXAddress) << 8) | ReadByte(chipXAddress)
	local y	= (ReadByte(pageYAddress) << 8) | ReadByte(chipYAddress)
	return x, y
end
local function GetAllChipY()
	return ReadByte(pageYAddress) * PageHeight + ReadByte(chipYAddress)
end

local function GetNormalizedCameraX()
	local camX	= ReadWord(cameraXAddress)
	return camX & 0xFF
end
local function GetNormalizedCameraY()
	local camY	= ReadWord(cameraYAddress)
	if(camY >= 0xF0)then
		camY	= (camY + 0xF0) & 0xFF
	end
	return camY
end



--------------------------------------------------
-- Draw
--------------------------------------------------

local function DrawPageLineVertical(x)
	emu.drawLine(x - 1, 0, x - 1, drawHeight, PageLineColor2)
	emu.drawLine(x    , 0, x    , drawHeight, PageLineColor1)
	emu.drawLine(x + 1, 0, x + 1, drawHeight, PageLineColor2)
end
local function DrawPageLineHorizontal(y)
	emu.drawLine(0, y - 1, screenWidth, y - 1, PageLineColor2)
	emu.drawLine(0, y    , screenWidth, y    , PageLineColor1)
	emu.drawLine(0, y + 1, screenWidth, y + 1, PageLineColor2)
end

local function DrawPageNumber(px, py, dx, dy)
	local drawOffset	= 2
	emu.drawString(dx + drawOffset, dy + drawOffset, string.format("%02X,%02X", px, py), PageLineColor1, PageLineColor2)
end

--------------------------------------------------

local isLagFrame	= false

local function drawStatus()
	emu.clearScreen()
	resetDrawStringPosition()

	local posX, posY	= GetFieldPosition()
	local camX, camY	= ReadWord(cameraXAddress), ReadWord(cameraYAddress)

	-- Page lines
	local pageLineX		= (drawPageXLineOffsetPixel - GetNormalizedCameraX()) % PageWidthPixel
	local pageLineY		= ((PageHeight + drawPageYLineOffset - (posY & 0x0F)) % PageHeight * 16) % PageHeightPixel - (camY & 0x0F)
	local pageLineXPage	= posX // 256
	local pageLineYPage	= posY // 256
	if(((GetAllChipY() % CameraHeight) * 16 > camY) or (((GetAllChipY() % CameraHeight) == 0) and (GetNormalizedCameraY() > ((CameraHeight - 1) * 16))))then
		pageLineY	= pageLineY + 16
	end
	if((GetNormalizedCameraX() & 0xFF) > drawPageXLineOffsetPixel)then
		pageLineXPage	= pageLineXPage + 1
	end
	if((GetNormalizedCameraY() & 0xFF) > drawPageYLineOffsetPixel)then
		pageLineYPage	= pageLineYPage + 1
	end

	pageLineYPage	= ((GetAllChipY() + drawPageYLineOffset - 1) // PageHeight)
	
	DrawPageLineVertical  (pageLineX)
	DrawPageLineHorizontal(pageLineY)
	DrawPageNumber(pageLineXPage, pageLineYPage, pageLineX, pageLineY)

	-- Draw status
	drawString("Pos : (%04X, %04X)", posX, posY)
	drawString("Cam : (%04X, %04X)", camX, camY)
	drawString("Time : %04X", ReadWord(timeAddress))
	drawString("State : %02X%s", ReadByte(processStateAddress), SelectBoolean(isLagFrame, "*", ""))

	-- Clear status
	isLagFrame	= false
end

local function lagFrameDetect()
	isLagFrame	= true
end



--------------------------------------------------
-- Register event
--------------------------------------------------

emu.addEventCallback(drawStatus, emu.eventType.endFrame)
emu.addMemoryCallback(lagFrameDetect, emu.memCallbackType.cpuExec, lagFrameDetectionAddress)


