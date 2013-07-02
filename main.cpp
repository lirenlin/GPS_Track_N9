#include <QtGui/QApplication>
#include <QtDeclarative>
#include "apphelper.h"
#include <QDeclarativeEngine>

#ifdef HAVE_GLWIDGET
#include <QGLWidget>
#endif

int main(int argc, char *argv[])
{
#ifdef Q_OS_SYMBIAN
    QApplication::setGraphicsSystem(QLatin1String("openvg"));
#elif defined(Q_WS_MAEMO_5) || defined(Q_WS_MAEMO_6)
    QApplication::setGraphicsSystem(QLatin1String("opengl"));
#else
    QApplication::setGraphicsSystem(QLatin1String("opengl"));
#endif

    QApplication app(argc, argv);
    //app.setProperty("NoMStyle", true);

    QDeclarativeView viewer;

#ifdef HAVE_GLWIDGET
    QGLWidget *glWidget = new QGLWidget(&viewer);
    viewer.setViewport(glWidget);
#endif
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.viewport()->setAttribute(Qt::WA_NoSystemBackground);

#ifdef Q_WS_MAEMO_5
    viewer.engine()->addImportPath(QString("/opt/qtm11/imports"));
    viewer.engine()->addPluginPath(QString("/opt/qtm11/plugins"));
#endif

    //WindowHelper *windowHelper = new WindowHelper();
    AppHelper *appHelper = new AppHelper();
    viewer.rootContext()->setContextProperty("helper", appHelper);
    //viewer.rootContext()->setContextProperty("windowHelper", windowHelper);

    //viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/main.qml"));
#ifdef Q_OS_SYMBIAN
    viewer.showFullScreen();
#elif defined(Q_WS_MAEMO_5)
    viewer.showFullScreen();
#elif defined(Q_WS_SIMULATOR)
    viewer.showFullScreen();
#else
    viewer.showFullScreen();
    // we don't want full screen on meego tablets at least
    //viewer.showMaximized();
#endif

    return app.exec();
    /*
    QDeclarativeView view;
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.showFullScreen();
    AppHelper *appHelper = new AppHelper();
    view.rootContext()->setContextProperty("helper", appHelper);
    return app.exec();
    */
}
