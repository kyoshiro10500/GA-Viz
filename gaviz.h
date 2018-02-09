#ifndef GAVIZ_H
#define GAVIZ_H

#include "model/model_table_cluster.h"
#include "model/model_table_population.h"
#include "model/model_table_generation.h"

#include <QObject>
#include <QQmlApplicationEngine>

class GAViz : public QObject {
    Q_OBJECT
public:
    explicit GAViz (QQmlApplicationEngine *engine, QObject* parent = 0) : QObject(parent), mEngine(engine)  {}

    Q_INVOKABLE bool parse(QUrl fileUrl);

public:
    PopulationTableModel *populationModel;
    ClusterTableModel *clusterModel;
    GenerationTableModel *generationModel;
    Population_clustered * population ;

private:
    QQmlApplicationEngine *mEngine;
};

#endif // GAVIZ_H
