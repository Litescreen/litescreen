const isCollapsed = ref(false);

export const useSidebar = () => {
  const toggleSidebar = () => {
    isCollapsed.value = !isCollapsed.value;
  };

  const collapseSidebar = () => {
    isCollapsed.value = true;
  }

  const expandSidebar = () => {
    isCollapsed.value = false;
  }
  
  return {
    isCollapsed,
    toggleSidebar,
    collapseSidebar,
    expandSidebar
  }
}