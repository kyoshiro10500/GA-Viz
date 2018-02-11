#ifndef GENERATION_CLUSTERED_H
#define GENERATION_CLUSTERED_H

#pragma once
#include "cluster.h"
#include <vector>

/*!
 * \brief Generation class : represents a generation
 */
class Generation_clustered
{
    private :
        std::vector<Cluster> _cluster; /*! A vector representing all clusters inside the generation*/
    public :
        //Constructor
        //! Default constructor of a generation. Set the number of individual and number_cluster to -1*/
        /*!
         * \param number_individual : an int representing the number of individual inside a generation
         * \param number_cluster : an int representing the number of cluster inside a generation
         */
        Generation_clustered(int number_individual = -1, int number_cluster = -1);

        //! Copy constructor
        /*!
         * Creates a new generation and copy every members of the old one
         */
        Generation_clustered(const Generation_clustered&) ;

        //Destructor
        //! Default destructor*/
        /*!
          * Destroy the generation and free every cluster inside it
          */
        ~Generation_clustered();

        //operator
        //! Vector-like operator for the generation*/
        Cluster & operator [] (int i);

        //! Vector-like operator for the generation*/
        Cluster operator [] (int i) const;

        //Getter
        //! Get the vector of cluster of the generation*/
        /*!
         * \return the vector of all cluster inside the generation
         */
        std::vector<Cluster> getCluster() const ;
};


#endif // GENERATION_CLUSTERED_H
