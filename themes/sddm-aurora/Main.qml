import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: root
    width: 1920
    height: 1080

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
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 40
        spacing: 12

        Item {
            width: 38
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            
            // Main Battery Body
            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: 4
                color: "transparent"
                border.color: "#111111"
                border.width: 2
                radius: 4

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: Qt.rgba(0, 0, 0, 0.2)
                    radius: 8
                    samples: 16
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.margins: 3
                    
                    width: (parent.width - 6) * (typeof battery !== "undefined" ? battery.percent / 100.0 : 1.0)
                    color: "#111111"
                    radius: 2
                }
            }

            Rectangle {
                width: 4
                height: 8
                color: "#111111"
                radius: 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Percentage Text
        Text {
            text: (typeof battery !== "undefined" ? battery.percent : "100") + "%"
            color: "#111111"
            font.pixelSize: 20
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter

            layer.enabled: true
            layer.effect: DropShadow {
                color: Qt.rgba(0, 0, 0, 0.1)
                radius: 4
                samples: 8
            }
        }
    }

    Item {
        id: loginContainer
        width: 420
        height: 500
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
            radius: 24
            color: Qt.rgba(0, 0, 0, 0.2) 
            border.color: Qt.rgba(1, 1, 1, 0.6) 
            border.width: 2

            Column {
                anchors.centerIn: parent
                width: parent.width * 0.8
                spacing: 25

                Rectangle {
                    width: 120
                    height: 120
                    radius: 60
                    color: Qt.rgba(0, 0, 0, 0.3)
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: Qt.rgba(1, 1, 1, 0.8)
                    border.width: 2
                }

                Text {
                    id: usernameDisplay
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: (userModel.lastUser !== "root" && userModel.lastUser !== "") ? userModel.lastUser : "Guest"
                    color: "white"
                    font.pixelSize: 24 
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
                    placeholderText: "Password"
                    placeholderTextColor: Qt.rgba(1, 1, 1, 0.6)
                    echoMode: TextInput.Password
                    color: "white"
                    font.pixelSize: 18
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
                    contentItem: Text {
                        text: parent.text
                        color: "white" 
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
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: sessionSelector.hovered ? "#333333" : "#111111"
            border.color: "#333333"
            border.width: 2
            radius: 10
            Behavior on color { ColorAnimation { duration: 150 } }
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: Qt.rgba(0, 0, 0, 0.3)
                radius: 15
                samples: 30
            }
        }

        popup: Popup {
            y: sessionSelector.height + 8 
            width: sessionSelector.width
            implicitHeight: contentItem.implicitHeight + 10 
            padding: 5

            background: Rectangle {
                color: "#111111"
                border.color: "#333333"
                border.width: 2
                radius: 10
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: Qt.rgba(0, 0, 0, 0.5)
                    radius: 20
                    samples: 40
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
        spacing: 20

        component PowerButton: Button {
            id: pwrBtn
            width: 120
            height: 45
            
            contentItem: Text { 
                text: pwrBtn.text 
                color: "white" 
                font.bold: true 
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
                scale: pwrBtn.pressed ? 0.95 : (pwrBtn.hovered ? 1.05 : 1.0)
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
                    radius: 12
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
            text: "Restart"
            onClicked: sddm.reboot()
        }

        PowerButton {
            text: "Shutdown"
            onClicked: sddm.powerOff()
        }
    }
}
