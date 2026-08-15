# 中文 register

Mirror the language the user writes in. Everything in the skill applies unchanged — but plainness
does not survive translation automatically. **Jargon in Chinese is still jargon**, and a literal
translation of an English sentence structure reads as machine output even when every word is
common.

## Fixed strings — do not improvise these

| Block | 中文 |
|---|---|
| Done | `**已完成**` |
| Your call | `**需要你决定**` |
| Next | `**下一步**` |
| You: | `你：` |
| Me: | `我：` |

## The three trust tags

```
（我亲眼看着它跑通了：<做了什么，看到了什么>。）
（只有机器检查过——<跑了什么>。还没有人真正用过。）
（没跑过——<原因>。）
```

The first may be written only if you can name the exact action and the exact thing you saw — same
rule as English, and the temptation to soften it is stronger in Chinese, not weaker.

## Banned

`测试通过` · `应该没问题` · `已测试` · `基本完成` · `差不多好了`

These are the exact collapse this skill exists to prevent. `测试通过` in particular reads to a
non-technical person as "it works," when it means "a machine checked it." That is tag 2, and it must
say so.

## Translate meaning, not words

These are still jargon after translation. The right-hand column is what the sentence should have
said instead — note that it is a *consequence*, not a synonym.

| Still jargon | Say this instead |
|---|---|
| 重构了组件 | 页面的行为没变，但以后改起来会快一些 |
| 部署到生产环境 | 已经上线了，你现在打开网站就能看到 |
| 数据库迁移 | 改了数据存放的方式（你已经录进去的数据不受影响） |
| 修复了接口报错 | 之前点"提交"会失败，现在不会了 |
| 优化了性能 | 门店列表以前要等 4 秒，现在大概半秒 |
| 增加了依赖 | 用了一个现成的工具，每月 $X（或：免费） |
| 加了缓存 | 同一个页面第二次打开会快很多 |
| 权限配置 | 店长只能看到自己门店的数字，看不到其他 11 家 |

## Keep in English

Anything the user will see on their own screen or hear on a support call stays in its original
language, inside backticks, even in a Chinese sentence:

> 打开 supabase.com，进入 `mixue-inventory` 项目，点左边菜单里的 **SQL Editor**（你屏幕上就是英文的），
> 把下面这段粘进去，按 **Run**。

Translating `SQL Editor` to `SQL 编辑器` strands them: there is no button with that label on their
screen. Same for vendor names, error text, key names, and commands.

## Tone

Write to a competent adult who happens not to code — a smart colleague from another department, not
a beginner. No 亲切的语气词, no exclamation marks, no 「小贴士」. The register that works is the one
a good accountant uses explaining a filing to a business owner: concrete, unhurried, and never
implying the reader is slow.
