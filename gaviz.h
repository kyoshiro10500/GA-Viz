#ifndef GAVIZ_H
#define GAVIZ_H

#include "model/model_table_cluster.h"
#include "model/model_table_population.h"
#include "model/model_table_generation.h"

#include <QObject>
#include <QQmlApplicationEngine>

/*!
 * \brief GAViz class : main class of the application. Holds the models which are used.
 */
class GAViz : public QObject {
    Q_OBJECT
public:
    explicit GAViz (QQmlApplicationEngine *engine, QObject* parent = 0) : QObject(parent), mEngine(engine)  {}

    //! Parse the file which is defined by the QUrl. Used by the file selector*/
    Q_INVOKABLE bool parse(QUrl fileUrl);

public:
    PopulationTableModel *populationModel; /*! The model for the populationView*/
    ClusterTableModel *clusterModel; /*! The model for the clusterView*/
    GenerationTableModel *generationModel; /*! The model for the generationView*/
    Population_clustered * population ; /*! The population used by the models*/

private:
    QQmlApplicationEngine *mEngine; /*! The engine of the application. Will render and calculate everything*/
};

#endif // GAVIZ_H
