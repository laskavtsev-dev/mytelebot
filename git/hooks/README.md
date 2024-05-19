1. Встановлюємо pre-commit:
```bash
$ sudo apt-get install pre-commit

$ pre-commit --version
pre-commit 2.17.0

$ touch .pre-commit-config.yaml

$ nano .pre-commit-config.yaml
```
```yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.16.1
    hooks:
      - id: gitleaks
```
```bash
$ pre-commit install
pre-commit installed at .git/hooks/pre-commit
```
2. Встановлюємо gitleaks:
```bash
$ cd ..
$ git clone https://github.com/gitleaks/gitleaks.git
$ cd gitleaks
$ make build
$ cp gitleaks /usr/local/bin
$ gitleaks detect --source . --log-opts="--all"
```

4. Перевірка роботи: змінимо щось в helm/values
```bash
las@playground:~/mytelebot$ git commit -m "this commit contains a secret"
Detect hardcoded secrets.................................................Failed
- hook id: gitleaks
- exit code: 1

○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

Finding:     default: "REDACTED
Secret:      REDACTED
RuleID:      github-pat
Entropy:     4.953056
File:        helm/values.yaml
Line:        17
Fingerprint: helm/values.yaml:github-pat:17

12:58PM INF 1 commits scanned.
12:58PM INF scan completed in 13.9ms
12:58PM WRN leaks found: 1
```

5. Створимо pre-commit-hook для автоматичного встановлення gitleaks на різних операційних системах:
```bash
$ nano .git/hooks/pre-commit
```
Додаємо наступне:
```code

```
6. 
7. 

