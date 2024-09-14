include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCADdesigns/chamferedCylinders.scad>

layerThickness = 0.2;

battenY = 8.5; // No covering
battenZ = 5.5;

strapOpeningX = 6;
strapOpeningY = 19.5;

cornerDia = 6;
cornerCZ = 1;

battenRecessOfsetX = cornerDia/2 + strapOpeningX + 3;

endX = battenRecessOfsetX + 25;
endY = strapOpeningY + 2*cornerDia;
endZ = battenZ + 2 * (7*layerThickness);
echo(str("endZ = ", endZ));

c1X = 0;
c1Y = (endY - cornerDia)/2;

c2X = strapOpeningX + cornerDia;

c3X = endX - cornerDia;
c3Y = (battenY + 0.5)/2;

p1 = [c1X, c1Y, 0];
p2 = [c2X, c1Y, 0];
p3 = [c3X, c3Y, 0]; // Front corners

module itemModule()
{
	difference()
	{
		exterior();
		battenRecess();
	}
}

module battenRecess()
{
	difference()
	{
		translate([battenRecessOfsetX,0,0]) rotate([0,90,0]) hull()
		{
			tcy([0,0,0], d=battenY, h=50);
		}

		doubleZ() tcu([-200, -200, battenZ/2], 400);
	}
}

module exterior()
{
	// Outer end:
	dc(p1);

	// Strap opening sides:
	doubleY() hull()
	{
		c(p1);
		c(p2);
	}

	// Strap opening inner end:
	dc(p2);

	// Body:
	hull()
	{
		doubleY() c(p2);
		doubleY() c(p3);
	}

}

module c(p)
{
	translate(p+[0,0,-endZ/2]) simpleChamferedCylinderDoubleEnded1(d=cornerDia, h=endZ, cz=cornerCZ);
}

module dc(p)
{
	hull() doubleY() c(p);
}

module clip(d=0)
{
	// tc([-200, -200, 0-d], 400);
}

if(developmentRender)
{
	display() itemModule();
	// displayGhost() battenGhost();
}
else
{
	itemModule();
}

module battenGhost()
{
	translate([0,0,0]) battenRecess();
}

