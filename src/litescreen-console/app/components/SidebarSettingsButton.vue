<template>
<div class="flex flex-row">
    <Button variant="ghost" size="sm" class="w-full justify-start" @click="openSettings" >
        <img src="/settings-icon.png" width="18" height="18" class="mr-2" />
        <span>Settings</span>
    </Button>
</div>
</template>

<script setup lang="ts">
const { openSettings } = useSettingsDialog();
</script>