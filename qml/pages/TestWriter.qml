
import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.i2ctool.I2cif 1.0
import harbour.i2ctool.Conv 1.0


Page
{
    id: tstPage
    property string deviceName : "/dev/i2c-1"
    property string result : "Unknown"

    function go(devName, addr, mode, wD, rC)
    {
        if (mode === 0 || mode === 2) // write
        {
            console.log("writing")
            i2cif2.i2cWrite(devName, conv2.toInt(addr), wD)
        }
        if (mode === 1 || mode === 2) // read
        {
            console.log("reading")
            i2cif2.i2cRead(devName, conv2.toInt(addr), rC)
        }
        if (mode === 3) // write, then read with repeated start
        {
            console.log("write, then read with repeated start")
            i2cif2.i2cWriteThenRead(devName, conv2.toInt(addr), wD, rC)
        }
    }

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: column.height

        Column
        {
            id: column

            width: parent.width
            spacing: 0
            property string colTitle: "Extention Board Tests"
            PageHeader
            {
                title: parent.colTitle
            }

            Label
            {
                width: parent.width - 100
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Address and data in hex. Separate databytes with space. Bytecount in decimal."
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
            }

            Rectangle
            {
                color: "transparent"
                height: 50
                width: 1
            }

            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-100
                Label
                {
                    text: "Device address:"
                    wrapMode: Text.NoWrap
                    horizontalAlignment: Text.AlignLeft
                }

                Rectangle
                {
                    color: "transparent"
                    height: 1
                    width: 50
                }

                TextField
                {
                    id: address2
                    placeholderText: "0x23"
                    text: "0x23"
                    inputMethodHints: Qt.ImhPreferUppercase| Qt.ImhSensitiveData | Qt.ImhNoPredictiveText
                    width: parent.width/2-100
                    validator: RegExpValidator { regExp: /[0-9a-fA-F]{1,2}/ }
                    EnterKey.onClicked: focus = false
                }
            }

            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                Button
                {
                    text: "LED On"
                    onClicked:
                    {
                        result = "RUNNING"
                        go(deviceName, address2.text, 0, "0x01", "0")
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
                    text: "LED Off"
                    onClicked:
                    {
                        result = "RUNNING"
                        go(deviceName, address2.text, 0, "0x02", "0")
                    }
                }
            }

            Rectangle
            {
                color: "transparent"
                height: 50
                width: 1
            }

            Label
            {
                width: parent.width - 100
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Status: " +  result
            }
        }
    }

    I2cif
    {
        id: i2cif2
        onI2cError: result = "ERROR"
        onI2cReadResultChanged: result = "OK"
        onI2cWriteOk: result = "OK"
    }

    Conv
    {
        id: conv2
    }
}
