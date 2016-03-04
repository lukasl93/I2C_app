
import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.i2ctool.I2cif 1.0

Page
{
    id: mainMenuPage

    onStatusChanged: i2cif.requestTohVddState()

    SilicaFlickable
    {
        anchors.fill: parent

        contentHeight: column.height

        Column
        {
            id: column

            width: mainMenuPage.width
            spacing: Theme.paddingLarge
            PageHeader
            {
                title: "I2C Tool"
            }

            ComboBox
            {
                id: devname
                anchors.horizontalCenter: parent.horizontalCenter
                label: "Device: "
                currentIndex: 1
                menu: ContextMenu
                {
                    MenuItem { text: "/dev/i2c-0" }
                    MenuItem { text: "/dev/i2c-1" }
                    MenuItem { text: "/dev/i2c-3" }
                    MenuItem { text: "/dev/i2c-4" }
                    MenuItem { text: "/dev/i2c-12" }
                }
            }


            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                Button
                {
                    text: "enable Vdd"
                    onClicked: i2cif.tohVddSet("on")
                }
                Image
                {
                    source: i2cif.tohVddStatus ? "../icon-on.png" : "../icon-off.png"
                }
                Button
                {
                    text: "disable Vdd"
                    onClicked: i2cif.tohVddSet("off")
                }

            }

            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-50
                Button
                {
                    text: "Probe"
                    onClicked: pageStack.push(Qt.resolvedUrl("Probe.qml"), {deviceName: devname.value})
                }

                Rectangle
                {
                    color: "transparent"
                    height: 1
                    width: 10
                }

                Button
                {
                    text: "Reader/Writer"
                    onClicked: pageStack.push(Qt.resolvedUrl("ReaderWriter.qml"), {deviceName: devname.value})
                }
            }
            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-50
                Button
                {
                    //anchors.horizontalCenter: parent.horizontalCenter
                    text: "TOH EEPROM"
                    onClicked:
                    {
                        pageStack.push(Qt.resolvedUrl("TohEeprom.qml"), {deviceName: "/dev/i2c-1"})
                    }
                }

                Rectangle
                {
                    color: "transparent"
                    height: 1
                    width: 10
                }

                Button
                {
                    //anchors.horizontalCenter: parent.horizontalCenter
                    text: "TOH Board Test"
                    onClicked:
                    {
                        pageStack.push(Qt.resolvedUrl("TestWriter.qml"), {deviceName: devname.value})
                    }
                }
             }

            Rectangle
            {
                height: 50
                width: 1
                color: "transparent"
            }

            Image
            {
                source: "../i2ctool.png"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label
            {
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: "I2C Tool ver " + Qt.application.version
            }
            Label
            {
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: "(C) 2015 Kimmoli"
            }
            Button
            {
                id: ugButton
                anchors.horizontalCenter: parent.horizontalCenter
                text: "User's guide (PDF)"
                enabled: !openingUsersGuide

                onClicked:
                {
                    openingUsersGuide = true
                    i2cif.openUsersGuide()
                }
                Row
                {
                    anchors.centerIn: parent
                    spacing: Theme.paddingMedium
                    visible: openingUsersGuide

                    Label
                    {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Opening..."
                        color: Theme.highlightColor
                    }
                    BusyIndicator
                    {
                        anchors.verticalCenter: parent.verticalCenter
                        size: BusyIndicatorSize.Small
                        running: openingUsersGuide
                    }
                }
            }
        }
    }

    I2cif
    {
        id: i2cif
    }

}


