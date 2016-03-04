# I2CTool

TARGET = harbour-i2ctool

CONFIG += sailfishapp

DEFINES += "APPVERSION=\\\"$${SPECVERSION}\\\""

message($${DEFINES})

usersguide.path = /usr/share/$${TARGET}
usersguide.files = i2ctool-ug.pdf

INSTALLS += usersguide

SOURCES += src/i2ctool.cpp \
    src/i2cif.cpp \
    src/conv.cpp
	
HEADERS += src/i2cif.h \
    src/conv.h

OTHER_FILES += qml/i2ctool.qml \
    qml/cover/CoverPage.qml \
    qml/pages/Mainmenu.qml \
    rpm/i2ctool.spec \
    harbour-i2ctool.png \
    harbour-i2ctool.desktop \
    qml/pages/Probe.qml \
    qml/pages/ReaderWriter.qml \
    qml/i2ctool.png \
    qml/pages/TohEeprom.qml \
    qml/icon-on.png \
    qml/icon-off.png \
    qml/pages/EditHeaderEntry.qml \
    qml/pages/TohEepromCfgEdit.qml \
    qml/pages/TestWriter.qml \
    i2ctool-ug.pdf
