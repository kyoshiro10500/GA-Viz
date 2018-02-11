#pragma once
#include <iostream>
#include <vector>
#include <stack>
#include <climits>

class Individu
{
	private :
        int _number_mutation = 0 ;
        int _number_crossover = 0 ;
        int _number_buses;
        int _distance;
        double _scoreBuses ;
        double _scoreDistance ;
        int _gIdx ;
        int _parent1 = -1 ;
        int _parent2 = -1 ;
	public :
		//constructeur
		Individu();
        Individu(const Individu&) ;

		//destructeur
		~Individu();

		//setter
		void setDistance(double distance);
		void setNumberBuses(int number_buses);
        void setGIdx(int gIdx) ;
        void setParent1(int parent1) ;
        void setParent2(int parent2) ;
        void setNumberMutation(int number_mutation) ;
        void setNumberCrossover(int number_crossover) ;

		//getter
		bool getMutation() const;
		bool getCrossing() const;
		bool getNew() const;
		int getNumberBuses() const;
		double getDistance() const;
		double getScore() const;
        int getGIdx() const ;
        int getParent1() const ;
        int getParent2() const ;
        double getScoreBuses() const ;
        double getScoreDistance() const ;
        int getNumberMutation() const ;
        int getNumberCrossover() const ;

		//Operator
		friend std::ostream& operator<<(std::ostream& os, const Individu& individu);

		//Functions
        void calculateScore(double min_distance, int min_number_buses , int max_distance, int max_buses);
};
