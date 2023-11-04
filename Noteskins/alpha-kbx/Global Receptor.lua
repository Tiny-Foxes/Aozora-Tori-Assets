-- [01.] Button Overlay
-- This is taken directly from default-kbx's Ovceptor Code and modified to fit into the noteskin.

local sButton = Var "Button"
local sGameButton = INPUTFILTER:GameButtonToKeyMapped(Var "GameButton", Var "Player")
sGameButton = string.gsub(sGameButton, "Key", "")

local Buttons = {}

if not PREFSMAN:GetPreference("UseOldJoystickMapping") and string.find(sGameButton, "Joy") then
	sGameButton = string.gsub(sGameButton, "Joy.+_", "")
	Buttons = Def.Sprite {
		Texture=NOTESKIN:GetPath("Key","Buttons/"..sGameButton),
		Text=sGameButton,
		OnCommand=function(self) self:x(0):zoom(1) end,
		ReverseOnCommand=function(self) self:y(28):valign(0) end,
		ReverseOffCommand=function(self) self:y(-28):valign(1) end
	}
else
	sGameButton = string.gsub(sGameButton, "Joy.+ ", "B")
	Buttons = Def.BitmapText {
		Font="_open sans semibold 24px",
		Text=sGameButton,
		OnCommand=function(self) self:LoadFromFont(NOTESKIN:GetPath("Key","Font/".."_league spartan Bold 24px.ini")) self:x(0):zoom(0.75) end,
		ReverseOnCommand=function(self) self:y(32):valign(0) end,
		ReverseOffCommand=function(self) self:y(-32):valign(1) end
	}
end

-- [02.] Receptor Body
-- Code for building the Receptor through Def.Quads are here.
-- To-do: Subtle Beat Flashes

return Def.ActorFrame {
	-- Background Gradient
	Def.Quad {
		InitCommand=function(self) self:x(0):diffuse(0,0,0,0.75):scaletoclipped(64,192) end,
		ReverseOnCommand=function(self) self:fadetop(0.25):fadebottom(0.0625) end,
		ReverseOffCommand=function(self) self:fadebottom(0.25):fadetop(0.0625) end
	},
	-- Background Left Line
	Def.Quad {
		InitCommand=function(self) self:x(-32):scaletoclipped(1,480):diffuse(1,1,1,0.125) end,
		ReverseOnCommand=function(self) self:y(96):valign(1):fadetop(0.25):fadebottom(0.0625) end,
		ReverseOffCommand=function(self) self:y(-96):valign(0):fadebottom(0.25):fadetop(0.0625) end
	},
	-- Background Right Line
	Def.Quad {
		InitCommand=function(self) self:x(32):scaletoclipped(1,480):diffuse(1,1,1,0.125) end,
		ReverseOnCommand=function(self) self:y(96):valign(1):fadetop(0.25):fadebottom(0.0625) end,
		ReverseOffCommand=function(self) self:y(-96):valign(0):fadebottom(0.25):fadetop(0.0625) end
	},
	-- Outer Receptor Body
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(64,24):diffuse(0,1,1,1) end
	},
	-- Inner Receptor Body
	Def. Quad {
		InitCommand=function(self) self:scaletoclipped(64,18):diffuse(0,0,0,0.875):effectclock("beat"):queuecommand("Flash") end,
		FlashCommand=function(self) self:diffuseramp():effectcolor1(0,0,0,0.875):effectcolor2(0,0,0,0.81375):effecttiming(0.2,0,0.8,0) end,
	},
	-- Lower Inner Receptor Flash 
	Def. Quad {
		InitCommand=function(self) self:y(9):scaletoclipped(64,2):diffuse(0,1,1,0.5) end
	},	
	-- Upper Inner Receptor Flash 
	Def. Quad {
		InitCommand=function(self) self:y(-9):scaletoclipped(64,2):diffuse(0,1,1,0.5) end
	},

	-- Lane Flash
	Def.Quad {
		InitCommand=function(self) self:diffuse(color("#00C0FF")):scaletoclipped(64,480):diffusealpha(0) end,
		PressCommand=function(self) self:diffusealpha(0.5) end,
		LiftCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		ReverseOnCommand=function(self) self:y(96):valign(1):fadetop(1):fadebottom(0.0625) end,
		ReverseOffCommand=function(self) self:y(-96):valign(0):fadetop(0.0625):fadebottom(1) end
	},
	Buttons
}