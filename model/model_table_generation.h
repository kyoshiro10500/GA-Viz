#ifndef MODEL_TABLE_GENERATION_H
#define MODEL_TABLE_GENERATION_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

class GenerationTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:
        GenerationTableModel(Population_clustered population) ;
        int rowCount(const QModelIndex &parent = QModelIndex()) const;
        int columnCount(const QModelIndex &parent = QModelIndex()) const;

        QVariant data(const QModelIndex &index, int role) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role) const;
        bool setData(const QModelIndex &index, const QVariant &value, int role);

        void addElement(const QString &element, int value);
        Population_clustered mElements;

        void setScoreFilter(float value) ;
        void setMutationFilter(bool value) ;
        void setCrossingoverFilter(bool value) ;
        void setGeneration(int value) ;
    private:
        float scoreFilter = 0 ;
        bool mutationFilter = false ;
        bool crossingoverFilter = false ;
        int generationIndex = -1 ;

};

#endif // MODEL_TABLE_GENERATION_H
