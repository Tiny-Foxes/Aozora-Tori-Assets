local Nskin = {}

-- [1.] Button Redirects
-- Defining on which direction the other directions should be based on
-- This will let us use less files which is quite handy to keep the noteskin directory nice
-- Do remember this will redirect all the files of that direction to the direction its pointed to
Nskin.ButtonRedir =
	{
	-- Still wondering how I can optimize this for even-numbered layouts. Will fix later.
		Key1		= "White";
		Key2		= "Blue";
		Key3		= "White";
		Key4		= "White";
		Key5		= "Blue";
		Key6		= "White";
		Key7		= "White";
		Key8		= "White";
		Key9		= "Blue";
		Key10		= "White";
		Key11		= "Blue";
		Key12		= "White";
		Key13		= "White";
		Key14		= "White";
		Key15		= "Blue";
		Key16		= "White";
		Key17		= "White";
		Key18		= "Blue";
		Key19		= "White";
	}


-- [2.] Rotation
-- Define the parts to be rotated at which degree
-- Why am I doing this
Nskin.Rotate = {}
	
-- [3.] Element Redirects
-- Define elements that need to be redirected

Nskin.ElementRedir =
	{
		["Tap Fake"]				= "Tap Note",
		["Hold Explosion"]			= "Tap Explosion Dim",
		["Roll Explosion"]			= "Tap Explosion Dim",
		["Hold Head Active"] 		= "Tap Note",
		["Roll Head Active"] 		= "Tap Note",
		["Hold Head Inactive"]	 	= "Tap Note",
		["Roll Head Inactive"] 		= "Tap Note",
		["Roll Topcap Active"] 		= "Hold Topcap Active",
		["Roll Topcap Inactive"] 	= "Hold Topcap Inactive",
		["Roll Bottomcap Active"] 	= "Hold Bottomcap Active",
		["Roll Bottomcap Inactive"] = "Hold Bottomcap Inactive",
		["Hold LiftTail Active"] 	= "Tap Note",
		["Hold LiftTail Inactive"] 	= "Tap Note",
		["Roll LiftTail Active"] 	= "Tap Note",
		["Roll LiftTail Inactive"] 	= "Tap Note",
		
	}

Nskin.PartsToRotate = {}


-- [5.] Blank Redirects
-- Parts that should be Redirected to _Blank.png
-- you can add/remove stuff if you want
Nskin.Blank =
	{
		["Hold Tail Active"]		= true,
		["Hold Tail Inactive"]		= true,
		["Roll Tail Active"]		= true,
		["Roll Tail Inactive"]		= true,
	}

-- [6.] Buttons and Elements
-- Between here we usally put all the commands the noteskin.lua needs to do, some are extern in other files
-- If you need help with lua go to https://quietly-turning.github.io/Lua-For-SM5/Luadoc/Lua.xml there are a bunch of codes there
-- Also check out common it has a load of lua codes in files there
-- Just play a bit with lua its not that hard if you understand coding
-- But SM can be a bum in some cases, and some codes jut wont work if you dont have the noteskin on FallbackNoteSkin=common in the metric.ini

function Nskin.Load()
	local sButton = Var "Button"
	local sElement = Var "Element"

	-- [6a.] Global Elements
	-- This is where arguments related to all gametypes are covered.

		-- Setting global button
		local Button = Nskin.ButtonRedir[sButton] or "White"

		-- Setting global element
		local Element = Nskin.ElementRedir[sElement] or sElement
		

		-- Elements shared across all buttons must fall back to one direction.
		-- If you'll use Ovceptor Elements, don't forget to add the string below to make sure it's rendered.
		if string.find(Element, "Tap Explosion") or
		   string.find(Element, "Receptor") or 
		   string.find(Element, "Tap Lift") or
		   string.find(Element, "Mine") then
			Button = "Global"
		end

		-- things don't play nicely
		if string.find(Element, "Explosion") and
		   string.find(Element, "Rays") then
			Button = "Global"
		end

	-- [6b.] Others
	-- Returning first part of the code, the redirects, Second part is for commands

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

-- Don't forget to return because else it won't work
return Nskin