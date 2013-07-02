# Add more folders to ship with the application, here

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT+= declarative
symbian:TARGET.UID3 = 0xE794C24F

!symbian: {
    DEFINES += HAVE_GLWIDGET
    QT += opengl
}

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices Location LocalServices ReadUserData WriteUserData

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=
maemo5 {
  CONFIG += mobility11 qdbus
} else {
  CONFIG += mobility
}
MOBILITY += location
VERSION = 0.2.0

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    apphelper.cpp

OTHER_FILES += \
    Poluilla.desktop \
    Poluilla.svg \
    Poluilla.png \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog \
    qml/main.qml \
    qml/components/TrackPage.qml \
    qml/components/StartPage.qml \
    qml/components/CustomTheme.qml \
    qml/components/BlueButtonEx.qml \
    qml/components/GreenButtonEx.qml \
    qml/components/MainPage.qml \
    qml/components/UploadPage.qml \
    qml/js/script.js

RESOURCES += \
    res.qrc

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic

HEADERS += \
    apphelper.h












