#ifndef MODEL_TABLE_GENERATION_H
#define MODEL_TABLE_GENERATION_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

class GenerationTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:
        GenerationTableModel(Population_clustered * population) ;
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
        Q_INVOKABLE void setGeneration(int value) ;

        Q_INVOKABLE QColor getColor(int gen, int ind, int index_gen, double score) ;
        Q_INVOKABLE bool getNew(int gen,int ind) const ;
        Q_INVOKABLE bool getCrossing(int gen,int ind) const ;
        Q_INVOKABLE bool getMutation(int gen,int ind) const ;
        Q_INVOKABLE float getScoreFilter() const;
        Q_INVOKABLE int getGeneration() const ;
        Q_INVOKABLE double getScoreBuses(int gen, int ind) const ;
        Q_INVOKABLE double getScoreDistance(int gen,int ind) const ;
    private:
        float scoreFilter = 0 ;
        bool mutationFilter = false ;
        bool crossingoverFilter = false ;
        int generationIndex = -1 ;

};

#endif // MODEL_TABLE_GENERATION_H
