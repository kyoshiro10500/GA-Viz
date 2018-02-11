#pragma once

/*!
 * \brief Poit class : represent the coordinate of a city
 */
class Points
{
	private :
        int _x; /*! x coordinate of the city*/
        int _y; /*! y coordinate of the city*/
	public :
		//Constructor
        //! Constructor of a point*/
        /*!
         * \param x : an int representing the x coordinate of the city
         * \param y : an int representing the y coordinate of the city
         */
		Points(int x,int y);

        //! Default constructor of a point. Set the coordinates to 0;0*/
		Points();

		//Getter
        //! Get the y coordinate of a point*/
        /*!
         * \return an int representing the y coordinate of a point
         */
		int gety() const;

        //! Get the x coordinate of a point*/
        /*!
         * \return an int representing the x coordinate of a point
         */
		int getx() const;

		//Setter
        //! Set the x coordinate of a point*/
        /*!
         * \param x : an int representing the x coordinate of the point
         */
		void setx(int x);

        //! Set the y coordinate of a point*/
        /*!
         * \param y : an int representing the y coordinate of the point
         */
		void sety(int y);
};
