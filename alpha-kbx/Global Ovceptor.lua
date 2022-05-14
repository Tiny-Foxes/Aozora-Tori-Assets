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
		ReverseOnCommand=function(self) self:y(60):valign(0) end,
		ReverseOffCommand=function(self) self:y(-60):valign(1) end
	}
end

return Def.ActorFrame {

	-- Ovceptor Body
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(64,64) end,
		ReverseOnCommand=function(self) self:y(32):valign(0):diffuse(color("#212121")):diffusebottomedge(color("#424242")) end,
		ReverseOffCommand=function(self) self:y(-32):valign(1):diffuse(color("#424242")):diffusebottomedge(color("#212121")) end
	};
	
	-- Ovceptor Top Line
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(64,2):diffuse(1,1,1,0.25) end,
		ReverseOnCommand=function(self) self:y(32):valign(0) end,
		ReverseOffCommand=function(self) self:y(-32):valign(1) end
	};
	
	-- Press Flash
	Def.Quad {
		OnCommand=function(self) self:scaletoclipped(64,64):diffuse(0,0.75,1,0) end,
		ReverseOnCommand=function(self) self:y(32):valign(0):fadetop(0.75) end,
		ReverseOffCommand=function(self) self:y(-32):valign(1):fadebottom(0.75) end,
		PressCommand=function(self) self:diffusealpha(0.5) end,
		LiftCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Buttons
}
