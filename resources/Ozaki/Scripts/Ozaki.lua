--------------------------------------------------
-- Jumbo Ozaki no Hole in One Professional
--   Status viewer for Mesen 0.9.9
--------------------------------------------------

--------------------------------------------------
-- Address
--------------------------------------------------

RandomBuffer		= 0x0032
Difficulty		= 0x0038
CourseType		= 0x0039
HoleNumber		= 0x003A
HoleIndex		= 0x003B
CapXPosition		= 0x0052
CapYPosition		= 0x0054
BallXPosition		= 0x0062
BallYPosition		= 0x0065
BaseWindDirection	= 0x003E
BaseWindVolume		= 0x003F

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

--------------------------------------------------
-- String draw system
--------------------------------------------------

local stringColor		= 0x00FFFFFF
local stringBackgroundColor	= 0x80000000
local stringBaseXPosition	= 0
local stringBaseYPosition	= 0
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
-- Ozaki RNG
--------------------------------------------------

local function GenerateRandomPool(seed)
	local i2r	= {}	-- index -> rand
	local r2i	= {}	-- rand -> index
	local start	= seed
	local index	= 1

	repeat
		i2r[index]	= seed
		r2i[seed]	= index
		index		= index + 1

		-- generate next RNG
		for i=1,11 do
			local t	= (seed >> 15) ~ (seed >> 1) ~ (seed)
			seed	= (seed << 1) | (~t & 1)
			seed	= seed & 0xFFFF
		end
	until(seed == start)

	return i2r, r2i
end

local RandomPool_Index_Long, RandomPool_Rand_Long	= GenerateRandomPool(0x0000)
local RandomPool_Index_Short, RandomPool_Rand_Short	= GenerateRandomPool(0x5555)
local randomValue	= 0x0000

local function GetRandomIndex(value)
	return RandomPool_Rand_Long[value] or -RandomPool_Rand_Short[value]	-- short cycle : invert (minus index)
end

local function GetNextRandom(value)
	local index	= RandomPool_Rand_Long[value]
	if(index)then
		index	= (index % #RandomPool_Index_Long) + 1
		return RandomPool_Index_Long[index]
	else
		index	= (RandomPool_Rand_Short[value] % #RandomPool_Index_Short) + 1
		return RandomPool_Index_Short[index]
	end
end

--------------------------------------------------
-- Ozaki utility
--------------------------------------------------

ReadPosition	= ReadWordLittleEndian
local function ReadBallYPosition()
	-- 3bytes position
	local low	= ReadPosition(BallYPosition)
	local high	= ReadByte(BallYPosition + 2)
	return (high << 16) | low
end
local function PositionToDex(pos)
	return pos / 32
end

local CourseNames	= {
	[0]	= "East",
	[1]	= "West",
}
local function GetCourseName()
	return CourseNames[ReadByte(CourseType)]	or "???"
end

local windAdd	= {0, 0, -1, 0, 0, 1, 1, 2}
local windMax	= {6, 10, 13}
local windName	= {"N", "NE", "E", "SE", "S", "SW", "W", "NW"}
local function GetWind(difficulty, baseDir, baseVol, rand)
	local nextRand	= GetNextRandom(rand)
	local dir	= baseDir
	local vol	= baseVol + windAdd[(nextRand & 7) + 1]

	if(vol >= 0)then
		local max	= windMax[difficulty + 1]	or windMax[1]
		while(vol >= max)do
			vol	= vol - 5
		end
		return windName[dir + 1], vol
	else
		dir	= dir ~ 0x04
		return windName[dir + 1], 1
	end
end
local function GetNextWind(rand)
	local difficulty= ReadByte(Difficulty)
	local baseDir	= ReadByte(BaseWindDirection) >> 5
	local baseVol	= ReadByte(BaseWindVolume)

	return GetWind(difficulty, baseDir, baseVol, rand)
end
local function GetNextHoleWind(rand)
	local difficulty= ReadByte(Difficulty)
	rand	= GetNextRandom(rand)
	local baseDir	= (rand & 0xE0) >> 5
	rand	= GetNextRandom(rand)
	local baseVol	= rand & 0x0F
	if(baseVol >= 11)then
		baseVol	= baseVol - 8
	end

	return GetWind(difficulty, baseDir, baseVol, rand)
end

--------------------------------------------------

local function showStatus()
	resetDrawStringPosition()

	local rand	= ReadWordLittleEndian(RandomBuffer)
	local nextRand	= GetNextRandom(rand)

	drawString("Hole : %s %d (#%d)", GetCourseName(), ReadByte(HoleNumber)+1, ReadByte(HoleIndex))
	drawString("Cup : %.1f, %.1f (%04X, %04X)",
		PositionToDex(ReadPosition(CapXPosition)), PositionToDex(ReadPosition(CapYPosition)),
		ReadPosition(CapXPosition), ReadPosition(CapYPosition)
	)
	drawString("Ball : %.1f, %.1f (%04X, %05X)",
		PositionToDex(ReadPosition(BallXPosition)), PositionToDex(ReadBallYPosition(BallYPosition)),
		ReadPosition(BallXPosition), ReadBallYPosition(BallYPosition)
	)
	drawString("RNG : %04X (#%05d)", rand, GetRandomIndex(rand))
	local windName, windVol	= GetNextWind(rand)
	drawString("NextWind : %s %dm, %s %dm", windName, windVol, GetNextWind(nextRand))
	windName, windVol	= GetNextHoleWind(rand)
	drawString("NextHole : %s %dm, %s %dm", windName, windVol, GetNextHoleWind(nextRand))
end

-- Register callback
emu.addEventCallback(showStatus, emu.eventType.startFrame)
