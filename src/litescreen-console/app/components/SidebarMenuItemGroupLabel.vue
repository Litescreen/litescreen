<template>
    <div class="text-xs font-semibold text-gray-400 uppercase tracking-wider pl-1 py-1 mb-1">
        {{ label }}
    </div>
</template>

<script setup lang="ts">
const props = defineProps<{
    label: string
}>()
</script>