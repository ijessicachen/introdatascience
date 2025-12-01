## TODO

Command to install (need to figure out a way to permanently install)
```bash
pip install cromosim
```

Quick links
- [Examples](https://github.com/sylvain-faure/cromosim/tree/master/examples) on Github
- Slight more detailed Social Force Model [documentation](https://www.cromosim.fr/example_micro.html)
 
Main tasks in `json` file
- Take more time to look through
    - `input_room.json`: has an obstacle and 2 exits
    - `input_stairs.json`: 2 groups going in opposing directions in a confined space
- Make `domain(s)`
    - then convert it to json
    - May have to change the destination to past the door not at the door. As a byproduct may need to expand the domain into the hallway too
    - Also figure out if you can make it so once a certain number of people reaches a destination that no longer becomes a destination so it can accurately simulate people going to different rows
- Make the `people` group things
- Make the `sensors`
- Figure out what those other values (kappa, delta, projection\_method, etc.) mean

Main tasks in main `py` file
- Modify forces to work with our model (Hopf Bifurcation *or* Density-Dependent)

Main tasks for visualization
- Combine result images into a gif --> add this to the main `py` file?
- Maybe modify sensor graphs if you want something more specific but they seem fine tbh

