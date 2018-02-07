#pragma once
#include "individu.h"
#include <vector>

class Cluster
{
    protected :
        std::vector<Individu> _individus;
        double _meanDistance ;
        double _meanBuses ;
        double _meanScore ;

	public :
        Cluster(int number_individual = -1);
        Cluster(const Cluster&) ;

		~Cluster();

        Individu & operator [] (int i);
        Individu operator [] (int i) const;

        void setMeanDistance(double meanDistance) ;
        void setMeanScore(double meanScore) ;
        void setMeanBuses(double meanBuses) ;

        std::vector<Individu> getIndividuals() const ;
        double getMeanDistance() const;
        double getMeanScore() const;
        double getMeanBuses() const;
};

