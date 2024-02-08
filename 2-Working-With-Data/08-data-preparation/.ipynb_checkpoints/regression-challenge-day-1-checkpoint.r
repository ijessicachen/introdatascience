{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "3f0c523e-0c0e-45fc-b5da-5f87166a8f44",
    "_uuid": "b6d9c40d221132f031edfd8f4b75b4ac8aaf04f9"
   },
   "source": [
    "Welcome to day one of the 5-Day Regression Challenge! To get started, click the blue \"fork notebook\" button in the upper right hand corner. This will make a copy of this notebook that you can edit. To run cells once you've forked the notebook, click inside a code cell and then hit CTRL + ENTER (CMD + ENTER on a Mac).\n",
    "\n",
    "![The button to fork this notebook](https://image.ibb.co/kNKUZ5/Screenshot_from_2017_08_30_16_47_40.png)\n",
    "\n",
    "___ \n",
    "**What is regression?**\n",
    "\n",
    "Regression is one way of modeling the strength and direction of the relationship between a dependent or output variable (usually represented by y) and one or more independent or input variables (usually represented by x). It differs from correlation analysis because it allows you to predict the outcome for new input or inputs you haven’t seen yet.\n",
    "\n",
    "**What types of regression are there?**\n",
    "\n",
    "There are many different types of regression. The specific family of regressions we’ll be learning are called “generalized linear models”. The important thing for you to know is that with this family of models, you need to pick a specific type of regression you’re interested in. The type of regression will depend on what type of data you’re trying to predict.\n",
    "\n",
    "* **Linear**: When you’re predicting a continuous value. (What temperature will it be today?)\n",
    "* **Logistic**: When you’re predicting which category your observation is in. (Is this is a cat or a dog?)\n",
    "* **Poisson**: When you’re predicting a count value. (How many dogs will I see in the park?)\n",
    "\n",
    "Today, we’re going to practice picking the right model for our dataset and plotting it. I will demonstrate first on one dataset, then you'll try your hand at another.\n",
    "\n",
    "___\n",
    "\n",
    "<center>\n",
    "[**You can check out a video that goes with this notebook by clicking here.**](https://www.youtube.com/embed/UOj-GJAuvPM)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "afad6981-9dee-4dfd-a41b-f4f6917cde21",
    "_uuid": "8c4ebe2f81c2de113e1fab8379bdd86eecad355a"
   },
   "source": [
    "## Example: Recipes\n",
    "____\n",
    "\n",
    "For our example, I'm going be working with a dataset of information on various recipes. I want to predict whether or not a recipe is a dessert based on how many calories it has. \n",
    "\n",
    "First, let's read in the library & datasets we'll need."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {
    "_cell_guid": "8d220215-fa3f-4d4d-b298-1fa9a25a03f1",
    "_kg_hide-output": true,
    "_uuid": "f6d64601c7bd679b8886efa25c414132b2342865",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:13.312803Z",
     "iopub.status.busy": "2024-02-07T02:02:13.309933Z",
     "iopub.status.idle": "2024-02-07T02:02:16.675434Z"
    }
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── Attaching packages ─────────────────────────────────────── tidyverse 1.2.1 ──\n",
      "✔ ggplot2 2.2.1.9000     ✔ purrr   0.2.4     \n",
      "✔ tibble  1.4.1          ✔ dplyr   0.7.4     \n",
      "✔ tidyr   0.7.2          ✔ stringr 1.2.0     \n",
      "✔ readr   1.2.0          ✔ forcats 0.2.0     \n",
      "── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "✖ dplyr::filter() masks stats::filter()\n",
      "✖ dplyr::lag()    masks stats::lag()\n",
      "Parsed with column specification:\n",
      "cols(\n",
      "  .default = col_double(),\n",
      "  title = col_character()\n",
      ")\n",
      "See spec(...) for full column specifications.\n",
      "Warning message:\n",
      "“Missing column names filled in: 'X1' [1]”Parsed with column specification:\n",
      "cols(\n",
      "  X1 = col_double(),\n",
      "  Date = col_datetime(format = \"\"),\n",
      "  Day = col_datetime(format = \"\"),\n",
      "  `High Temp (°F)` = col_double(),\n",
      "  `Low Temp (°F)` = col_double(),\n",
      "  Precipitation = col_character(),\n",
      "  `Brooklyn Bridge` = col_double(),\n",
      "  `Manhattan Bridge` = col_double(),\n",
      "  `Williamsburg Bridge` = col_double(),\n",
      "  `Queensboro Bridge` = col_double(),\n",
      "  Total = col_double()\n",
      ")\n",
      "Parsed with column specification:\n",
      "cols(\n",
      "  `Formatted Date` = col_character(),\n",
      "  Summary = col_character(),\n",
      "  `Precip Type` = col_character(),\n",
      "  `Temperature (C)` = col_double(),\n",
      "  `Apparent Temperature (C)` = col_double(),\n",
      "  Humidity = col_double(),\n",
      "  `Wind Speed (km/h)` = col_double(),\n",
      "  `Wind Bearing (degrees)` = col_double(),\n",
      "  `Visibility (km)` = col_double(),\n",
      "  `Loud Cover` = col_double(),\n",
      "  `Pressure (millibars)` = col_double(),\n",
      "  `Daily Summary` = col_character()\n",
      ")\n"
     ]
    }
   ],
   "source": [
    "# library we'll need\n",
    "library(tidyverse)\n",
    "\n",
    "# read in all three datasets (you'll pick one to use later)\n",
    "recipes <- read_csv(\"../input/epirecipes/epi_r.csv\")\n",
    "bikes <- read_csv(\"../input/nyc-east-river-bicycle-crossings/nyc-east-river-bicycle-counts.csv\")\n",
    "weather <- read_csv(\"../input/szeged-weather/weatherHistory.csv\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "e6eb71ca-1580-40f7-9987-ac7112d6b22f",
    "_uuid": "7913f702ef02f5a2d2e9e56214bd1e5d36246152"
   },
   "source": [
    "I'm going to do a little bit of data cleaning. I know that this has some really outrageous outliers, so I want to ignore any recipe with more than ten thousand calories. I also know that there are a lot of missing values, so I'm going to remove them. You shouldn't need to do this with the other datasets. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {
    "_cell_guid": "fc1362a1-9096-440d-86a5-b548132ca302",
    "_uuid": "3f0526ab364ee475a1bd9c465a138f05b00133fc",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:16.681960Z",
     "iopub.status.busy": "2024-02-07T02:02:16.678418Z",
     "iopub.status.idle": "2024-02-07T02:02:17.104174Z"
    }
   },
   "outputs": [],
   "source": [
    "# quickly clean our dataset\n",
    "recipes <- recipes %>% #I have no idea what <- and %>% do\n",
    "    filter(calories < 10000) %>% # remove outliers\n",
    "    na.omit() # remove rows with NA values"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "a9a026d4-e912-4e30-ad77-09df37d0849f",
    "_uuid": "b19bdbc1bca5f3410f720d45af75e9b86aae4add"
   },
   "source": [
    "So I already have my question, \"Can I predict whether or not a recipe is a dessert based on how many calories it has?\". (With your dataset you'll need to come up with your question by picking one variable to predict and one to use to predict it).\n",
    "\n",
    "In order to build a model, I need to know what type of variable whether or not a recipe is a dessert is. There are three choices:\n",
    "\n",
    "* **Continuous**. These are numeric variables that can take any value, including decimals. Examples include temperatures or prices.\n",
    "* **Count**. These are numeric variables that can only take positive integer values. Examples include the number of people at a party or the number of cars in a parking lot.\n",
    "* **Categorical**. These are not numbers. Categorical variables tell you whether or not an observation is part of a specific group. Good examples include gender or whether someone owns more than ten hats.\n",
    "\n",
    "The best way to figure out which one is a variable is is to use your knowledge of a dataset and the world in general. For example, I know that whether or not a recipie is a dessert is a *categorical* variable, while the number of calories in a dessert is probably a *count* variable (unless you have a very, very accurate measure of calories, in which case it might be continuous).\n",
    "\n",
    "There are some quick tests you can do to double-check, though. For example, I might want to know if the ratings for a recipie are categorical, count, or continuous. First, I can check if they're numeric:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {
    "_cell_guid": "6dc1f11b-5d4b-4f28-869a-958fd7aa282d",
    "_uuid": "409e34e284429408d4225b71d3fae9263dbd2c90",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:17.109553Z",
     "iopub.status.busy": "2024-02-07T02:02:17.107667Z",
     "iopub.status.idle": "2024-02-07T02:02:17.133499Z"
    }
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Is this variable numeric?\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "TRUE"
      ],
      "text/latex": [
       "TRUE"
      ],
      "text/markdown": [
       "TRUE"
      ],
      "text/plain": [
       "[1] TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# are the ratings all numeric?\n",
    "print(\"Is this variable numeric?\")\n",
    "is.numeric(recipes$rating)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "97e80dea-1db9-43a3-9609-de333f3c30ed",
    "_uuid": "21d2e83ef0fc129f0e08e610358ab646afeef2f1"
   },
   "source": [
    "So I know it's represented by a numeric variable in this dataframe. This means that ratings are probably not things like \"very good\" or \"very bad\".\n",
    "\n",
    "Next, I can check if all the values are integers (whole numbers). If so, it's probably a count variable. If not, it's probably continuous."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {
    "_cell_guid": "7ed0b43f-e731-4001-b286-ab15a7288d09",
    "_uuid": "85a343c580fe208edcbc7b2fa2ba00c5d6553a08",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:17.139578Z",
     "iopub.status.busy": "2024-02-07T02:02:17.137786Z",
     "iopub.status.idle": "2024-02-07T02:02:17.164846Z"
    }
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[1] \"Is this variable only integers?\"\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "FALSE"
      ],
      "text/latex": [
       "FALSE"
      ],
      "text/markdown": [
       "FALSE"
      ],
      "text/plain": [
       "[1] FALSE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# are the ratings all integers?\n",
    "print(\"Is this variable only integers?\")\n",
    "all.equal(recipes$rating, as.integer(recipes$rating)) == T"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "8470cacf-c9f7-4a1c-964a-02d12acf4c95",
    "_uuid": "7f0c8a44b23130b6faf15ec078351c7e6f5476ae"
   },
   "source": [
    "So, in this dataset, ratings are a continuous variable. It's a number that can have decimal values. \n",
    "\n",
    "However, I'm not interested in predicting ratings. I'm interested in predicting if something is a dessert or not based on how many calories it has. To do this, I can plot the number of calories by whether or not the recipe is for a dessert. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {
    "_cell_guid": "253249df-7dd7-475f-bf5f-8288895f00cb",
    "_uuid": "0d05f9909472a79cf8cfa7aec8c846283996a657",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:17.170690Z",
     "iopub.status.busy": "2024-02-07T02:02:17.168514Z",
     "iopub.status.idle": "2024-02-07T02:02:18.381599Z"
    }
   },
   "outputs": [
    {
     "data": {},
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdaYAcdYHw4epzzkxmMrlMCEcIIQQQkEM5TTDceIKAHHIKoqy4ICyKHLK4IAgY\nFBAWgei6AioLKgZfLjlUVJAbQ0IUJCEhMZnJZO6Z7n4/FI5j5mAS0unwn+f5lO6urvp3TVX3\nr7urK4lCoRABAPDulyz1AAAAWD+EHQBAIIQdAEAghB0AQCCEHQBAIIQdAEAghB0AQCCEHQBA\nINKlHsD61NbW1t7eXtRFJBKJmpqaKIpaW1u7urqKuqyNXCaTKS8vX716dakHUmLV1dWpVKqj\no6PY295GLt41mpqahvk5z8vLy8vKynK5XHNzc6nHUmLV1dUdHR3D/HkynU5XVVVFUWTXqKio\niKKora2t1AMppfWYEHV1dQPdFFTYFQqFXC5X1EUkEolkMhlFUT6fL/ayNnLpdDqRSAzzlRD1\n2iSG+apIJpPJZDKfz+fz+VKPpcTi9TDMt4coipLJ5AZ4Tt7IpVKpnueHYR52sWG+PWyYhPBV\nLABAIIQdAEAghB0AQCCEHQBAIIQdAEAghB0AQCCEHQBAIIQdAEAghB0AQCCEHQBAIIQdAEAg\nhB0AQCCEHQBAIIQdAEAghB0AQCCEHQBAIIQdAEAghB0AQCCEHQBAIIQdAEAghB0AQCCEHQBA\nIIQdAEAghB0AQCCEHQBAIIQdAEAghB0AQCCEHQBAINIbcmE3nnBE1RW3HTu2st9bn7j92jsf\neXrR6tTW277v2DNO2XpEdvDrAQDobUOFXaHzmQduvndl+xED3L7g9gsuu+Mvx33+jG1qu35x\n0/UX/XvbD//77FRiwOtL4qmnnjr00EO7u7tLs/iNVTKZHD9+/OrVq1evXj34lIlEolAo9DuH\nbbbZZtq0aU899dTy5ctHjRoVRVFDQ8OIESNSqVRzc3N7e3sikejq6spkMt3d3VtuueWee+65\nfPnyRx55pKmpaY15ZrPZmpqatra2ESNGJJPJFStWdHV15fP5ZDI5atSoTTfddN68eW1tbclk\ncsqUKRdddNF+++131113XXDBBX//+98LhUJdXd255567//77n3jiiS+99FJXV1dFRcXMmTNv\nuOGGysp/eU/y8MMPX3vttS+88EJlZeX73//+L33pS1OnTh3k4b/66qvHHHPMggUL4gEnk8lM\nJpNKpdrb26MoymQyu+666/nnn7/LLru8/vrrl19++W9/+9tVq1ZNnz69srLyD3/4Q2trayKR\nyGQyyWRy3LhxH/rQh84666y5c+f+z//8z4IFC8aOHTtjxozx48f/4he/WLhw4YQJE/bff/+z\nzjpr5MiRgwzpjTfeuPzyyx9//PGGhoZp06YdeuihTz755JNPPtnW1rb99tt/6lOfeuihh554\n4ommpqb6+vooipYvXz5u3LhZs2Z96UtfyufzV1555UMPPbRs2bK6urooihobG8eOHTthwoTX\nX3990aJFhUKhoqJi77333n777e+5556FCxcWCoVCoZBIJCZOnHjYYYedeeaZ99133/e+9715\n8+al0+lEItHe3j5p0qQDDzzwi1/8YmNj42WXXTZ37tyWlpZCoZBKpTbffPMbb7xxhx126P0Q\nGhsbr7rqqvvvv3/JkiVTpkw56qijTjzxxHQ6HUXRwoULTzrppPnz53d3dycSiXjt5fP5fD6f\ny+UymcyWW275ve99b6uttrrzzjtvvfXWl19+edSoUfvss89//Md/jB8/fpD1dv755992222d\nnZ3x9nb00Uefc8453/rWtx588ME333xz2rRpxx9/fF1d3Q033PDss892d3cXCoWqqqpdd931\n3HPPLS8vj/+4TU1N+Xw+3hK23nrrs8466yMf+cggC33zzTe/8Y1vPProoytWrJg6deqJJ554\n5JFHJhL/fDbsvdlMmzbts5/97OAz/NOf/nTllVc+/fTTURTttNNOH/zgB+fOnfvCCy9UVVXt\ntttu55133pQpUwa5exRFK1euvPLKK++///433ngj3rvLyspyuVxtbe1uu+32X//1X5MmTRp8\nDuvghRdeuOKKK5588snu7u4ddtjhrLPO2n333XtuXb169ZVXXnnnnXc2NDREUTRq1KhNNtnk\ntddeW7VqVRRFY8aMOf744//t3/6tvLx8KMt68MEH43186Otko1UoFH7605/Gu9uoUaP22muv\n88477z3vec/6mv/8+fMvv/zyJ598sqWlZfvttz/zzDNnzpw50MTd3d233Xbbj370o4ULF44f\nP37WrFlnn312/DRSwoewbp544omrr776mWeeSafTO++887nnnrv99tuXdkj9v9CuX0sfu+KL\n3/pta1c+iqIjbr69n0/sCp2nffLIqiOvuvqTk6Mo6mh8/JOfvuJj1//vSROz/V+/SXW/C2pt\n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\neKMa0ju32WabdXV1jRw5st+vaxOJxJgxY5qamt7hUkaNGtV3vdXU1KxYseIdznkQY8aMGfof\nK/4ZTVdX1yB/zbWaYV/9bs9RFPUcbLrOc1gHgwx79OjR1dXVqVRq8Be8HnV1dblcbpCJ6+vr\nB/pQZK0eUXysYRRFRXptGqL6+vqBjm3odztf25n3e30+n++9+cXrIZfLjR07dunSpf3uubW1\ntQMNpqgPYd0MskEOspHEPZfL5d7J8Tb5fD71jy7qa6MIu0zVdlH02Py27kllbw301fZczR4j\nB7q+547V1dXXX399z8XW1tZ38v3LIHbYYYdiH1HExu+9731vvIHNnDnzmmuuWePW+NCK973v\nfX03wm233basrKyjo2OICxro48C1lUwm99prr3w+33dIm2222YQJE5YuXbpeFlQMA+1xqVRq\n3333jR/R7rvv/sQTT6zxEAqFwkc/+tEbbrihra1t3RadTCY33XTTCRMm9F1vBx988HXXXbdu\ns31bhULhQx/6UN+Fjh07dvLkya+++mrf76Hi6adMmTJmzJgVK1YMNMEaM9xrr73edhuLf0Sy\n44479vukWlZWtvPOOz/99NODzCSRSFRVVQ00h3XwgQ98IP5d/BobRiKRmDFjRmdn54wZMx56\n6KGhPFEfdNBBg49q5syZ3/nOd9a4cvB10q+eY+z6/n5/Q5o1a9bPf/7zNa5MJpMTJkyYNGnS\nO/wD7bTTTpWVlWsc+xibOXNmz8x7jrHbf//9n3322b6D2XXXXVOp1ECDKepDWDczZszo+zQV\n/6xt991373dIPcfYrdUHzP0a5DPgjeIExWW1+47Lpu77zVufana3zvv96s4dZo0f6PoNP8IR\nI0Z88Ytf3PDLZQMYN27cUCbLZDI33XRT/O/dd989/tFTz1c58a/zvv71r/f7SUZ5efns2bOH\nOJ4Pf/jDvec8kGQy2fMry34niF+EBjrSP5lMXn311fGB5z3T957bIDNPJpNlZWWDf5M1FPFJ\nSfouIh75QPc677zz4jtGUfRf//VfFRUVa8xhq622OuOMMy677LIhDmOLLbboPYz4x4/xyuk7\n8YUXXtjv2/T4Jy99r+z34kB/slmzZvV7gpJEInHVVVfFA+s9h1133fXYY4+NoiiTyVx11VVR\nr80mnmCgGW6xxRZnnXVW3+l7r4Qoii6//PIRI0b0O9T41mw2O9BjiefwzW9+M345Xy/Gjx//\nla98pVAo9N7voig69dRT4y/NL7nkkqEsbuzYsV/+8pcHn2afffY5/PDDo3/dx6O3WycbrSOO\nOGKPPfaI+mzn11xzzTvci6MoGjly5KWXXtr373LUUUfFC13D6aefvsaZoeJ3xZdffnmpHsK6\nmT59+mmnnRb1eSE4//zzJ0yYUJIhxVIXX3zxhllSIdd0x49/ue1HDn9v1VvfKy/8yQ/u/uPf\ndtpx60QiPa37+Tt/dO/oLaeWty+9/RuXLa7Y45JPfTA54PX9L6Krq6t4n8fuvffem2yyya9+\n9asizf9draqqKpfLvZP3o6NHj952221XrlzZ3d1dVVWVzWa7urqy2WxFRUX8dUnvF57q6uqZ\nM2fW1NQsW7as38/zs9lsLpfLZrPl5eW9zztYXl4+ZsyYlpaW+OKoUaO+9rWv3Xjjjel0+qmn\nnoqnzGazJ5100te+9rVHH300PjNfMpnccccd586dO3HixJ5ZHXjggZMmTZo3b96qVasymczO\nO+983XXXHXrooQM9wOnTp++11173339/74+R4q7qOYHFFltscc0115xzzjn77bffX/7yl6VL\nl+ZyuYkTJ77nPe9pbGzsOQ9FfH64D33oQzfffHN9ff2CBQtaW1vjk+3tvvvuixcvbmtrq66u\nPuSQQ+bMmTN58uSBhjR58uSDDjqoZ0ETJkz4xCc+kUgk4vP5TZ48+aSTTioUCvGhLTU1NZlM\nprOzs7Ky8oADDvj+979/wgknvP7664sXL+7u7q6srIy/p66srNxss806OjriPTGRSGy33XYz\nZsxYtGhR7w8sy8vLDzvssDlz5owbN27+/PnNzc2pVCqVSuXz+erq6o9+9KM/+MEPPv7xj7/y\nyitvvPFGz5+4rq7u+uuvP/7443vmM3bs2MMOO2zJkiWLFi3q6uoaPXr0ySeffP31148YMeK9\n733v+9///kceeaTnzx31KaqxY8feeuutF198cUVFRTyM8vLyvffe+9Zbb9155537XWmJROIz\nn/nM888//9e//rXnmg9+8IO33HLLihUr4mGMHTv285///CGHHPLKK6+sWrUqXmgymdx2222v\nueaa4447bv78+WtsuqNHj/7KV75yySWX9DTrGjbddNNDDz30tddeW7JkSXd39/jx488888xv\nfvObPe/at9pqq/3333/hwoXxX3OTTTY599xzB5nhXnvttd12282bN6+hoSE+kd6HP/zhhoaG\nVatWxafj+u53v3vggQf2e9/Y+PHjP/GJTyxevPj111+PT7sTRVEqlSoUCvEcfvjDH+6///5D\n/G50iHbbbbdddtll3rx58WlWpkyZctlll33uc5+Ll15fX3/44YcvXrz4r3/9a/xRYiaTGT9+\nfFtbW3yxrKzsyCOPnDNnzpgxY952WQcffPCECRPifXyI66SvVCoV/43W+fPj9SKZTB522GFV\nVVXxdl5WVrbPPvvccsstu+6663qZ/w477LDXXnvNnz9/+fLlhUJhiy22uPjii88555zee1z8\nW4HOzs6ysrKjjjoqn8+/8sorbW1tVVVV8Yl7ttpqqxI+hHWz7777brXVVvF+lEqlpk+ffu21\n1w50rpOo17vWjo6Od7hrDPLud8N9vZjreP3jn/x879OdPPq5Y2avnPjT26+IoiiKCr/939l3\nPvL04ubMtO12+/zZJ4/Ppga9vh9FPY9dLJFI1NTU/OpXv3r55Zebmpp++tOfrlixYuLEia+9\n9lpVVdXq1as7OzuHfgbjqqqqlpaWbDYb/166vLy8paUlkUik0+n4p16FQiH+4+Xz+REjRrS3\nt1dUVGQymYkTJxYKhXw+v3LlyilTppSXly9durSuri6VSm266aYLFiyIT86yfPnyPfbY46WX\nXtp9992feeaZXC73/ve/P5fLrVy5sqGhoaurKw6ySZMmbbnllqtXr166dOm4ceNGjBjR1NQ0\nduzYN954Y9y4cfEX+fGLd2dnZz6fHz16dDKZTKfTqVSqs7Nz5MiR8YDjMwl3dXXV19e//PLL\n8S/I9txzz2effXaTTTYZNWpUOp3OZDLz58+PFxqfcyt+PY4PO8jn862trT2f2FdWViaTyfiM\nbtlstrm5OR5bz8+muru74xXe0tKSz+fr6+vjkUdRtHr16urq6kQi0dbWlk6nW1paMplMVVVV\nFEW5XK65uTmuxt5/jpaWlq6urjU+clu8eHHvnusrnk88hqH80bu7u5csWTJmzJj4LHQVFRUt\nLS3xW881PlqPH13P3hufBziTyfQ8tJ4p17im9yoailwu197eHq+cKIq6urrigfUdRt9Fx3/3\n+FzQ6XS65wwaq1evTqVSvQ8QXr16dTabLRQKnZ2dawyvpaWlvLw8lUr1HXm89Obm5tra2sF/\nRDbQo87n82+++WZdXV38rjqfz8f7S/wn6D1lzyY3pLUWRXEB906EeK8cN25cd3d3/DvBePOL\n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\nVIpcYYu6D/znzReMKev449xbr7z+/PLJPzhq6sh4gra2tm9/+9s9dz/11FN32WWXYj2Sf1VW\nVlZWVrZhlrUxq6qqKvUQNgqZTCaTcfRnVFlZWeohbBSSyaRdI/I82YtdIxbnHeXl7+g3oLlc\nbpBbi76Kk2XlURQ1dOer/xGnK7py6ZH97+qLfzW7qXr/Q8a/tQOkspvcfffd/7hxxN5HnvPy\nfU/+8rvPHXX13m9NkEpNnDix5+4jRowY/NGuF3Fl5/P5Yf72K5FIJJPJDbDCN3LJZDKRSBQK\nhXx+WB8sEG8P9gvbQ49UKmV7iPeL6O1eiYeDeD3YL9ZLQuTz+UE+8Ct62GWqtouix+a3dU8q\ne2sQr7bnavYY2d+0hR/c/petTjxzkLntNLbiwYblPRdramruueeenoutra0NDQ3rZdgDSSQS\n9fX1URQ1Nzd3dnYWdVkbubKyssrKymKv8I1fbW1tOp1ub29vaWkp9VhKKZlMjho1qrGxcZg/\ncVdVVVVUVORyucbGxlKPpcTq6upaW1s7OjpKPZBSymazNTU1URQ1NjYO88atrq6Ooqi5ubnU\nAyml9ZgQo0ePHuimoh/9UFa777hs6r7fLIsvdrfO+/3qzh1mje87Zdvyu36/uvPEvf5506qF\nNx59zEmLO3ve6OQfW9I6ctrUvvcFAKDoYZdIlJ3ziemv3Pq1B56a98ZfXvjeBV+vmDjzxEkj\noiha+JMf3DLn5z1TLr7v0eyIXaaU//PTxZrNj5maWv3lC2/4w/PzFrz4zB2zz32kteasz04r\n9pgBAN6NNsRhjFOPvvScaPadN112Y3Nm2nZ7X332yfHZiRc/dN+9KyeedPyH48keeXhpzRbH\n9L5jIlX95dkX3nLdnOsuu7Alqtpiyg4XXXvJ1EqHXgIA9CMR0rf+ra2tra2tRV1EzxfkTU1N\njrFzjF30j2Ps2traHGM3atSolStXOsauoqKiu7vbMXaOsYt6HWO3YsWKkF5t14Fj7KL1mhCl\nPMYOAIANQ9gBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgB\nAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELY\nAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC\n2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAE\nQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEA\nBELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgB\nAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELY\nAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABCJd6gGsT8lksqysrKiLSCQS8T8ymUzPv4en\ndDqdSCSKvcI3fvFmkEqlhvmqiNdDNpstFAqlHksppVKpaIM8F238EolEJpMp9ShKLJ1+60W2\nrKzMrhFF0TDfL9ZXQgy+LSVC2tQ6OzvjTaeo4kXk8/mQVt06SCQSyWQyl8uVeiAllkwmE4lE\noVDI5/OlHkuJpVIp24PtoUcqlfI8GT9PRlFk14jXg/1ivSREPp8f5F1TUJ/YdXd3NzU1FXUR\niUSivr4+iqLm5ubOzs6iLmsjV1ZWVllZ2dDQUOqBlFhtbW06nW5vb29paSn1WEopmUyOGjVq\n1apVw/yJu6qqqqKiIpfLNTY2lnosJVZXV9fa2trR0VHqgZRSNputqamJoqixsXGYN251dXUU\nRc3NzaUeSCmtx4QYPXr0QDc5xg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDC\nDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQ\nwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAg\nEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4A\nIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIO\nACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQQw27D3zgA1cuau57/dLf/NteM49d\nr0MCAGBdpAe/ed68efE/fv/7309+6aV5zTX/cnOh+w/3/Pp3j/+tSIMDAGDo3ibsttlmm55/\n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\ngpb06ClTpnxg1syJ5aniDQ4AgKFbi7CLoihdtcUBH93CqU0AADZC/rNXAIBACDsAgEAIOwCA\nQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsA\ngEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7\nAIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAI\nOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBA\nCDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCA\nQKRLPYD1KZFIpNPFfUSJRCL+RyqVKvayNnLJZHIDrPCNX7xJJJPJYb4q4vWQTqfz+Xypx1JK\nyWQy2iDPRe8KnidTqVT8j3Q6XSgUSjuY0kokEvaL9ZUQg29LiZA2ta6urkwmU+pRAAAUSy6X\n63nP0FdQ7dzV1bVq1aqiLiKRSNTX10dR1NTU1NnZWdRlbeTKysoqKysbGhpKPZASq62tTafT\nbW1tLS0tpR5LKSWTyVGjRq1cuXKYf2JXVVVVUVHR3d3d2NhY6rGUWF1dXWtra0dHR6kHUkrZ\nbLampiaKohUrVoT0Mco6qK6ujqKoubm51AMppfWYEKNHjx7oJsfYAQAEQtgBAARC2AEABELY\nAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC\n2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAE\nQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEA\nBELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgB\nAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELY\nAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC\n2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAEQtgBAARC2AEABELYAQAE\nQtgBAARC2AEABCK9YRbzxO3X3vnI04tWp7be9n3HnnHK1iOya0yQ7/r7z2757q/+8PKypvyE\nzad+5NjT9tthfBRFb/7u/M9c9nzvKU+85c6Pjy7fMMMGAHgX2RBht+D2Cy674y/Hff6MbWq7\nfnHT9Rf9e9sP//vsVOJfpvnlxed8/5XaU7541lZ1yWcf+NF3Ljwjf/2cAyZWNT7TWFF/6BdO\n2bZnys1rMhtgzAAA7zrFD7tC5zd/8sKWR191+KzJURRNmZL85KevmLP4tJM2qe6ZJNfx+s0v\nrNz9gisO3mVMFEVbTXvvkj8e+b/XPnfAN3Zf9lJT7fQ999xz2wHnDwBAFEUb4Bi79saHl3Tm\n9ps1Ib5YVrvXjtXZZx9a2nua7vaFm22++SHT6/5xRWLHmmx3U3MURc82ddTuWNvdumrJsoZ8\nsccKAPBuVvRP7Lpano+iaHrFP78/3aYyfd8Lq3pPUzZyxuzZM3outi176pY3mjc9aVoURU83\nd+Uen33kd17uKhTSlWM/csKZJxy4fc+UuVxu/vz5PRdHjBhRXV0dFVMi8dZXyKlUKp3eQEco\nbpxSqVQikRjmKyH6xyaRTCaH+apIJpNRFKXT6Xx+WL8Fi9eDXSOKokQi4XkylUrF/0in04VC\nobSDKa2ep4hSD6SU1ldCDL4tFX0V5zvaoiiqz/zzo8HRmVR3S/tA0y984mffvOrW7s0O+MqB\nm+Q6F63IFbao+8B/3nzBmLKOP8699crrzy+f/IOjpo6MJ25qajruuON67nvqqaeeeuqpRXso\n/6KqqmrDLGgjV1tbW+ohbBTKysrKyspKPYrSq6mpKfUQNgqpVMquEUVRZWVlZWVlqUexURg5\ncmSph7BRyGbX/Onk8PQOEyKXyw1ya9HDLllWHkVRQ3e++h9vXFZ05dIj+3kJ7Fz1yi3XXDX3\n2Ya9PvbZzx+3f2UyEaU2ufvuu/9x+4i9jzzn5fue/OV3nzvq6r2LPWwAgHedooddpmq7KHps\nflv3pLK3wu7V9lzNHmu+d2l947EvfuHqrq1mfeOmk6eNGfBsJjuNrXiwYXnPxZEjR95zzz09\nF7PZbENDw3od/poSiUT8Rry5ubmrq6uoy9rIZbPZ8vLypqamUg+kxGpqalKpVEdHR2tra6nH\nUkrxrtHY2DjMv2+qqKgoLy/P5XJ2jZqamvb29s7OzlIPpJQymUx8gJBdI/7s1vPkekmIQqEw\natSogW4tetiV1e47LnvTfb9Z9qFDJkVR1N067/erOw+ZNf5fx9h92TmzszM/e93nDsj0Og3K\nqoU3nn7h76+89b8nZuMozD+2pHXkjlN7JkgmkxMnTuy52NraWuyNpucL8nw+P/hnocGLD6Ua\n5ish+sexDraH+ACafD4/zI+xi7eHQqEwzLeHmP2i5xi7XC43zMMufvjDfHvYMAlR9LBLJMrO\n+cT0/7j1aw+M/9L0uu6fX/eNiokzT5w0IoqihT/5wSMttScd/+HWN7//7OrOT29f/dTvn/jn\nyCqm7rzdMVNTD3z5whvOOGZWXbL9Tw/8zyOtNd/47LRijxkA4N1oQ/w+ZerRl54Tzb7zpstu\nbM5M227vq88+OT478eKH7rt35cSTjv9w04JXoij6/je/0fteNZO+/D/X7f7l2Rfect2c6y67\nsCWq2mLKDhdde8nUymH9mxoAgIEkQvpweMN8FVtfXx9FUVNT0zA/dqSsrKyysrLYBzVu/Gpr\na9PpdFtbW0tLS6nHUkrJZHLUqFErV64c5l/FVlVVVVRUdHd3NzY2lnosJVZXV9fa2trR0VHq\ngZRSNpuNfyq+YsWKkF5t10F8rGFzc3OpB1JK6zEhRo8ePdBNRT9BMQAAG4awAwAIhLADAAiE\nsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAI\nhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMA\nCISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLAD\nAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISw\nAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiE\nsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAI\nhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMA\nCISwAwAIhLADAAhEutQDWM8SicSGmX8ikSj2st4VrISY7SF++NZDD+shsj3860tGaUeykRjm\n62HDJESiUCgUadYbXldXVyaTKfUoAACKJZfLpVKpgW4N6hO77u7u5ubmoi4ikUjU1tZGUdTc\n3NzV1VXUZW3kstlsRUXFqlWrSj2QEqupqUmlUh0dHa2traUeSynFu8aqVavy+Xypx1JKFRUV\n5eXluVyuqamp1GMpsZqamvb29s7OzlIPpJQymUx1dXUURY2NjSF9jLIOKisroyjyPLleEqJQ\nKIwaNWqgW4MKu0KhkMvlirqIns9O8/l8sZe1kcvn8xtghW/84idr20MymYyiKJfLDfOwi7cH\nu0bMftHzsUoulxvmYRc//GG+PWyYhPDjCQCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAI\nOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBA\nCDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCA\nQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsA\ngEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7\nAIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAI\nOwCAQAg7AIBACDsAgEAIu//f3p3HNXH0fwCfTUJCLkgQ5FZEbhA8KkKrViloFbXaPj7e1hO8\nautR61H91adWf16tR2uttR5Vq7VWVJBay6Mttgp4UrwVRDkEQe4Qcu7vj60xTQBRA/l1/bz/\n8OXOzu7M7E423+zODgAAAAAsgcAOAAAAgCUQ2AEAAACwBAI7AAAAAJZAYAcAAADAEgjsAAAA\nAFgCgR0AAAAASyCwAwAAAGAJBHYAAAAALIHADgAAAIAlENgBAAAAsAQCOwAAAACWQGAHAAAA\nwBII7AAAAABYAoEdAAAAAEsgsAMAAABgCQR2AAAAACyBwA4AAACAc2k4TQAAIABJREFUJXgt\nU0zavg37f7uYX831D+48esYkfym/6Xmasm2LcXFx0el0VqwANILL5RJC9Ho9TdMURTEpFEVp\nNBpCCEVRFEXRNE0I4fP5FEVptVpDZoFAIBQKORyOQCBQqVQajYaiKJVKpVKpCCE8Hk8ulzs7\nOxcVFVVWVhJChEKhUqnUaDQcDocphSESiQQCQWVlpV6vFwqFzK74fL5UKhUKhRKJhKIoDofT\nqlUrsVh8+/bt4uJipVIpFArDwsI8PT3LysokEklxcfG9e/eYttjY2Li7uysUCkJI9+7dx48f\nf/ny5eTkZKVS+fLLLw8dOlSv16elpaWkpGRnZ+v1+tatW8vlcj6f7+PjExIS8vvvvycmJpaW\nlgqFQicnJ1dXV4VCkZ+fX1paWldXx+FwZDKZk5OTSCSyt7eXSCTl5eV8Pj8yMrJXr15Xrly5\ne/eul5eXh4fHtWvXkpKSrl+/rtfrHR0d7ezsioqKOBxO586dbW1tCwsLPTw84uLi3NzcTpw4\ncezYMYVC4e3t7e7uTggJCwsLDAxkzlFJSUl6enpJSYmPj09ERERFRQWz2L59+4iIiDt37mRm\nZj58+FCn092/f7+wsFAqlQYFBTk4ONTU1Hh7e0dGRhYWFv7www85OTlt27YViUTHjx8vLy/3\n9fWdOnVqREREQ31Dr9dnZGRkZmaWlJQwR1UulwcHB0dERNjY2Bjn1Ol06enpN2/edHBweOml\nl4qLi48ePVpSUhIYGNi/f/82bdoYZ87Ozt6/f39ubm5QUNDIkSOdnJzMi66srExKSsrIyBCL\nxX379u3ZsyfTORty6dKljIyMgoICHo8nlUoFAoG3t3d4eLhcLtdqtWlpab///ntlZaWzszNF\nUXfv3q2pqWndurWrqytN04WFhTRNd+vWrXv37rm5uceOHSstLQ0ICOjbt2+7du2MS6moqMjI\nyMjLy2N2LhaLmfTa2tr09PScnBxPT8/w8HCZTGbYJDc39+LFi1VVVUFBQS+99JJJK5RKZXp6\nenZ2tru7e3h4uIODg3nTlEplYmLi6dOnBQJBTExMVFQUh2P5mws3b968dOmSRqPp0KFDaGgo\nIUSlUqWlpWVnZ7u4uEREROj1+vT09OLiYqYT8vl/+04xHAEPDw/msD9DHTQaTVpa2u3bt11d\nXaOjo11cXJj0/Pz8CxculJWV+fv7d+vWrTma/7Sqq6szMjJyc3Pbtm0bHh5uZ2dnWKXT6Y4d\nO3bixAm9Xv/qq6/GxsaafFgM1Gr1mTNnmCPcrVu3Vq1aNaXourq6tLS0nJwcV1fXbt261dtn\n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"
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# plot calories by whether or not it's a dessert\n",
    "ggplot(recipes, aes(x = calories, y = dessert)) + # draw a \n",
    "    geom_point()  # add points"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "f19abc2c-a75e-4917-bd09-6db506a08f59",
    "_uuid": "a84042b366578bda0f92c7a5d18317c9a33e521d"
   },
   "source": [
    "Since whether or not something is a dessert is a categorical variable, we want to use logistic regression to answer this question. As you can see in the chart below, the link function for logistic regression is \"binomial\".\n",
    "___\n",
    "![Regression guide](https://image.ibb.co/ducqSw/regression_guide.png)\n",
    "___\n",
    "\n",
    "We can fit and plot a regression line to our data using the geom_smooth() layer. To make sure we do logistic regression, we need to make sure that we tell geom_smooth to fit a regression model from the binomial family, like so:\n",
    "    \n",
    "    geom_smooth(method = \"glm\", method.args = list(family = \"binomial\"))\n",
    " \n",
    " If we were fitting a linear regression model instead, for example, we'd ask geom_smooth() to fit a model from the gaussian family, like so:\n",
    "    \n",
    "    geom_smooth(method = \"glm\", method.args = list(family = \"gaussian\"))\n",
    "    \n",
    "geom_smooth() relies on the x and y arguments that you pass to ggplot (in the aes() argument), so you want to make sure you put the value you're interested in predicting in the y argument slot. (Here, that's \"dessert\".)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {
    "_cell_guid": "35e19714-3142-44f2-811f-ebba59229b48",
    "_uuid": "ea7f63a1a1a6a01cdb0a3edda950162189f90bcf",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:18.401960Z",
     "iopub.status.busy": "2024-02-07T02:02:18.400499Z",
     "iopub.status.idle": "2024-02-07T02:02:20.017660Z"
    }
   },
   "outputs": [
    {
     "data": {},
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzde5wT1f3/8TOTe/aW7C67y3IREBBBRauoCFqweLe1VRTqpd6o1tZqi2Kt1kv9\narHeUcFqFaX9+VWptVprwa9X1FqsWETRIoiXyl5hN9ndJJPrzO+Pg3HdG2E32eyefT0fPHhs\nksnMJ5OZ5J0zZ85olmUJAAAADH56vgsAAABAdhDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ\n7AAAABRBsAMAAFAEwQ4AAEAR9nwXkE2GYUSj0ZwuQtO04uJiIUQkEkkkEjld1gDncDjcbndb\nW1u+C8mzwsJCm80Wi8Vyve0NcHLXaG1tHeJjnrvdbpfLlUqlQqFQvmvJs8LCwlgsNsQ/J+12\ne0FBgRCCXcPj8QghDMPIdyH5lMUI4ff7u3tIqWBnWVYqlcrpIjRN03VdCGGaZq6XNcDZ7XZN\n04b4ShDtNokhvip0Xdd13TRN0zTzXUueyfUwxLcHIYSu6/3wmTzA2Wy29OfDEA920hDfHvon\nQnAoFgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEO\nAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEAR\nBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAA\nAEUQ7AAAABRBsAMAAFCEvT8Xdv85pxXc8siZFd4uH137+N0r16zf1mbba8o3zrx4wV5Fzp7v\nBwAAQHv9Feys+LsvPvhcc/S0bh7f8vg1i5/45KyfXLy3L/G3B5Zd93Pj0d9fZtO6vT8v3nnn\nnRNPPDGZTOZn8QOVrutVVVVtbW1tbW09T6lpmmVZXc5h7733njRp0jvvvLN9+/bS0lIhRCAQ\nKCoqstlsoVAoGo1qmpZIJBwORzKZ3HPPPWfMmLF9+/Y1a9a0trZ2mKfT6SwuLjYMo6ioSNf1\npqamRCJhmqau66WlpaNHj960aZNhGLqujx8//rrrrjvqqKOeeuqpa665ZseOHZZl+f3+K664\n4uijjz733HM//PDDRCLh8Xhmz5593333eb1f+03yyiuv3H333Rs3bvR6vYcccsjll18+ceLE\nHl7+Z599dsYZZ2zZskUWrOu6w+Gw2WzRaFQI4XA4pk2bdvXVVx900EFffPHFzTff/Oabb7a0\ntEyePNnr9f7rX/+KRCKapjkcDl3XKysrv/Wtby1cuHDVqlX/7//9vy1btlRUVMyaNauqqupv\nf/vb1q1bq6urjz766IULF5aUlPRQUm1t7c033/zGG28EAoFJkyadeOKJ69atW7dunWEY++67\n7/e///2XX3557dq1ra2tZWVlQojt27dXVlbOmTPn8ssvN03z1ltvffnllxsbG/1+vxAiGAxW\nVFRUV1d/8cUX27ZtsyzL4/Ecfvjh++677zPPPLN161bLsizL0jRtxIgRp5xyyqWXXrp69eqH\nHnpo06ZNdrtd07RoNDpq1Khjjz32Zz/7WTAYXLx48apVq8LhsGVZNpttzJgx999//9SpU9u/\nhGAwePvtt7/wwgt1dXXjx4+fP3/+ueeea7fbhRBbt24977zzNm/enEwmNU2Ta880TdM0U6mU\nw+HYc889H3rooQkTJqxcufLhhx/+6KOPSktLjzjiiF/84hdVVVU9rLerr776kUceicfjcns7\n/fTTFy1adNddd7300ksNDQ2TJk06++yz/X7/fffdt2HDhmQyaVlWQUHBtGnTrrjiCrfbLd/c\n1tZW0zTllrDXXnstXLjwO9/5Tg8LbWho+O1vf/vaa681NTVNnDjx3HPPnTdvnqZ99WnYfrOZ\nNGnSj370o55n+O9///vWW29dv369EOKAAw745je/uWrVqo0bNxYUFBx88MFXXnnl+PHje3i6\nEKK5ufnWW2994YUXamtr5d7tcrlSqZTP5zv44IN/85vfjBo1quc59MLGjRtvueWWdevWJZPJ\nqVOnLly4cPr06elH29rabr311pUrVwYCASFEaWnpyJEjP//885aWFiHEsGHDzj777J/+9Kdu\ntzuTZb300ktyH898nQxYlmX9+c9/lrtbaWnpzJkzr7zyyuHDh2dr/ps3b7755pvXrVsXDof3\n3XffSy+9dPbs2d1NnEwmH3nkkccee2zr1q1VVVVz5sy57LLL5MdIHl9C76xdu/aOO+549913\n7Xb7gQceeMUVV+y77775LanrL9rsqn/9lp/d9WYkYQohTnvw8S5a7Kz4hafOK5h3+x2njhNC\nxIJvnPqDW7677H/PG+Hs+v6RhV0uKBKJRCKRHL2KFStWXH755TmaOfJo7733/s9//tPhzs4Z\ntLCwcP369T6fT9688cYblyxZout6+rtZ1/UHH3zwhBNO6HIpr7zyyrx583a5u2matmDBgj/8\n4Q/xeLzniTVNs9lsMrK0n7L9zcrKylWrVnX35bpu3bqTTz45Go3K6eUT00+XL627LO7z+UzT\nbGtr68sHiNfrjUQi6XXYXnl5eWtrq0xOHdx9993f//735d+ff/75cccdt337dnlTVnvwwQc/\n9dRTa9asOfPMMzNZ4QceeOC6devSZWia5vV6n3nmmQ4JMm3atGmfffZZhzt1XZexVbR7Czq/\nNek7uyxs/vz599xzT5cLfe+990466SSZcdMzOfbYY1esWKHruhDin//852mnnRaLxdq/fT3M\ncPny5VdeeaWmaelX3eHd13X9kUceOeaYY7pbdVu3bj3++OObm5u7fFTXdZvN9uijj/bw7d4L\njz/++KWXXiqESO93lmX96le/uuSSS4QQNTU1xx57bH19fc8zmTBhwqpVq3r+zSOEuO6665Yt\nW9ZhH+95nXQmf2cKIZqamvrh27Y7lmUtWLDgr3/9a/vt3OPxPP300wcccEDf5//cc88tWLBA\n/moSX25+l1566a9+9av0NIWFhUKIUCgUi8Xmzp27du3a9jtIeXn56tWr99hjj3y9hN65++67\nb7zxxvR+JHfGJUuWzJ8/v8vpNU2TP5K7+3zLXHl5eXcP9UewS7TV1zbHzETDpQtv7DLYRQPP\nn3b20otWrDzOv/NX1LWnz2059ubffntrl/cv+UHXv5lyF+yi0ejo0aPzuFtiIJg1a9af/vQn\nIcSGDRuOOuqoDtuDruvFxcUbNmzo0LAnhEgkEhMnTgyFQpksRbYtdc46vaBp2nHHHbdixYrO\nD1mWNWPGjK1bt/Z6Qd1lvmzpbv5Op7Ompkb+fcYZZ7z44oudX8K11167ZMkS2UjTC7IJ+dVX\nX+380F133XXTTTf1braZeOyxx+bMmdP5/iOPPPKDDz7o/EqXLl162mmnmaY5bdq0bdu2dZ6g\nyxnW1tZOmzYtkUj08A7quu73+999993uGrfmzp37+uuv97D97HIOu6u5ufmAAw4wDKNDXNZ1\n/R//+Meee+65YMGCZ555JpNZXXjhhTfeeGMPE7zzzjvHHXdc5318d1/RAAl2zzzzzIIFCzrc\nqev6xIkTX3/99T7OPBKJTJ06Nd0CnaZp2gsvvJD+gZQOdsuWLbvuuus6FzN79uzHH388Ly+h\ndz755JPDDjvMNM0OG6Tb7V6/fr0McB30T7Drj0OxjqKqPYpEKtbtiRqJ8PtCiMkeR/qevb32\n1RtbEkd2fX/6ZiQSueuuu9I3DzvssEMPPTS7xUtvvvkmqQ5r166Vn02rV6/uvD2YphkMBt9+\n++3OjXZvvPFGhqlOCNFdc04vWJb1f//3fzabzePxdHjogw8+2LJlSx9n3pen93r+8Xh8zZo1\nJ5xwQigUeumllzoHC13X//SnP/U61QkhTNP84IMP6uvrOx93e+KJJ3o9213SNO2555777ne/\n2+H+Tz/99P333+88va7rf//7388777x///vf//3vf7ucoMsZvvrqq7v8UjFNs6mp6d///vfR\nRx/d+dFAIPDaa6/1vA3IOaxfv/6oo47qeVkZevbZZzv/dLcsK5VKvfDCC5MmTVq1alWGs3rm\nmWfaf3d01uWsel4nXZJNOEKIwsLCPH6JPPfcc52bxk3T3LRp07Zt2yZNmtSXmb/22mvBYLDz\n/ZZlrVq1asaMGfKmw+EQQhQWFj777LNdFvPKK6+YpilzcD+/hN558cUXU6lUhzstyzIM4403\n3jjjjDN6eK7H43E6e3/CQM8/yPv15InumDFDCFHm+Cr5lTtsyXC0u/vTN2Ox2FNPPfXVo+Xl\ns2bNykWF6WM9GMpisZj8pd7Y2NjlAUT5UOdf83ncfpLJZEtLS+fOKzt27MhLPVmxefPmU045\npaampvOnqhDCNM10k15fbN++fZ999ulwp+y5lTt1dXWdt5/u3izTNLdt2+Z2u3vYwLqcYeYb\nZJfbsxCiubk5w5jS3Rx6oYey6+vrw+Fw5k0gDQ0NTqcznbo6k/t4lxtY716Ry+Xa3adkUUND\nQ3fv1/bt2/fff/++zLy790XX9fr6+g7rymaz1dTUdPnhaZpmIBCoqKjocm45fQm909jY2N1D\nDQ0NPW8kDodDJt3e6XLLTBsQwU53uYUQgaRZaLPJe5oSKXuJq7v70090OBwHH3xw+ubw4cMT\niUQuKuyyTRVDjcPhkBtYWVlZdx8xZWVlnTdCeTpIXsgDxAOqpL7bY489EolESUlJl4drNU0b\nNmxYa2trH5dSWlraeb0VFxc3NTX1cc49GDZsWOZvljyNJpFI9PBu7tYMO+tyexZCpDub9noO\nvdBD2eXl5YWFhTabrecvvDS/359KpXqYuKysrLtGkd16RbKvoRAiR99NGSorK+uub0OX2/nu\nzrzL+03TbL/5yfWQSqUqKirq6+u73HN9Pl93xeT0JfRODxtkDxuJzHOpVKov/W1M07R9mYs6\nGxDBzlGwjxCvbzaSo1w7C/0smio+rKS7+9NPLCwsXLZsWfpmJBLpy/GXHkydOjXXPYow8O23\n335yA5s9e/add97Z4VHZteIb3/hG541wypQpLpcrFotluKDumgN3l67rM2fONE2zc0l77LFH\ndXV1fX19VhaUC93tcTab7cgjj5SvaPr06WvXru3wEizLOumkk+677z7DMHq3aF3XR48eXV1d\n3Xm9HX/88UuXLu3dbHfJsqxvfetbnRdaUVExbty4zz77rPNxKDn9+PHjhw0b1tTU1N0EHWY4\nc+bMXW5j8iSS/fffv8sPVZfLdeCBB65fv76HmWiaVlBQ0N0ceuHQQw+V58V32DA0TZs1a1Y8\nHp81a9bLL7+cyQf1cccd13NVs2fPvvfeezvc2fM66VK6j13n8/f705w5c5599tkOd+q6Xl1d\nPWrUqD6+QQcccIDX6+3Q91GaPXt2eubpPnZHH330hg0bOhczbdo0m83WXTE5fQm9M2vWrM4f\nU/K0tunTp3dZUrqP3W41MHephzbgATFAsct3ZKXTtvofO1s1k5FNb7XFp86p6u7+/q+wqKjo\nZz/7Wf8vF/2gsrIyk8kcDscDDzwg/54+fbo86Sl9KEeenXfTTTd12ZLhdruXLFmSYT3f/va3\n28+5O7qup8+y7HIC+SXUXU9/XdfvuOMO2fE8PX37ufUwc13XXS5Xz0eyMiEHJem8CFl5d8+6\n8sor5ROFEL/5zW88Hk+HOUyYMOHiiy9evHhxhmWMHTu2fRny5Ee5cjpPfO2113b5M12e8tL5\nzi5vdveWzZkzp8sBSjRNu/3222Vh7ecwbdq0M888UwjhcDhuv/120W6zkRN0N8OxY8cuXLiw\n8/TtV4IQ4uabby4qKuqyVPmo0+ns7rXIOdx2223y6zwrqqqqrrrqKsuy2u93QogLLrhAHjS/\n4YYbMllcRUXFL3/5y56nOeKII+bOnSu+vo+LXa2TAeu000477LDDRKft/M477+zjXiyEKCkp\nufHGGzu/L/Pnz5cL7eCiiy7qMDKU/FV888035+sl9M7kyZMvvPBC0emL4Oqrr66urs5LSZLt\n+uuv758lWanWJ/709ynfmbtfwc7jyluf/OPTb//3gP330jT7pOT7Kx97rnzPie5o/eO/XVzj\nOeyG739T7/b+rheRSCRy1x57+OGHjxw58vnnn8/R/Ae1goKCVCrVl9+j5eXlU6ZMaW5uTiaT\nBQUFTqczkUg4nU6PxyMPl7T/4iksLJw9e3ZxcXFjY2OX7flOpzOVSjmdTrfb3X7cQbfbPWzY\nsHA4LG+Wlpb++te/vv/+++12+zvvvCOndDqd55133q9//evXXntNjsyn6/r++++/atWqESNG\npGd17LHHjho1atOmTS0tLQ6H48ADD1y6dOmJJ57Y3QucPHnyzJkzX3jhhfbNSDJXpQewGDt2\n7J133rlo0aKjjjrqk08+qa+vT6VSI0aMGD58eDAYTI9DIceH+9a3vvXggw+WlZVt2bIlEonI\nwfamT59eU1NjGEZhYeEJJ5ywYsWKcePGdVfSuHHjjjvuuPSCqqurTz75ZE3T5Hh+48aNO++8\n8yzLkl1biouLHQ5HPB73er3HHHPMH/7wh3POOeeLL76oqalJJpNer1cep/Z6vXvssUcsFpN7\noqZp++yzz6xZs7Zt29a+wdLtdp9yyikrVqyorKzcvHlzKBSy2Ww2m800zcLCwpNOOumPf/zj\n9773vY8//ri2tjb9Fvv9/mXLlp199tnp+VRUVJxyyil1dXXbtm1LJBLl5eXnn3/+smXLioqK\n9ttvv0MOOWTNmjXpt1t0SlQVFRUPP/zw9ddf7/F4ZBlut/vwww9/+OGHDzzwwC5XmqZpP/zh\nD99///1PP/00fc83v/nN5cuXNzU1yTIqKip+8pOfnHDCCR9//HFLS4tcqK7rU6ZMufPOO886\n66zNmzd32HTLy8uvuuqqG264IZ1ZOxg9evSJJ574+eef19XVJZPJqqqqSy+99Lbbbkv/ap8w\nYcLRRx+9detW+W6OHDnyiiuu6GGGM2fO3GeffTZt2hQIBORAet/+9rcDgUBLS4scjut3v/vd\nscce2+VzpaqqqpNPPrmmpuaLL76Qw+4IIWw2m2VZcg6PPvro0UcfneGx0QwdfPDBBx100KZN\nm+QwK+PHj1+8ePGPf/xjufSysrK5c+fW1NR8+umnsinR4XBUVVUZhiFvulyuefPmrVixYtiw\nYbtc1vHHH19dXS338QzXSWc2m02+R71uP84KXddPOeWUgoICuZ27XK4jjjhi+fLl06ZNy8r8\np06dOnPmzM2bN2/fvt2yrLFjx15//fWLFi1qv8fJcwXi8bjL5Zo/f75pmh9//LFhGAUFBXLg\n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\neo7j7rzzzqiTzPDhw202W+1dZy5S7969c3JyJk+eXO0l1zFjxlR7dWzq1KmxQ7TQIHjHHXcE\ng8G8vDzaNyvqgw8++CDdD7XsCo1GM27cuLicpXv06JGbmxt1+OjLWvYqrQCTJk0KBoOTJ0+u\ndkPuu+++UChUx2LQOwZi19i6devYfajVau+66664bH490O2NPeKTJ0+eOHFitX8IDMNMmTIl\nciGTJk1ShpeKXMikSZMYhomck3aqo7/fe++91e5qOr3hdsFFGzt2LM/zsYebYRie56ut23SG\nuteomtRUpUkDBDve1r8Jp9n4beU/fCHfoR1usduAzLrMU5fPNphqhycASC6GYWoaWSpey4/L\n/O3atVu9ejUdRkGZTenHQ1/WZdin2stjMpnWrl1rNBojJ7Zs2XLJkiU13XdpMplef/31a665\nhhDSoUOHt99+m/Z9qWlF3bt3f/PNNwkhK1asaNeuXdS7/fv3nzNnjvJy4sSJ9P7TqDWuWLEi\ntheRzWZbuXIlHfkvFsuy/fr1U0abq4crr7zynXfeIYTk5eXdf//9kYlHp9NNnz591qxZzzzz\nDB3UTTkikydPnjx58ltvvaXcQEbfcjgcy5YtoyPLDBo0aNasWZEfZBhmwoQJTz75pLL22267\n7amnnoo6xHq9/r333ovthlU/Go1m2bJlnTp1iixndnb21KlTab+uqANBXxoMhldeeYVu3ZAh\nQ2bMmEH/oJQ9QHdX3Ytx9dVXv/766/RIKWu84447NmzYMGDAgMhVp6SkvPvuu23atLmYrb4Y\nd95552OPPUb/DJmqgT8feuihcePGdejQYeHChVHnFq1WO2/evKuvvjpy4vXXX//iiy/q9XoS\ncfRHjx79xBNP1LLq/v37z549O6rOjB8//pFHHonzRiZYdnb20qVLY08vNpttyZIlkbcPN6SG\nGMfu8AfTn/y08IFpj+XaQ2vfmPO1/5plbzykYUjBJ8u+9tom3DW0lnlqml6thA53QggRBCE7\nO7thOoBDvNTUIZ2JGeiLoj1h6VuR/85qNBo6ehmdSD+uLEE5g9OvLuWfUeUGSTqqAh3NmA6D\nzPN8SUmJIAj0zju73Z6enk7v0fN6vW63m65Iq9Xq9XpZlrVabU5OzsMPP7xly5YtW7aIoti1\na9enn346HA5/+umn69atO3v2bDAYTElJsVqtZrM5Jyfniiuu2Lp167fffuv3+xmGMZvNNpst\n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\n0KFDhy4r9FZOjdc54SLqBvrY1VWgfPMZMTxwQDP6krf1udLM7fvqbHJLBYkQChS0bNVqcK69\nagJzpZULuTyEkH0uwXalLeSrOFPklKrerqluoM6oSVwOPaqE+sgh5wv/+HTUc0+kaRmCU0Rj\nknbl+Dkvz5//8t8jJ8brnHAxdQN97Ooq6N1PCMk16JQpHY3ajT9WJK9EkCh8St/58/sqL/1F\nuxef9rSYkEMI2eMJhr+ZP+qfPwdlWWvMGHb33+6+pUtNdSPYH3VGPeJy6FEl1Kfg0+fPZv5l\nZOvK58DiFNF46CyZLS0kLPyugSxe54SLqRsIdnUlCX5CSJru3CF06DQhbyB5JYKGUJC/Zt5L\nS0Itb376luZh8WRpWL7C3uu5d55J54Vdny95ccF0fetlt2qqrxuoM6oRr0OPKqEyYfHU//u4\n4I5//qPqJU4Rjd2F/u0n4lyBYFdXLK8nhDhDklmjoVNKg2FtCp/UQkECiRVHFr/y0uf7nH2G\n3/fAuEFGliGa5p999lnV+5brRz3+88bvNiz8YfAj1dcN1BnV0HDxOfSoEipz6j/zXeZBgzMr\ne83Hq5407EZAPF3o334izhXoY1dXOlNnQshhf0iZciwQtnZKSV6JIIF8p7dOnfj4DqHznEVL\nH7/rZiNb/Z1IV2UYgp7imuoG6oyK1e/Qo0qoi7zsw6Ptxg6rZQ6cIhqbeJ0TLqZuINjVFW/r\n34TTbPy2iL4M+Q7tcIvdBmQmt1SQEHJo9uPzuX73LXrhgZz0c0+ArSh4a/SYCafEcNUEaesZ\nX0pO+5rqBuqMasTr0KNKqIm/+NMdbvGePucOH04REK9zwsXUDc2zzz4b581SKYbR5oT2f7xy\nvaNNe33g7IdzZp8yXPePO2+soSkHLmO+wqVv/PvA7SP6e8+ePlnlbKnxivZX/bjm40++K85q\nYvWVnNy08qX1BfKM5+92cFwNdQN1RiX4lJw4HXpUCfU4/ulbm0+0vW9UP2VK/OpJEjcLLowc\ndn30rw2dhv25q0lHaosK8Zp+/iJhgOILIm/7YP7HX+855dHldO7xwKMTMzlNsosE8Xd269N5\nL/4YNdGaPW35G70F5/7Fb7yX/9NvXmK6om23MfflXdmMdq+pqW6gzqhE/A49qoRKvDth1LfN\nHl08q0fkRJwiGpuwcGLEyAciByiO3zmhnnUDwQ4AAABAJdDHDgAAAEAlEOwAAAAAVALBDgAA\n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"
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# plot & add a regression line\n",
    "ggplot(recipes, aes(x = calories, y = dessert)) + # draw a \n",
    "    geom_point() + # add points\n",
    "    geom_smooth(method = \"glm\", # plot a regression...\n",
    "                method.args = list(family = \"binomial\")) # ...from the binomial family"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "1041a1e3-e0ad-4c61-8c05-f6cf4655b8ac",
    "_uuid": "fd36d169e4c18f6537667cba813142d9c98268ff"
   },
   "source": [
    "That blue line we've plotted is actually a regression model! Looking at the regression line, we can tell that as the number of calories in a recipe increases, it's more likely that that recipe is a dessert. (We can tell this because the line moves towards 1, which means \"is a dessert\" and away from 0, which means \"isn't a dessert\"). \n",
    "\n",
    "The grey shape behind it is the standard error. Looking at the error, we can tell that we're pretty sure about our prediction when there's fewer calories (towards the left side of the graph), but as we move to the right we get less certain and our error increases.\n",
    "\n",
    "We'll learn more about fitting and interpreting models tomorrow, but for now it's time for you to try your own hand at picking the right type of model and fitting it."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "2e948f7c-38a0-4291-a1db-21d4354064ac",
    "_uuid": "43724752a422d0fd6edd2de8b1c19bd8e671d641"
   },
   "source": [
    "## Your turn!\n",
    "___\n",
    "![Regression guide](https://image.ibb.co/ducqSw/regression_guide.png)\n",
    "\n",
    "A quick guide to the three types of regression we've talked about.\n",
    "___\n",
    "\n",
    "Now it's your turn to come up with a question, pick the right model for your data and plot it.\n",
    "\n",
    "1. Pick one of the two datasets (\"weather\" or \"bikes\", your choice! You can find out more about these datasets by expanding the \"Input\" section at the very top of this notebook.)\n",
    "    * wait is this in R? put this on hold to do an intro to that\n",
    "2. Identify which variables are continuous, categorical and count using the dataset documentation. (You can also check out a summary of the dataset using summary() or str())\n",
    "3. Pick a variable to predict and one varaible to use to predict it\n",
    "    * For this challange, if you're picking a categorical value, I'd recommend choosing one with only two possible categories (like dessert or not dessert)\n",
    "4. Plot your two variables\n",
    "5. Use \"geom_smooth\" and the appropriate family to fit and plot a model\n",
    "6. Optional: If you want to share your analysis with friends or to ask for help, you’ll need to make it public so that other people can see it.\n",
    "  * Publish your kernel by hitting the big blue “publish” button. (This may take a second.)\n",
    "  * Change the visibility to “public” by clicking on the blue “Make Public” text (right above the “Fork Notebook” button).\n",
    "  * Tag your notebook with 5daychallenge"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {
    "_cell_guid": "049c2eb8-dcef-4145-8504-53ef5b360497",
    "_uuid": "887817af8bb97cca166e6ba20671a5bb91a31f85",
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.024190Z",
     "iopub.status.busy": "2024-02-07T02:02:20.021321Z",
     "iopub.status.idle": "2024-02-07T02:02:20.049828Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "       X1              Date                          Day                     \n",
       " Min.   :  0.00   Min.   :2016-04-01 00:00:00   Min.   :2016-04-01 00:00:00  \n",
       " 1st Qu.: 52.25   1st Qu.:2016-04-08 00:00:00   1st Qu.:2016-04-08 00:00:00  \n",
       " Median :104.50   Median :2016-04-15 12:00:00   Median :2016-04-15 12:00:00  \n",
       " Mean   :104.50   Mean   :2016-04-15 12:00:00   Mean   :2016-04-15 12:00:00  \n",
       " 3rd Qu.:156.75   3rd Qu.:2016-04-23 00:00:00   3rd Qu.:2016-04-23 00:00:00  \n",
       " Max.   :209.00   Max.   :2016-04-30 00:00:00   Max.   :2016-04-30 00:00:00  \n",
       " High Temp (°F)  Low Temp (°F)   Precipitation      Brooklyn Bridge\n",
       " Min.   :39.90   Min.   :26.10   Length:210         Min.   : 504   \n",
       " 1st Qu.:55.00   1st Qu.:44.10   Class :character   1st Qu.:1447   \n",
       " Median :62.10   Median :46.90   Mode  :character   Median :2380   \n",
       " Mean   :60.58   Mean   :46.41                      Mean   :2270   \n",
       " 3rd Qu.:68.00   3rd Qu.:50.00                      3rd Qu.:3147   \n",
       " Max.   :81.00   Max.   :66.00                      Max.   :3871   \n",
       " Manhattan Bridge Williamsburg Bridge Queensboro Bridge     Total      \n",
       " Min.   : 997     Min.   :1440        Min.   :1306      Min.   : 4335  \n",
       " 1st Qu.:2617     1st Qu.:3282        1st Qu.:2457      1st Qu.: 9596  \n",
       " Median :4165     Median :5194        Median :3477      Median :15292  \n",
       " Mean   :4050     Mean   :4862        Mean   :3353      Mean   :14534  \n",
       " 3rd Qu.:5309     3rd Qu.:6030        3rd Qu.:4192      3rd Qu.:18315  \n",
       " Max.   :6951     Max.   :7834        Max.   :5032      Max.   :23318  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# their method first\n",
    "summary(bikes)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.056103Z",
     "iopub.status.busy": "2024-02-07T02:02:20.053496Z",
     "iopub.status.idle": "2024-02-07T02:02:20.091784Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'X1'</li>\n",
       "\t<li>'Date'</li>\n",
       "\t<li>'Day'</li>\n",
       "\t<li>'High_Temp_(°F)'</li>\n",
       "\t<li>'Low_Temp_(°F)'</li>\n",
       "\t<li>'Precipitation'</li>\n",
       "\t<li>'Brooklyn_Bridge'</li>\n",
       "\t<li>'Manhattan_Bridge'</li>\n",
       "\t<li>'Williamsburg_Bridge'</li>\n",
       "\t<li>'Queensboro_Bridge'</li>\n",
       "\t<li>'Total'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'X1'\n",
       "\\item 'Date'\n",
       "\\item 'Day'\n",
       "\\item 'High\\_Temp\\_(°F)'\n",
       "\\item 'Low\\_Temp\\_(°F)'\n",
       "\\item 'Precipitation'\n",
       "\\item 'Brooklyn\\_Bridge'\n",
       "\\item 'Manhattan\\_Bridge'\n",
       "\\item 'Williamsburg\\_Bridge'\n",
       "\\item 'Queensboro\\_Bridge'\n",
       "\\item 'Total'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'X1'\n",
       "2. 'Date'\n",
       "3. 'Day'\n",
       "4. 'High_Temp_(°F)'\n",
       "5. 'Low_Temp_(°F)'\n",
       "6. 'Precipitation'\n",
       "7. 'Brooklyn_Bridge'\n",
       "8. 'Manhattan_Bridge'\n",
       "9. 'Williamsburg_Bridge'\n",
       "10. 'Queensboro_Bridge'\n",
       "11. 'Total'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"X1\"                  \"Date\"                \"Day\"                \n",
       " [4] \"High_Temp_(°F)\"      \"Low_Temp_(°F)\"       \"Precipitation\"      \n",
       " [7] \"Brooklyn_Bridge\"     \"Manhattan_Bridge\"    \"Williamsburg_Bridge\"\n",
       "[10] \"Queensboro_Bridge\"   \"Total\"              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>X1</th><th scope=col>Date</th><th scope=col>Day</th><th scope=col>High Temp (°F)</th><th scope=col>Low Temp (°F)</th><th scope=col>Precipitation</th><th scope=col>Brooklyn Bridge</th><th scope=col>Manhattan Bridge</th><th scope=col>Williamsburg Bridge</th><th scope=col>Queensboro Bridge</th><th scope=col>Total</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>0         </td><td>2016-04-01</td><td>2016-04-01</td><td>78.1      </td><td>66.0      </td><td>0.01      </td><td>1704      </td><td>3126      </td><td>4115      </td><td>2552      </td><td>11497     </td></tr>\n",
       "\t<tr><td>1         </td><td>2016-04-02</td><td>2016-04-02</td><td>55.0      </td><td>48.9      </td><td>0.15      </td><td> 827      </td><td>1646      </td><td>2565      </td><td>1884      </td><td> 6922     </td></tr>\n",
       "\t<tr><td>2         </td><td>2016-04-03</td><td>2016-04-03</td><td>39.9      </td><td>34.0      </td><td>0.09      </td><td> 526      </td><td>1232      </td><td>1695      </td><td>1306      </td><td> 4759     </td></tr>\n",
       "\t<tr><td>3         </td><td>2016-04-04</td><td>2016-04-04</td><td>44.1      </td><td>33.1      </td><td>0.47 (S)  </td><td> 521      </td><td>1067      </td><td>1440      </td><td>1307      </td><td> 4335     </td></tr>\n",
       "\t<tr><td>4         </td><td>2016-04-05</td><td>2016-04-05</td><td>42.1      </td><td>26.1      </td><td>0         </td><td>1416      </td><td>2617      </td><td>3081      </td><td>2357      </td><td> 9471     </td></tr>\n",
       "\t<tr><td>5         </td><td>2016-04-06</td><td>2016-04-06</td><td>45.0      </td><td>30.0      </td><td>0         </td><td>1885      </td><td>3329      </td><td>3856      </td><td>2849      </td><td>11919     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|lllllllllll}\n",
       " X1 & Date & Day & High Temp (°F) & Low Temp (°F) & Precipitation & Brooklyn Bridge & Manhattan Bridge & Williamsburg Bridge & Queensboro Bridge & Total\\\\\n",
       "\\hline\n",
       "\t 0          & 2016-04-01 & 2016-04-01 & 78.1       & 66.0       & 0.01       & 1704       & 3126       & 4115       & 2552       & 11497     \\\\\n",
       "\t 1          & 2016-04-02 & 2016-04-02 & 55.0       & 48.9       & 0.15       &  827       & 1646       & 2565       & 1884       &  6922     \\\\\n",
       "\t 2          & 2016-04-03 & 2016-04-03 & 39.9       & 34.0       & 0.09       &  526       & 1232       & 1695       & 1306       &  4759     \\\\\n",
       "\t 3          & 2016-04-04 & 2016-04-04 & 44.1       & 33.1       & 0.47 (S)   &  521       & 1067       & 1440       & 1307       &  4335     \\\\\n",
       "\t 4          & 2016-04-05 & 2016-04-05 & 42.1       & 26.1       & 0          & 1416       & 2617       & 3081       & 2357       &  9471     \\\\\n",
       "\t 5          & 2016-04-06 & 2016-04-06 & 45.0       & 30.0       & 0          & 1885       & 3329       & 3856       & 2849       & 11919     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "X1 | Date | Day | High Temp (°F) | Low Temp (°F) | Precipitation | Brooklyn Bridge | Manhattan Bridge | Williamsburg Bridge | Queensboro Bridge | Total | \n",
       "|---|---|---|---|---|---|\n",
       "| 0          | 2016-04-01 | 2016-04-01 | 78.1       | 66.0       | 0.01       | 1704       | 3126       | 4115       | 2552       | 11497      | \n",
       "| 1          | 2016-04-02 | 2016-04-02 | 55.0       | 48.9       | 0.15       |  827       | 1646       | 2565       | 1884       |  6922      | \n",
       "| 2          | 2016-04-03 | 2016-04-03 | 39.9       | 34.0       | 0.09       |  526       | 1232       | 1695       | 1306       |  4759      | \n",
       "| 3          | 2016-04-04 | 2016-04-04 | 44.1       | 33.1       | 0.47 (S)   |  521       | 1067       | 1440       | 1307       |  4335      | \n",
       "| 4          | 2016-04-05 | 2016-04-05 | 42.1       | 26.1       | 0          | 1416       | 2617       | 3081       | 2357       |  9471      | \n",
       "| 5          | 2016-04-06 | 2016-04-06 | 45.0       | 30.0       | 0          | 1885       | 3329       | 3856       | 2849       | 11919      | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  X1 Date       Day        High Temp (°F) Low Temp (°F) Precipitation\n",
       "1 0  2016-04-01 2016-04-01 78.1           66.0          0.01         \n",
       "2 1  2016-04-02 2016-04-02 55.0           48.9          0.15         \n",
       "3 2  2016-04-03 2016-04-03 39.9           34.0          0.09         \n",
       "4 3  2016-04-04 2016-04-04 44.1           33.1          0.47 (S)     \n",
       "5 4  2016-04-05 2016-04-05 42.1           26.1          0            \n",
       "6 5  2016-04-06 2016-04-06 45.0           30.0          0            \n",
       "  Brooklyn Bridge Manhattan Bridge Williamsburg Bridge Queensboro Bridge Total\n",
       "1 1704            3126             4115                2552              11497\n",
       "2  827            1646             2565                1884               6922\n",
       "3  526            1232             1695                1306               4759\n",
       "4  521            1067             1440                1307               4335\n",
       "5 1416            2617             3081                2357               9471\n",
       "6 1885            3329             3856                2849              11919"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "gsub(\" \", \"_\", colnames(bikes))\n",
    "head(bikes)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "I need to make the remove spaces in the column headers"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.098400Z",
     "iopub.status.busy": "2024-02-07T02:02:20.095573Z",
     "iopub.status.idle": "2024-02-07T02:02:20.170707Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "'High.Temp...F.'"
      ],
      "text/latex": [
       "'High.Temp...F.'"
      ],
      "text/markdown": [
       "'High.Temp...F.'"
      ],
      "text/plain": [
       "[1] \"High.Temp...F.\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>X1</th><th scope=col>Date</th><th scope=col>Day</th><th scope=col>High.Temp...F.</th><th scope=col>Low.Temp...F.</th><th scope=col>Precipitation</th><th scope=col>Brooklyn.Bridge</th><th scope=col>Manhattan.Bridge</th><th scope=col>Williamsburg.Bridge</th><th scope=col>Queensboro.Bridge</th><th scope=col>Total</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>0         </td><td>2016-04-01</td><td>2016-04-01</td><td>78.1      </td><td>66.0      </td><td>0.01      </td><td>1704      </td><td>3126      </td><td>4115      </td><td>2552      </td><td>11497     </td></tr>\n",
       "\t<tr><td>1         </td><td>2016-04-02</td><td>2016-04-02</td><td>55.0      </td><td>48.9      </td><td>0.15      </td><td> 827      </td><td>1646      </td><td>2565      </td><td>1884      </td><td> 6922     </td></tr>\n",
       "\t<tr><td>2         </td><td>2016-04-03</td><td>2016-04-03</td><td>39.9      </td><td>34.0      </td><td>0.09      </td><td> 526      </td><td>1232      </td><td>1695      </td><td>1306      </td><td> 4759     </td></tr>\n",
       "\t<tr><td>3         </td><td>2016-04-04</td><td>2016-04-04</td><td>44.1      </td><td>33.1      </td><td>0.47 (S)  </td><td> 521      </td><td>1067      </td><td>1440      </td><td>1307      </td><td> 4335     </td></tr>\n",
       "\t<tr><td>4         </td><td>2016-04-05</td><td>2016-04-05</td><td>42.1      </td><td>26.1      </td><td>0         </td><td>1416      </td><td>2617      </td><td>3081      </td><td>2357      </td><td> 9471     </td></tr>\n",
       "\t<tr><td>5         </td><td>2016-04-06</td><td>2016-04-06</td><td>45.0      </td><td>30.0      </td><td>0         </td><td>1885      </td><td>3329      </td><td>3856      </td><td>2849      </td><td>11919     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|lllllllllll}\n",
       " X1 & Date & Day & High.Temp...F. & Low.Temp...F. & Precipitation & Brooklyn.Bridge & Manhattan.Bridge & Williamsburg.Bridge & Queensboro.Bridge & Total\\\\\n",
       "\\hline\n",
       "\t 0          & 2016-04-01 & 2016-04-01 & 78.1       & 66.0       & 0.01       & 1704       & 3126       & 4115       & 2552       & 11497     \\\\\n",
       "\t 1          & 2016-04-02 & 2016-04-02 & 55.0       & 48.9       & 0.15       &  827       & 1646       & 2565       & 1884       &  6922     \\\\\n",
       "\t 2          & 2016-04-03 & 2016-04-03 & 39.9       & 34.0       & 0.09       &  526       & 1232       & 1695       & 1306       &  4759     \\\\\n",
       "\t 3          & 2016-04-04 & 2016-04-04 & 44.1       & 33.1       & 0.47 (S)   &  521       & 1067       & 1440       & 1307       &  4335     \\\\\n",
       "\t 4          & 2016-04-05 & 2016-04-05 & 42.1       & 26.1       & 0          & 1416       & 2617       & 3081       & 2357       &  9471     \\\\\n",
       "\t 5          & 2016-04-06 & 2016-04-06 & 45.0       & 30.0       & 0          & 1885       & 3329       & 3856       & 2849       & 11919     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "X1 | Date | Day | High.Temp...F. | Low.Temp...F. | Precipitation | Brooklyn.Bridge | Manhattan.Bridge | Williamsburg.Bridge | Queensboro.Bridge | Total | \n",
       "|---|---|---|---|---|---|\n",
       "| 0          | 2016-04-01 | 2016-04-01 | 78.1       | 66.0       | 0.01       | 1704       | 3126       | 4115       | 2552       | 11497      | \n",
       "| 1          | 2016-04-02 | 2016-04-02 | 55.0       | 48.9       | 0.15       |  827       | 1646       | 2565       | 1884       |  6922      | \n",
       "| 2          | 2016-04-03 | 2016-04-03 | 39.9       | 34.0       | 0.09       |  526       | 1232       | 1695       | 1306       |  4759      | \n",
       "| 3          | 2016-04-04 | 2016-04-04 | 44.1       | 33.1       | 0.47 (S)   |  521       | 1067       | 1440       | 1307       |  4335      | \n",
       "| 4          | 2016-04-05 | 2016-04-05 | 42.1       | 26.1       | 0          | 1416       | 2617       | 3081       | 2357       |  9471      | \n",
       "| 5          | 2016-04-06 | 2016-04-06 | 45.0       | 30.0       | 0          | 1885       | 3329       | 3856       | 2849       | 11919      | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  X1 Date       Day        High.Temp...F. Low.Temp...F. Precipitation\n",
       "1 0  2016-04-01 2016-04-01 78.1           66.0          0.01         \n",
       "2 1  2016-04-02 2016-04-02 55.0           48.9          0.15         \n",
       "3 2  2016-04-03 2016-04-03 39.9           34.0          0.09         \n",
       "4 3  2016-04-04 2016-04-04 44.1           33.1          0.47 (S)     \n",
       "5 4  2016-04-05 2016-04-05 42.1           26.1          0            \n",
       "6 5  2016-04-06 2016-04-06 45.0           30.0          0            \n",
       "  Brooklyn.Bridge Manhattan.Bridge Williamsburg.Bridge Queensboro.Bridge Total\n",
       "1 1704            3126             4115                2552              11497\n",
       "2  827            1646             2565                1884               6922\n",
       "3  526            1232             1695                1306               4759\n",
       "4  521            1067             1440                1307               4335\n",
       "5 1416            2617             3081                2357               9471\n",
       "6 1885            3329             3856                2849              11919"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>78.1</li>\n",
       "\t<li>55</li>\n",
       "\t<li>39.9</li>\n",
       "\t<li>44.1</li>\n",
       "\t<li>42.1</li>\n",
       "\t<li>45</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 78.1\n",
       "\\item 55\n",
       "\\item 39.9\n",
       "\\item 44.1\n",
       "\\item 42.1\n",
       "\\item 45\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 78.1\n",
       "2. 55\n",
       "3. 39.9\n",
       "4. 44.1\n",
       "5. 42.1\n",
       "6. 45\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 78.1 55.0 39.9 44.1 42.1 45.0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# remember it's one-indexed\n",
    "make.names(colnames(bikes[4]))\n",
    "colnames(bikes) <- make.names(colnames(bikes))\n",
    "head(bikes)\n",
    "head(bikes$High.Temp...F.)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "double check if numeric (for practice)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.177411Z",
     "iopub.status.busy": "2024-02-07T02:02:20.174572Z",
     "iopub.status.idle": "2024-02-07T02:02:20.197019Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "TRUE"
      ],
      "text/latex": [
       "TRUE"
      ],
      "text/markdown": [
       "TRUE"
      ],
      "text/plain": [
       "[1] TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "is.numeric(bikes$High.Temp...F.)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.203962Z",
     "iopub.status.busy": "2024-02-07T02:02:20.201337Z",
     "iopub.status.idle": "2024-02-07T02:02:20.223037Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "TRUE"
      ],
      "text/latex": [
       "TRUE"
      ],
      "text/markdown": [
       "TRUE"
      ],
      "text/plain": [
       "[1] TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "is.numeric(bikes$Low.Temp...F.)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.229348Z",
     "iopub.status.busy": "2024-02-07T02:02:20.226724Z",
     "iopub.status.idle": "2024-02-07T02:02:20.250028Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "FALSE"
      ],
      "text/latex": [
       "FALSE"
      ],
      "text/markdown": [
       "FALSE"
      ],
      "text/plain": [
       "[1] FALSE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all.equal(bikes$High.Temp...F., as.integer(bikes$High.Temp...F.)) == T"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.256779Z",
     "iopub.status.busy": "2024-02-07T02:02:20.253918Z",
     "iopub.status.idle": "2024-02-07T02:02:20.277263Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "FALSE"
      ],
      "text/latex": [
       "FALSE"
      ],
      "text/markdown": [
       "FALSE"
      ],
      "text/plain": [
       "[1] FALSE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "all.equal(bikes$Low.Temp...F., as.integer(bikes$Low.Temp...F.)) == T"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Let's try using high temp to predict low temp. Both are continuous. Plot them:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.284436Z",
     "iopub.status.busy": "2024-02-07T02:02:20.281714Z",
     "iopub.status.idle": "2024-02-07T02:02:20.669833Z"
    }
   },
   "outputs": [
    {
     "data": {},
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdd2AUZd4H8Gdmtvdkd9NDCgFCkSZNCBAQRbACVpB2lvNE0bPr6Xmeeiqnp8d7\nnuVOARVFz3YH1kMJIHiggIIISkxCS8huypZk+8y8fyyEZdK2Zev385d5sjvz28kw+3XK76F4\nnicAAAAAkPzoeBcAAAAAANGBYAcAAACQIhDsAAAAAFIEgh0AAABAikCwAwAAAEgRCHYAAAAA\nKQLBDgAAACBFINgBAAAApIgkDnbetj0URVEU1d0LtlwzgKKokffvimVVwXO1fExRlEia190L\nNs4qoihq7FN7I1nLz2smUxQ1ec3PIb1r52/PooJwyffmSGpLLnlSkeDj0zStz+9/zrRZj6/d\nFoM233/pn0FR1Mctrr5bRXv93yiKkmkn9d0qgpdiO6HP8eMgheSuHabOv/puw+rlCy8eXFak\nVYgzckvGTTl/yfInvmt0xr7IxMGz9kqd7Jp1v8S7EIDkI4p3AQlkw6jsi78z6cvfbDpwTbxr\n6UIsy5PqC/v3P/29wnPtNbUnKIopLS0OfFmuhOnrShJNTkmpkj75/xI86zh6pPZ/9TX/q/p0\n9Ru/3//xI5Ju/y8j+hJ8d41ciu2E711/SWPur/88Pitw0Of4admcS17+/GdCCEWL9dl5nO3Y\nN1vrvtn639df+PPV9774xmNXxnCfClnf7YQUo37lhZmDr7vk50u/HyjH9xRACPAPBrow4sGP\nqx88/aOr5WO5/kJanFVdXR2/okLmbdsjUY/W9HvQevjRaC3zlW/3z86UdfzIuVvfefae+Q+8\nUv3pHxdtuG7dxf2itaKo64ut0adSYyf0sx95ccG6mtt3/j4wpbGu2jnDxm2otcmzzv79048u\nmXdejkJECN90eM8/n/nTH55//83Hr2qQ5H35+4q41R1XpVe9OeE3+otv3vjTqgviXQtAMkGw\nO230Ey+9ZXFJNefEu5CuJXh56YmWZlx93z98OzYu/LDuiwc+IxffELNVY39IIh/f+CdGNfaJ\ns42Bg2sWnruh1qYpvXz7928OVYlPDVOGotH3rXz3ojHLhi95oeqR875YbjlXJ419zcHo052Q\nopVPXz9w4v8trn2hvkSWHOdlARIBgt1peRdcdnW8a+hBgpeXzs5/aBT5sM7R+AUhwmDXfuyH\n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\nAKAS/w97+PIdmMrN1gAAAABJRU5ErkJggg=="
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(bikes, aes(x = High.Temp...F., y = Low.Temp...F.)) + # draw a \n",
    "    geom_point() + # add points\n",
    "    # looks linear so we're using family = \"gaussian\"\n",
    "    geom_smooth(method = \"glm\", # plot a regression...\n",
    "                method.args = list(family = \"gaussian\")) +\n",
    "    xlab(\"High Temp (ºF)\") + \n",
    "    ylab(\"Low Temp (ºF)\") +\n",
    "    ggtitle(\"Using High Temp to Predict Low Temp (Gaussian)\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:20.672763Z",
     "iopub.status.busy": "2024-02-07T02:02:20.670969Z",
     "iopub.status.idle": "2024-02-07T02:02:21.196898Z"
    }
   },
   "outputs": [],
   "source": [
    "# I'm going to save it\n",
    "highlowtempplot <- ggplot(bikes, aes(x = High.Temp...F., y = Low.Temp...F.)) + # draw a \n",
    "    geom_point() + # add points\n",
    "    # looks linear so we're using family = \"gaussian\"\n",
    "    geom_smooth(method = \"glm\", # plot a regression...\n",
    "                method.args = list(family = \"gaussian\")) +\n",
    "    xlab(\"High Temp (ºF)\") + \n",
    "    ylab(\"Low Temp (ºF)\") +\n",
    "    ggtitle(\"Using High Temp to Predict Low Temp (Gaussian)\")\n",
    "\n",
    "ggsave(\"HighTemppredictLowTemp.png\", # the name of the file where it will be save\n",
    "       plot = highlowtempplot, # what plot to save\n",
    "       height=15, width=17, units=\"cm\") # the size of the plot & units of the size"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Try another regression with the weather dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:02:51.250613Z",
     "iopub.status.busy": "2024-02-07T02:02:51.248806Z",
     "iopub.status.idle": "2024-02-07T02:02:51.320936Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       " Formatted Date       Summary          Precip Type        Temperature (C)  \n",
       " Length:96453       Length:96453       Length:96453       Min.   :-21.822  \n",
       " Class :character   Class :character   Class :character   1st Qu.:  4.689  \n",
       " Mode  :character   Mode  :character   Mode  :character   Median : 12.000  \n",
       "                                                          Mean   : 11.933  \n",
       "                                                          3rd Qu.: 18.839  \n",
       "                                                          Max.   : 39.906  \n",
       " Apparent Temperature (C)    Humidity      Wind Speed (km/h)\n",
       " Min.   :-27.717          Min.   :0.0000   Min.   : 0.000   \n",
       " 1st Qu.:  2.311          1st Qu.:0.6000   1st Qu.: 5.828   \n",
       " Median : 12.000          Median :0.7800   Median : 9.966   \n",
       " Mean   : 10.855          Mean   :0.7349   Mean   :10.811   \n",
       " 3rd Qu.: 18.839          3rd Qu.:0.8900   3rd Qu.:14.136   \n",
       " Max.   : 39.344          Max.   :1.0000   Max.   :63.853   \n",
       " Wind Bearing (degrees) Visibility (km)   Loud Cover Pressure (millibars)\n",
       " Min.   :  0.0          Min.   : 0.00   Min.   :0    Min.   :   0        \n",
       " 1st Qu.:116.0          1st Qu.: 8.34   1st Qu.:0    1st Qu.:1012        \n",
       " Median :180.0          Median :10.05   Median :0    Median :1016        \n",
       " Mean   :187.5          Mean   :10.35   Mean   :0    Mean   :1003        \n",
       " 3rd Qu.:290.0          3rd Qu.:14.81   3rd Qu.:0    3rd Qu.:1021        \n",
       " Max.   :359.0          Max.   :16.10   Max.   :0    Max.   :1046        \n",
       " Daily Summary     \n",
       " Length:96453      \n",
       " Class :character  \n",
       " Mode  :character  \n",
       "                   \n",
       "                   \n",
       "                   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Identify which variables are continuous, categorical and count using the dataset \n",
    "#documentation. (You can also check out a summary of the dataset using summary() \n",
    "#or str())\n",
    "summary(weather)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:03:54.561731Z",
     "iopub.status.busy": "2024-02-07T02:03:54.558909Z",
     "iopub.status.idle": "2024-02-07T02:03:54.605644Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Formatted.Date</th><th scope=col>Summary</th><th scope=col>Precip.Type</th><th scope=col>Temperature..C.</th><th scope=col>Apparent.Temperature..C.</th><th scope=col>Humidity</th><th scope=col>Wind.Speed..km.h.</th><th scope=col>Wind.Bearing..degrees.</th><th scope=col>Visibility..km.</th><th scope=col>Loud.Cover</th><th scope=col>Pressure..millibars.</th><th scope=col>Daily.Summary</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>2006-04-01 00:00:00.000 +0200    </td><td>Partly Cloudy                    </td><td>rain                             </td><td>9.472222                         </td><td>7.388889                         </td><td>0.89                             </td><td>14.1197                          </td><td>251                              </td><td>15.8263                          </td><td>0                                </td><td>1015.13                          </td><td>Partly cloudy throughout the day.</td></tr>\n",
       "\t<tr><td>2006-04-01 01:00:00.000 +0200    </td><td>Partly Cloudy                    </td><td>rain                             </td><td>9.355556                         </td><td>7.227778                         </td><td>0.86                             </td><td>14.2646                          </td><td>259                              </td><td>15.8263                          </td><td>0                                </td><td>1015.63                          </td><td>Partly cloudy throughout the day.</td></tr>\n",
       "\t<tr><td>2006-04-01 02:00:00.000 +0200    </td><td>Mostly Cloudy                    </td><td>rain                             </td><td>9.377778                         </td><td>9.377778                         </td><td>0.89                             </td><td> 3.9284                          </td><td>204                              </td><td>14.9569                          </td><td>0                                </td><td>1015.94                          </td><td>Partly cloudy throughout the day.</td></tr>\n",
       "\t<tr><td>2006-04-01 03:00:00.000 +0200    </td><td>Partly Cloudy                    </td><td>rain                             </td><td>8.288889                         </td><td>5.944444                         </td><td>0.83                             </td><td>14.1036                          </td><td>269                              </td><td>15.8263                          </td><td>0                                </td><td>1016.41                          </td><td>Partly cloudy throughout the day.</td></tr>\n",
       "\t<tr><td>2006-04-01 04:00:00.000 +0200    </td><td>Mostly Cloudy                    </td><td>rain                             </td><td>8.755556                         </td><td>6.977778                         </td><td>0.83                             </td><td>11.0446                          </td><td>259                              </td><td>15.8263                          </td><td>0                                </td><td>1016.51                          </td><td>Partly cloudy throughout the day.</td></tr>\n",
       "\t<tr><td>2006-04-01 05:00:00.000 +0200    </td><td>Partly Cloudy                    </td><td>rain                             </td><td>9.222222                         </td><td>7.111111                         </td><td>0.85                             </td><td>13.9587                          </td><td>258                              </td><td>14.9569                          </td><td>0                                </td><td>1016.66                          </td><td>Partly cloudy throughout the day.</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llllllllllll}\n",
       " Formatted.Date & Summary & Precip.Type & Temperature..C. & Apparent.Temperature..C. & Humidity & Wind.Speed..km.h. & Wind.Bearing..degrees. & Visibility..km. & Loud.Cover & Pressure..millibars. & Daily.Summary\\\\\n",
       "\\hline\n",
       "\t 2006-04-01 00:00:00.000 +0200     & Partly Cloudy                     & rain                              & 9.472222                          & 7.388889                          & 0.89                              & 14.1197                           & 251                               & 15.8263                           & 0                                 & 1015.13                           & Partly cloudy throughout the day.\\\\\n",
       "\t 2006-04-01 01:00:00.000 +0200     & Partly Cloudy                     & rain                              & 9.355556                          & 7.227778                          & 0.86                              & 14.2646                           & 259                               & 15.8263                           & 0                                 & 1015.63                           & Partly cloudy throughout the day.\\\\\n",
       "\t 2006-04-01 02:00:00.000 +0200     & Mostly Cloudy                     & rain                              & 9.377778                          & 9.377778                          & 0.89                              &  3.9284                           & 204                               & 14.9569                           & 0                                 & 1015.94                           & Partly cloudy throughout the day.\\\\\n",
       "\t 2006-04-01 03:00:00.000 +0200     & Partly Cloudy                     & rain                              & 8.288889                          & 5.944444                          & 0.83                              & 14.1036                           & 269                               & 15.8263                           & 0                                 & 1016.41                           & Partly cloudy throughout the day.\\\\\n",
       "\t 2006-04-01 04:00:00.000 +0200     & Mostly Cloudy                     & rain                              & 8.755556                          & 6.977778                          & 0.83                              & 11.0446                           & 259                               & 15.8263                           & 0                                 & 1016.51                           & Partly cloudy throughout the day.\\\\\n",
       "\t 2006-04-01 05:00:00.000 +0200     & Partly Cloudy                     & rain                              & 9.222222                          & 7.111111                          & 0.85                              & 13.9587                           & 258                               & 14.9569                           & 0                                 & 1016.66                           & Partly cloudy throughout the day.\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "Formatted.Date | Summary | Precip.Type | Temperature..C. | Apparent.Temperature..C. | Humidity | Wind.Speed..km.h. | Wind.Bearing..degrees. | Visibility..km. | Loud.Cover | Pressure..millibars. | Daily.Summary | \n",
       "|---|---|---|---|---|---|\n",
       "| 2006-04-01 00:00:00.000 +0200     | Partly Cloudy                     | rain                              | 9.472222                          | 7.388889                          | 0.89                              | 14.1197                           | 251                               | 15.8263                           | 0                                 | 1015.13                           | Partly cloudy throughout the day. | \n",
       "| 2006-04-01 01:00:00.000 +0200     | Partly Cloudy                     | rain                              | 9.355556                          | 7.227778                          | 0.86                              | 14.2646                           | 259                               | 15.8263                           | 0                                 | 1015.63                           | Partly cloudy throughout the day. | \n",
       "| 2006-04-01 02:00:00.000 +0200     | Mostly Cloudy                     | rain                              | 9.377778                          | 9.377778                          | 0.89                              |  3.9284                           | 204                               | 14.9569                           | 0                                 | 1015.94                           | Partly cloudy throughout the day. | \n",
       "| 2006-04-01 03:00:00.000 +0200     | Partly Cloudy                     | rain                              | 8.288889                          | 5.944444                          | 0.83                              | 14.1036                           | 269                               | 15.8263                           | 0                                 | 1016.41                           | Partly cloudy throughout the day. | \n",
       "| 2006-04-01 04:00:00.000 +0200     | Mostly Cloudy                     | rain                              | 8.755556                          | 6.977778                          | 0.83                              | 11.0446                           | 259                               | 15.8263                           | 0                                 | 1016.51                           | Partly cloudy throughout the day. | \n",
       "| 2006-04-01 05:00:00.000 +0200     | Partly Cloudy                     | rain                              | 9.222222                          | 7.111111                          | 0.85                              | 13.9587                           | 258                               | 14.9569                           | 0                                 | 1016.66                           | Partly cloudy throughout the day. | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  Formatted.Date                Summary       Precip.Type Temperature..C.\n",
       "1 2006-04-01 00:00:00.000 +0200 Partly Cloudy rain        9.472222       \n",
       "2 2006-04-01 01:00:00.000 +0200 Partly Cloudy rain        9.355556       \n",
       "3 2006-04-01 02:00:00.000 +0200 Mostly Cloudy rain        9.377778       \n",
       "4 2006-04-01 03:00:00.000 +0200 Partly Cloudy rain        8.288889       \n",
       "5 2006-04-01 04:00:00.000 +0200 Mostly Cloudy rain        8.755556       \n",
       "6 2006-04-01 05:00:00.000 +0200 Partly Cloudy rain        9.222222       \n",
       "  Apparent.Temperature..C. Humidity Wind.Speed..km.h. Wind.Bearing..degrees.\n",
       "1 7.388889                 0.89     14.1197           251                   \n",
       "2 7.227778                 0.86     14.2646           259                   \n",
       "3 9.377778                 0.89      3.9284           204                   \n",
       "4 5.944444                 0.83     14.1036           269                   \n",
       "5 6.977778                 0.83     11.0446           259                   \n",
       "6 7.111111                 0.85     13.9587           258                   \n",
       "  Visibility..km. Loud.Cover Pressure..millibars.\n",
       "1 15.8263         0          1015.13             \n",
       "2 15.8263         0          1015.63             \n",
       "3 14.9569         0          1015.94             \n",
       "4 15.8263         0          1016.41             \n",
       "5 15.8263         0          1016.51             \n",
       "6 14.9569         0          1016.66             \n",
       "  Daily.Summary                    \n",
       "1 Partly cloudy throughout the day.\n",
       "2 Partly cloudy throughout the day.\n",
       "3 Partly cloudy throughout the day.\n",
       "4 Partly cloudy throughout the day.\n",
       "5 Partly cloudy throughout the day.\n",
       "6 Partly cloudy throughout the day."
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# make column headers useable\n",
    "colnames(weather) <- make.names(colnames(weather))\n",
    "head(weather)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:10:00.585600Z",
     "iopub.status.busy": "2024-02-07T02:10:00.583033Z",
     "iopub.status.idle": "2024-02-07T02:10:00.692681Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Formatted.Date</th><th scope=col>Summary</th><th scope=col>Precip.Type</th><th scope=col>Temperature..C.</th><th scope=col>Apparent.Temperature..C.</th><th scope=col>Humidity</th><th scope=col>Wind.Speed..km.h.</th><th scope=col>Wind.Bearing..degrees.</th><th scope=col>Visibility..km.</th><th scope=col>Loud.Cover</th><th scope=col>Pressure..millibars.</th><th scope=col>Daily.Summary</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>2006-12-13 19:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.12222222                  </td><td>-3.705556                    </td><td>1.00                         </td><td>12.3165                      </td><td>205                          </td><td>0.3059                       </td><td>0                            </td><td>1034.92                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-13 20:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.05000000                  </td><td>-4.133333                    </td><td>1.00                         </td><td>13.9426                      </td><td>202                          </td><td>0.3220                       </td><td>0                            </td><td>1035.39                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-13 21:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td> 0.00000000                  </td><td>-4.255556                    </td><td>0.96                         </td><td>14.2646                      </td><td>210                          </td><td>0.3220                       </td><td>0                            </td><td>1035.71                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-13 22:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.05000000                  </td><td>-4.233333                    </td><td>0.96                         </td><td>14.4417                      </td><td>212                          </td><td>0.3059                       </td><td>0                            </td><td>1036.02                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-13 23:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.02222222                  </td><td>-3.561111                    </td><td>1.00                         </td><td>10.9319                      </td><td>219                          </td><td>0.3220                       </td><td>0                            </td><td>1036.18                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-14 00:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.07222222                  </td><td>-3.638889                    </td><td>1.00                         </td><td>11.0285                      </td><td>229                          </td><td>0.3220                       </td><td>0                            </td><td>1036.29                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-14 01:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.89444444                  </td><td>-2.761111                    </td><td>0.97                         </td><td> 5.3613                      </td><td>228                          </td><td>0.1610                       </td><td>0                            </td><td>1036.63                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-14 02:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.43888889                  </td><td>-3.688889                    </td><td>0.96                         </td><td>14.1358                      </td><td>228                          </td><td>0.3220                       </td><td>0                            </td><td>1036.20                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-14 03:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.41111111                  </td><td>-3.727778                    </td><td>0.96                         </td><td>14.1519                      </td><td>210                          </td><td>0.3220                       </td><td>0                            </td><td>1036.39                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-14 04:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.09444444                  </td><td>-4.288889                    </td><td>0.97                         </td><td>13.8460                      </td><td>208                          </td><td>0.3059                       </td><td>0                            </td><td>1036.19                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "\t<tr><td>2006-12-14 05:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.13888889                  </td><td>-4.722222                    </td><td>1.00                         </td><td>15.8424                      </td><td>199                          </td><td>0.6279                       </td><td>0                            </td><td>1036.19                      </td><td>Foggy throughout the day.    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llllllllllll}\n",
       " Formatted.Date & Summary & Precip.Type & Temperature..C. & Apparent.Temperature..C. & Humidity & Wind.Speed..km.h. & Wind.Bearing..degrees. & Visibility..km. & Loud.Cover & Pressure..millibars. & Daily.Summary\\\\\n",
       "\\hline\n",
       "\t 2006-12-13 19:00:00.000 +0100 & Foggy                         & rain                          &  0.12222222                   & -3.705556                     & 1.00                          & 12.3165                       & 205                           & 0.3059                        & 0                             & 1034.92                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-13 20:00:00.000 +0100 & Foggy                         & rain                          &  0.05000000                   & -4.133333                     & 1.00                          & 13.9426                       & 202                           & 0.3220                        & 0                             & 1035.39                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-13 21:00:00.000 +0100 & Foggy                         & snow                          &  0.00000000                   & -4.255556                     & 0.96                          & 14.2646                       & 210                           & 0.3220                        & 0                             & 1035.71                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-13 22:00:00.000 +0100 & Foggy                         & rain                          &  0.05000000                   & -4.233333                     & 0.96                          & 14.4417                       & 212                           & 0.3059                        & 0                             & 1036.02                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-13 23:00:00.000 +0100 & Foggy                         & snow                          & -0.02222222                   & -3.561111                     & 1.00                          & 10.9319                       & 219                           & 0.3220                        & 0                             & 1036.18                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-14 00:00:00.000 +0100 & Foggy                         & snow                          & -0.07222222                   & -3.638889                     & 1.00                          & 11.0285                       & 229                           & 0.3220                        & 0                             & 1036.29                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-14 01:00:00.000 +0100 & Foggy                         & snow                          & -0.89444444                   & -2.761111                     & 0.97                          &  5.3613                       & 228                           & 0.1610                        & 0                             & 1036.63                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-14 02:00:00.000 +0100 & Foggy                         & rain                          &  0.43888889                   & -3.688889                     & 0.96                          & 14.1358                       & 228                           & 0.3220                        & 0                             & 1036.20                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-14 03:00:00.000 +0100 & Foggy                         & rain                          &  0.41111111                   & -3.727778                     & 0.96                          & 14.1519                       & 210                           & 0.3220                        & 0                             & 1036.39                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-14 04:00:00.000 +0100 & Foggy                         & snow                          & -0.09444444                   & -4.288889                     & 0.97                          & 13.8460                       & 208                           & 0.3059                        & 0                             & 1036.19                       & Foggy throughout the day.    \\\\\n",
       "\t 2006-12-14 05:00:00.000 +0100 & Foggy                         & snow                          & -0.13888889                   & -4.722222                     & 1.00                          & 15.8424                       & 199                           & 0.6279                        & 0                             & 1036.19                       & Foggy throughout the day.    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "Formatted.Date | Summary | Precip.Type | Temperature..C. | Apparent.Temperature..C. | Humidity | Wind.Speed..km.h. | Wind.Bearing..degrees. | Visibility..km. | Loud.Cover | Pressure..millibars. | Daily.Summary | \n",
       "|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2006-12-13 19:00:00.000 +0100 | Foggy                         | rain                          |  0.12222222                   | -3.705556                     | 1.00                          | 12.3165                       | 205                           | 0.3059                        | 0                             | 1034.92                       | Foggy throughout the day.     | \n",
       "| 2006-12-13 20:00:00.000 +0100 | Foggy                         | rain                          |  0.05000000                   | -4.133333                     | 1.00                          | 13.9426                       | 202                           | 0.3220                        | 0                             | 1035.39                       | Foggy throughout the day.     | \n",
       "| 2006-12-13 21:00:00.000 +0100 | Foggy                         | snow                          |  0.00000000                   | -4.255556                     | 0.96                          | 14.2646                       | 210                           | 0.3220                        | 0                             | 1035.71                       | Foggy throughout the day.     | \n",
       "| 2006-12-13 22:00:00.000 +0100 | Foggy                         | rain                          |  0.05000000                   | -4.233333                     | 0.96                          | 14.4417                       | 212                           | 0.3059                        | 0                             | 1036.02                       | Foggy throughout the day.     | \n",
       "| 2006-12-13 23:00:00.000 +0100 | Foggy                         | snow                          | -0.02222222                   | -3.561111                     | 1.00                          | 10.9319                       | 219                           | 0.3220                        | 0                             | 1036.18                       | Foggy throughout the day.     | \n",
       "| 2006-12-14 00:00:00.000 +0100 | Foggy                         | snow                          | -0.07222222                   | -3.638889                     | 1.00                          | 11.0285                       | 229                           | 0.3220                        | 0                             | 1036.29                       | Foggy throughout the day.     | \n",
       "| 2006-12-14 01:00:00.000 +0100 | Foggy                         | snow                          | -0.89444444                   | -2.761111                     | 0.97                          |  5.3613                       | 228                           | 0.1610                        | 0                             | 1036.63                       | Foggy throughout the day.     | \n",
       "| 2006-12-14 02:00:00.000 +0100 | Foggy                         | rain                          |  0.43888889                   | -3.688889                     | 0.96                          | 14.1358                       | 228                           | 0.3220                        | 0                             | 1036.20                       | Foggy throughout the day.     | \n",
       "| 2006-12-14 03:00:00.000 +0100 | Foggy                         | rain                          |  0.41111111                   | -3.727778                     | 0.96                          | 14.1519                       | 210                           | 0.3220                        | 0                             | 1036.39                       | Foggy throughout the day.     | \n",
       "| 2006-12-14 04:00:00.000 +0100 | Foggy                         | snow                          | -0.09444444                   | -4.288889                     | 0.97                          | 13.8460                       | 208                           | 0.3059                        | 0                             | 1036.19                       | Foggy throughout the day.     | \n",
       "| 2006-12-14 05:00:00.000 +0100 | Foggy                         | snow                          | -0.13888889                   | -4.722222                     | 1.00                          | 15.8424                       | 199                           | 0.6279                        | 0                             | 1036.19                       | Foggy throughout the day.     | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "   Formatted.Date                Summary Precip.Type Temperature..C.\n",
       "1  2006-12-13 19:00:00.000 +0100 Foggy   rain         0.12222222    \n",
       "2  2006-12-13 20:00:00.000 +0100 Foggy   rain         0.05000000    \n",
       "3  2006-12-13 21:00:00.000 +0100 Foggy   snow         0.00000000    \n",
       "4  2006-12-13 22:00:00.000 +0100 Foggy   rain         0.05000000    \n",
       "5  2006-12-13 23:00:00.000 +0100 Foggy   snow        -0.02222222    \n",
       "6  2006-12-14 00:00:00.000 +0100 Foggy   snow        -0.07222222    \n",
       "7  2006-12-14 01:00:00.000 +0100 Foggy   snow        -0.89444444    \n",
       "8  2006-12-14 02:00:00.000 +0100 Foggy   rain         0.43888889    \n",
       "9  2006-12-14 03:00:00.000 +0100 Foggy   rain         0.41111111    \n",
       "10 2006-12-14 04:00:00.000 +0100 Foggy   snow        -0.09444444    \n",
       "11 2006-12-14 05:00:00.000 +0100 Foggy   snow        -0.13888889    \n",
       "   Apparent.Temperature..C. Humidity Wind.Speed..km.h. Wind.Bearing..degrees.\n",
       "1  -3.705556                1.00     12.3165           205                   \n",
       "2  -4.133333                1.00     13.9426           202                   \n",
       "3  -4.255556                0.96     14.2646           210                   \n",
       "4  -4.233333                0.96     14.4417           212                   \n",
       "5  -3.561111                1.00     10.9319           219                   \n",
       "6  -3.638889                1.00     11.0285           229                   \n",
       "7  -2.761111                0.97      5.3613           228                   \n",
       "8  -3.688889                0.96     14.1358           228                   \n",
       "9  -3.727778                0.96     14.1519           210                   \n",
       "10 -4.288889                0.97     13.8460           208                   \n",
       "11 -4.722222                1.00     15.8424           199                   \n",
       "   Visibility..km. Loud.Cover Pressure..millibars. Daily.Summary            \n",
       "1  0.3059          0          1034.92              Foggy throughout the day.\n",
       "2  0.3220          0          1035.39              Foggy throughout the day.\n",
       "3  0.3220          0          1035.71              Foggy throughout the day.\n",
       "4  0.3059          0          1036.02              Foggy throughout the day.\n",
       "5  0.3220          0          1036.18              Foggy throughout the day.\n",
       "6  0.3220          0          1036.29              Foggy throughout the day.\n",
       "7  0.1610          0          1036.63              Foggy throughout the day.\n",
       "8  0.3220          0          1036.20              Foggy throughout the day.\n",
       "9  0.3220          0          1036.39              Foggy throughout the day.\n",
       "10 0.3059          0          1036.19              Foggy throughout the day.\n",
       "11 0.6279          0          1036.19              Foggy throughout the day."
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Pick a variable to predict and one varaible to use to predict it\n",
    "weather[1580:1590,]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:10:41.236720Z",
     "iopub.status.busy": "2024-02-07T02:10:41.233664Z",
     "iopub.status.idle": "2024-02-07T02:10:41.255583Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>-21.8222222222222</li>\n",
       "\t<li>39.9055555555556</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item -21.8222222222222\n",
       "\\item 39.9055555555556\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. -21.8222222222222\n",
       "2. 39.9055555555556\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] -21.82222  39.90556"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "range(weather$Temperature..C.)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Use ```Temperature..C.``` (continuous) to predict ```Precip.Type``` (categorical)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:13:32.859674Z",
     "iopub.status.busy": "2024-02-07T02:13:32.856989Z",
     "iopub.status.idle": "2024-02-07T02:13:32.884137Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'rain'</li>\n",
       "\t<li>'snow'</li>\n",
       "\t<li>'null'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'rain'\n",
       "\\item 'snow'\n",
       "\\item 'null'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'rain'\n",
       "2. 'snow'\n",
       "3. 'null'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"rain\" \"snow\" \"null\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Plot your two variables\n",
    "unique(weather$Precip.Type) # list possible values of Precip.Type"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:24:19.007111Z",
     "iopub.status.busy": "2024-02-07T02:24:19.003838Z",
     "iopub.status.idle": "2024-02-07T02:24:19.081832Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Name</th><th scope=col>Grade_score</th><th scope=col>Mathematics1_score</th><th scope=col>Science_score</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>George </td><td>4      </td><td>45     </td><td>56     </td></tr>\n",
       "\t<tr><td>Andrea </td><td>6      </td><td>78     </td><td>52     </td></tr>\n",
       "\t<tr><td>Micheal</td><td>2      </td><td>44     </td><td>45     </td></tr>\n",
       "\t<tr><td>Maggie </td><td>9      </td><td>89     </td><td>88     </td></tr>\n",
       "\t<tr><td>Ravi   </td><td>5      </td><td>66     </td><td>33     </td></tr>\n",
       "\t<tr><td>Xien   </td><td>7      </td><td>49     </td><td>90     </td></tr>\n",
       "\t<tr><td>Jalpa  </td><td>8      </td><td>72     </td><td>47     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llll}\n",
       " Name & Grade\\_score & Mathematics1\\_score & Science\\_score\\\\\n",
       "\\hline\n",
       "\t George  & 4       & 45      & 56     \\\\\n",
       "\t Andrea  & 6       & 78      & 52     \\\\\n",
       "\t Micheal & 2       & 44      & 45     \\\\\n",
       "\t Maggie  & 9       & 89      & 88     \\\\\n",
       "\t Ravi    & 5       & 66      & 33     \\\\\n",
       "\t Xien    & 7       & 49      & 90     \\\\\n",
       "\t Jalpa   & 8       & 72      & 47     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "Name | Grade_score | Mathematics1_score | Science_score | \n",
       "|---|---|---|---|---|---|---|\n",
       "| George  | 4       | 45      | 56      | \n",
       "| Andrea  | 6       | 78      | 52      | \n",
       "| Micheal | 2       | 44      | 45      | \n",
       "| Maggie  | 9       | 89      | 88      | \n",
       "| Ravi    | 5       | 66      | 33      | \n",
       "| Xien    | 7       | 49      | 90      | \n",
       "| Jalpa   | 8       | 72      | 47      | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  Name    Grade_score Mathematics1_score Science_score\n",
       "1 George  4           45                 56           \n",
       "2 Andrea  6           78                 52           \n",
       "3 Micheal 2           44                 45           \n",
       "4 Maggie  9           89                 88           \n",
       "5 Ravi    5           66                 33           \n",
       "6 Xien    7           49                 90           \n",
       "7 Jalpa   8           72                 47           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th></th><th scope=col>Name</th><th scope=col>Grade_score</th><th scope=col>Mathematics1_score</th><th scope=col>Science_score</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>3</th><td>Micheal</td><td>2      </td><td>44     </td><td>45     </td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Maggie </td><td>9      </td><td>89     </td><td>88     </td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Ravi   </td><td>5      </td><td>66     </td><td>33     </td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Xien   </td><td>7      </td><td>49     </td><td>90     </td></tr>\n",
       "\t<tr><th scope=row>7</th><td>Jalpa  </td><td>8      </td><td>72     </td><td>47     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llll}\n",
       "  & Name & Grade\\_score & Mathematics1\\_score & Science\\_score\\\\\n",
       "\\hline\n",
       "\t3 & Micheal & 2       & 44      & 45     \\\\\n",
       "\t4 & Maggie  & 9       & 89      & 88     \\\\\n",
       "\t5 & Ravi    & 5       & 66      & 33     \\\\\n",
       "\t6 & Xien    & 7       & 49      & 90     \\\\\n",
       "\t7 & Jalpa   & 8       & 72      & 47     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "| <!--/--> | Name | Grade_score | Mathematics1_score | Science_score | \n",
       "|---|---|---|---|---|\n",
       "| 3 | Micheal | 2       | 44      | 45      | \n",
       "| 4 | Maggie  | 9       | 89      | 88      | \n",
       "| 5 | Ravi    | 5       | 66      | 33      | \n",
       "| 6 | Xien    | 7       | 49      | 90      | \n",
       "| 7 | Jalpa   | 8       | 72      | 47      | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  Name    Grade_score Mathematics1_score Science_score\n",
       "3 Micheal 2           44                 45           \n",
       "4 Maggie  9           89                 88           \n",
       "5 Ravi    5           66                 33           \n",
       "6 Xien    7           49                 90           \n",
       "7 Jalpa   8           72                 47           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# we will probably want to drop null's?\n",
    "#testdf <- weather[-!(weather$Precip.Type == \"null\"),]\n",
    "\n",
    "# I can't figure it out, so I'll first test with this:\n",
    "# https://www.datasciencemadesimple.com/delete-or-drop-rows-in-r-with-conditions-2/\n",
    "\n",
    "# create dataframe\n",
    "df1 <- data.frame(Name = c('George','Andrea', 'Micheal','Maggie','Ravi','Xien','Jalpa'), \n",
    "                 Grade_score=c(4,6,2,9,5,7,8),\n",
    "                 Mathematics1_score=c(45,78,44,89,66,49,72),\n",
    "                 Science_score=c(56,52,45,88,33,90,47))\n",
    "df1\n",
    "\n",
    "testdf <- df1[!(df1$Name==\"George\" | df1$Name==\"Andrea\"),]\n",
    "testdf"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:26:47.778579Z",
     "iopub.status.busy": "2024-02-07T02:26:47.774833Z",
     "iopub.status.idle": "2024-02-07T02:26:47.810349Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Formatted.Date</th><th scope=col>Summary</th><th scope=col>Precip.Type</th><th scope=col>Temperature..C.</th><th scope=col>Apparent.Temperature..C.</th><th scope=col>Humidity</th><th scope=col>Wind.Speed..km.h.</th><th scope=col>Wind.Bearing..degrees.</th><th scope=col>Visibility..km.</th><th scope=col>Loud.Cover</th><th scope=col>Pressure..millibars.</th><th scope=col>Daily.Summary</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>2012-04-11 16:00:00.000 +0200</td><td>Mostly Cloudy                </td><td>null                         </td><td>19.01667                     </td><td>19.01667                     </td><td>0.26                         </td><td>14.8764                      </td><td>163                          </td><td> 9.982                       </td><td>0                            </td><td>1002.40                      </td><td>Mostly cloudy until night.   </td></tr>\n",
       "\t<tr><td>2012-04-11 18:00:00.000 +0200</td><td>Mostly Cloudy                </td><td>null                         </td><td>17.85000                     </td><td>17.85000                     </td><td>0.28                         </td><td>13.7977                      </td><td>169                          </td><td> 9.982                       </td><td>0                            </td><td>1001.79                      </td><td>Mostly cloudy until night.   </td></tr>\n",
       "\t<tr><td>2012-04-11 19:00:00.000 +0200</td><td>Mostly Cloudy                </td><td>null                         </td><td>16.32222                     </td><td>16.32222                     </td><td>0.32                         </td><td>10.8192                      </td><td>151                          </td><td> 9.982                       </td><td>0                            </td><td>1001.60                      </td><td>Mostly cloudy until night.   </td></tr>\n",
       "\t<tr><td>2012-04-11 21:00:00.000 +0200</td><td>Mostly Cloudy                </td><td>null                         </td><td>12.56667                     </td><td>12.56667                     </td><td>0.43                         </td><td> 9.0160                      </td><td>159                          </td><td> 9.982                       </td><td>0                            </td><td>1001.92                      </td><td>Mostly cloudy until night.   </td></tr>\n",
       "\t<tr><td>2012-04-11 22:00:00.000 +0200</td><td>Mostly Cloudy                </td><td>null                         </td><td>12.92778                     </td><td>12.92778                     </td><td>0.47                         </td><td>17.6295                      </td><td>197                          </td><td>16.100                       </td><td>0                            </td><td>1002.20                      </td><td>Mostly cloudy until night.   </td></tr>\n",
       "\t<tr><td>2012-04-12 00:00:00.000 +0200</td><td>Mostly Cloudy                </td><td>null                         </td><td>10.10000                     </td><td>10.10000                     </td><td>0.61                         </td><td>11.3666                      </td><td>180                          </td><td>16.100                       </td><td>0                            </td><td>1002.25                      </td><td>Light rain in the morning.   </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llllllllllll}\n",
       " Formatted.Date & Summary & Precip.Type & Temperature..C. & Apparent.Temperature..C. & Humidity & Wind.Speed..km.h. & Wind.Bearing..degrees. & Visibility..km. & Loud.Cover & Pressure..millibars. & Daily.Summary\\\\\n",
       "\\hline\n",
       "\t 2012-04-11 16:00:00.000 +0200 & Mostly Cloudy                 & null                          & 19.01667                      & 19.01667                      & 0.26                          & 14.8764                       & 163                           &  9.982                        & 0                             & 1002.40                       & Mostly cloudy until night.   \\\\\n",
       "\t 2012-04-11 18:00:00.000 +0200 & Mostly Cloudy                 & null                          & 17.85000                      & 17.85000                      & 0.28                          & 13.7977                       & 169                           &  9.982                        & 0                             & 1001.79                       & Mostly cloudy until night.   \\\\\n",
       "\t 2012-04-11 19:00:00.000 +0200 & Mostly Cloudy                 & null                          & 16.32222                      & 16.32222                      & 0.32                          & 10.8192                       & 151                           &  9.982                        & 0                             & 1001.60                       & Mostly cloudy until night.   \\\\\n",
       "\t 2012-04-11 21:00:00.000 +0200 & Mostly Cloudy                 & null                          & 12.56667                      & 12.56667                      & 0.43                          &  9.0160                       & 159                           &  9.982                        & 0                             & 1001.92                       & Mostly cloudy until night.   \\\\\n",
       "\t 2012-04-11 22:00:00.000 +0200 & Mostly Cloudy                 & null                          & 12.92778                      & 12.92778                      & 0.47                          & 17.6295                       & 197                           & 16.100                        & 0                             & 1002.20                       & Mostly cloudy until night.   \\\\\n",
       "\t 2012-04-12 00:00:00.000 +0200 & Mostly Cloudy                 & null                          & 10.10000                      & 10.10000                      & 0.61                          & 11.3666                       & 180                           & 16.100                        & 0                             & 1002.25                       & Light rain in the morning.   \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "Formatted.Date | Summary | Precip.Type | Temperature..C. | Apparent.Temperature..C. | Humidity | Wind.Speed..km.h. | Wind.Bearing..degrees. | Visibility..km. | Loud.Cover | Pressure..millibars. | Daily.Summary | \n",
       "|---|---|---|---|---|---|\n",
       "| 2012-04-11 16:00:00.000 +0200 | Mostly Cloudy                 | null                          | 19.01667                      | 19.01667                      | 0.26                          | 14.8764                       | 163                           |  9.982                        | 0                             | 1002.40                       | Mostly cloudy until night.    | \n",
       "| 2012-04-11 18:00:00.000 +0200 | Mostly Cloudy                 | null                          | 17.85000                      | 17.85000                      | 0.28                          | 13.7977                       | 169                           |  9.982                        | 0                             | 1001.79                       | Mostly cloudy until night.    | \n",
       "| 2012-04-11 19:00:00.000 +0200 | Mostly Cloudy                 | null                          | 16.32222                      | 16.32222                      | 0.32                          | 10.8192                       | 151                           |  9.982                        | 0                             | 1001.60                       | Mostly cloudy until night.    | \n",
       "| 2012-04-11 21:00:00.000 +0200 | Mostly Cloudy                 | null                          | 12.56667                      | 12.56667                      | 0.43                          |  9.0160                       | 159                           |  9.982                        | 0                             | 1001.92                       | Mostly cloudy until night.    | \n",
       "| 2012-04-11 22:00:00.000 +0200 | Mostly Cloudy                 | null                          | 12.92778                      | 12.92778                      | 0.47                          | 17.6295                       | 197                           | 16.100                        | 0                             | 1002.20                       | Mostly cloudy until night.    | \n",
       "| 2012-04-12 00:00:00.000 +0200 | Mostly Cloudy                 | null                          | 10.10000                      | 10.10000                      | 0.61                          | 11.3666                       | 180                           | 16.100                        | 0                             | 1002.25                       | Light rain in the morning.    | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  Formatted.Date                Summary       Precip.Type Temperature..C.\n",
       "1 2012-04-11 16:00:00.000 +0200 Mostly Cloudy null        19.01667       \n",
       "2 2012-04-11 18:00:00.000 +0200 Mostly Cloudy null        17.85000       \n",
       "3 2012-04-11 19:00:00.000 +0200 Mostly Cloudy null        16.32222       \n",
       "4 2012-04-11 21:00:00.000 +0200 Mostly Cloudy null        12.56667       \n",
       "5 2012-04-11 22:00:00.000 +0200 Mostly Cloudy null        12.92778       \n",
       "6 2012-04-12 00:00:00.000 +0200 Mostly Cloudy null        10.10000       \n",
       "  Apparent.Temperature..C. Humidity Wind.Speed..km.h. Wind.Bearing..degrees.\n",
       "1 19.01667                 0.26     14.8764           163                   \n",
       "2 17.85000                 0.28     13.7977           169                   \n",
       "3 16.32222                 0.32     10.8192           151                   \n",
       "4 12.56667                 0.43      9.0160           159                   \n",
       "5 12.92778                 0.47     17.6295           197                   \n",
       "6 10.10000                 0.61     11.3666           180                   \n",
       "  Visibility..km. Loud.Cover Pressure..millibars. Daily.Summary             \n",
       "1  9.982          0          1002.40              Mostly cloudy until night.\n",
       "2  9.982          0          1001.79              Mostly cloudy until night.\n",
       "3  9.982          0          1001.60              Mostly cloudy until night.\n",
       "4  9.982          0          1001.92              Mostly cloudy until night.\n",
       "5 16.100          0          1002.20              Mostly cloudy until night.\n",
       "6 16.100          0          1002.25              Light rain in the morning."
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# find where null's are so I can test well\n",
    "head(weather[weather$Precip.Type == 'null', ])\n",
    "# not sure if it helps, but this is something"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:27:35.550203Z",
     "iopub.status.busy": "2024-02-07T02:27:35.547996Z",
     "iopub.status.idle": "2024-02-07T02:27:35.588420Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'rain'</li>\n",
       "\t<li>'snow'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'rain'\n",
       "\\item 'snow'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'rain'\n",
       "2. 'snow'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"rain\" \"snow\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# try the removing null's with the actual data\n",
    "testdf <- weather[!(weather$Precip.Type==\"null\"),]\n",
    "unique(testdf$Precip.Type)\n",
    "\n",
    "#YES"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:28:03.617583Z",
     "iopub.status.busy": "2024-02-07T02:28:03.615675Z",
     "iopub.status.idle": "2024-02-07T02:28:03.655814Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<ol class=list-inline>\n",
       "\t<li>'rain'</li>\n",
       "\t<li>'snow'</li>\n",
       "</ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'rain'\n",
       "\\item 'snow'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'rain'\n",
       "2. 'snow'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"rain\" \"snow\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# make it real for the real thing\n",
    "weather <- weather[!(weather$Precip.Type==\"null\"),]\n",
    "unique(weather$Precip.Type)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Data cleaning for ```Precip.Type``` done."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:29:34.544172Z",
     "iopub.status.busy": "2024-02-07T02:29:34.540428Z",
     "iopub.status.idle": "2024-02-07T02:29:34.566649Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "FALSE"
      ],
      "text/latex": [
       "FALSE"
      ],
      "text/markdown": [
       "FALSE"
      ],
      "text/plain": [
       "[1] FALSE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "is.null(weather$Temperature..C.) \n",
    "# YESSS"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:34:03.039526Z",
     "iopub.status.busy": "2024-02-07T02:34:03.036892Z",
     "iopub.status.idle": "2024-02-07T02:34:12.058009Z"
    }
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“glm.fit: algorithm did not converge”Warning message:\n",
      "“Computation failed in `stat_smooth()`:\n",
      "y values must be 0 <= y <= 1”"
     ]
    },
    {
     "data": {},
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABA\nEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsA\nAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ\n7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAA\nFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbAD\nAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAE\nwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAA\nQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7\nAAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABF\nEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAA\nABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGw\nAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQ\nBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4A\nAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEE\nOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwAAAAUQbADAABQBMEOAABAEQQ7AAAA\nRRDsAAAAFEGwAwAAUATBDgAAQBEEOwAAAEUQ7AAAABRBsAMAAFAEwQ4AAEARBDsAAABFEOwA\nAAAUQbADAABQBMEOAABAEQQ7AAAARRDsAAAAFEGwAwAAUATBDgAAQBEEO60lNe8AACAASURB\n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\nC91ma1277rrrmWee+Y2bDR48ePDgwQ2L9dMyhNDIzY3/09LxPnbfU3XF4iWZRWW5X/09lDT/\njJ372DUh/wdtKsKuCZmWTUXYNSFh11Q2Wtj98O5j931kFzT/2pcLABCvr/0yKQAAPyzCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgElmpHgBfMG3atKlT\np+bm5g4YMCDVY/nBq62traysTPUoYjB9+vQpU6ZkZWUNHDgw1WP5wTMtm8rMmTMnT56cmZl5\n0EEHpXosP3i1tbUrV65M9Shi8P7777/55puJROKQQw5J1RgSyWQyVcfmy+67776RI0e2aNHi\n2WefTfVYYLXRo0ePGDGiqKho4sSJqR4LrPboo49ec801eXl5L730UqrHAquNHTv2iiuuyMjI\neP3111M1Bm/FAgBEQtgBAERC2AEARMJn7NJLVVVVZWVlIpEoKipK9VhgNdOSNGRakoaqq6vr\nv4ZSXFycqjEIOwCASHgrFgAgEsIOACASblCcFuqq54+969Zxr8+ct7Rus607HXzc6fv1aFv/\n1Kujb3z4+cmzl2Vu322n484+dfuinNQOlU2QSUg6cJ4knVUtm3rmyZftfNP9Z7RrVr8mVdPS\nFbu08PTlF/xlwoKDTj332isv7Nt+5Z8uO3vcnBUhhPdHX3rNQ6/tccRpQ399QuGsF4b+5qZa\nH4lk4zIJSRPOk6SvZPU9Q66dV1XbsCKF09IVu9SrXfXJHdMW7n7pdT/duVUIoWPnHT/93589\ncOM7+1/ba8Qj07b9+R+O7N8hhLDddhlHnXDdvXNO/8UWhakeMpuMZJVJSDpwniSdTR992YRV\n3UOYtHo5pWdOV+xSr6byw/Zbb31g19I1KxI9i3Nqli6vXDzx06ra/fpvVr82t3mfnoU5UyZ8\nlqpxsgkyCUkTzpOkrWX/99TQRz87/3cnN6xJ7bQUdqmXW7L3yJEjuxesvnq6ct6bd81dvtXA\nztUrpoYQuuZnN2zZpSBr8bQlqRklmySTkDThPEl6qqued+2Qu/v86ne9muc2rEzttBR26eXD\nV8eee9ZVNe33H3LAFnWrVoYQWmav/Tsqy86sWVGZutGxyTEJSUPOk6SPcSOGlHc9efBe7dZd\nmdpp6TN2KbBs9ohjz3yh/nH/Wx741eaFIYSqJR/cdcMfnpmyqM+hZ5x1/E8KMhLLcvNCCItq\n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\npDHqSnOGAAAAAElFTkSuQmCC"
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(weather, aes(x = Temperature..C., y = Precip.Type)) + # draw a \n",
    "    geom_point() + # add points\n",
    "    # looks logistic so we're using family = \"binomial\"\n",
    "    geom_smooth(method = \"glm\", # plot a regression...\n",
    "                method.args = list(family = \"binomial\")) +\n",
    "    xlab(\"Temperature (ºC)\") + \n",
    "    ylab(\"Precipitation Type\") +\n",
    "    ggtitle(\"Using Precipiation (ºC) to Predict Precip. Type, (binomial)\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:42:07.562893Z",
     "iopub.status.busy": "2024-02-07T02:42:07.561118Z",
     "iopub.status.idle": "2024-02-07T02:42:07.594869Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Name</th><th scope=col>Grade_score</th><th scope=col>Mathematics1_score</th><th scope=col>Science_score</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>George </td><td>4      </td><td>45     </td><td>56     </td></tr>\n",
       "\t<tr><td>Andrea </td><td>6      </td><td>78     </td><td>52     </td></tr>\n",
       "\t<tr><td>Micheal</td><td>2      </td><td>44     </td><td>45     </td></tr>\n",
       "\t<tr><td>Maggie </td><td>9      </td><td>89     </td><td>88     </td></tr>\n",
       "\t<tr><td>Ravi   </td><td>5      </td><td>66     </td><td>33     </td></tr>\n",
       "\t<tr><td>Xien   </td><td>7      </td><td>49     </td><td>90     </td></tr>\n",
       "\t<tr><td>Jalpa  </td><td>8      </td><td>72     </td><td>47     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|llll}\n",
       " Name & Grade\\_score & Mathematics1\\_score & Science\\_score\\\\\n",
       "\\hline\n",
       "\t George  & 4       & 45      & 56     \\\\\n",
       "\t Andrea  & 6       & 78      & 52     \\\\\n",
       "\t Micheal & 2       & 44      & 45     \\\\\n",
       "\t Maggie  & 9       & 89      & 88     \\\\\n",
       "\t Ravi    & 5       & 66      & 33     \\\\\n",
       "\t Xien    & 7       & 49      & 90     \\\\\n",
       "\t Jalpa   & 8       & 72      & 47     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "Name | Grade_score | Mathematics1_score | Science_score | \n",
       "|---|---|---|---|---|---|---|\n",
       "| George  | 4       | 45      | 56      | \n",
       "| Andrea  | 6       | 78      | 52      | \n",
       "| Micheal | 2       | 44      | 45      | \n",
       "| Maggie  | 9       | 89      | 88      | \n",
       "| Ravi    | 5       | 66      | 33      | \n",
       "| Xien    | 7       | 49      | 90      | \n",
       "| Jalpa   | 8       | 72      | 47      | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "  Name    Grade_score Mathematics1_score Science_score\n",
       "1 George  4           45                 56           \n",
       "2 Andrea  6           78                 52           \n",
       "3 Micheal 2           44                 45           \n",
       "4 Maggie  9           89                 88           \n",
       "5 Ravi    5           66                 33           \n",
       "6 Xien    7           49                 90           \n",
       "7 Jalpa   8           72                 47           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# bc of this message: y values must be 0 <= y <= 1”\n",
    "# let's make a new column in weather just showing precipitation in terms of 0 (rain)\n",
    "#or 1 (snow)\n",
    "\n",
    "# first with our test dataset\n",
    "df1\n",
    "# use ifelse\n",
    "df1$failmath <- ifelse(df1$Mathematics1_score<50, 1, 0)\n",
    "df1$failscience <- ifelse(df1$Science_score<50, 1, 0)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:44:00.024334Z",
     "iopub.status.busy": "2024-02-07T02:44:00.022207Z",
     "iopub.status.idle": "2024-02-07T02:44:00.106837Z"
    }
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table>\n",
       "<thead><tr><th scope=col>Formatted.Date</th><th scope=col>Summary</th><th scope=col>Precip.Type</th><th scope=col>Temperature..C.</th><th scope=col>Apparent.Temperature..C.</th><th scope=col>Humidity</th><th scope=col>Wind.Speed..km.h.</th><th scope=col>Wind.Bearing..degrees.</th><th scope=col>Visibility..km.</th><th scope=col>Loud.Cover</th><th scope=col>Pressure..millibars.</th><th scope=col>Daily.Summary</th><th scope=col>precip</th></tr></thead>\n",
       "<tbody>\n",
       "\t<tr><td>2006-12-13 19:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.12222222                  </td><td>-3.705556                    </td><td>1.00                         </td><td>12.3165                      </td><td>205                          </td><td>0.3059                       </td><td>0                            </td><td>1034.92                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-13 20:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.05000000                  </td><td>-4.133333                    </td><td>1.00                         </td><td>13.9426                      </td><td>202                          </td><td>0.3220                       </td><td>0                            </td><td>1035.39                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-13 21:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td> 0.00000000                  </td><td>-4.255556                    </td><td>0.96                         </td><td>14.2646                      </td><td>210                          </td><td>0.3220                       </td><td>0                            </td><td>1035.71                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-13 22:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.05000000                  </td><td>-4.233333                    </td><td>0.96                         </td><td>14.4417                      </td><td>212                          </td><td>0.3059                       </td><td>0                            </td><td>1036.02                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-13 23:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.02222222                  </td><td>-3.561111                    </td><td>1.00                         </td><td>10.9319                      </td><td>219                          </td><td>0.3220                       </td><td>0                            </td><td>1036.18                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 00:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.07222222                  </td><td>-3.638889                    </td><td>1.00                         </td><td>11.0285                      </td><td>229                          </td><td>0.3220                       </td><td>0                            </td><td>1036.29                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 01:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.89444444                  </td><td>-2.761111                    </td><td>0.97                         </td><td> 5.3613                      </td><td>228                          </td><td>0.1610                       </td><td>0                            </td><td>1036.63                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 02:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.43888889                  </td><td>-3.688889                    </td><td>0.96                         </td><td>14.1358                      </td><td>228                          </td><td>0.3220                       </td><td>0                            </td><td>1036.20                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-14 03:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.41111111                  </td><td>-3.727778                    </td><td>0.96                         </td><td>14.1519                      </td><td>210                          </td><td>0.3220                       </td><td>0                            </td><td>1036.39                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-14 04:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.09444444                  </td><td>-4.288889                    </td><td>0.97                         </td><td>13.8460                      </td><td>208                          </td><td>0.3059                       </td><td>0                            </td><td>1036.19                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 05:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.13888889                  </td><td>-4.722222                    </td><td>1.00                         </td><td>15.8424                      </td><td>199                          </td><td>0.6279                       </td><td>0                            </td><td>1036.19                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 06:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-1.11111111                  </td><td>-5.888889                    </td><td>1.00                         </td><td>15.6331                      </td><td>219                          </td><td>0.4830                       </td><td>0                            </td><td>1036.11                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 07:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-1.03333333                  </td><td>-5.927778                    </td><td>1.00                         </td><td>16.3898                      </td><td>201                          </td><td>0.3059                       </td><td>0                            </td><td>1036.66                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 08:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-1.11111111                  </td><td>-5.594444                    </td><td>1.00                         </td><td>14.1358                      </td><td>190                          </td><td>0.7889                       </td><td>0                            </td><td>1036.90                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 09:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-1.11111111                  </td><td>-5.244444                    </td><td>1.00                         </td><td>12.5258                      </td><td>199                          </td><td>0.6279                       </td><td>0                            </td><td>1037.10                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 10:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.16111111                  </td><td>-4.144444                    </td><td>0.94                         </td><td>12.7512                      </td><td>189                          </td><td>0.7084                       </td><td>0                            </td><td>1037.50                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 11:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.02222222                  </td><td>-4.261111                    </td><td>1.00                         </td><td>14.1358                      </td><td>190                          </td><td>1.8837                       </td><td>0                            </td><td>1037.68                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 12:00:00.000 +0100</td><td>Foggy                        </td><td>snow                         </td><td>-0.02222222                  </td><td>-3.583333                    </td><td>1.00                         </td><td>11.0285                      </td><td>189                          </td><td>2.9785                       </td><td>0                            </td><td>1037.09                      </td><td>Foggy throughout the day.    </td><td>1                            </td></tr>\n",
       "\t<tr><td>2006-12-14 13:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.96111111                  </td><td>-2.938889                    </td><td>0.93                         </td><td>13.5562                      </td><td>200                          </td><td>2.6082                       </td><td>0                            </td><td>1037.04                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-14 14:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 1.06666667                  </td><td>-2.916667                    </td><td>0.92                         </td><td>14.1036                      </td><td>189                          </td><td>2.5438                       </td><td>0                            </td><td>1036.28                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "\t<tr><td>2006-12-14 15:00:00.000 +0100</td><td>Foggy                        </td><td>rain                         </td><td> 0.05000000                  </td><td>-3.827778                    </td><td>1.00                         </td><td>12.4775                      </td><td>199                          </td><td>2.5438                       </td><td>0                            </td><td>1036.39                      </td><td>Foggy throughout the day.    </td><td>0                            </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "\\begin{tabular}{r|lllllllllllll}\n",
       " Formatted.Date & Summary & Precip.Type & Temperature..C. & Apparent.Temperature..C. & Humidity & Wind.Speed..km.h. & Wind.Bearing..degrees. & Visibility..km. & Loud.Cover & Pressure..millibars. & Daily.Summary & precip\\\\\n",
       "\\hline\n",
       "\t 2006-12-13 19:00:00.000 +0100 & Foggy                         & rain                          &  0.12222222                   & -3.705556                     & 1.00                          & 12.3165                       & 205                           & 0.3059                        & 0                             & 1034.92                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-13 20:00:00.000 +0100 & Foggy                         & rain                          &  0.05000000                   & -4.133333                     & 1.00                          & 13.9426                       & 202                           & 0.3220                        & 0                             & 1035.39                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-13 21:00:00.000 +0100 & Foggy                         & snow                          &  0.00000000                   & -4.255556                     & 0.96                          & 14.2646                       & 210                           & 0.3220                        & 0                             & 1035.71                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-13 22:00:00.000 +0100 & Foggy                         & rain                          &  0.05000000                   & -4.233333                     & 0.96                          & 14.4417                       & 212                           & 0.3059                        & 0                             & 1036.02                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-13 23:00:00.000 +0100 & Foggy                         & snow                          & -0.02222222                   & -3.561111                     & 1.00                          & 10.9319                       & 219                           & 0.3220                        & 0                             & 1036.18                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 00:00:00.000 +0100 & Foggy                         & snow                          & -0.07222222                   & -3.638889                     & 1.00                          & 11.0285                       & 229                           & 0.3220                        & 0                             & 1036.29                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 01:00:00.000 +0100 & Foggy                         & snow                          & -0.89444444                   & -2.761111                     & 0.97                          &  5.3613                       & 228                           & 0.1610                        & 0                             & 1036.63                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 02:00:00.000 +0100 & Foggy                         & rain                          &  0.43888889                   & -3.688889                     & 0.96                          & 14.1358                       & 228                           & 0.3220                        & 0                             & 1036.20                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-14 03:00:00.000 +0100 & Foggy                         & rain                          &  0.41111111                   & -3.727778                     & 0.96                          & 14.1519                       & 210                           & 0.3220                        & 0                             & 1036.39                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-14 04:00:00.000 +0100 & Foggy                         & snow                          & -0.09444444                   & -4.288889                     & 0.97                          & 13.8460                       & 208                           & 0.3059                        & 0                             & 1036.19                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 05:00:00.000 +0100 & Foggy                         & snow                          & -0.13888889                   & -4.722222                     & 1.00                          & 15.8424                       & 199                           & 0.6279                        & 0                             & 1036.19                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 06:00:00.000 +0100 & Foggy                         & snow                          & -1.11111111                   & -5.888889                     & 1.00                          & 15.6331                       & 219                           & 0.4830                        & 0                             & 1036.11                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 07:00:00.000 +0100 & Foggy                         & snow                          & -1.03333333                   & -5.927778                     & 1.00                          & 16.3898                       & 201                           & 0.3059                        & 0                             & 1036.66                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 08:00:00.000 +0100 & Foggy                         & snow                          & -1.11111111                   & -5.594444                     & 1.00                          & 14.1358                       & 190                           & 0.7889                        & 0                             & 1036.90                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 09:00:00.000 +0100 & Foggy                         & snow                          & -1.11111111                   & -5.244444                     & 1.00                          & 12.5258                       & 199                           & 0.6279                        & 0                             & 1037.10                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 10:00:00.000 +0100 & Foggy                         & snow                          & -0.16111111                   & -4.144444                     & 0.94                          & 12.7512                       & 189                           & 0.7084                        & 0                             & 1037.50                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 11:00:00.000 +0100 & Foggy                         & snow                          & -0.02222222                   & -4.261111                     & 1.00                          & 14.1358                       & 190                           & 1.8837                        & 0                             & 1037.68                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 12:00:00.000 +0100 & Foggy                         & snow                          & -0.02222222                   & -3.583333                     & 1.00                          & 11.0285                       & 189                           & 2.9785                        & 0                             & 1037.09                       & Foggy throughout the day.     & 1                            \\\\\n",
       "\t 2006-12-14 13:00:00.000 +0100 & Foggy                         & rain                          &  0.96111111                   & -2.938889                     & 0.93                          & 13.5562                       & 200                           & 2.6082                        & 0                             & 1037.04                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-14 14:00:00.000 +0100 & Foggy                         & rain                          &  1.06666667                   & -2.916667                     & 0.92                          & 14.1036                       & 189                           & 2.5438                        & 0                             & 1036.28                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\t 2006-12-14 15:00:00.000 +0100 & Foggy                         & rain                          &  0.05000000                   & -3.827778                     & 1.00                          & 12.4775                       & 199                           & 2.5438                        & 0                             & 1036.39                       & Foggy throughout the day.     & 0                            \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "Formatted.Date | Summary | Precip.Type | Temperature..C. | Apparent.Temperature..C. | Humidity | Wind.Speed..km.h. | Wind.Bearing..degrees. | Visibility..km. | Loud.Cover | Pressure..millibars. | Daily.Summary | precip | \n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2006-12-13 19:00:00.000 +0100 | Foggy                         | rain                          |  0.12222222                   | -3.705556                     | 1.00                          | 12.3165                       | 205                           | 0.3059                        | 0                             | 1034.92                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-13 20:00:00.000 +0100 | Foggy                         | rain                          |  0.05000000                   | -4.133333                     | 1.00                          | 13.9426                       | 202                           | 0.3220                        | 0                             | 1035.39                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-13 21:00:00.000 +0100 | Foggy                         | snow                          |  0.00000000                   | -4.255556                     | 0.96                          | 14.2646                       | 210                           | 0.3220                        | 0                             | 1035.71                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-13 22:00:00.000 +0100 | Foggy                         | rain                          |  0.05000000                   | -4.233333                     | 0.96                          | 14.4417                       | 212                           | 0.3059                        | 0                             | 1036.02                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-13 23:00:00.000 +0100 | Foggy                         | snow                          | -0.02222222                   | -3.561111                     | 1.00                          | 10.9319                       | 219                           | 0.3220                        | 0                             | 1036.18                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 00:00:00.000 +0100 | Foggy                         | snow                          | -0.07222222                   | -3.638889                     | 1.00                          | 11.0285                       | 229                           | 0.3220                        | 0                             | 1036.29                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 01:00:00.000 +0100 | Foggy                         | snow                          | -0.89444444                   | -2.761111                     | 0.97                          |  5.3613                       | 228                           | 0.1610                        | 0                             | 1036.63                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 02:00:00.000 +0100 | Foggy                         | rain                          |  0.43888889                   | -3.688889                     | 0.96                          | 14.1358                       | 228                           | 0.3220                        | 0                             | 1036.20                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-14 03:00:00.000 +0100 | Foggy                         | rain                          |  0.41111111                   | -3.727778                     | 0.96                          | 14.1519                       | 210                           | 0.3220                        | 0                             | 1036.39                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-14 04:00:00.000 +0100 | Foggy                         | snow                          | -0.09444444                   | -4.288889                     | 0.97                          | 13.8460                       | 208                           | 0.3059                        | 0                             | 1036.19                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 05:00:00.000 +0100 | Foggy                         | snow                          | -0.13888889                   | -4.722222                     | 1.00                          | 15.8424                       | 199                           | 0.6279                        | 0                             | 1036.19                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 06:00:00.000 +0100 | Foggy                         | snow                          | -1.11111111                   | -5.888889                     | 1.00                          | 15.6331                       | 219                           | 0.4830                        | 0                             | 1036.11                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 07:00:00.000 +0100 | Foggy                         | snow                          | -1.03333333                   | -5.927778                     | 1.00                          | 16.3898                       | 201                           | 0.3059                        | 0                             | 1036.66                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 08:00:00.000 +0100 | Foggy                         | snow                          | -1.11111111                   | -5.594444                     | 1.00                          | 14.1358                       | 190                           | 0.7889                        | 0                             | 1036.90                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 09:00:00.000 +0100 | Foggy                         | snow                          | -1.11111111                   | -5.244444                     | 1.00                          | 12.5258                       | 199                           | 0.6279                        | 0                             | 1037.10                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 10:00:00.000 +0100 | Foggy                         | snow                          | -0.16111111                   | -4.144444                     | 0.94                          | 12.7512                       | 189                           | 0.7084                        | 0                             | 1037.50                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 11:00:00.000 +0100 | Foggy                         | snow                          | -0.02222222                   | -4.261111                     | 1.00                          | 14.1358                       | 190                           | 1.8837                        | 0                             | 1037.68                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 12:00:00.000 +0100 | Foggy                         | snow                          | -0.02222222                   | -3.583333                     | 1.00                          | 11.0285                       | 189                           | 2.9785                        | 0                             | 1037.09                       | Foggy throughout the day.     | 1                             | \n",
       "| 2006-12-14 13:00:00.000 +0100 | Foggy                         | rain                          |  0.96111111                   | -2.938889                     | 0.93                          | 13.5562                       | 200                           | 2.6082                        | 0                             | 1037.04                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-14 14:00:00.000 +0100 | Foggy                         | rain                          |  1.06666667                   | -2.916667                     | 0.92                          | 14.1036                       | 189                           | 2.5438                        | 0                             | 1036.28                       | Foggy throughout the day.     | 0                             | \n",
       "| 2006-12-14 15:00:00.000 +0100 | Foggy                         | rain                          |  0.05000000                   | -3.827778                     | 1.00                          | 12.4775                       | 199                           | 2.5438                        | 0                             | 1036.39                       | Foggy throughout the day.     | 0                             | \n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "   Formatted.Date                Summary Precip.Type Temperature..C.\n",
       "1  2006-12-13 19:00:00.000 +0100 Foggy   rain         0.12222222    \n",
       "2  2006-12-13 20:00:00.000 +0100 Foggy   rain         0.05000000    \n",
       "3  2006-12-13 21:00:00.000 +0100 Foggy   snow         0.00000000    \n",
       "4  2006-12-13 22:00:00.000 +0100 Foggy   rain         0.05000000    \n",
       "5  2006-12-13 23:00:00.000 +0100 Foggy   snow        -0.02222222    \n",
       "6  2006-12-14 00:00:00.000 +0100 Foggy   snow        -0.07222222    \n",
       "7  2006-12-14 01:00:00.000 +0100 Foggy   snow        -0.89444444    \n",
       "8  2006-12-14 02:00:00.000 +0100 Foggy   rain         0.43888889    \n",
       "9  2006-12-14 03:00:00.000 +0100 Foggy   rain         0.41111111    \n",
       "10 2006-12-14 04:00:00.000 +0100 Foggy   snow        -0.09444444    \n",
       "11 2006-12-14 05:00:00.000 +0100 Foggy   snow        -0.13888889    \n",
       "12 2006-12-14 06:00:00.000 +0100 Foggy   snow        -1.11111111    \n",
       "13 2006-12-14 07:00:00.000 +0100 Foggy   snow        -1.03333333    \n",
       "14 2006-12-14 08:00:00.000 +0100 Foggy   snow        -1.11111111    \n",
       "15 2006-12-14 09:00:00.000 +0100 Foggy   snow        -1.11111111    \n",
       "16 2006-12-14 10:00:00.000 +0100 Foggy   snow        -0.16111111    \n",
       "17 2006-12-14 11:00:00.000 +0100 Foggy   snow        -0.02222222    \n",
       "18 2006-12-14 12:00:00.000 +0100 Foggy   snow        -0.02222222    \n",
       "19 2006-12-14 13:00:00.000 +0100 Foggy   rain         0.96111111    \n",
       "20 2006-12-14 14:00:00.000 +0100 Foggy   rain         1.06666667    \n",
       "21 2006-12-14 15:00:00.000 +0100 Foggy   rain         0.05000000    \n",
       "   Apparent.Temperature..C. Humidity Wind.Speed..km.h. Wind.Bearing..degrees.\n",
       "1  -3.705556                1.00     12.3165           205                   \n",
       "2  -4.133333                1.00     13.9426           202                   \n",
       "3  -4.255556                0.96     14.2646           210                   \n",
       "4  -4.233333                0.96     14.4417           212                   \n",
       "5  -3.561111                1.00     10.9319           219                   \n",
       "6  -3.638889                1.00     11.0285           229                   \n",
       "7  -2.761111                0.97      5.3613           228                   \n",
       "8  -3.688889                0.96     14.1358           228                   \n",
       "9  -3.727778                0.96     14.1519           210                   \n",
       "10 -4.288889                0.97     13.8460           208                   \n",
       "11 -4.722222                1.00     15.8424           199                   \n",
       "12 -5.888889                1.00     15.6331           219                   \n",
       "13 -5.927778                1.00     16.3898           201                   \n",
       "14 -5.594444                1.00     14.1358           190                   \n",
       "15 -5.244444                1.00     12.5258           199                   \n",
       "16 -4.144444                0.94     12.7512           189                   \n",
       "17 -4.261111                1.00     14.1358           190                   \n",
       "18 -3.583333                1.00     11.0285           189                   \n",
       "19 -2.938889                0.93     13.5562           200                   \n",
       "20 -2.916667                0.92     14.1036           189                   \n",
       "21 -3.827778                1.00     12.4775           199                   \n",
       "   Visibility..km. Loud.Cover Pressure..millibars. Daily.Summary            \n",
       "1  0.3059          0          1034.92              Foggy throughout the day.\n",
       "2  0.3220          0          1035.39              Foggy throughout the day.\n",
       "3  0.3220          0          1035.71              Foggy throughout the day.\n",
       "4  0.3059          0          1036.02              Foggy throughout the day.\n",
       "5  0.3220          0          1036.18              Foggy throughout the day.\n",
       "6  0.3220          0          1036.29              Foggy throughout the day.\n",
       "7  0.1610          0          1036.63              Foggy throughout the day.\n",
       "8  0.3220          0          1036.20              Foggy throughout the day.\n",
       "9  0.3220          0          1036.39              Foggy throughout the day.\n",
       "10 0.3059          0          1036.19              Foggy throughout the day.\n",
       "11 0.6279          0          1036.19              Foggy throughout the day.\n",
       "12 0.4830          0          1036.11              Foggy throughout the day.\n",
       "13 0.3059          0          1036.66              Foggy throughout the day.\n",
       "14 0.7889          0          1036.90              Foggy throughout the day.\n",
       "15 0.6279          0          1037.10              Foggy throughout the day.\n",
       "16 0.7084          0          1037.50              Foggy throughout the day.\n",
       "17 1.8837          0          1037.68              Foggy throughout the day.\n",
       "18 2.9785          0          1037.09              Foggy throughout the day.\n",
       "19 2.6082          0          1037.04              Foggy throughout the day.\n",
       "20 2.5438          0          1036.28              Foggy throughout the day.\n",
       "21 2.5438          0          1036.39              Foggy throughout the day.\n",
       "   precip\n",
       "1  0     \n",
       "2  0     \n",
       "3  1     \n",
       "4  0     \n",
       "5  1     \n",
       "6  1     \n",
       "7  1     \n",
       "8  0     \n",
       "9  0     \n",
       "10 1     \n",
       "11 1     \n",
       "12 1     \n",
       "13 1     \n",
       "14 1     \n",
       "15 1     \n",
       "16 1     \n",
       "17 1     \n",
       "18 1     \n",
       "19 0     \n",
       "20 0     \n",
       "21 0     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# do it with our own\n",
    "weather$precip <- ifelse(weather$Precip.Type == \"rain\", 0, 1)\n",
    "weather[1580:1600,]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:46:17.343710Z",
     "iopub.status.busy": "2024-02-07T02:46:17.341874Z",
     "iopub.status.idle": "2024-02-07T02:46:26.476419Z"
    }
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“glm.fit: algorithm did not converge”Warning message:\n",
      "“glm.fit: fitted probabilities numerically 0 or 1 occurred”"
     ]
    },
    {
     "data": {},
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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"
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# try the graph again, with the new column\n",
    "ggplot(weather, aes(x = Temperature..C., y = precip)) + # draw a \n",
    "    geom_point() + # add points\n",
    "    # looks logistic so we're using family = \"binomial\"\n",
    "    geom_smooth(method = \"glm\", # plot a regression...\n",
    "                method.args = list(family = \"binomial\")) +\n",
    "    xlab(\"Temperature (ºC)\") + \n",
    "    ylab(\"Precipitation Type (0: rain, 1: snow)\") +\n",
    "    ggtitle(\"Using Temperature (ºC) to Predict Precip. Type, (binomial)\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-02-07T02:48:34.880607Z",
     "iopub.status.busy": "2024-02-07T02:48:34.877395Z",
     "iopub.status.idle": "2024-02-07T02:48:43.538110Z"
    }
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“glm.fit: algorithm did not converge”Warning message:\n",
      "“glm.fit: fitted probabilities numerically 0 or 1 occurred”"
     ]
    }
   ],
   "source": [
    "# try to save it\n",
    "tempprecip <- ggplot(weather, aes(x = Temperature..C., y = precip)) + # draw a \n",
    "    geom_point() + # add points\n",
    "    # looks logistic so we're using family = \"binomial\"\n",
    "    geom_smooth(method = \"glm\", # plot a regression...\n",
    "                method.args = list(family = \"binomial\")) +\n",
    "    xlab(\"Temperature (ºC)\") + \n",
    "    ylab(\"Precipitation Type (0: rain, 1: snow)\") +\n",
    "    ggtitle(\"Using Temperature (ºC) to Predict Precip. Type, (binomial)\")\n",
    "\n",
    "ggsave(\"TemperaturePredictPrecip.png\", # the name of the file where it will be save\n",
    "       plot = tempprecip, # what plot to save\n",
    "       height=18, width=17, units=\"cm\") # the size of the plot & units of the size"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "_cell_guid": "a32e821c-ce59-4adc-8ff3-4328afb5636c",
    "_uuid": "953796ad71cb7f0ff93f958530845f2e903541e2"
   },
   "source": [
    "Want more? Ready for a different dataset? [This notebook](https://www.kaggle.com/rtatman/datasets-for-regression-analysis/) has additional dataset suggestions for you to practice regression with. "
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 634,
     "sourceId": 1203,
     "sourceType": "datasetVersion"
    },
    {
     "datasetId": 588,
     "sourceId": 1569,
     "sourceType": "datasetVersion"
    },
    {
     "datasetId": 2358,
     "sourceId": 3966,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 38,
   "isGpuEnabled": false,
   "isInternetEnabled": false,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "3.4.2"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
