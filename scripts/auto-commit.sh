#!/bin/bash
# ================================================
# 小三 — Obsidian 自动 commit 脚本
# 由 cronjob 定时调用，确保笔记变更不丢失
# ================================================

VAULT="/mnt/d/txh/txh"
LOG="$VAULT/.git/auto-commit.log"

cd "$VAULT" || exit 1

# 检查是否有变更
if git diff --quiet && git diff --cached --quiet; then
    echo "[$(date '+%Y-%m-%d %H:%M')] 无变更，跳过" >> "$LOG"
    exit 0
fi

# 有变更就 commit
git add -A
COMMIT_MSG="auto: $(date '+%Y-%m-%d %H:%M')"
git commit -m "$COMMIT_MSG" >> "$LOG" 2>&1

if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M')] ✓ 已提交: $COMMIT_MSG" >> "$LOG"
    # 自动 push
    git push origin master >> "$LOG" 2>&1
    if [ $? -eq 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M')] ✓ 已推送" >> "$LOG"
    else
        echo "[$(date '+%Y-%m-%d %H:%M')] ✗ push 失败（可能无网络或凭证过期）" >> "$LOG"
    fi
else
    echo "[$(date '+%Y-%m-%d %H:%M')] ✗ 提交失败" >> "$LOG"
fi
