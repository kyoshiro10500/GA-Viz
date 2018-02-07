#include "points.h"

//Constructor
Points::Points(int x,int y) : _x(x), _y(y)
{
}

Points::Points() : _x(0), _y(0)
{
}

//Getter
int Points::gety() const
{
	return _y;
}

int Points::getx() const
{
	return _x;
}

//Setter
void Points::setx(int x)
{
	_x = x;
}

void Points::sety(int y)
{
	_y = y;
}
