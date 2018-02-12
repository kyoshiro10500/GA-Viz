#ifndef MODEL_TABLE_POPULATION_H
#define MODEL_TABLE_POPULATION_H

#include "parseur_sources/population_clustered.h"
#include <QAbstractTableModel>
#include <QColor>

/*!
 * \brief PopulationTableModel class : the class representing the model of populationView
 */
class PopulationTableModel : public QAbstractTableModel
{
    Q_OBJECT
    public:
        //! Constructor of the model
        /*!
        * \param population : the population on which the model will rely on
        */
        PopulationTableModel(Population_clustered * population) ;

        //! Holds the number of row of the model of the model
        /*!
         * The number of row corresponds to the number of generations of the population
         */
        int rowCount(const QModelIndex &parent = QModelIndex()) const;

        //! Holds the number of column of the model of the model
        /*!
         * The number of column corresponds to the number of individuals per generations
         */
        int columnCount(const QModelIndex &parent = QModelIndex()) const;

        QVariant data(const QModelIndex &index, int role) const;
        QVariant headerData(int section, Qt::Orientation orientation, int role) const;
        bool setData(const QModelIndex &index, const QVariant &value, int role);

        void addElement(const QString &element, int value);
        Population_clustered * mElements; /*! A pointer to the population*/

        //! Set the value of scoreFilter
        Q_INVOKABLE void setScoreFilter(float value) ;

        //! Set the value of mutationFilter
        Q_INVOKABLE void setMutationFilter(bool value) ;

        //! Set the value of crossingoverFilter
        Q_INVOKABLE void setCrossingoverFilter(bool value) ;

        //! Set the value of showGenealogy
        Q_INVOKABLE void setGenealogy(bool value) ;

        //! Get the value of showGenealogy
        Q_INVOKABLE bool getGenealogy() const;

        //! Get if the individual is new or not
        Q_INVOKABLE bool getNew(int gen,int ind) const ;

        //! Get if the individual is issued from a crossing over or not
        Q_INVOKABLE bool getCrossing(int gen,int ind) const ;

        //! Get if the individual is issued from a mutation or not
        Q_INVOKABLE bool getMutation(int gen,int ind) const ;

        //! Get the value of parent1 of the individual
        Q_INVOKABLE int getParent1(int gen,int ind) const ;

        //! Get the value of parent2 of the individual
        Q_INVOKABLE int getParent2(int gen,int ind) const ;

        //! Get the value of scoreFilter
        Q_INVOKABLE float getScoreFilter() const;

        //! Get the value of the color of the individual
        Q_INVOKABLE QColor getColor(int gen, int ind, double score,double numberMutations, double numberCrossover) const;

        //! Get the value of the number of individuals per cluster
        Q_INVOKABLE int get_number_individuals() const;

        //! Get the value of the number of clusters per generation
        Q_INVOKABLE int get_number_cluster() const ;

        //! Get the value of the number of generation
        Q_INVOKABLE int get_number_generation() const;

        //! Get the value of crossing over of an individual
        Q_INVOKABLE int get_number_crossover() const ;

        //! Get the value of mutations of an individual
        Q_INVOKABLE int get_number_mutation() const ;

        //! Get the value of the best score of the population
        Q_INVOKABLE double get_best_score() const ;

        //! Get the value of the worst score of the population
        Q_INVOKABLE double get_worst_score() const ;

        //! Get the value of the mean score of the population
        Q_INVOKABLE double get_mean_score() const ;

    private:
        float scoreFilter = 0 ; /*! represents the value of the scoreFilter*/
        bool mutationFilter = false ; /*! represents the value of the mutationFilter*/
        bool crossingoverFilter = false ; /*! represents the value of the crossing over filter*/
        bool showGenealogy = false ; /*! represents wether the genealogy should be displayed or not*/
        bool genealogy = false ;

};

#endif // MODEL_TABLE_POPULATION_H
