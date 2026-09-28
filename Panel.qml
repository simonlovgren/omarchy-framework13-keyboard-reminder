import QtQuick
import qs.Ui
import qs.Commons

Panel {
  id: root
  moduleName: "maustronaut.framework13-fn-keys"
  ipcTarget: "maustronaut.framework13-fn-keys"
  manageIpc: false

  property var anchorItem: null
  property var hostWidget: null
  readonly property var barIdentity: hostWidget || root

  readonly property color foreground: bar ? bar.foreground : Color.foreground
  readonly property color mutedForeground: Qt.rgba(foreground.r, foreground.g, foreground.b, 0.7)
  readonly property color keyFill: Color.popups.background
  readonly property color actionFill: Style.selectedFillFor(foreground, Color.accent)
  readonly property color keyBorder: Style.normalBorderFor(foreground, Color.accent)

  function open() {
    controller.show()
  }

  function close() {
    controller.hide()
  }

  function toggle() {
    opened ? close() : open()
  }

  function closeForPopoutSwitch() {
    popoutSwitchClosing = true
    close()
    Qt.callLater(function() { popoutSwitchClosing = false })
  }

  KeyboardPanel {
    id: popup
    anchorItem: root.anchorItem
    owner: root.barIdentity
    bar: root.bar
    open: root.opened
    contentWidth: popup.fittedContentWidth(
      keyboard.width + popup.padding * 2
      + Border.left(popup.borderSpec) + Border.right(popup.borderSpec)
    )
    contentHeight: popup.fittedContentHeight(keyboard.implicitHeight)

    Column {
      id: keyboard
      spacing: Style.space(14)

      readonly property real unit: Style.space(45)
      readonly property real gap: Style.space(5)
      // Every physical row spans 15 units. Declare it so KeyboardPanel
      // encloses repeater-backed rows.
      width: 15 * unit + 14 * gap
      readonly property var rows: [
        [
          { key: "Esc", action: "Fn", width: 2 },
          { key: "F1", action: "BR-" },
          { key: "F2", action: "BR+" },
          { key: "F3", action: "KB-" },
          { key: "F4", action: "KB+" },
          { key: "F5", action: "RF" },
          { key: "F6", action: "MIC" },
          { key: "F7", action: "PREV" },
          { key: "F8", action: "PLAY" },
          { key: "F9", action: "NEXT" },
          { key: "F10", action: "MUTE" },
          { key: "F11", action: "VOL-" },
          { key: "F12", action: "VOL+", width: 2 }
        ],
        [
          { key: "`" }, { key: "1" }, { key: "2" }, { key: "3" }, { key: "4" },
          { key: "5" }, { key: "6" }, { key: "7" }, { key: "8" }, { key: "9" },
          { key: "0" }, { key: "-" }, { key: "=" }, { key: "Backspace", width: 2 }
        ],
        [
          { key: "Tab", width: 1.5 }, { key: "Q" }, { key: "W" }, { key: "E" },
          { key: "R" }, { key: "T" }, { key: "Y" }, { key: "U" }, { key: "I" },
          { key: "O" }, { key: "P" }, { key: "[" }, { key: "]" }, { key: "\\", width: 1.5 }
        ],
        [
          { key: "Caps", width: 1.75 }, { key: "A" }, { key: "S" }, { key: "D" },
          { key: "F" }, { key: "G" }, { key: "H" }, { key: "J" }, { key: "K" },
          { key: "L" }, { key: ";" }, { key: "'" }, { key: "Enter", width: 2.25 }
        ],
        [
          { key: "Shift", width: 2.25 }, { key: "Z" }, { key: "X" }, { key: "C" },
          { key: "V" }, { key: "B" }, { key: "N" }, { key: "M" }, { key: "," },
          { key: "." }, { key: "/" }, { key: "Shift", width: 2.75 }
        ],
        [
          { key: "Ctrl", width: 1.25 }, { key: "Super", width: 1.25 },
          { key: "Alt", width: 1.25 }, { key: "Fn", action: "Fn", width: 1.25 },
          { key: "Space", width: 4.5 }, { key: "Alt", width: 1.25 },
          { key: "Ctrl", width: 1.25 }, { key: "←" }, { key: "↑↓" }, { key: "→" }
        ]
      ]

      Text {
        id: title
        text: "FRAMEWORK LAPTOP 13"
        color: root.foreground
        font.family: root.bar ? root.bar.fontFamily : Style.font.family
        font.bold: true
        font.pixelSize: Style.font.title
      }

      Text {
        id: instructions
        text: "Hold Fn, then press marked top-row key"
        color: root.mutedForeground
        font.family: root.bar ? root.bar.fontFamily : Style.font.family
        font.pixelSize: Style.font.bodySmall
      }

      Item {
        width: keyboard.width
        implicitHeight: 6 * keyboard.unit + 5 * keyboard.gap

        Column {
          spacing: keyboard.gap

          Repeater {
            model: keyboard.rows

            delegate: Row {
              required property var modelData
              spacing: keyboard.gap

              Repeater {
                model: modelData

                delegate: Rectangle {
                  required property var modelData
                  readonly property var keyData: modelData
                  readonly property bool hasAction: keyData.action !== undefined

                  width: (keyData.width || 1) * keyboard.unit + ((keyData.width || 1) - 1) * keyboard.gap
                  height: keyboard.unit
                  radius: Style.cornerRadius
                  color: hasAction ? root.actionFill : root.keyFill
                  border.width: hasAction ? 2 : 1
                  border.color: hasAction ? root.foreground : root.keyBorder

                  Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                      anchors.horizontalCenter: parent.horizontalCenter
                      text: keyData.key
                      color: root.foreground
                      font.family: root.bar ? root.bar.fontFamily : Style.font.family
                      font.bold: hasAction
                      font.pixelSize: hasAction ? Style.font.bodySmall : Style.font.body
                    }

                    Text {
                      anchors.horizontalCenter: parent.horizontalCenter
                      visible: hasAction
                      text: keyData.action || ""
                      color: root.mutedForeground
                      font.family: root.bar ? root.bar.fontFamily : Style.font.family
                      font.bold: true
                      font.pixelSize: Style.font.caption
                    }
                  }
                }
              }
            }
          }
        }
      }

      Rectangle {
        width: parent.width
        height: 1
        color: root.keyBorder
      }

      Grid {
        columns: 4
        columnSpacing: Style.space(16)
        rowSpacing: Style.space(7)

        Repeater {
          model: [
            "BR-  display brightness down",
            "BR+  display brightness up",
            "KB-  keyboard backlight down",
            "KB+  keyboard backlight up",
            "RF   wireless toggle",
            "MIC  microphone mute",
            "PREV previous track",
            "PLAY play/pause",
            "NEXT next track",
            "MUTE speaker mute",
            "VOL- volume down",
            "VOL+ volume up"
          ]

          delegate: Text {
            required property string modelData
            text: modelData
            color: root.mutedForeground
            font.family: root.bar ? root.bar.fontFamily : Style.font.family
            font.pixelSize: Style.font.bodySmall
          }
        }
      }
    }
  }
}
