# Obsidian 配置笔记

## 当前状态
- WSL2 无桌面，Obsidian 需在 Windows 侧安装
- vault 路径: `/home/txh-office/kb/vault`（Linux侧）
- Windows 用户: `唐晓晖`

## Windows 侧安装步骤

### 1. 下载 Obsidian
- 官网: https://obsidian.md
- 下载 Windows installer (.exe)

### 2. 配置 vault 路径
- 打开 Obsidian → "Open folder as vault"
- 选择路径: `\\wsl$\Ubuntu\home\txh-office\kb\vault`
- 或在 Windows 资源管理器: `\\wsl$\Ubuntu`

### 3. 推荐的 Obsidian 插件
- ** Templater ** - 动态模板
- ** Dataview ** - 查询笔记数据
- ** Git ** - 自动同步
- ** Excalidraw ** - 画图
- ** Hover Editor ** - 悬浮编辑
- ** QuickAdd ** - 快速添加

### 4. Git 同步（重要）
由于 WSL 和 Windows Obsidian 共用 vault，Git 同步只需在一边做，推荐在 WSL 里用 git，这样 agent 也能方便地 commit。

```bash
cd /home/txh-office/kb
git init
git remote add origin <your-github-repo>
```

### 5. .gitignore
```
.obsidian/
!/.obsidian/community-plugins.json
!/.obsidian/plugins/
```

## WSL 访问 Windows Obsidian（备选方案）
如果 Windows 安装了 Obsidian，笔记存在:
```
C:\Users\唐晓晖\AppData\Roaming\obsidian\Vaults\
```
可以软链接:
```bash
ln -s "/mnt/c/Users/唐晓晖/AppData/Roaming/obsidian/Vaults/my-vault" ~/kb/vault
```

---

*创建: 2026-05-21*
