#include <QFile>
#include <QTextStream>
#include "apphelper.h"

AppHelper::AppHelper(QObject *parent) :
    QObject(parent)
{
}

Q_INVOKABLE void AppHelper::write(QString path, QString data)
{
    QFile file( path );
    file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
    QTextStream out(&file);
    out << data;
    file.close();
}
