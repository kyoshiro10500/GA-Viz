#pragma once

#include <string>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include "population_clustered.h"
#include "points.h"

class Parseur
{
	private :
		std::string _fileNamePopulation;
		std::string _fileNamePoints;
	public :
		//Constructor
        Parseur(std::string fileNamePopulation,std::string fileNamePoints);
        //Function
        Population_clustered parseFile();
		std::vector<Points> parseFilePoints();
        std::vector<std::vector<int>> parseRoutes(int gIdx) ;
};
