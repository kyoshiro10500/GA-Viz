#include "gaviz.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QObject::connect((QObject*)&engine, SIGNAL(quit()), &app, SLOT(quit()));
    GAViz gaviz(&engine);
    engine.rootContext()->setContextProperty("gaviz", &gaviz);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
