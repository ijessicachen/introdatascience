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
     "iopub.execute_input": "2024-01-22T17:24:42.363419Z",
     "iopub.status.busy": "2024-01-22T17:24:42.361971Z",
     "iopub.status.idle": "2024-01-22T17:24:44.449826Z"
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
     "iopub.execute_input": "2024-01-22T17:25:33.710398Z",
     "iopub.status.busy": "2024-01-22T17:25:33.708745Z",
     "iopub.status.idle": "2024-01-22T17:25:33.974676Z"
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
     "iopub.execute_input": "2024-01-22T17:26:55.251952Z",
     "iopub.status.busy": "2024-01-22T17:26:55.250617Z",
     "iopub.status.idle": "2024-01-22T17:26:55.273890Z"
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
     "iopub.execute_input": "2024-01-22T17:27:12.878484Z",
     "iopub.status.busy": "2024-01-22T17:27:12.876824Z",
     "iopub.status.idle": "2024-01-22T17:27:12.894893Z"
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
     "iopub.execute_input": "2024-01-22T17:27:55.958369Z",
     "iopub.status.busy": "2024-01-22T17:27:55.957195Z",
     "iopub.status.idle": "2024-01-22T17:27:57.157394Z"
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
     "iopub.execute_input": "2024-01-22T17:28:46.300594Z",
     "iopub.status.busy": "2024-01-22T17:28:46.299596Z",
     "iopub.status.idle": "2024-01-22T17:28:47.234738Z"
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
    "    method.args = list(family = \"binomial\")) # ...from the binomial family"
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
    "    * since I should probably also practice with pandas, I'll do one dataset like how they did it here, and one with pandas\n",
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
     "iopub.execute_input": "2024-01-22T17:32:42.715170Z",
     "iopub.status.busy": "2024-01-22T17:32:42.713949Z",
     "iopub.status.idle": "2024-01-22T17:32:42.734990Z"
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
   "cell_type": "markdown",
   "metadata": {},
   "source": []
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
