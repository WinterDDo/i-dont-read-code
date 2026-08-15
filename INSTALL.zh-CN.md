# 安装

挑你在用的那个工具就行。下面这些你不需要看懂，照做即可。

English: [INSTALL.md](INSTALL.md)

---

## Claude Code（推荐）

在 Claude Code 里依次敲这两行：

```
/plugin marketplace add WinterDDo/i-dont-read-code
/plugin install i-dont-read-code@i-dont-read-code
```

（名字看起来重复了两遍，是因为格式是「插件名@来源」。不是写错了。）

第二行会弹一个小菜单问你装在哪。默认的 **User** 就对，意思是所有项目都能用。

装完会打印一小段总结。如果里面出现 `Run /reload-plugins to activate.` 这句话，
就再敲一次 `/reload-plugins`。没出现就不用管。

**然后确认它真的装上了。** 开一个新对话，输入：

```
skill check
```

你应该会看到类似这样的回复：

```
i-dont-read-code v0.2.0 is on
Always-on rules: yes
Per-turn reminder: on
```
```
No "what you own" card yet — say "make my project card" when you want one.
```

每一行代表一个部件在报到。前两行是最关键的，那就是"一直生效"的那部分。

你可能还会看到一行 `Deep examples: loaded`。没看到也不用担心：
更深的那部分内容只在真正需要的时候才加载，所以大多数时候它安静着才是对的。

**行数少了不代表失败**，而是有用的信息。如果完全看不到类似的东西，那才是没装上，看最下面的排查部分。

到这里就结束了。以后每个项目、每个新对话都自动生效。

---

## Claude Code 网页版

插件的装法一样，但其中一个部件——每轮的提醒——在网页版里不会运行，其余部分正常。

想补上这个缺口，直接跟 Claude 说：

```
set up my rules file
```

它会把文件建好、把规则写进去，再告诉你放在哪了。你不需要知道那是什么文件、在哪个位置。

---

## Cursor

**所有项目通用（做一次就够）：**

1. 打开 Cursor → **Settings** → **Rules**
2. 找到那个叫 **User Rules** 的框
3. 打开 [`portable/cursor-user-rules.txt`](portable/cursor-user-rules.txt)，
   把 "copy everything below this line" 这行以下的内容全部复制，粘贴进那个框里

你会看到文字留在框里了。这就好了，从此对所有项目生效。

**只想给某一个项目用：** 直接让 Cursor 的 AI `set up my rules file`，它会把文件建在该建的地方。
（想自己动手的话，要复制的文件是
[`portable/.cursor/rules/i-dont-read-code.mdc`](portable/.cursor/rules/i-dont-read-code.mdc)。）

---

## Codex、Windsurf、Gemini CLI 等

直接跟它说：

```
set up my rules file
```

内容来自 [`portable/AGENTS.md-snippet.md`](portable/AGENTS.md-snippet.md)，
你也可以自己把这个文件的内容粘进去。最后它会存进一个叫 `AGENTS.md` 的文件，
这是这几个工具通用的约定。

---

## 什么都不装，只放一个文件

如果你不想装任何东西，就跟 Claude 说 `set up my rules file`，并告诉它你想所有项目都用。
它会把规则写进你的个人配置文件里。

这样也能用，但效果最弱：写在文件里的规则，在很长的对话里会慢慢失效，而插件不会。

---

## 这个要花多少钱

一直生效的那部分是免费的，它是直接写进 Claude 读你消息的方式里的。

每轮的提醒会给你发出的每条消息附加大约 400 个词的说明。正常使用下大概每天几美分，
但也不是完全没有。想去掉就说 **`turn off the reminder`**，其他部分照常工作。

不会有任何数据被传到外部，全部在你自己的机器上运行。

---

## 怎么关掉

**只关一条回复：** 说 **"details"** 或者 **"把技术版本给我看"**。
你会拿到那一条的完整技术版本，然后自动恢复正常。想看底层细节，永远不需要卸载它——这正是它的设计。

**彻底关掉：** `/plugin uninstall i-dont-read-code@i-dont-read-code`，
或者把你粘贴过的那个文件删掉。

---

## 出问题了怎么办

**第一行就报错。** 要么是仓库名变了，要么是你的 Claude Code 版本比较旧、没有 `/plugin`。
敲 `/help` 看看——如果列表里没有 `plugin`，先升级 Claude Code。
如果有，请把报错原文贴到 issue 里：那说明这份说明里的名字写错了，是我们的问题，不是你的。

**第二行报错。** 多半是第一行没跑完。运行 `/plugin marketplace list`，
里面应该能看到 `i-dont-read-code`。看不到就把第一行再跑一次。

**`skill check` 的回复完全不像上面那个样子。** 插件没加载。
试试 `/plugin marketplace update i-dont-read-code`，然后 `/reload-plugins`，
接着开一个**新**对话——规则是在对话开始时读进去的，已经开着的对话不会生效。

**`skill check` 只回了几行，不全。** 说明部分生效了。少掉的那一行能告诉你是哪个部件出了问题，
把你看到的贴到 issue 里。在那之前它大部分功能仍然是好的。

**装上了，但回复看起来还是很技术。** 如果你在同一个对话里待了很久，开个新的。
如果你用的是网页版 Claude Code，按上面说的让它 `set up my rules file`。

**它太简略了，我想要更多。** 说 "details" 就能拿到任何一条回复的技术版本，
或者直接告诉它你想多看什么。它应该迁就你，不是反过来。
