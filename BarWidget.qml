import QtQuick
import qs.Ui
import qs.Commons

BarWidget {
  id: root
  moduleName: "maustronaut.framework13-fn-keys"

  readonly property bool opened: panelLoader.item ? panelLoader.item.opened === true : false
  readonly property bool popoutSwitchClosing: panelLoader.item
    ? panelLoader.item.popoutSwitchClosing === true : false

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function injectPanel() {
    const panel = panelLoader.item
    if (!panel) return
    panel.bar = root.bar
    panel.settings = root.settings
    panel.anchorItem = button
    panel.hostWidget = root
  }

  function open() {
    if (panelLoader.item) panelLoader.item.open()
  }

  function close() {
    if (panelLoader.item) panelLoader.item.close()
  }

  function toggle() {
    if (panelLoader.item) panelLoader.item.toggle()
  }

  function closeForPopoutSwitch() {
    if (panelLoader.item) panelLoader.item.closeForPopoutSwitch()
  }

  onBarChanged: injectPanel()
  onSettingsChanged: injectPanel()

  Loader {
    id: panelLoader
    active: true
    source: Qt.resolvedUrl("Panel.qml")
    visible: false

    onLoaded: {
      root.injectPanel()
      Qt.callLater(root.injectPanel)
    }
  }

  Item {
    id: button
    anchors.fill: parent
    implicitWidth: root.vertical ? root.barSize : 34
    implicitHeight: root.barSize

    Rectangle {
      anchors.centerIn: parent
      width: root.vertical ? parent.width - Style.space(4) : Style.space(30)
      height: root.vertical ? Style.space(30) : parent.height - Style.space(4)
      radius: Style.cornerRadius
      color: mouse.containsMouse || root.opened
        ? Style.hoverFillFor(root.bar ? root.bar.foreground : Color.foreground, Color.accent)
        : "transparent"
      opacity: mouse.containsMouse || root.opened ? 1 : 0.72

      Text {
        anchors.centerIn: parent
        text: "󰌌"
        color: root.bar ? root.bar.foreground : Color.foreground
        font.family: root.bar ? root.bar.fontFamily : Style.font.family
        font.bold: true
        font.pixelSize: Style.font.icon
      }
    }

    MouseArea {
      id: mouse
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      onClicked: root.toggle()
    }
  }
}
