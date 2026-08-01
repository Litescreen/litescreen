import { contextBridge, ipcRenderer } from 'electron'
// import { IPCSenderChannels } from '@main/ipc'
import { IPCSenderChannels } from '@litescreen/core/ipc';

export interface ElectronAPI {
  // Add your API methods here
  exampleMethod: () => void
}

contextBridge.exposeInMainWorld('electronAPI', {
  exampleMethod: () => ipcRenderer.send('test-event'),
  checkForUpdates: () => ipcRenderer.send(IPCSenderChannels.UpdateCheck)
} as ElectronAPI)