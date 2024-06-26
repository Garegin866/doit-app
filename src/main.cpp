#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/TaskListModel/tasklistmodel.h"
#include "src/doitapplication.h"
#include "src/pagecontroller.h"

int main(int argc, char *argv[])
{
    DoItApplication app(argc, argv);

    app.registerTypes();
    app.loadFonts();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    PageController *pageController = new PageController();
    engine.rootContext()->setContextProperty("PageController", pageController);

    TaskListModel *taskListModel = new TaskListModel();
    engine.rootContext()->setContextProperty("TaskListModel", taskListModel);

    engine.load(url);

    return app.exec();
}
