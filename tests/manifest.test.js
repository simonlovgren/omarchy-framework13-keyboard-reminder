const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const root = path.resolve(__dirname, "..");
const manifest = JSON.parse(fs.readFileSync(path.join(root, "manifest.json"), "utf8"));
const widget = fs.readFileSync(path.join(root, manifest.entryPoints.barWidget), "utf8");
const panel = fs.readFileSync(path.join(root, "Panel.qml"), "utf8");

assert.equal(manifest.schemaVersion, 1);
assert.equal(manifest.id, "maustronaut.framework13-fn-keys");
assert.deepEqual(manifest.kinds, ["bar-widget"]);
assert.equal(manifest.barWidget.defaultSection, "right");
assert.equal(manifest.barWidget.defaults.showIcons, true);
assert.match(widget, /source: Qt\.resolvedUrl\("Panel\.qml"\)/);
assert.match(panel, /KeyboardPanel/);
assert.match(widget, /Color\.accent/);
assert.match(widget, /Style\.hoverFillFor/);
assert.match(widget, /text: "󰌌"/);
assert.match(panel, /Color\.popups\.background/);
assert.match(panel, /Style\.selectedFillFor/);
assert.match(panel, /Style\.normalBorderFor/);
assert.match(panel, /width: 15 \* unit \+ 14 \* gap/);
assert.match(panel, /\{ key: "Esc", action: "FN LK", icon: "󰌾", description: "Fn Lock", width: 1\.5 \}/);
assert.match(panel, /\{ key: "F12", action: "FW", icon: "󰒓", description: "Framework boot selector" \}/);
assert.match(panel, /\{ key: "F11", action: "PRT", icon: "󰄀", description: "Print screen" \}/);
assert.match(panel, /\{ key: "Del", action: "INS", icon: "INS", description: "Insert", width: 1\.5 \}/);
assert.match(panel, /\{ key: "Ctrl", width: 1\.25 \}, \{ key: "Fn", width: 1\.25 \},/);
assert.match(panel, /\{ key: "Space", width: 4\.5 \}/);
assert.match(panel, /popup\.padding \* 2/);
assert.match(panel, /implicitHeight: 6 \* keyboard\.unit \+ 5 \* keyboard\.gap/);
assert.match(panel, /readonly property bool showIcons: setting\("showIcons", true\)/);
assert.match(panel, /function toggleLegendStyle\(\)/);
assert.match(panel, /root\.showIcons && keyData\.icon/);
assert.match(panel, /keyData\.action \|\| keyData\.subLabel \|\| ""/);
for (const legend of ["FN LK", "MUTE", "VOL-", "VOL+", "PREV", "PLAY", "NEXT", "BR-", "BR+", "DISP", "AIR", "PRT", "FW", "INS"])
  assert.ok(panel.includes(`action: "${legend}"`), `missing ${legend} key legend`);
