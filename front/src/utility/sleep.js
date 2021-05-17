//スリープする(ms)
const func = ms => new Promise(resolve => setTimeout(resolve, ms))

async function sleep(ms) {
  await func(ms)
}

export default sleep