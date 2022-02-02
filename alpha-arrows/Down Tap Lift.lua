return Def.Sprite {
	Texture=NOTESKIN:GetPath( '_down', 'tap lift' );
	InitCommand=function(self)
		self:animate(false):thump():effectclock("beat"):effectmagnitude(0.9,1,1) 
	end;
};
