# introdatascience
mainly from that [microsoft data science for beginners](https://github.com/microsoft/Data-Science-For-Beginners/tree/main) thing

**currently working on**
  - time to begin 3-9!!

**also**
  - skipped 2-6 (for now)
  - 2-7
      - feel free at any time to go back to 2-7 assignment part 1 and make it better
      - challenge 2 (which leads into 2-7 assignment part 2)
      - at the very end of 2-7 challenge 2 the sankey diagram isn't showing up, fix that.
  - 2-8
      - can go back to 2-8 parsing dates to figure out those volcano dates
      - figure out a way so that the R code and stuff actually shows up? idrk what I mean but basically make it so you can see my workspace just like with jupyter notebook.
      - 5 day regression challenge on kaggle
      - scale and normalize data, more practice section

**docker stuff**
  - figure out how to permanently keep the largedata folder and large data in the working environment
  - figure out how to permanently install plotly and other relavent libraries.

### permanently remove file from git
```bash
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch metadata.csv.zip' --prune-empty --tag-name-filter cat -- --all
```
