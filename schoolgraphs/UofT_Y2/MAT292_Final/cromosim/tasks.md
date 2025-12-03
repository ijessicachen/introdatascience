## TODO

Command to install (need to figure out a way to permanently install)
```bash
pip install cromosim
```

Quick links
- [Examples](https://github.com/sylvain-faure/cromosim/tree/master/examples) on Github
- Slight more detailed Social Force Model [documentation](https://www.cromosim.fr/example_micro.html)

Main steps
- make domain only of room and run simple social force model out of doors
- make domain of room and hallway and run social force model for a group moving in and a group moving out
- add to previous one with Density-Dependent
- if you have time, add to previous one with Hopf Bifurcation
 
Main tasks in `json` file
- Take more time to look through
    - `input_room.json`: has an obstacle and 2 exits
    - `input_stairs.json`: 2 groups going in opposing directions in a confined space
    - experiment with their other values (kappa, delta, etc.)
- Make the `people` group things
    - make sure to shift the groups starting inside the hall by x=100pixels right in order to have them start in the right boxes for the new image
    - group moving in
        - randomly scattered in the hall
- Make the `sensors`
    - prob at doors, maybe in the hall too, make them visible (green or something)

Make tasks for domain `py` file
- REDO DOMAIN TO ACCOUNT FOR SHIFT TO INCLUDE HALL
    - shift 
    - include hall (take dimensions from photos)
- New destinations!!!
- Also figure out if you can make it so once a certain number of people reaches a destination that no longer becomes a destination so it can accurately simulate people going to different rows

Main tasks in main `py` file
- Load domains directly from Python, load everything else from json file
- Modify forces to work with our model (Hopf Bifurcation, Density-Dependent)

Main tasks for visualization
- Maybe modify sensor graphs if you want something more specific but they seem fine tbh

