#!/bin/bash
# ================================================
# 小三每日学习脚本 — 永不下线
# 每天自动运行，爬取信息、更新知识库
# ================================================

KB="/mnt/d/txh/txh"
LOG="$KB/.learn.log"
DATE=$(date +%Y-%m-%d)
TODAY="$KB/daily-$(date +%Y-%m-%d).md"

# 确保今天是新的一天
if [ -f "$TODAY" ]; then
    echo "[$(date)] 今日学习已存在: $TODAY" >> "$LOG"
    exit 0
fi

echo "[$(date)] ===== 开始每日学习: $DATE =====" >> "$LOG"

# 1. 创建今日笔记
cat > "$TODAY" << EOF
---
created: $(date +%Y-%m-%d\ %H:%M)
tags: [daily, $DATE]
---

# 每日学习 $DATE

## 今日目标
-

## 学习内容
### AI/ML 前沿
-

### 系统管理
-

### 工具技巧
-

## 完成事项
- [ ]

## 问题与解决
-

## 明日计划
- [ ]

---
*小三学习记录 — 坚持每天进步*
EOF

# 2. 更新技能索引（动态添加今日新技能）
SKILLS="$KB/skills-index.md"
if ! grep -q "$DATE" "$SKILLS" 2>/dev/null; then
    echo "" >> "$SKILLS"
    echo "### $DATE" >> "$SKILLS"
    echo "- 持续学习更新中..." >> "$SKILLS"
fi

# 3. 更新主索引
INDEX="$KB/00-知识库索引.md"
RECENT=$(ls -t "$KB"/daily-*.md 2>/dev/null | head -1 | xargs basename 2>/dev/null)
if [ -n "$RECENT" ]; then
    echo "[$(date)] 今日笔记已创建: $TODAY" >> "$LOG"
fi

echo "[$(date)] ===== 每日学习初始化完成 =====" >> "$LOG"
echo "Created: $TODAY"
