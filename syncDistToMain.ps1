#Requires -Version 7
param(
    [string]$SrcBranch = 'dev',
    [string]$DstBranch = 'main',
    [string]$DistDir   = 'dist',
    [switch]$AutoPush
)

$ErrorActionPreference = 'Stop'

# 1. 工作区干净检查
if (git status --porcelain) { Write-Error '❗ 工作区有未提交文件'; exit 1 }

# 2. 切到源分支并更新
git fetch origin
git checkout $SrcBranch
git pull origin $SrcBranch

# 3. 取 dist 的 tree hash
$tree = git ls-tree HEAD $DistDir
if (-not $tree) { Write-Error "❗ $SrcBranch 下没有 $DistDir 目录"; exit 1 }
$treeHash = ($tree -split "\s+")[2]

# 4. 切到目标分支并更新
git checkout $DstBranch
git pull origin $DstBranch

# 5. 用临时 tree 覆盖工作区
git read-tree -u $treeHash

# 6. 拿最新提交信息
$msg = git log -1 --pretty=%B $SrcBranch

# 7. 提交 + 可选推送
git add -A
git commit -m $msg
if ($AutoPush) { git push origin $DstBranch }

Write-Host "✅ $DistDir 已同步到 $DstBranch 并提交"