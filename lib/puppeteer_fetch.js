
// npm install puppeteer puppeteer-extra puppeteer-extra-plugin-stealth

if (process.argv.length !== 4) {
  console.info("Usage: node puppeteer_fetch.js <url> <savePath>")
  process.exit()
}

let url = process.argv[2], savePath = process.argv[3];

// puppeteer-extra is a drop-in replacement for puppeteer,
// it augments the installed puppeteer with plugin functionality
const puppeteer = require('puppeteer-extra')
const { executablePath } = require('puppeteer')

// add stealth plugin and use defaults (all evasion techniques)
const StealthPlugin = require('puppeteer-extra-plugin-stealth')
puppeteer.use(StealthPlugin())

// puppeteer usage as normal
puppeteer.launch({
  executablePath: executablePath(),
  headless: true
}).then(async browser => {
  const page = await browser.newPage()
  await page.goto(url)
  try {
    await page.waitForSelector("body")
  } catch(e) {
    console.warn(`Exception when fetching ${url}\n  ${e}`)
    await browser.close()
    return
  }

  const content = await page.$eval("body", el => el.innerText)

  console.log(content.slice(0,200))
  const fs = require('fs')
  fs.writeFile(savePath, content, () => {})
  console.info(`save to ${savePath} successfully`)
  await browser.close()

})
