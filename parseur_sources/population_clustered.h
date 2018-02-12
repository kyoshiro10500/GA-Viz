#ifndef POPULATION_CLUSTERED_H
#define POPULATION_CLUSTERED_H

#pragma once
#include "generation_clustered.h"
#include <vector>
#include <iostream>

/*!
 * \brief Population class : represents a population
 */
class Population_clustered
{
    private :
        std::vector<Generation_clustered> _generations; /*! A vector representing all the generations*/
        int _number_generation; /*! The number of generations in the population*/
        int _number_cluster ; /*! The number of clusters per generation*/
        int _number_individual; /*! The number of individuals per cluster*/
        int _number_crossover ; /*! The number of crossing over in the population*/
        int _number_mutation ; /*! The number of mutations in the population*/
        double _best_score ; /*! The best score in the population */
        double _worst_score ; /*! The worst score in the population */
        double _mean_score ; /*! The mean score in the population*/

    public :
        //Constructor
        //! Default constructor of a population. The default values of number_generation, number_individual, number_cluster are -1*/
        /*!
         * \param number_generation : an int representing the number of generations inside the population
         * \param number_individual : an int representing the number of individuals per cluster
         * \param number_cluster : an int representing the number of clusters per generation
         */
        Population_clustered(int number_generation = -1,int number_individual = -1,int number_cluster = -1);

        //! Copy constructor of a population*/
        /*!
         * Creates a population by copying another one members
         */
        Population_clustered(const Population_clustered&);

        //Destructor
        //! Destructor of a population
        /*!
          * Destroy the population by freeing evrery cluster in it
          */
        ~Population_clustered();

        //Operator
        //! Vector-like operator for the generation*/
        Generation_clustered & operator [] (int i);
        //! Vector-like operator for the generation*/
        Generation_clustered operator [] (int i) const;

        //Getter
        //! Get the number of generation inside a population*/
        /*!
         * \return an int representing the number of generations of the population
         */
        int get_number_generation() const;

        //! Get the number of individuals per cluster inside a population*/
        /*!
         * \return an int representing the number of individuals per cluster of the population
         */
        int get_number_individuals() const;

        //! Get the number of clusters per generation inside a population*/
        /*!
         * \return an int representing the number of clusters per generation of the population
         */
        int get_number_cluster() const ;

        //! Get the number of crossing over inside a population*/
        /*!
         * \return an int representing the number of crossing over of the population
         */
        int get_number_crossover() const ;

        //! Get the number of mutations inside a population*/
        /*!
         * \return an int representing the number of mutations of the population
         */
        int get_number_mutation() const ;

        //! Get the generations of a population*/
        /*!
         * \return a vector containing all the generations of the population
         */
        std::vector<Generation_clustered> get_generation() const ;

        //! Get the best score of a population*/
        /*!
         * \return a double representing the best mean score inside a population
         */
        double get_best_score() const ;

        //! Get the worst score of a population*/
        /*!
         * \return a double representing the worst mean score inside a population
         */
        double get_worst_score() const ;

        //! Get the mean score of a population*/
        /*!
         * \return a double representing the global mean score inside a population
         */
        double get_mean_score() const ;

        //Setter
        //! Set the number of crossing over of a population
        /*!
         * \param number_crossover : an int representing the number of crossing over of a population
         */
        void set_number_crossover(int number_crossover) ;

        //! Set the number of mutations over of a population
        /*!
         * \param number_mutation : an int representing the number of mutations of a population
         */
        void set_number_mutation(int number_mutation) ;

        //! Set the best score of a population
        /*!
         * \param best_score : an fouble representing the best score of a population
         */
        void set_best_score(double best_score) ;

        //! Set the worst score of a population
        /*!
         * \param worst_score : an double representing the worst score of a population
         */
        void set_worst_score(double worst_score) ;

        //! Set the global mean score of a population
        /*!
         * \param worst_score : a double representing the global mean score of a population
         */
        void set_mean_score(double mean_score) ;

};

#endif // POPULATION_CLUSTERED_H
