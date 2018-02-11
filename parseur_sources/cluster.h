#pragma once
#include "individu.h"
#include <vector>

/*!
 * \brief Cluster class : represents a cluster
 */

class Cluster
{
    protected :
        std::vector<Individu> _individus; /*! A vector representing all the individuals contained inside a cluster*/
        double _meanDistance ; /*! The mean distance of the cluster */
        double _meanBuses ; /*! The mean buses of the cluster */
        double _meanScore ; /*! The mean score of the cluster */

	public :

        //Constructors
        //! Default constructor of a cluster. Set the number of individual default value to -1*/
        /*!
         * \param number_individual : an int representing the number of individuals inside the cluster
         */
        Cluster(int number_individual = -1);

        //! Copy constructor of a cluster*/
        /*!
         * Creates a new cluster and copy all the members of the old cluster inside it
         */
        Cluster(const Cluster&) ;

        //Destructor
        //! Default destructor of a cluster*/
        /*!
        *   Destroy the cluster by freeing all the Individual contained inside it
        */
		~Cluster();

        //Operator
        //! Vector-like operator for the cluster*/
        Individu & operator [] (int i);

        //! Vector-like operator for the cluster*/
        Individu operator [] (int i) const;

        //Setters
        //! Set the mean distance of a cluster*/
        /*!
         * \param meanDistance : a double corresponding to the value of mean distance of a cluster
         */
        void setMeanDistance(double meanDistance) ;

        //! Set the mean score of a cluster*/
        /*!
         * \param meanScore : a double corresponding to the value of mean score of a cluster
         */
        void setMeanScore(double meanScore) ;

        //! Set the mean buses of a cluster*/
        /*!
         * \param meanBuses : a double corresponding to the value of mean buses of a cluster
         */
        void setMeanBuses(double meanBuses) ;

        //Getters
        //! Get the vector of the individuals inside a cluster*/
        /*!
         * \return a vector corresponding of all the individuals inside the cluster
         */
        std::vector<Individu> getIndividuals() const ;

        //! Get the mean distance of a cluster*/
        /*!
         * \return a double corresponding the mean distance of a cluster
         */
        double getMeanDistance() const;

        //! Get the mean score of a cluster*/
        /*!
         * \return a double corresponding the mean score of a cluster
         */
        double getMeanScore() const;

        //! Get the mean buses of a cluster*/
        /*!
         * \return a double corresponding the mean buses of a cluster
         */
        double getMeanBuses() const;
};

