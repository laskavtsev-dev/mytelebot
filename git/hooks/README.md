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
