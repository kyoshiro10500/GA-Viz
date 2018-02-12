#include "model/model_table_generation.h"
#include <QDebug>

GenerationTableModel::GenerationTableModel(Population_clustered * population) : mElements(population)
{

}

int GenerationTableModel::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements->get_number_individuals()*mElements->get_number_cluster();
}

int GenerationTableModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements->get_number_generation();
}


QVariant GenerationTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= mElements->get_number_generation())
    {
        return QVariant();
    }

    switch (role)
    {
        case Qt::BackgroundColorRole :
            break ;
        case Qt::DisplayRole:
            break ;
        case Qt::EditRole:
            break;
    }

    return QVariant();

}

QVariant GenerationTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
    {
        return QStringLiteral("I%1").arg(section +1);
    }
    if (orientation == Qt::Vertical && role == Qt::DisplayRole)
    {
        return QStringLiteral("G%1").arg(section +1);
    }
    return QVariant();
}


bool GenerationTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    return true ;
}

void GenerationTableModel::addElement(const QString &element, int value)
{
    return ;
}

void GenerationTableModel::setScoreFilter(float value)
{
    scoreFilter = value ;
}

void GenerationTableModel::setMutationFilter(bool value)
{
    mutationFilter = value ;
}

void GenerationTableModel::setCrossingoverFilter(bool value)
{
    crossingoverFilter = value ;
}

void GenerationTableModel::setGeneration(int value)
{
    generationIndex = value ;
}

int GenerationTableModel::getGeneration() const
{
    return generationIndex ;
}

QColor GenerationTableModel::getColor(int gen, int ind, int index_gen,double score) const
{
    if((*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore() >= score &&
       ((*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getMutation() == mutationFilter || !mutationFilter )&&
       ((*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getCrossing() == crossingoverFilter || !crossingoverFilter) &&
        gen == index_gen)
    {
        return QColor(0,(*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore()*255,(*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore()*255) ;
    }
    else if(gen == index_gen)
    {
        return QColor(0,0,0) ;
    }
    else
    {
        return QColor(0,(*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore()*35,(*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore()*35) ;
    }
}

float GenerationTableModel::getScoreFilter() const
{
    return scoreFilter;
}


bool GenerationTableModel::getNew(int gen,int ind) const
{
     return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getNew() ;
}

bool GenerationTableModel::getCrossing(int gen,int ind) const
{
    return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getCrossing() ;
}

bool GenerationTableModel::getMutation(int gen,int ind) const
{
    return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getMutation() ;
}

double GenerationTableModel::getScoreBus(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScoreBuses() ;
}

double GenerationTableModel::getScoreDistance(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScoreDistance() ;
}

double GenerationTableModel::getDistance(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getDistance() ;
}

int GenerationTableModel::getNumberBuses(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getNumberBuses() ;
}

int GenerationTableModel::getNumberMutation(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getNumberMutation() ;
}

int GenerationTableModel::getNumberCrossover(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getNumberCrossover() ;
}

double GenerationTableModel::getScore(int gen, int ind) const
{
    return  (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore();
}

double GenerationTableModel::getMeanScore(int gen)
{
    double meanScore = 0.0 ;
    for(int i= 0; i<columnCount();i++)
    {
        meanScore += (*mElements)[gen][i/mElements->get_number_individuals()][i%mElements->get_number_individuals()].getScore();
    }
    return ((double) meanScore/(double)columnCount()) ;
}

int GenerationTableModel::getGenNumberMutations(int gen)
{
    int mutations = 0 ;
    for(int i= 0; i<columnCount();i++)
    {
        mutations += (*mElements)[gen][i/mElements->get_number_individuals()][i%mElements->get_number_individuals()].getNumberMutation() ;
    }
    return mutations ;
}

int GenerationTableModel::getGenNumberCrossover(int gen)
{
    int crossover = 0 ;
    for(int i= 0; i<columnCount();i++)
    {
        crossover += (*mElements)[gen][i/mElements->get_number_individuals()][i%mElements->get_number_individuals()].getNumberCrossover() ;
    }
    return crossover ;
}

QList<int> GenerationTableModel::getRang(int gen, int ind) const
{
    int rangBus = 1 ;
    int rangDistance = 1 ;
    int rangScore = 1 ;
    QList<int> rang ;
    double score = (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore();
    double scoreBus = (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScoreBuses() ;
    double scoreDistance = (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScoreDistance();
    for(int g=0;g<rowCount();g++)
    {
        for(int i=0;i<columnCount();i++)
        {
            if((*mElements)[g][i/mElements->get_number_individuals()][i%mElements->get_number_individuals()].getScore() >score)
            {
                rangScore++ ;
            }
            if((*mElements)[g][i/mElements->get_number_individuals()][i%mElements->get_number_individuals()].getScoreBuses() >scoreBus)
            {
                rangBus++ ;
            }
            if((*mElements)[g][i/mElements->get_number_individuals()][i%mElements->get_number_individuals()].getScoreDistance() >scoreDistance)
            {
                rangDistance++ ;
            }
        }
    }
    rang.append(rangScore); rang.append(rangBus); rang.append(rangDistance);
    return rang ;
}
