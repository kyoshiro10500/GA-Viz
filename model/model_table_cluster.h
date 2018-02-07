#ifndef MODEL_TABLE_CLUSTER_H
#define MODEL_TABLE_CLUSTER_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

class ClusterTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:

        ClusterTableModel(Population_clustered population) ;
        int rowCount(const QModelIndex &parent = QModelIndex()) const;
        int columnCount(const QModelIndex &parent = QModelIndex()) const;

        QVariant data(const QModelIndex &index, int role) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role) const;
        bool setData(const QModelIndex &index, const QVariant &value, int role);

        void addElement(const QString &element, int value);
        Population_clustered mElements;

private:
        bool _isForPopulation ;
};
#endif // MODEL_TABLE_CLUSTER_H
