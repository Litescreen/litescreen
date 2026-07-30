<template>
    <div class="py-4 border-b border-neutral-800">
        <h3 class="text-2xl font-semibold text-white">{{ pageTitle }}</h3>
    </div>
</template>

<script setup lang="ts">
const props = defineProps<{
    pageTitle: string
}>()
</script>