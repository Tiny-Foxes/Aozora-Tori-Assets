-- In KBX, ReverseOn is the default state.

return Def.ActorFrame {
	-- Background Gradient
	Def.Quad {
		InitCommand=function(self) self:x(0):diffuse(0,0,0,0.75):scaletoclipped(64,192) end,
		ReverseOnCommand=function(self) self:fadetop(0.25) end,
		ReverseOffCommand=function(self) self:fadebottom(0.25) end
	},
	
	-- Receptor Body
	Def.Quad {
		InitCommand=function(self) self:y(0):scaletoclipped(64,24) end,
		ReverseOnCommand=function(self) self:diffuse(color("#800000")):diffusebottomedge(color("#FF0000")) end,
		ReverseOffCommand=function(self) self:diffuse(color("#FF0000")):diffusebottomedge(color("#800000")) end,
	},
	-- Top Border Line
	Def.Quad {
		InitCommand=function(self) self:y(11):scaletoclipped(64,2):diffuse(1,1,1,0.25) end
	},
	-- Bottom Border Line
	Def.Quad {
		InitCommand=function(self) self:y(-11):scaletoclipped(64,2):diffuse(1,1,1,0.25) end
	},
	
	-- Upper Gradient Flash
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(64,24):diffuse(1,1,1,0.75):effectclock("beat"):queuecommand("Flash") end,
		FlashCommand=function(self) self:diffuseramp():effectcolor1(0,1,1,0.625):effectcolor2(0,1,1,1):effecttiming(0.2,0,0.8,0) end,
		ReverseOnCommand=function(self) self:y(-24):fadetop(0.75) end,
		ReverseOffCommand=function(self) self:y(24):fadebottom(0.75) end
	},
	-- Lane Flash
	Def.Quad {
		InitCommand=function(self) self:diffuse(color("#00FFFF")):scaletoclipped(64,768):fadetop(1):diffusealpha(0) end,
		PressCommand=function(self) self:diffusealpha(0.5) end,
		LiftCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		ReverseOnCommand=function(self) self:y(32):valign(1) end,
		ReverseOffCommand=function(self) self:y(-32):valign(0) end
	}
	
}