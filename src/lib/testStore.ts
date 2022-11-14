export const testStore = writable(1)

// to show that its actually working
setInterval(() => {
    testStore.update(n => n + 1)
}, 1000)