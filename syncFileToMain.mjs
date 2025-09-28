import { simpleGit } from 'simple-git'
import fs from 'fs-extra'
import { fileURLToPath } from 'url'
import { dirname, join } from 'path'

const __dirname = dirname(fileURLToPath(import.meta.url))
const repo = simpleGit(__dirname)

async function run() {
  await repo.fetch()
  await repo.checkout('dev')
  await repo.pull('origin', 'dev')

  // 把 dist 拷走
  await fs.copy('dist', '.tmp-dist')

  await repo.checkout('main')
  await repo.pull('origin', 'main')

  // 清空根目录（保留 .git）
  const files = await fs.readdir('.')
  for (const f of files) {
    if (f === '.git') continue
    await fs.remove(f)
  }

  // 把 tmp-dist 内容放回来
  await fs.copy('.tmp-dist', '.')
  await fs.remove('.tmp-dist')

  const log = await repo.log({ maxCount: 1 })
  await repo.add('.')
  await repo.commit(log.latest.message)
  await repo.push('origin', 'main')
}

run().catch(console.error)