import { Configuration } from 'electron-builder'

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
    target: ["dmg", "zip"]
  },
  win: {
    target: ["nsis", "portable"]
  },
  linux: {
    target: ["AppImage", "deb"]
  }
}

export default config