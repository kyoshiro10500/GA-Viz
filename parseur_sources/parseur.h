#pragma once

#include <string>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include "population_clustered.h"
#include "points.h"

/*!
 * \brief Parseur class : represents the paser used to parse all the information
 */
class Parseur
{
	private :
        std::string _fileNamePopulation; /*! The filename where all the infos are stored regarding individuals*/
        std::string _fileNamePoints; /*! The filename where all infos are stored regarding routes*/
	public :
		//Constructor
        //! Constructor for the parseur*/
        /*!
         * \param fileNamePopulation :  a string representing the path to the file
         * \param fileNamePoints : a string representing the path to the file
         */
        Parseur(std::string fileNamePopulation,std::string fileNamePoints);

        //Function
        //! Parse the file of individuals*/
        /*!
         * \return The population representing all the individuals
         */
        Population_clustered parseFile();

        //! Parse the file of routes*/
        /*!
         * \return The points of the routes
         */
		std::vector<Points> parseFilePoints();

        //! Parse the routes of an individual*/
        /*!
         * \param gIdx : an int representing the global index of an individual
         * \return a matrix representing all the routes of an individual
         */
        std::vector<std::vector<int>> parseRoutes(int gIdx) ;
};
