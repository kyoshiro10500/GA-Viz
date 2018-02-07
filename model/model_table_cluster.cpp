#include "model/model_table_cluster.h"
#include <QDebug>

ClusterTableModel::ClusterTableModel(Population_clustered population) : mElements(population)
{

}

int ClusterTableModel::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements.get_number_cluster() ;
}

int ClusterTableModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : mElements.get_number_generation();
}


QVariant ClusterTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= mElements.get_number_generation())
    {
        return QVariant();
    }

    switch (role)
    {
        case Qt::TextAlignmentRole :
           return Qt::AlignCenter;
           break ;
        case Qt::BackgroundColorRole :
            return QColor(140,140,140) ;
            break ;
        case Qt::DisplayRole:
            return QStringLiteral("C%1").arg(index.column()+1);
            break ;
        case Qt::EditRole:
            break;
    }

    return QVariant();

}

QVariant ClusterTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
    {
        return QStringLiteral("C%1").arg(section +1);
    }
    if (orientation == Qt::Vertical && role == Qt::DisplayRole)
    {
        return QStringLiteral("G%1").arg(section +1);
    }
    return QVariant();
}


bool ClusterTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    return true ;
}

void ClusterTableModel::addElement(const QString &element, int value)
{
    return ;
}
