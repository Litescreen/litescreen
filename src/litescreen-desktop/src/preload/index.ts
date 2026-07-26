import { contextBridge, ipcRenderer } from 'electron'

export interface ElectronAPI {
  // Add your API methods here
  exampleMethod: () => void
}

contextBridge.exposeInMainWorld('electronAPI', {
  exampleMethod: () => ipcRenderer.send('test-event')
} as ElectronAPI)