#include "doitapplication.h"

#include <QFontDatabase>
#include <QQuickStyle>
#include <QIcon>

DoItApplication::DoItApplication(int &argc, char *argv[]) : QGuiApplication(argc, argv) {
    QGuiApplication::setWindowIcon(QIcon(":/images/logo.svg"));

    QGuiApplication::setApplicationName(APPLICATION_NAME);
    QGuiApplication::setOrganizationName(ORGANIZATION_NAME);
    QGuiApplication::setApplicationDisplayName(APPLICATION_NAME);
}

void DoItApplication::registerTypes() {
    PageLoader::declareQmlPageEnum();
}

void DoItApplication::loadFonts() {
    QQuickStyle::setStyle("Basic");

    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Regular.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Bold.ttf");
}
