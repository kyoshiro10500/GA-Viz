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
            if(mElements[index.row()][index.column()/mElements.get_number_individuals()][index.column()%mElements.get_number_individuals()].getScore() >= scoreFilter &&
               (mElements[index.row()][index.column()/mElements.get_number_individuals()][index.column()%mElements.get_number_individuals()].getMutation() == mutationFilter || !mutationFilter) &&
               (mElements[index.row()][index.column()/mElements.get_number_individuals()][index.column()%mElements.get_number_individuals()].getCrossing() == crossingoverFilter || !crossingoverFilter) &&
               index.row() == generationIndex)
            {
                return QColor(0,mElements[index.row()][index.column()/mElements.get_number_individuals()][index.column()%mElements.get_number_individuals()].getScore()*255,mElements[index.row()][index.column()/mElements.get_number_individuals()][index.column()%mElements.get_number_individuals()].getScore()*255) ;
            }
            else
            {
                return QColor(0,0,0) ;
            }
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
