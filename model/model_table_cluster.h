#ifndef MODEL_TABLE_CLUSTER_H
#define MODEL_TABLE_CLUSTER_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

//!
//! \brief ClusterTableModel class : The class representing the model of the clusterView
//!
class ClusterTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:
        //! Constructor of the model*/
         /*!
         * \param population : the population on which the model will rely on
         */
        ClusterTableModel(Population_clustered * population) ;

        //! Holds the number of row of the model of the model*/
        /*!
         * The number of row corresponds to the number of generations of the population
         */
        int rowCount(const QModelIndex &parent = QModelIndex()) const;

        //! Holds the number of column of the model of the model*/
        /*!
         * The number of column corresponds to the number of clusters per generations
         */
        int columnCount(const QModelIndex &parent = QModelIndex()) const;

        QVariant data(const QModelIndex &index, int role) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role) const;
        bool setData(const QModelIndex &index, const QVariant &value, int role);

        void addElement(const QString &element, int value);
        Population_clustered * mElements; /*! A pointer to the population*/

    private:

};
#endif // MODEL_TABLE_CLUSTER_H
