import { cp, rm, mkdir, readdir } from 'node:fs/promises'
import { existsSync } from 'node:fs'
import { resolve } from 'node:path'

// --- Config -----------------------------------------------------------
const SOURCE_DIR = resolve(process.cwd(), '.output/public')
const TARGET_DIR = resolve(process.cwd(), '../litescreen-desktop/dist/renderer/public')
// ------------------------------------------------------------------------

async function countFiles(dir: string): Promise<number> {
  let count = 0
  const entries = await readdir(dir, { withFileTypes: true })
  for (const entry of entries) {
    if (entry.isDirectory()) {
      count += await countFiles(resolve(dir, entry.name))
    } else {
      count += 1
    }
  }
  return count
}

async function copyBuild() {
  console.log('\n🚀 Copying litescreen-console build files to litescreen-desktop...')
  console.log(`📁 Source: ${SOURCE_DIR}`)
  console.log(`📁 Target: ${TARGET_DIR}`)

  if (!existsSync(SOURCE_DIR)) {
    console.error(
      `❌ ERROR: Source directory not found. Did you run "nuxt generate" first?`
    )
    process.exit(1)
  }

  console.log('Clearing target directory (if it exists)...')
  await rm(TARGET_DIR, { recursive: true, force: true })

  console.log('Creating target directory...')
  await mkdir(TARGET_DIR, { recursive: true })

  console.log('📦 Copying files (recursive)...')
  await cp(SOURCE_DIR, TARGET_DIR, { recursive: true })

  const fileCount = await countFiles(TARGET_DIR)
  console.log(`✅ Done. ${fileCount} file(s) copied to: ${TARGET_DIR}\n`)
}

copyBuild().catch((err) => {
  console.error('❌ FAILED:', err)
  process.exit(1)
})