include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCADdesigns/chamferedCylinders.scad>

layerThickness = 0.2;

battenY = 8.5; // No covering
battenZ = 5.5;

strapOpeningX = 6;
strapOpeningY = 19.5;

cornerDia = 6;
cornerCZ = 1;

endY = strapOpeningY + 2*cornerDia;
endZ = battenZ + 2 * (3*layerThickness);

c1X = 0;
c1Y = (endY - cornerDia)/2;

p1 = [c1X, c1Y, 0];

module itemModule()
{
	hull() doubleY() c(p1);
}

module c(p)
{
	translate(p+[0,0,-endZ/2]) simpleChamferedCylinderDoubleEnded1(d=cornerDia, h=endZ, cz=cornerCZ);
}

module clip(d=0)
{
	//tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
