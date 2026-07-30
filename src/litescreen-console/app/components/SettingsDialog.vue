<template>
  <Dialog :open="isOpen" @update:open="val => isOpen = val">
    <DialogContent class="sm:max-w-[600px]">
      <DialogHeader>
        <DialogTitle>Settings</DialogTitle>
        <DialogDescription>
          Manage your account settings and preferences.
        </DialogDescription>
      </DialogHeader>
      
      <!-- <div class="grid gap-4 py-4">
        <div class="grid gap-2">
          <Label for="name">Name</Label>
          <Input id="name" placeholder="Enter your name" />
        </div>
        
        <div class="grid gap-2">
          <Label for="email">Email</Label>
          <Input id="email" type="email" placeholder="Enter your email" />
        </div>
        
        <div class="flex items-center space-x-2">
          <Switch id="notifications" />
          <Label for="notifications">Enable notifications</Label>
        </div>
      </div> -->
      
      <DialogFooter>
        <Button variant="outline" @click="cancel">Cancel</Button>
        <Button @click="saveSettings">Save changes</Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template>

<script setup lang="ts">
const { isOpen, closeSettings } = useSettingsDialog();

const cancel = () => {
  console.log('Cancelling...')
  closeSettings()
}

const saveSettings = () => {
  // Handle your save logic here
  console.log('Saving settings...')
  closeSettings();
}
</script>