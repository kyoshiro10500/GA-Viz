#include "generation_clustered.h"

//Constructor
Generation_clustered::Generation_clustered(int number_individual,int number_cluster) :
_cluster(std::vector<Cluster>(number_cluster, Cluster(number_individual)))
{

}

Generation_clustered::Generation_clustered(const Generation_clustered& gen)
{
    _cluster = gen.getCluster() ;
}

//Destructor
Generation_clustered::~Generation_clustered()
{
    _cluster.clear();
}

//Getter
std::vector<Cluster> Generation_clustered::getCluster() const
{
    return _cluster ;
}

//Operator
Cluster & Generation_clustered::operator [] (int i)
{
    if (i < 0)
    {
        throw("ERROR - generation.cpp - Generation::operator [] : INDEX OUT OF RANGE");
    }
    else if (i >= _cluster.size())
    {
        throw("ERROR - genration.cpp - Generation::operator [] : INDEX OUT OF RANGE");
    }
    else
    {
        return _cluster[i];
    }
}

Cluster Generation_clustered::operator [] (int i) const
{
    if (i < 0)
    {
        throw("ERROR - Generation::operator [] : INDEX OUT OF RANGE");
    }
    else if (i >= _cluster.size())
    {
        throw("ERROR - Generation::operator [] : INDEX OUT OF RANGE");
    }
    else
    {
        return _cluster[i];
    }
}
