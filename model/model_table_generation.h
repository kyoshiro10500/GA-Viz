#ifndef MODEL_TABLE_GENERATION_H
#define MODEL_TABLE_GENERATION_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

/*!
 * \brief GenerationTableModel class : represents the model of the generationView
 */
class GenerationTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:
        //! Constructor of the model*/
        /*!
        * \param population : the population on which the model will rely on
        */
        GenerationTableModel(Population_clustered * population) ;

        //! Holds the number of row of the model of the model*/
        /*!
         * The number of row corresponds to the number of generations of the population
         */
        int rowCount(const QModelIndex &parent = QModelIndex()) const;

        //! Holds the number of column of the model of the model*/
        /*!
         * The number of column corresponds to the number of individuals per generations
         */
        int columnCount(const QModelIndex &parent = QModelIndex()) const;

        QVariant data(const QModelIndex &index, int role) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role) const;
        bool setData(const QModelIndex &index, const QVariant &value, int role);

        void addElement(const QString &element, int value);
        Population_clustered * mElements; /*! A pointer to the population*/

        //! Set the value of scoreFilter*/
        Q_INVOKABLE void setScoreFilter(float value) ;

        //! Set the value of mutationFilter*/
        Q_INVOKABLE void setMutationFilter(bool value) ;

        //! Set the value of crossingoverFilter*/
        Q_INVOKABLE void setCrossingoverFilter(bool value) ;

        //! Set the value of the generation focused on*/
        Q_INVOKABLE void setGeneration(int value) ;

        //! Get the color of the individual*/
        Q_INVOKABLE QColor getColor(int gen, int ind, int index_gen, double score) const;

        //! Get the score of the individual*/
        Q_INVOKABLE double getScore(int gen, int ind) const;

        //! Get the score regarding buses of the individual*/
        Q_INVOKABLE double getScoreBus(int gen, int ind) const ;

        //! Get the score regarding distance of the individual*/
        Q_INVOKABLE double getScoreDistance(int gen, int ind) const ;

        //! Get the distance of the individual*/
        Q_INVOKABLE double getDistance(int gen, int ind) const ;

        //! Get the number of buses of the individual*/
        Q_INVOKABLE int getNumberBuses(int gen, int ind) const ;

        //! Get the number of mutation of the individual*/
        Q_INVOKABLE int getNumberMutation(int gen, int ind) const ;

        //! Get the number of crossing over of the individual*/
        Q_INVOKABLE int getNumberCrossover(int gen, int ind) const ;

        //! Get if the individual is new or not*/
        Q_INVOKABLE bool getNew(int gen,int ind) const ;

        //! Get if the individual has crossing over or not*/
        Q_INVOKABLE bool getCrossing(int gen,int ind) const ;

        //! Get if the individual has mutation or not*/
        Q_INVOKABLE bool getMutation(int gen,int ind) const ;

        //! Get the value of scoreFilter*/
        Q_INVOKABLE float getScoreFilter() const;

        //! Get the focused generation*/
        Q_INVOKABLE int getGeneration() const ;

        //! Get the list of the rank of an individual {MeanScoreRank, BusesRank, DistanceRank} */
        Q_INVOKABLE QList<int> getRang(int gen, int ind) const ;
    private:
        float scoreFilter = 0 ; /*! The scoreFilter value of the model*/
        bool mutationFilter = false ; /*! The mutationFilter value of the model*/
        bool crossingoverFilter = false ; /*! The scrossingoverFilter ofthe model*/
        int generationIndex = -1 ; /*! The focused generation index*/

};

#endif // MODEL_TABLE_GENERATION_H
