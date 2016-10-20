TEMPLATE = app

QT += qml quick
QT += qml
QT += gui
QT += widgets
QT += multimedia

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc \
    src.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
