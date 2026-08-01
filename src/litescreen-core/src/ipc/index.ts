const IPCSenderChannels = {
    Test: 'test',
    GetVersion: 'app:getVersion',
    Restart: 'app:restart',
    Quit: 'app:quit',
    UpdateCheck: 'updates:check',
    UpdateInstall: 'updates:install'
} as const

const IPCInvokerChannels = {
    Test: 'test'
} as const

export {
    IPCSenderChannels,
    IPCInvokerChannels
}