local Nskin = {}

-- [1.] Button Redirects
-- Defining on which direction the other directions should be based on
-- This will let us use less files which is quite handy to keep the noteskin directory nice
-- Do remember this will redirect all the files of that direction to the Direction its pointed to

Nskin.ButtonRedir =

	{
	-- cardinal directions	
		
		Up	= "Down",
		Down	= "Down",
		Left	= "Down",
		Right	= "Down",
		
	-- ordinal directions
	
		UpLeft		= "Down",
		UpRight 	= "Down",
		DownLeft	= "Down",
		DownRight	= "Down",
	
	-- centre is center
		
		Center = "Center",
		
	}

-- [2.] Rotation
-- Define the parts to be rotated at which degree

Nskin.Rotate =

	{
	-- cardinal directions	
	
		Up = 180,
		Down = 0,
		Left = 90,
		Right = -90,
	
	-- ordinal directions	
	
		UpLeft = 135,
		UpRight = -135,
		DownLeft = 45,
		DownRight = -45,
	
	-- center
	
		Center = 0,

	}

-- [3.] Element Redirects
-- Define elements that need to be redirected

Nskin.ElementRedir =

	{
		["Tap Fake"]				= "Tap Note",
		["Hold Explosion"]			= "Tap Explosion Dim",
		["Roll Explosion"]			= "Hold Explosion",
	}

-- [4.] Element Rotations
-- Parts of noteskins which we want to rotate
-- Tap Explosions are set to false as they'll be rotated in aFallback Explosion

Nskin.PartsToRotate =

	{
		["Receptor"]			= true,
		["Tap Explosion Bright"]	= false,
		["Tap Explosion Dim"]		= false,
		["Tap Note"]			= true,
		["Tap Fake"]			= true,
		["Tap Lift"]			= true,
		["Tap Addition"]		= true,
		["Hold Explosion"]		= true,
		["Hold Head Active"]		= true,
		["Hold Head Inactive"]		= true,
		["Roll Explosion"]		= true,
		["Roll Head Active"]		= true,
		["Roll Head Inactive"]		= true,
	}

-- [5.] Blank Redirects
-- Parts that should be Redirected to _Blank.png
-- you can add/remove stuff if you want

Nskin.Blank =

	{
		["Hold Tail Active"]		= true,
		["Hold Tail Inactive"]		= true,
		["Roll Tail Active"]		= true,
		["Roll Tail Inactive"]		= true,
		["Center Hold Topcap"]		= true,
	}
	
-- [6.] Buttons and Elements
-- Between here we usally put all the commands the noteskin.lua needs to do, some are extern in other files
-- If you need help with lua go to https://quietly-turning.github.io/Lua-For-SM5/Luadoc/Lua.xml there are a bunch of codes there
-- Also check out common it has a load of lua codes in files there
-- Just play a bit with lua its not that hard if you understand coding
-- But SM can be an ass in some cases, and some codes jut wont work if you dont have the noteskin on FallbackNoteSkin=common in the metric.ini 

function Nskin.Load()
	local sButton = Var "Button"
	local sElement = Var "Element"
	
	-- [6a.] Global Elements
	-- This is where arguments related to all gametypes are covered.

		-- Setting global button
		
		local Button = Nskin.ButtonRedir[sButton] or "Down"
	
		-- Setting global element
		
		local Element = Nskin.ElementRedir[sElement] or sElement
	
		-- Set Hold/Roll Heads to Tap Notes
		
		if string.find(sElement, "Head") then
			Element = "Tap Note"
		end
	
		-- We want to make this a global noteskin so we will use "Center" for fallback for unknown buttons.
		
		if string.find(Element, "Tap Note") or
		   string.find(Element, "Explosion") or
		   string.find(Element, "Lift") or
		   string.find(Element, "Receptor") then
			Button = Nskin.ButtonRedir[sButton] or "Center"
		end
		
		-- Because we want the body and bottomcaps to stay the same per direction
	
		if (string.find(Element, "Hold") or string.find(Element, "Roll")) and not 
		    string.find(Element, "Topcap") then
			Button = "Down"
		end
	
		-- For the Topcap element, use a different graphic for UpLeft and UpRight, and make sure Center is blank
		
		if string.find(Element, "Topcap") and (sButton == "UpLeft" or sButton == "DownLeft") then
			Button = "UpLeft"
			
			else if string.find(Element, "Topcap") and (sButton == "UpRight" or sButton == "DownRight") then
			Button = "UpRight"
		
				else if string.find(Element, "Topcap") and sButton == "Center" then
					Button = Nskin.ButtonRedir[sButton] or sButton
				end	
			end	
		end
		
		-- Explosion rays only stem from one part
		
		if string.find(Element, "Explosion") and 
		   string.find(Element, "Rays") then
			Button = "Down"
		end
			
		-- Only one kind of mine is used
	
		if string.find(Element, "Tap Mine") then
			Button = "Down"
		end

	-- [6b.] Others
	-- Returning first part of the code, The redirects, Second part is for commands
	
	local t = LoadActor(NOTESKIN:GetPath(Button,Element))
	
	-- Set blank redirects
	if Nskin.Blank[sElement] then
		t = Def.Actor {}
		-- Check if element is sprite only
		if Var "SpriteOnly" then
			t = LoadActor(NOTESKIN:GetPath("","_blank"))
		end
	end
	
	if Nskin.PartsToRotate[sElement] then
		t.BaseRotationZ = Nskin.Rotate[sButton] or nil
	end
	
	return t
end
-- >

-- dont forget to return cuz else it wont work >
return Nskin
