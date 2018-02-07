#ifndef GENERATION_CLUSTERED_H
#define GENERATION_CLUSTERED_H

#pragma once
#include "cluster.h"
#include <vector>

class Generation_clustered
{
    private :
        std::vector<Cluster> _cluster;
    public :
        //Constructor
        Generation_clustered(int number_individual = -1, int number_cluster = -1);
        Generation_clustered(const Generation_clustered&) ;

        //Destructor
        ~Generation_clustered();

        //Getter
        std::vector<Cluster> getCluster() const ;

        //operator
        Cluster & operator [] (int i);
        Cluster operator [] (int i) const;
};


#endif // GENERATION_CLUSTERED_H
