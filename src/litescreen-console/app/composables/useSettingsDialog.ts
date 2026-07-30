export const useSettingsDialog = () => {
  const isOpen = useState('settings-dialog-open', () => false)
  
  const openSettings = () => {
    isOpen.value = true
  }
  
  const closeSettings = () => {
    isOpen.value = false
  }
  
  return {
    isOpen,
    openSettings,
    closeSettings
  }
}