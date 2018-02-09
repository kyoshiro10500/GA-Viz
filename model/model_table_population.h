#ifndef MODEL_TABLE_POPULATION_H
#define MODEL_TABLE_POPULATION_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

class PopulationTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:
        PopulationTableModel(Population_clustered * population) ;
        int rowCount(const QModelIndex &parent = QModelIndex()) const;
        int columnCount(const QModelIndex &parent = QModelIndex()) const;

        QVariant data(const QModelIndex &index, int role) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role) const;
        bool setData(const QModelIndex &index, const QVariant &value, int role);

        void addElement(const QString &element, int value);
        Population_clustered * mElements;

        Q_INVOKABLE void setScoreFilter(float value) ;
        Q_INVOKABLE void setMutationFilter(bool value) ;
        Q_INVOKABLE void setCrossingoverFilter(bool value) ;
        Q_INVOKABLE void setGenealogy(bool value) ;

        Q_INVOKABLE bool getGenealogy() const;
        Q_INVOKABLE bool getNew(int gen,int ind) const ;
        Q_INVOKABLE bool getCrossing(int gen,int ind) const ;
        Q_INVOKABLE bool getMutation(int gen,int ind) const ;
        Q_INVOKABLE int getParent1(int gen,int ind) const ;
        Q_INVOKABLE int getParent2(int gen,int ind) const ;
        Q_INVOKABLE float getScoreFilter() const;
        Q_INVOKABLE QColor getColor(int gen, int ind, double score) ;

    private:
        float scoreFilter = 0 ;
        bool mutationFilter = false ;
        bool crossingoverFilter = false ;
        bool showGenealogy = false ;
        bool genealogy = false ;

};

#endif // MODEL_TABLE_POPULATION_H
