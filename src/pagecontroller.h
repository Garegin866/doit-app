#ifndef PAGECONTROLLER_H
#define PAGECONTROLLER_H

#include <QObject>
#include <QQmlEngine>

namespace PageLoader
{
Q_NAMESPACE
enum class PageEnum {
    PageStart = 0,
    PageSetup,
    PageHome
};
Q_ENUM_NS(PageEnum)

static void declareQmlPageEnum()
{
    qmlRegisterUncreatableMetaObject(PageLoader::staticMetaObject, "PageEnum", 1, 0, "PageEnum", "Error: only enums");
}

}

class PageController : public QObject
{
    Q_OBJECT
public:
    explicit PageController(QObject *parent = nullptr);

public slots:
    QString getInitialPage();
    QString getPagePath(PageLoader::PageEnum page);

    // void keyPressEvent(Qt::Key key);

    // void closeApplication();

signals:
    void goToPage(PageLoader::PageEnum page, bool slide = true);
    void goToStartPage();
    void openMenu();

};

#endif // PAGECONTROLLER_H
