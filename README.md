# introdatascience
mainly from that [microsoft data science for beginners](https://github.com/microsoft/Data-Science-For-Beginners/tree/main) thing


### permanently remove file from git
```bash
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch metadata.csv.zip' --prune-empty --tag-name-filter cat -- --all
```
