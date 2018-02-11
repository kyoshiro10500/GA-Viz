#ifndef POPULATION_CLUSTERED_H
#define POPULATION_CLUSTERED_H

#pragma once
#include "generation_clustered.h"
#include <vector>
#include <iostream>

class Population_clustered
{
    private :
        std::vector<Generation_clustered> _generations;
        int _number_generation;
        int _number_individual;
        int _number_cluster ;
        int _number_crossover ;
        int _number_mutation ;
        double _best_score ;
        double _worst_score ;

    public :
        //Constructor
        Population_clustered(int number_generation = -1,int number_individual = -1,int number_cluster = -1);
        Population_clustered(const Population_clustered&);
        //Destructor
        ~Population_clustered();

        //Operator
        Generation_clustered & operator [] (int i);
        Generation_clustered operator [] (int i) const;
        friend std::ostream& operator<<(std::ostream& os, const Population_clustered& population);

        //Getter
        int get_number_generation() const;
        int get_number_individuals() const;
        int get_number_cluster() const ;
        int get_number_crossover() const ;
        int get_number_mutation() const ;
        std::vector<Generation_clustered> get_generation() const ;
        double get_best_score() const ;
        double get_worst_score() const ;

        //Setter
        void set_number_crossover(int number_crossover) ;
        void set_number_mutation(int number_mutation) ;
        void set_best_score(double best_score) ;
        void set_worst_score(double worst_score) ;

};

#endif // POPULATION_CLUSTERED_H
