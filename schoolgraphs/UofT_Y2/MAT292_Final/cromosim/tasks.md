## TODO

Command to install (need to figure out a way to permanently install)
```bash
pip install cromosim
```

Quick links
- [Examples](https://github.com/sylvain-faure/cromosim/tree/master/examples) on Github
- Slight more detailed Social Force Model [documentation](https://www.cromosim.fr/example_micro.html)

Main steps
- make domain of room and hallway and run social force model for a group moving in and a group moving out
- add to previous one with Density-Dependent
- if you have time, add to previous one with Hopf Bifurcation
 
Main tasks in `json` file
- experiment with their other values (kappa, delta, etc.)
- Make the `people` group things
    - group moving in
        - randomly scattered in the hall
        - you probably have to make something like 6 groups of 5, randomly scattered, that each have their own destination in a row
    - fix the door issue (too many people using the top door, does not reflect real behaviour)
        - change the groups so only some can use the top door (make another object there at onley some can go through using the `excluded_colors` feature)
- add more sensors if you want

Make tasks for domain `py` file
- New destinations!!!
- Also figure out if you can make it so once a certain number of people reaches a destination that no longer becomes a destination so it can accurately simulate people going to different rows
    - possible solution in the works by adjusting the groups in the `json` file (see notes above about the tasks in the `json` file for more info)
- refine the colours for different groups

Main tasks in main `py` file
- Modify forces to work with altered models (Hopf Bifurcation, Density-Dependent)

Main tasks for visualization
- Maybe modify sensor graphs if you want something more specific but they seem fine tbh

## Other Notes

I am aware you can properly change the documentation if you install, but since I only figured out how to install it on Jupyter Notebook we are instead making copies of methods and altering those instead as this is the best way I could come up with to change the docs for what we are doing.
