#include "parseur.h"
#include <climits>
#include <stack>
#include <QDebug>
#include <vector>

Parseur::Parseur(std::string fileNamePopulation, std::string fileNamePoints) :
_fileNamePopulation(fileNamePopulation),_fileNamePoints(fileNamePoints)
{
}


Population_clustered Parseur::parseFile()
{
    int count = 1; //Used to read the file_header
    int current_line = 1 ;
    std::string line; //Used to store each line of the file
    std::ifstream fichier(_fileNamePopulation, std::ios::in); //Used to open the file
    if (fichier) //If the file exists
    {
        int number_cluster = -1 ;
        int number_generation = -1;
        int number_individual = -1;
        while (std::getline(fichier, line) && count <6) //The header is read
        {
            current_line++;
            if (count == 3) //Information of the number of generation
            {
                std::string number_generation_string = "";
                int begin_number_generation_location = line.find(": ",0) + 2;
                while (begin_number_generation_location != line.size())
                {
                    number_generation_string += line[begin_number_generation_location];
                    begin_number_generation_location++;
                }
                number_generation = stoi(number_generation_string);
            }
            else if (count == 4) //In formation of the number of clusters in each generation
            {
                std::string number_cluster_string = "";
                int begin_number_cluster_location = line.find(": ", 0) + 2;
                while (begin_number_cluster_location != line.size())
                {
                    number_cluster_string += line[begin_number_cluster_location];
                    begin_number_cluster_location++;
                }
                number_cluster = stoi(number_cluster_string);
            }
            else if (count == 5) //Information of the number of individuals in each generation
            {
                std::string number_individual_string = "";
                int begin_number_individual_location = line.find(": ", 0) + 2;
                while (begin_number_individual_location != line.size())
                {
                    number_individual_string += line[begin_number_individual_location];
                    begin_number_individual_location++;
                }
                number_individual = stoi(number_individual_string);
            }
            count++;
        }
        //We have the total number of individual but we want individuals per cluster
        number_individual = number_individual / (number_cluster) ;
        //We have the information needed to parse the file and store the data
        //We will now begin with the parsing
        if (number_generation > 0 && number_individual > 0 && number_cluster > 0) //We verify that there are generations and individuals
        {
            Population_clustered population = Population_clustered(number_generation, number_individual, number_cluster); //We generate our population_clustered
            int index_generation = 0;
            int min_buses = INT_MAX; //We will calulate the minimum solution during the parsing
            int max_buses = INT_MIN;
            double min_distance = INT_MAX;
            double max_distance = INT_MIN ;
            while (index_generation < number_generation && std::getline(fichier, line)) //index_generation < number_generation && std::getline(fichier, line)
            {
                current_line++ ;
                if (line.find("Generation:",0) != -1) // We have found a generation
                {
                    int index_cluster = 0 ;
                    while(index_cluster < number_cluster)
                    {
                        int index_individual = 0; //We set the index of the individual we have to store to 0
                        while (index_individual < number_individual) //We read all the individual from the generation index_generation
                        {
                            double distance = 0;
                            int number_buses = 0;
                            int gIdx = -1 ;
                            int mutations = 0 ;
                            int crossings = 0 ;
                            int parent1 = -1 ;
                            int parent2 = -1 ;

                            while (line.find("gIdx: ", 0) == -1) //We read while we don't find an individual
                            {
                                std::getline(fichier, line);
                                current_line++ ;
                            }

                            //We parse the gIdx
                            std::string gIdx_string = "";
                            int begin_gIdx_location = line.find(": ", 0) + 2;
                            while (begin_gIdx_location != line.size())
                            {
                                gIdx_string += line[begin_gIdx_location];
                                begin_gIdx_location++;
                            }
                            gIdx = stoi(gIdx_string);

                            //Here we have the number of buses
                            std::getline(fichier, line);
                            std::string number_bus_string = "";
                            int number_bus_location = line.find("No. of Routes: ", 0) + 15;
                            while (number_bus_location != line.size())
                            {
                                number_bus_string += line[number_bus_location];
                                number_bus_location++;
                            }
                            number_buses = stoi(number_bus_string);
                            if (number_buses < min_buses)
                            {
                                min_buses = number_buses;
                            }
                            if(number_buses > max_buses)
                            {
                                max_buses = number_buses ;
                            }

                            //We jump to the info we want
                            while (line.find("TotalDistance: ", 0) == -1)
                            {
                                std::getline(fichier, line);
                                current_line++ ;
                            }

                            //Here we have the distance of the individual
                            std::string distance_string = "";
                            int distance_location = line.find("TotalDistance: ", 0) + 15;
                            while (distance_location != line.size())
                            {
                                distance_string += line[distance_location];
                                distance_location++;
                            }
                            distance = stod(distance_string);
                            if (distance < min_distance)
                            {
                                min_distance = distance;
                            }
                            if(distance > max_distance)
                            {
                                max_distance = distance ;
                            }

                            //Here we have the mutations of the individual
                            std::getline(fichier, line);
                            std::string mutation_string = "";
                            int mutation_location = line.find(": ", 0) + 2;
                            while (mutation_location != line.size())
                            {
                                mutation_string += line[mutation_location];
                                mutation_location++;
                            }
                            mutations = stoi(mutation_string);

                            //Here we have the crossovers of the individual
                            std::getline(fichier, line);
                            std::string crossing_string = "";
                            int crossing_location = line.find(": ", 0) + 2;
                            while (crossing_location != line.size())
                            {
                                crossing_string += line[crossing_location];
                                crossing_location++;
                            }
                            crossings = stoi(crossing_string);
                            //Here we have the parents of the individual
                            std::getline(fichier, line);
                            std::string parent_string = "";
                            int parent_location = line.find(": ", 0) + 2;
                            while (line[parent_location] != ' ')
                            {
                                parent_string += line[parent_location];
                                parent_location++;
                            }
                            parent1 = stoi(parent_string);

                            parent_string = "";
                            parent_location = line.find(", ", 0) + 2;
                            while (parent_location != line.size())
                            {
                                parent_string += line[parent_location];
                                parent_location++;
                            }
                            parent2 = stoi(parent_string);

                            //We store the information
                            population[index_generation][index_cluster][index_individual].setGIdx(gIdx);
                            population[index_generation][index_cluster][index_individual].setNumberBuses(number_buses);
                            population[index_generation][index_cluster][index_individual].setDistance(distance);
                            population[index_generation][index_cluster][index_individual].setCrossing(crossings != 0);
                            population[index_generation][index_cluster][index_individual].setMutation(mutations != 0);
                            population[index_generation][index_cluster][index_individual].setParent1(parent1);
                            population[index_generation][index_cluster][index_individual].setParent2(parent2);
                            population[index_generation][index_cluster][index_individual].setIsNew(parent1 != -1 || parent2 != -1 || index_generation == 0);

                            index_individual++; //We go to the next individual
                        }
                        index_cluster++ ; //We have read all the individual from this cluster, we can go to the next one
                    }
                    index_generation++; //We have read all the cluster from this generation, we can go to the next one
                }
            }
            fichier.close();
            //We will calculate the score of each individual
            int number_mutation = 0 ;
            int number_crossover = 0 ;
            for (int i = 0; i < number_generation; i++)
            {
                for (int j = 0; j < number_cluster; j++)
                {
                    double meanBuses =0 ;
                    double meanDistance =0 ;
                    double meanScore =0 ;
                    for(int k=0;k < number_individual;k++)
                    {
                        population[i][j][k].calculateScore(min_distance, min_buses, max_distance, max_buses);
                        if(population[i][j][k].getCrossing())
                        {
                            number_crossover++ ;
                        }
                        if(population[i][j][k].getMutation())
                        {
                            number_mutation++ ;
                        }
                        meanBuses += population[i][j][k].getNumberBuses() ;
                        meanDistance += population[i][j][k].getDistance() ;
                        meanScore += population[i][j][k].getScore() ;
                    }
                    population[i][j].setMeanBuses((double) meanBuses/(double) number_individual);
                    population[i][j].setMeanDistance((double) meanDistance/(double) number_individual);
                    population[i][j].setMeanScore((double) meanScore/(double)number_individual);
                }
            }
            population.set_number_crossover(number_crossover);
            population.set_number_mutation(number_mutation);
            return population;
        }
        else
        {
            throw("ERROR - parseur.cpp - parseFileCluster() : Population without generations or individuals");
        }


    }
    else
    {
        throw("ERROR - parseur.cpp - parseFileCluster() : Failed to open file");
    }
}

/* @requires nothing
@assigns nothing
@ensures returns an instance of std::vector<Points> contaigning all the points from the file
to store the data
*/
std::vector<Points> Parseur::parseFilePoints()
{
	std::string line; //used to store each line from the file
	std::ifstream fichier(_fileNamePoints, std::ios::in); //used to open and read the file
	if (fichier) //Success we can read the file
	{
		std::getline(fichier, line); //We get the first line containg how much points there are
		if (line.find("C") != -1) //We found the information
		{
			int number_points_location = line.find("C") + 1;
			std::string string_number_points = "";
			while (number_points_location < line.size())
			{
				string_number_points += line[number_points_location];
				number_points_location++;
			}
			int number_points = stoi(string_number_points); //We have how much points there are in the file
			std::vector<Points> vector_points = std::vector<Points>(number_points, Points()); //We allocate the vector we will return
			int index_point = 0; //We will parse each point 
			while (line.find("CUST NO.") == -1) //We ignore the informations from the table
			{
				std::getline(fichier, line);
			}
			std::getline(fichier, line);
			//Here we go, the real parsing will begin
			//A line is like "     index      x      y"
			while (index_point < number_points && std::getline(fichier, line))
			{
				int x_location = line.find("      ", 0) + 6; //the position of x in the line
				int y_location = line.find("      ", x_location) + 6; //the position of y in the line ( and the end of x+6)
				int y_location_end = line.find("      ", y_location); //the end of y
				std::string x_string = "";
				std::string y_string = "";
				while (x_location < y_location - 6)
				{
					x_string += line[x_location];
					x_location++;
				}
				while (y_location < y_location_end)
				{
					y_string += line[y_location];
					y_location++;
				}
				vector_points[index_point].setx(std::stoi(x_string)); //We set x in the point at index index_point
				vector_points[index_point].sety(std::stoi(y_string)); //We set y in the point at index index_point
				index_point++;
			}
			fichier.close();
			return vector_points;
		}
		else
		{
			throw("ERROR - parseur.cpp - parseFilePoints() : Impossible to read the header of the file");
		}		
	}
	else
	{
		throw("ERROR - parseur.cpp - parseFilePoints() : Impossible to read the file");
	}
}

std::vector<std::vector<int>> Parseur::parseRoutes(int gIdx)
{
    std::string line; //used to store each line from the file
    std::ifstream fichier(_fileNamePopulation, std::ios::in); //used to open and read the file
    if (fichier) //Success we can read the file
    {
        std::vector<std::vector<int>> routes ;
        int index = -1 ;
        //We search for the individual of index equals to gIdx
        while(index != gIdx)
        {
            std::getline(fichier,line) ;
            if(line.find("gIdx:") != -1)
            {
                index++;
            }
        }
        //We jump the line No. of routes
        std::getline(fichier,line) ;
        std::getline(fichier,line) ;
        while(line.find("Route: ") != -1)
        {
            //We will construct the route one by one
            std::vector<int> currentRoute ;
            int currentPositionInLine = line.find("Route: ") + 7 ;
            std::string routeString = "" ;
            while(currentPositionInLine != line.size())
            {
                if(line[currentPositionInLine] != '	') //Warning here it is not a regular space, it was a copy/paste from the file. Looks like a tabulation or something like that
                {
                    routeString += line[currentPositionInLine] ;
                    currentPositionInLine++ ;
                }
                else
                {
                    currentRoute.push_back(std::stoi(routeString));
                    routeString = "" ;
                    currentPositionInLine++ ;
                }
            }
            routes.push_back(currentRoute);
            std::getline(fichier,line) ;
        }

        return routes ;
    }
    else
    {
        throw("ERROR - parseur.cpp - parseFilePoints() : Impossible to read the file");
    }
}
