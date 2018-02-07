#pragma once
class Points
{
	private :
		int _x;
		int _y;
	public :
		//Constructor
		Points(int x,int y);
		Points();

		//Getter
		int gety() const;
		int getx() const;

		//Setter
		void setx(int x);
		void sety(int y);
};