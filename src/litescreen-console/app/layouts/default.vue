<template>
    <div class="bg-neutral-950 h-screen w-screen flex flex-row">
        <Sidebar />
        <PageContainer>
            <slot />
        </PageContainer>
        <SettingsDialog />    
    </div>
</template>

<script setup lang="ts">
const { isOpen } = useSettingsDialog();
</script>