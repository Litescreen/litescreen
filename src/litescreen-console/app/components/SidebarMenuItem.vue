<template>
    <div class="flex flex-row">
        <NuxtLink :to="routePath" class="w-full">
            <Button variant="ghost" size="sm" class="w-full justify-start">
                <img :src="iconPath" width="18" height="18" class="mr-2" />
                <span>{{ label }}</span>
            </Button>
        </NuxtLink>
    </div>
</template>

<script setup lang="ts">
const props = defineProps<{
    label: string,
    iconPath: string,
    routePath: string
}>()
</script>