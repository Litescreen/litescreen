import { app, BrowserWindow, ipcMain, protocol, net } from 'electron'
import * as path from 'path'
import { existsSync, statSync } from 'fs'
import { pathToFileURL } from 'url'

const PUBLIC_DIR = path.join(__dirname, '../renderer/public')
const PROTOCOL = 'app';

//#region Setup custom protocol

/**
 * Introduce a custom protocol to serve what would normally be relative server paths for the spa.
 */
protocol.registerSchemesAsPrivileged([
  {
    scheme: PROTOCOL,
    privileges: {
      standard: true,
      secure: true,
      supportFetchAPI: true,
      corsEnabled: true,
      stream: true
    }
  }
])

/**
 * Configures the custom protocol to serve the would-be web server files.
 */
const configureProtocol = () => {
  
  protocol.handle(PROTOCOL, (request) => {
    const url = new URL(request.url)
    const relativePath = decodeURIComponent(url.pathname === '/' ? '/index.html' : url.pathname)
    let filePath = path.join(PUBLIC_DIR, relativePath)

    if (!filePath.startsWith(PUBLIC_DIR + path.sep) && filePath !== PUBLIC_DIR) {
      return new Response('Forbidden', { status: 403 })
    }

    // Not a real file on disk (e.g. a client-side route like /playlists) —
    // fall back to index.html so the spa router can take over and resolve it.
    if (!existsSync(filePath) || statSync(filePath).isDirectory()) {
      filePath = path.join(PUBLIC_DIR, 'index.html')
    }

    return net.fetch(pathToFileURL(filePath).toString())
  })

}

//#endregion Setup custom protocol

let mainWindow: BrowserWindow | null = null
const createWindow = () => {
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    title: 'Litescreen Desktop',
    // Grab the icon frm the built spa
    icon: path.join(__dirname, '../renderer/public/icon.png'),
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, '../preload/index.js')
    }
  })

  mainWindow.maximize();

  if (process.env.NODE_ENV === 'development') {
    mainWindow.loadURL('http://localhost:3000')
    mainWindow.webContents.openDevTools()
  } else {
    // Target index.vue against a dummy hostname for the protocol.
    mainWindow.loadURL(`${PROTOCOL}://placeholderHostname/`)
  }
 
  mainWindow.on('closed', () => {
    mainWindow = null
  })
}

app.whenReady().then(() => {

  configureProtocol();
  createWindow()

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow()
    }
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})