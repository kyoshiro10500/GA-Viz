#-------------------------------------------------
#
# Project created by QtCreator 2017-11-04T09:49:22
#
#-------------------------------------------------

QT       += qml quick
QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = GA_Viz
TEMPLATE = app


SOURCES += main.cpp\
    parseur_sources/cluster.cpp \
    parseur_sources/individu.cpp \
    parseur_sources/parseur.cpp \
    parseur_sources/points.cpp \
    model/model_table_population.cpp \
    parseur_sources/population_clustered.cpp \
    parseur_sources/generation_clustered.cpp \
    model/model_table_cluster.cpp \
    model/model_table_generation.cpp \
    gaviz.cpp

HEADERS  += parseur_sources/cluster.h \
    parseur_sources/individu.h \
    parseur_sources/parseur.h \
    parseur_sources/points.h \
    ui_ga_viz.h \
    parseur_sources/population_clustered.h \
    parseur_sources/generation_clustered.h \
    model/model_table_cluster.h \
    model/model_table_generation.h \
    model/model_table_population.h \
    gaviz.h

FORMS    += ga_viz.ui

DISTFILES += \
    debug/GA_Viz.exe \
    ressources/c101.txt \
    ressources/GA Out \
    ressources/GA Out - Clustered \
    object_script.GA_Viz.Debug \
    object_script.GA_Viz.Release \
    ressources/GA Out \
    ressources/GA Out - Clustered \
    ressources/GA Out \
    ressources/GA Out - Clustered \
    Filter.qml \
    main.qml \
    PopulationView.qml \
    ToolBarButton.qml \
    qtquickcontrols2.conf \
    ClusterView.qml \
    GenerationView.qml

RESOURCES += \
    qml.qrc
