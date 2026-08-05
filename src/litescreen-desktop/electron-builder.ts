import { Configuration } from 'electron-builder'
import * as path from 'path'

const iconPath = path.join(__dirname, './dist/renderer/public/icon.png');

const config: Configuration = {
  appId: 'com.litescreen.desktop',
  productName: 'Litescreen Desktop',
  artifactName: "Litescreen-Desktop-${os}-${arch}.${ext}",
  copyright: 'Symbisoft, LLC',
  directories: {
    output: "release"
  },
  files: [
    "dist/**/*",
    "package.json"
  ],
  extraMetadata: {
    main: "dist/main/index.js"
  },
  mac: {
    target: ["dmg"],
    icon: iconPath
  },
  win: {
    target: ["nsis"],
    icon: iconPath
  },
  // Allow both NSIS user installs and machine installs.
  nsis: {
    oneClick: false,
    perMachine: false,
    allowElevation: true,
    allowToChangeInstallationDirectory: true
  },
  linux: {
    target: ["AppImage"],
    icon: iconPath
  }
}

export default config