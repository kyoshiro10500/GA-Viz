#include "model/model_table_generation.h"
#include <QDebug>

GenerationTableModel::GenerationTableModel(Population_clustered population) : mElements(population)
{

}

int GenerationTableModel::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements.get_number_individuals()*mElements.get_number_cluster();
}

int GenerationTableModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements.get_number_generation();
}


QVariant GenerationTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= mElements.get_number_generation())
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

QColor GenerationTableModel::getColor(int gen, int ind, int index_gen,double score)
{
    if(mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getScore() >= score &&
       (mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getMutation() == mutationFilter || !mutationFilter )&&
       (mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getCrossing() == crossingoverFilter || !crossingoverFilter) &&
        gen == index_gen)
    {
        return QColor(0,mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getScore()*255,mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getScore()*255) ;
    }
    else if(gen == index_gen)
    {
        return QColor(0,0,0) ;
    }
    else
    {
        return QColor(0,mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getScore()*35,mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getScore()*35) ;
    }
}

float GenerationTableModel::getScoreFilter() const
{
    return scoreFilter;
}


bool GenerationTableModel::getNew(int gen,int ind) const
{
     return mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getNew() ;
}

bool GenerationTableModel::getCrossing(int gen,int ind) const
{
    return mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getCrossing() ;
}

bool GenerationTableModel::getMutation(int gen,int ind) const
{
    return mElements[gen][ind/mElements.get_number_individuals()][ind%mElements.get_number_individuals()].getMutation() ;
}


