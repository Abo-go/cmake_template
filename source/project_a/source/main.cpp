#include "MainWindow.h"
#include <QApplication>

int main(int argc, char* argv[])
{
    QApplication a(argc, argv);

    QFont font = a.font();
    font.setPointSize(16);
    a.setFont(font);

    MainWindow mw;

    mw.show();
    a.exec();

    return 0;
}