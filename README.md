# introdatascience
mainly from that [microsoft data science for beginners](https://github.com/microsoft/Data-Science-For-Beginners/tree/main) thing

**currently working on**
  - 2-7 challenge 2 (which leads into 2-7 assignment part 2)
*note*
  - skipped 2-6 (for now)
  - feel free at any time to go back to 2-7 assignment part 1 and make it better
  - at the very end of 2-7 challenge 2 the sankey diagram isn't showing up, fix that.

### permanently remove file from git
```bash
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch metadata.csv.zip' --prune-empty --tag-name-filter cat -- --all
```
