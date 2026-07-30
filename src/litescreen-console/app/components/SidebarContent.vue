<template>
    <div>
        <SidebarMenuItemGroup>
            <SidebarMenuItem
                label="Dashboard"
                iconPath="/dashboard-icon.png"
                routePath="/"
            />
        </SidebarMenuItemGroup>

        <SidebarMenuItemGroup>
            <SidebarMenuItemGroupLabel label="Build" />
            <SidebarMenuItem
                label="Playlists"
                iconPath="/playlist-icon.png"
                routePath="/playlists"
            />
            <SidebarMenuItem
                label="Assets"
                iconPath="/assets-icon.png"
                routePath="/assets"
            />
            <SidebarMenuItem
                label="Integrations"
                iconPath="/integrations-icon.png"
                routePath="/integrations"
            />
            <SidebarMenuItem
                label="Schedules"
                iconPath="/schedules-icon.png"
                routePath="/playlist-schedules"
            />
        </SidebarMenuItemGroup>

        <SidebarMenuItemGroup>
            <SidebarMenuItemGroupLabel label="Display" />
            <SidebarMenuItem
                label="Screens"
                iconPath="/screens-icon.png"
                routePath="/screens"
            />
            <SidebarMenuItem
                label="Screen Commands"
                iconPath="/screen-commands-icon.png"
                routePath="/screen-commands"
            />
            <SidebarMenuItem
                label="Screen Events"
                iconPath="/screen-events-icon.png"
                routePath="/screen-events"
            />
        </SidebarMenuItemGroup>

        <!-- <SidebarMenuItemGroup>
            <SidebarMenuItemGroupLabel label="Manage" />
            <SidebarMenuItem
                label="Locations"
                iconPath="/locations-icon.png"
                routePath="/locations"
            />
            <SidebarMenuItem
                label="Environments"
                iconPath="/environments-icon.png"
                routePath="/environments"
            />
            <SidebarMenuItem
                label="Team"
                iconPath="/team-icon.png"
                routePath="/team"
            />
        </SidebarMenuItemGroup> -->
    </div>
</template>

<script setup lang="ts">
const { isCollapsed } = useSidebar();
isCollapsed.value = false;
</script>