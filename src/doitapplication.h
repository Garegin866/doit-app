#ifndef DOITAPPLICATION_H
#define DOITAPPLICATION_H

#include <QGuiApplication>

#include "src/pagecontroller.h"

#define APPLICATION_NAME    "DoIt"
#define ORGANIZATION_NAME   "Horizon"

class DoItApplication : public QGuiApplication
{
public:
    DoItApplication(int &argc, char *argv[]);

    void registerTypes();
    void loadFonts();

};

#endif // DOITAPPLICATION_H
