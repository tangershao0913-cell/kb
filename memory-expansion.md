# 记忆体扩展方案

> 小三的持久记忆系统 — 2026-05-21

## 当前状态

内置会话记忆：始终启用，`memory_char_limit: 2200`（已满，需扩展）

## 可用插件一览

| 插件 | 本地模式 | API Key | 现状 | 推荐度 |
|------|---------|---------|------|--------|
| **holographic** | ✅ 纯Python | 无 | 未配置 | ⭐⭐⭐⭐⭐ |
| hindsight | ✅ | 需要 | 需配置 | ⭐⭐⭐ |
| honcho | ✅ | 需要 | 未配置 | ⭐⭐⭐ |
| mem0 | ✅ | 需要 | 未配置 | ⭐⭐⭐ |
| supermemory | ❌ | 需要 | 未配置 | ⭐⭐ |
| byterover | ❌ | 需要 | 未配置 | ⭐⭐ |
| openviking | ❌ | 需要 | 未配置 | ⭐⭐ |
| retaindb | ✅ | 需要 | 未配置 | ⭐⭐ |

---

## holographic（推荐优先启用）

**本质**：Holographic Reduced Representations (HRR) — 相位编码的向量符号架构。

**原理**：
- 每个概念 = 固定维度（默认1024）相位向量
- bind（卷积）= 相位相加 → 绑定两个概念
- unbind（解卷积）= 相位相减 → 检索绑定值
- bundle（捆绑）= 叠加平均 → 合并多个概念
- 用 SHA-256 生成确定性原子向量，跨平台一致

**优势**：
- 纯本地，无 API Key 要求
- NumPy 即可运行
- 支持 `encode_text()` 文本编码
- 支持 `encode_fact()` 结构化事实编码（content + entities）
- SNR 容量分析（dim=1024 时约存 256 项后质量下降）

**安装/启用**：
```bash
# 1. 安装 numpy（系统python无pip，用uv）
uv pip install numpy --python ~/.hermes/hermes-agent/venv/bin/python

# 2. 启用（已完成 ✓）
hermes config set memory.provider holographic

# 3. 验证
hermes memory status
```

**状态**：✅ **已启用并可用**（2026-05-21）

**用法示例**：
```python
import numpy as np
from holographic import encode_text, encode_fact, bind, unbind, similarity

# 编码文本
vec = encode_text("Python is great", dim=1024)

# 编码事实（content + 关联实体）
fact_vec = encode_fact("installed python 3.14", ["python", "3.14"])

# 绑定 & 解绑
memory = bind(encode_text("task:", 1024), encode_text("debug hindsight", 1024))
retrieved = unbind(memory, encode_text("task:", 1024))

# 相似度
sim = similarity(retrieved, encode_text("debug hindsight", 1024))  # ≈ 1.0
```

**已知文件**：`~/.hermes/hermes-agent/plugins/memory/holographic/holographic.py`

---

## hindsight（当前配置但未就绪）

- 需要 `HINDSIGHT_API_KEY`（https://ui.hindsight.vectorize.io）
- Python 3.14 不兼容（use_2to3 问题），另一台机器用 Docker 部署可用
- 适合有 API Key 的用户

---

## honcho（Mem0 产品）

- 本地模式可用
- 需要 API Key 或自托管

---

## Obsidian 知识库（文件系统层，最可靠）

当前已搭建：
- 路径：`/home/txh-office/kb/vault`
- Git 已初始化
- 每日自动创建笔记（cron 8:00）
- Obsidian 在 Windows 侧安装

**这是小三最稳定的记忆层**，所有重要信息都持久化到 Markdown 文件。

---

## 扩展策略（推荐路径）

### 第一步：立即启用 holographic
```bash
hermes config set memory.provider holographic
```

### 第二步：Obsidian 作为结构化知识层
- 所有重要结论、代码片段、配置都写入 Obsidian
- holographic 作为即时"类比记忆"层

### 第三步：可选 hindsight（需 API Key）
- 如果有 Vectorize 账户，申请 Key 接入
- 作为云端记忆同步

---

## 记忆体使用原则

1. **holographic** — 存储即时概念、相似度匹配
2. **Obsidian 文件** — 存储结构化知识、配置、代码
3. **内置 session memory** — 当前会话上下文
4. **memory tool** — 跨会话重要事实（用户偏好、环境）

---

*创建: 2026-05-21*
