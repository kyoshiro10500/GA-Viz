#include "cluster.h"
#include <QDebug>
//Constructor
Cluster::Cluster(int number_individual) : _individus(std::vector<Individu>(number_individual, Individu()))
{

}

 Cluster::Cluster(const Cluster& clu)
 {
     _individus = clu.getIndividuals();
     _meanDistance = clu.getMeanDistance() ;
     _meanBuses = clu.getMeanBuses() ;
     _meanScore = clu.getMeanScore() ;
 }

//Destructor
Cluster::~Cluster()
{
    _individus.clear();
}

//Setter
void Cluster::setMeanScore(double meanScore)
{
    _meanScore = meanScore;
}

void Cluster::setMeanBuses(double meanBuses)
{
    _meanBuses = meanBuses ;
}

void Cluster::setMeanDistance(double meanDistance)
{
    _meanDistance = meanDistance ;
}

//Getter

std::vector<Individu> Cluster::getIndividuals() const
{
    return _individus ;
}

double Cluster::getMeanScore() const
{
    return _meanScore ;
}

double Cluster::getMeanBuses() const
{
    return _meanBuses ;
}

double Cluster::getMeanDistance() const
{
    return _meanDistance ;
}

//Operator
Individu & Cluster::operator [] (int i)
{
    if (i < 0)
    {
        throw("ERROR - cluster.cpp - Cluster::operator [] : INDEX OUT OF RANGE");
    }
    else if (i >= _individus.size())
    {
        throw("ERROR - cluster.cpp - Cluster::operator [] : INDEX OUT OF RANGE");
    }
    else
    {
        return _individus[i];
    }
}

Individu Cluster::operator [] (int i) const
{
    if (i < 0)
    {
        throw("ERROR - cluster.cpp - Cluster::operator [] : INDEX OUT OF RANGE");
    }
    else if (i >= _individus.size())
    {
        throw("ERROR - cluster.cpp - Cluster::operator [] : INDEX OUT OF RANGE");
    }
    else
    {
        return _individus[i];
    }
}
