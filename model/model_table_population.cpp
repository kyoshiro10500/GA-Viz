#include "model/model_table_population.h"
#include <QDebug>

PopulationTableModel::PopulationTableModel(Population_clustered * population) : mElements(population)
{

}

int PopulationTableModel::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements->get_number_individuals()*mElements->get_number_cluster();
}

int PopulationTableModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements->get_number_generation();
}


QVariant PopulationTableModel::data(const QModelIndex &index, int role) const
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

QVariant PopulationTableModel::headerData(int section, Qt::Orientation orientation, int role) const
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


bool PopulationTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{

}

void PopulationTableModel::addElement(const QString &element, int value)
{
    return ;
}

void PopulationTableModel::setScoreFilter(float value)
{
    scoreFilter = value ;
}

float PopulationTableModel::getScoreFilter() const
{
    return scoreFilter;
}

void PopulationTableModel::setMutationFilter(bool value)
{
    mutationFilter = value ;
}

void PopulationTableModel::setCrossingoverFilter(bool value)
{
    crossingoverFilter = value ;
}

bool PopulationTableModel::getNew(int gen,int ind) const
{
     return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getNew() ;
}

bool PopulationTableModel::getCrossing(int gen,int ind) const
{
    return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getCrossing() ;
}

bool PopulationTableModel::getMutation(int gen,int ind) const
{
    return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getMutation() ;
}

bool PopulationTableModel::getGenealogy() const
{
    return genealogy ;
}

void PopulationTableModel::setGenealogy(bool value)
{
    genealogy = value ;
}

int PopulationTableModel::getParent1(int gen, int ind) const
{
    return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getParent1() ;
}

int PopulationTableModel::getParent2(int gen, int ind) const
{
    return (*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getParent2() ;
}

QColor PopulationTableModel::getColor(int gen, int ind, double score) const
{
    if((*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore() >= score &&
       ((*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getMutation() == mutationFilter || !mutationFilter )&&
       ((*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getCrossing() == crossingoverFilter || !crossingoverFilter))
    {
        return QColor(0,(*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore()*255,(*mElements)[gen][ind/mElements->get_number_individuals()][ind%mElements->get_number_individuals()].getScore()*255) ;
    }
    else
    {
        return QColor(0,0,0) ;
    }
}

int PopulationTableModel::get_number_individuals() const
{
    return mElements->get_number_individuals();
}

int PopulationTableModel::get_number_cluster() const
{
    return mElements->get_number_cluster();
}

int PopulationTableModel::get_number_crossover() const
{
    return mElements->get_number_crossover();
}

int PopulationTableModel::get_number_mutation() const
{
    return mElements->get_number_mutation();
}
