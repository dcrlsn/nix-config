import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: root
    width: 1920
    height: 1080

    property string mainFont: "FiraCode Nerd Font"
    property string iconFont: "FiraCode Nerd Font Propo"
    property bool hasBattery: (typeof battery !== "undefined" && battery !== null && battery.percent !== undefined)
    property int batteryPercent: hasBattery ? battery.percent : 0

    Image {
        id: bg
        anchors.fill: parent
        source: "assets/background.png" 
        fillMode: Image.PreserveAspectCrop
    }

    Column {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 40
        spacing: -5

        Text {
            id: timeDisplay
            color: "white"
            font.family: root.mainFont
            font.pixelSize: 72
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: Qt.rgba(0, 0, 0, 0.6)
                radius: 15
                samples: 30
                verticalOffset: 2
            }
        }

        Text {
            id: dateDisplay
            color: Qt.rgba(1, 1, 1, 0.8)
            font.family: root.mainFont
            font.pixelSize: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: Qt.rgba(0, 0, 0, 0.6)
                radius: 10
                samples: 20
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                var d = new Date()
                timeDisplay.text = d.toLocaleTimeString(Qt.locale("en_US"), "h:mm AP")
                dateDisplay.text = d.toLocaleDateString(Qt.locale("en_US"), "dddd, MMMM d")
            }
            Component.onCompleted: triggered()
        }
    }

    Row {
        id: batteryIndicator
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 40
        spacing: 12
        visible: root.hasBattery

        Item {
            width: 38
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            
            // Main Battery Body
            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: 4
                color: "transparent"
                border.color: "white"
                border.width: 2
                radius: 4

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: Qt.rgba(0, 0, 0, 0.4)
                    radius: 8
                    samples: 16
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.margins: 3
                    
                    width: Math.max(0, (parent.width - 6) * Math.min(1.0, root.batteryPercent / 100.0))
                    color: "white"
                    radius: 2
                }
            }

            Rectangle {
                width: 4
                height: 8
                color: "white"
                radius: 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: Qt.rgba(0, 0, 0, 0.4)
                    radius: 4
                    samples: 8
                }
            }
        }

        // Percentage Text
        Text {
            text: root.batteryPercent + "%"
            color: "white"
            font.family: root.mainFont
            font.pixelSize: 20
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter

            layer.enabled: true
            layer.effect: DropShadow {
                color: Qt.rgba(0, 0, 0, 0.5)
                radius: 8
                samples: 16
            }
        }
    }

    Item {
        id: loginContainer
        width: 380
        height: 250
        anchors.centerIn: parent

        ShaderEffectSource {
            id: blurSource
            sourceItem: bg
            anchors.fill: parent
            sourceRect: Qt.rect(loginContainer.x, loginContainer.y, loginContainer.width, loginContainer.height)
        }

        GaussianBlur {
            anchors.fill: parent
            source: blurSource
            radius: 40 
            samples: 80
        }

        Rectangle {
            anchors.fill: parent
            radius: 20
            color: Qt.rgba(0, 0, 0, 0.2) 
            border.color: Qt.rgba(1, 1, 1, 0.6) 
            border.width: 2

            Column {
                anchors.centerIn: parent
                width: parent.width * 0.82
                spacing: 18

                Text {
                    id: usernameDisplay
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: (userModel.lastUser !== "root" && userModel.lastUser !== "") ? userModel.lastUser : "Guest"
                    color: "white"
                    font.family: root.mainFont
                    font.pixelSize: 22 
                    font.bold: true
                    
                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: Qt.rgba(0, 0, 0, 0.5)
                        radius: 8
                        samples: 16
                    }
                }

                TextField {
                    id: passwordField
                    width: parent.width
                    height: 45
                    placeholderText: "Password"
                    placeholderTextColor: Qt.rgba(1, 1, 1, 0.6)
                    echoMode: TextInput.Password
                    color: "white"
                    font.family: root.mainFont
                    font.pixelSize: 16
                    focus: true 
                    leftPadding: 14
                    rightPadding: 14
                    background: Rectangle {
                        color: Qt.rgba(0, 0, 0, 0.5)
                        radius: 12
                    }
                    onAccepted: sddm.login(usernameDisplay.text, passwordField.text, sessionSelector.currentIndex)
                }

                Button {
                    id: loginBtn
                    text: "LOGIN"
                    width: parent.width
                    height: 45
                    contentItem: Text {
                        text: parent.text
                        color: "white" 
                        font.family: root.mainFont
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        color: loginBtn.hovered ? "#333333" : "#111111"
                        scale: loginBtn.pressed ? 0.95 : (loginBtn.hovered ? 1.02 : 1.0)
                        radius: 12
                        border.color: "#333333"
                        border.width: 2
                        
                        Behavior on color { ColorAnimation { duration: 150 } }
                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            color: Qt.rgba(0, 0, 0, 0.4)
                            radius: 15
                            samples: 30
                            verticalOffset: 4
                        }
                    }
                    onClicked: sddm.login(usernameDisplay.text, passwordField.text, sessionSelector.currentIndex)
                }
            }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            color: Qt.rgba(0, 0, 0, 0.3)
            radius: 30
            samples: 60
        }
    }

    ComboBox {
        id: sessionSelector
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 40
        width: 200
        height: 45
        
        model: sessionModel 
        textRole: "name"

        Component.onCompleted: {
            for (var i = 0; i < count; ++i) {
                var sessionName = textAt(i).toLowerCase();
                if (sessionName.indexOf("plasma") !== -1 || sessionName.indexOf("kde") !== -1) {
                    currentIndex = i;
                    break;
                }
            }
        }
        
        contentItem: Text {
            text: parent.displayText
            color: "white"
            font.family: root.mainFont
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Item {
            scale: sessionSelector.pressed ? 0.95 : (sessionSelector.hovered ? 1.03 : 1.0)
            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

            ShaderEffectSource {
                id: sessionBlurSource
                sourceItem: bg
                anchors.fill: parent
                sourceRect: Qt.rect(sessionSelector.x, sessionSelector.y, sessionSelector.width, sessionSelector.height)
            }

            GaussianBlur {
                anchors.fill: parent
                source: sessionBlurSource
                radius: 40
                samples: 80
            }

            Rectangle {
                anchors.fill: parent
                radius: 12
                color: sessionSelector.pressed ? Qt.rgba(0, 0, 0, 0.35) : (sessionSelector.hovered ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(0, 0, 0, 0.2))
                border.color: sessionSelector.hovered ? Qt.rgba(1, 1, 1, 0.9) : Qt.rgba(1, 1, 1, 0.6)
                border.width: 2

                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }
            }

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: Qt.rgba(0, 0, 0, 0.3)
                radius: 20
                samples: 40
                verticalOffset: 3
            }
        }

        popup: Popup {
            id: sessionPopup
            y: sessionSelector.height + 8 
            width: sessionSelector.width
            implicitHeight: contentItem.implicitHeight + 10 
            padding: 5

            background: Item {
                ShaderEffectSource {
                    id: popupBlurSource
                    sourceItem: bg
                    anchors.fill: parent
                    sourceRect: Qt.rect(sessionSelector.x, sessionSelector.y + sessionSelector.height + 8, sessionSelector.width, sessionPopup.height)
                }

                GaussianBlur {
                    anchors.fill: parent
                    source: popupBlurSource
                    radius: 40
                    samples: 80
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 12
                    color: Qt.rgba(0, 0, 0, 0.25)
                    border.color: Qt.rgba(1, 1, 1, 0.6)
                    border.width: 2
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: Qt.rgba(0, 0, 0, 0.4)
                    radius: 20
                    samples: 40
                    verticalOffset: 4
                }
            }

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: sessionSelector.popup.visible ? sessionSelector.delegateModel : null
                currentIndex: sessionSelector.highlightedIndex

                header: Item {
                    width: parent.width
                    height: 35
                    
                    Text {
                        text: "Desktop Session"
                        color: Qt.rgba(1, 1, 1, 0.4) 
                        font.family: root.mainFont
                        font.pixelSize: 12
                        font.bold: true
                        font.capitalization: Font.AllUppercase
                        anchors.centerIn: parent
                    }
                    
                    Rectangle {
                        width: parent.width * 0.8
                        height: 1
                        color: Qt.rgba(1, 1, 1, 0.1)
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

    Row {
        id: powerRow
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 40
        spacing: 16

        component PowerButton: Button {
            id: pwrBtn
            width: 50
            height: 50
            padding: 0
            leftPadding: 0
            rightPadding: 0
            topPadding: 0
            bottomPadding: 0
            
            ToolTip.delay: 300
            ToolTip.timeout: 3000
            
            contentItem: Text { 
                anchors.centerIn: parent
                text: pwrBtn.text 
                color: "white" 
                font.family: root.iconFont
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter 
                verticalAlignment: Text.AlignVCenter 

                layer.enabled: true
                layer.effect: DropShadow {
                    color: Qt.rgba(0, 0, 0, 0.6)
                    radius: 4
                    samples: 8
                }
            }
            
            background: Item { 
                scale: pwrBtn.pressed ? 0.93 : (pwrBtn.hovered ? 1.08 : 1.0)
                Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }

                ShaderEffectSource {
                    id: pwrBlurSource
                    sourceItem: bg
                    anchors.fill: parent
                    sourceRect: Qt.rect(powerRow.x + pwrBtn.x, powerRow.y + pwrBtn.y, pwrBtn.width, pwrBtn.height)
                }

                GaussianBlur {
                    anchors.fill: parent
                    source: pwrBlurSource
                    radius: 40
                    samples: 80
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 14
                    color: pwrBtn.pressed ? Qt.rgba(0, 0, 0, 0.35) : (pwrBtn.hovered ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(0, 0, 0, 0.2))
                    border.color: pwrBtn.hovered ? Qt.rgba(1, 1, 1, 0.9) : Qt.rgba(1, 1, 1, 0.6)
                    border.width: 2

                    Behavior on color { ColorAnimation { duration: 150 } }
                    Behavior on border.color { ColorAnimation { duration: 150 } }
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: Qt.rgba(0, 0, 0, 0.3)
                    radius: 20
                    samples: 40
                    verticalOffset: 3
                }
            }
        }

        PowerButton {
            text: "\uf0c0"
            ToolTip.visible: hovered
            ToolTip.text: "Switch User"
            onClicked: {
                if (typeof userModel !== "undefined" && userModel.count > 1) {
                    var nextIdx = (userModel.lastIndex + 1) % userModel.count
                    userModel.lastIndex = nextIdx
                    var nextName = (userModel.nameAt ? userModel.nameAt(nextIdx) : userModel.get(nextIdx).name)
                    usernameDisplay.text = nextName
                }
            }
        }

        PowerButton {
            text: "\uf021"
            ToolTip.visible: hovered
            ToolTip.text: "Restart"
            onClicked: sddm.reboot()
        }

        PowerButton {
            text: "\uf011"
            ToolTip.visible: hovered
            ToolTip.text: "Shutdown"
            onClicked: sddm.powerOff()
        }
    }
}
