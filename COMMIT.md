# 📝 Commit Message Guidelines
Consistent commit messages improve readability, automate changelogs, and streamline collaboration. Follow these conventions:

## 🏷 Commit Types (with Emojis)
| Type       | Emoji | GitHub Code       | When to Use                                      |
|------------|-------|-------------------|--------------------------------------------------|
| `feat`     | ✨    | `:sparkles:`      | Introducing new functionality                   |
| `fix`      | 🐛    | `:bug:`           | Correcting bugs                                  |
| `chore`    | 🔧    | `:wrench:`        | Maintenance tasks                                |
| `refactor` | ♻️    | `:recycle:`       | Improving code structure                        |
| `docs`     | 📚    | `:books:`         | Documentation changes                           |
| `style`    | 🎨    | `:art:`           | Cosmetic changes                                |
| `test`     | ✅    | `:white_check_mark:` | Test-related changes                            |
| `perf`     | ⚡    | `:zap:`           | Performance optimizations                       |
| `ci`       | 👷    | `:construction_worker:` | CI/CD pipeline changes                  |
| `build`    | 📦    | `:package:`       | Build system/external dependencies              |
| `revert`   | ⏪    | `:rewind:`        | Undoing previous commits                       |

## ✍️ Format
```
<emoji> <type>(<scope>): <subject>
```

## 🌟 Examples
```
🐛 fix(api): handle null response in /users endpoint
✨ feat(auth): add Google OAuth login
🔧 chore(deps): upgrade lodash to 4.17.21
📚 docs(readme): add Docker setup guide
```
