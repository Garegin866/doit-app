#include "pagecontroller.h"

PageController::PageController(QObject *parent) : QObject(parent) {

}

QString PageController::getInitialPage() {
    return getPagePath(PageLoader::PageEnum::PageStart);
}

QString PageController::getPagePath(PageLoader::PageEnum page) {
    QMetaEnum metaEnum = QMetaEnum::fromType<PageLoader::PageEnum>();
    QString pageName = metaEnum.valueToKey(static_cast<int>(page));
    return "qrc:/Pages/" + pageName + ".qml";
}
