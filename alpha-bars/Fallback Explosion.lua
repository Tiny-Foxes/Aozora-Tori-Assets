-- code by Jose Valera, edits by Aqui-kun
-- ** this code is purpose built for explosions that require specific elements to be rotated and vice versa

-- ** Define "Button" and Rotations
local t = Def.ActorFrame{}
local ButtonLabel = Var "Button"

-- This is our Dim command, and will just be that.
-- The explosion will be the ONLY element that will be rotated.
t[#t+1] = NOTESKIN:LoadActor( Var "Button", "Tap Explosion Dim" )..{
  InitCommand=function(s) s:diffusealpha(0) end,
	W5Command=NOTESKIN:GetMetricA("GhostArrowDim", "W5Command");
	W4Command=NOTESKIN:GetMetricA("GhostArrowDim", "W4Command");
	W3Command=NOTESKIN:GetMetricA("GhostArrowDim", "W3Command");
  W2Command=NOTESKIN:GetMetricA("GhostArrowDim", "W2Command");
  W1Command=NOTESKIN:GetMetricA("GhostArrowDim", "W1Command");
  HeldCommand=NOTESKIN:GetMetricA("GhostArrowBright", "W1Command");
	JudgmentCommand=cmd(finishtweening);
	BrightCommand=cmd(visible,false);
	DimCommand=cmd(visible,true);
}

-- This is our Bright command, and will just be that.
-- The explosion will be the ONLY element that will be rotated.
t[#t+1] = NOTESKIN:LoadActor( Var "Button", "Tap Explosion Dim" )..{
  InitCommand=function(s) s:diffusealpha(0) end,
	W5Command=NOTESKIN:GetMetricA("GhostArrowBright", "W5Command");
	W4Command=NOTESKIN:GetMetricA("GhostArrowBright", "W4Command");
	W3Command=NOTESKIN:GetMetricA("GhostArrowBright", "W3Command");
  W2Command=NOTESKIN:GetMetricA("GhostArrowBright", "W2Command");
  W1Command=NOTESKIN:GetMetricA("GhostArrowBright", "W1Command");
	HeldCommand=NOTESKIN:GetMetricA("GhostArrowBright", "W1Command");
	JudgmentCommand=function(s) s:finishtweening() end,
	BrightCommand=function(s) s:visible(true) end,
	DimCommand=function(s) s:visible(false) end,
}

t[#t+1] = NOTESKIN:LoadActor( Var "Button", "Tap Explosion Rays" )..{
  InitCommand=function(s) s:diffusealpha(0) end,
	W5Command=NOTESKIN:GetMetricA("BrightRay", "W5Command");
	W4Command=NOTESKIN:GetMetricA("BrightRay", "W4Command");
	W3Command=NOTESKIN:GetMetricA("BrightRay", "W3Command");
  W2Command=NOTESKIN:GetMetricA("BrightRay", "W2Command");
  W1Command=NOTESKIN:GetMetricA("BrightRay", "W1Command");
	HeldCommand=NOTESKIN:GetMetricA("BrightRay", "W1Command");
	JudgmentCommand=function(s) s:finishtweening() end,
	BrightCommand=function(s) s:visible(true) end,
	DimCommand=function(s) s:visible(false) end,
}

-- Hold Explosion Commands
t[#t+1] = NOTESKIN:LoadActor( Var "Button", "Hold Explosion" ) .. {
		HoldingOnCommand=NOTESKIN:GetMetricA("HoldGhostArrow", "HoldingOnCommand");
		HoldingOffCommand=NOTESKIN:GetMetricA("HoldGhostArrow", "HoldingOffCommand");
		InitCommand=cmd(playcommand,"HoldingOff";finishtweening);
	};
-- Roll Explosion Commands
t[#t+1] = NOTESKIN:LoadActor( Var "Button", "Roll Explosion" ) .. {
		RollOnCommand=NOTESKIN:GetMetricA("HoldGhostArrow", "RollOnCommand");
		RollOffCommand=NOTESKIN:GetMetricA("HoldGhostArrow", "RollOffCommand");
		InitCommand=cmd(playcommand,"RollOff";finishtweening);
	};

-- Mine Explosion Commands
t[#t+1] = NOTESKIN:LoadActor( Var "Button", "HitMine Explosion" ) .. {
		InitCommand=cmd(blend,"BlendMode_Add";diffusealpha,0);
		HitMineCommand=cmd(diffuse,1.0,1.0,1.0,1;zoom,1;linear,0.1;zoom,2;diffusealpha,.6;linear,0.06;diffusealpha,0);
	};

return t;
