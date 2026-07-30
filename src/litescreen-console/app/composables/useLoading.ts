export const useLoading = () => {
  const isLoading = ref(true);

  const toggleLoading = () => {
    isLoading.value = !isLoading.value
  }
  
  return {
    isLoading,
    toggleLoading
  }
}