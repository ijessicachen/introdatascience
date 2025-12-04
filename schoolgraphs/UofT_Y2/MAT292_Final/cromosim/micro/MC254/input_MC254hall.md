basically just the json file with comments bc I'm tweaking out at the lack of comments in json files
- actually bro this isn't even with comments, it's just what I think should be the good version while I'm testing what's going wrong
```
{
  "people_init":[
    {
      "domain": "MC254",
      "groups": [
        {
          "nb": 10,
          "radius_distribution": ["uniform",0.14,0.16],
          "velocity_distribution": ["normal",1.4,0.4],
          "box": [8.04,13.88,4.0,7.94],
          "destination": "door"
        },
        {
          "nb": 10,
          "radius_distribution": ["uniform",0.14,0.16],
          "velocity_distribution": ["normal",1.4,0.4],
          "box": [8.04,13.88,9.0,13.0],
          "destination": "door"
        },
        {
          "nb": 5,
          "radius_distribution": ["uniform",0.14,0.16],
          "velocity_distribution": ["normal",1.4,0.4],
          "box": [14.18,17.96,4.9,7.94],
          "destination": "door"
        },
        {
          "nb": 5,
          "radius_distribution": ["uniform",0.14,0.16],
          "velocity_distribution": ["normal",1.4,0.4], "box": [14.18,19.05,9.0,13.0],
          "destination": "door"
        }
      ]
    }
  ],
  "sensors":[
    {
      "name": "sensor1",
      "domain": "MC254hall",
      "line": [4.83,5.15,4.83,6.05] 
    },
    {
      "name": "sensor2",
      "domain": "MC254",
      "line": [4.83,13.51,4.83,14.41]
    },
    {
      "name": "sensor3",
      "domain": "MC254",
      "line": [5.79,7.90,5.79,9.10]
    }
  ],
  "prefix":"norm_MC254hall_results/",
  "seed":40,
  "with_graphes": true,
  "Tf":50.0,
  "dt":0.005,
  "drawper":200,
  "mass":80.0,
  "tau":0.5,
  "F":2000.0,
  "kappa":120000.0,
  "delta":0.08,
  "Fwall":2000.0,
  "lambda":0.5,
  "eta":240000.0,
  "projection_method": "cvxopt",
  "dmax":0.3,
  "dmin_people":0.0,
  "dmin_walls":0.2,
  "plot_people":true,
  "plot_contacts":true,
  "plot_desired_velocities":false,
  "plot_velocities":false,
  "plot_paths":false,
  "plot_sensors":true
}
```
