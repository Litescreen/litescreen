import { ElectronAPI } from './'

declare global {
  interface Window {
    electronAPI: ElectronAPI
  }
}