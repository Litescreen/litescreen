<template>
    <PageHeader page-title="Dashboard" />
    <PageContent v-if="!isLoading">
        <div class="grid grid-cols-2 gap-4">
            <Card>
                <CardContent>
                    Welcome to the Litescreen Console!
                </CardContent>
            </Card>

            <Card>
                <CardContent>
                    Welcome to the Litescreen Console!
                </CardContent>
            </Card>
        </div>
    </PageContent>
    <LoadingPanel v-else />
</template>

<script setup lang="ts">
const { toggleLoading, isLoading } = useLoading();

setTimeout(() => {
    toggleLoading();
}, 2000);
</script>