#include "gaviz.h"

#include "parseur_sources/parseur.h"

#include <QQmlContext>
#include <QDebug>

bool erasePrefix = true;
#ifdef W_OS_LINUX
  erasePrefix = false;
#endif

bool GAViz::parse (QUrl fileUrl) {

    std::string filePath = fileUrl.path().toStdString();

    if (erasePrefix) {
        filePath = filePath.erase(0, 1);
    }

    Parseur parseur = Parseur(filePath, "ressources/c101.txt") ;
    Population_clustered population = parseur.parseFile();
    populationModel = new PopulationTableModel(population);
    clusterModel = new ClusterTableModel(population);
    generationModel = new GenerationTableModel(population);

    mEngine->rootContext()->setContextProperty("populationModel", populationModel);
    mEngine->rootContext()->setContextProperty("clusterModel", clusterModel);
    mEngine->rootContext()->setContextProperty("generationModel", generationModel);

    // return false if not a GA file
    return true;
}
