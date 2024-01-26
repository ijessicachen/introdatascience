{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "02e2441c",
   "metadata": {
    "_cell_guid": "0926f356-6bbe-4248-99aa-baa691d220ea",
    "_uuid": "6cb0634fab1b2db27213c739e20544e720063ffe",
    "papermill": {
     "duration": 0.015293,
     "end_time": "2024-01-26T23:33:21.246161",
     "exception": false,
     "start_time": "2024-01-26T23:33:21.230868",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "![](https://www.r-project.org/Rlogo.png)\n",
    "\n",
    "____________________________________________________________________________________\n",
    "This tutorial is the second part of a series. If you've never programmed before, I recommend checking out the \"[First Steps](https://www.kaggle.com/rtatman/getting-started-in-r-first-steps/)\" part of the tutorial.\n",
    "\n",
    "In this part of the tutorial, we'll:\n",
    "\n",
    "* read data into R\n",
    "* look at the data we've read in\n",
    "* remove unwanted rows\n",
    "\n",
    "____________________________________________________________________________________\n",
    "\n",
    "\n",
    "### Learning goals:\n",
    "\n",
    "By the end of this tutorial, you will be able to do the following things. (Don't worry if you don't know what all these things are yet; we'll get there together!)\n",
    "\n",
    "* [Be familiar with basic concepts: functions, variables, data types and vectors](https://www.kaggle.com/rtatman/getting-started-in-r-first-steps/)\n",
    "* [Load data into R](https://www.kaggle.com/rtatman/getting-started-in-r-load-data-into-r)\n",
    "* [Summerize your data](https://www.kaggle.com/rtatman/getting-started-in-r-summarize-data)\n",
    "* [Graph data](https://www.kaggle.com/rtatman/getting-started-in-r-graphing-data/)\n",
    "\n",
    "______\n",
    "\n",
    "### Your turn!\n",
    "\n",
    "Throughout this tutorial, you'll have lots of opportunities to practice what you've just learned. Look for the phrase \"your turn!\" to find these exercises."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8ebec50e",
   "metadata": {
    "_cell_guid": "97e50be4-e6db-4701-a978-ddd3fc24a80e",
    "_uuid": "620ded751819b200ca7461814daa1b4fd1403903",
    "papermill": {
     "duration": 0.013899,
     "end_time": "2024-01-26T23:33:21.274924",
     "exception": false,
     "start_time": "2024-01-26T23:33:21.261025",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Reading data into R\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "41a44bd9",
   "metadata": {
    "_cell_guid": "ef9bb176-bf6c-4d19-a353-84f2a28b282e",
    "_uuid": "5a37bd20dc4a6fa1ad95d14d50fbbb8d91772bee",
    "papermill": {
     "duration": 0.015985,
     "end_time": "2024-01-26T23:33:21.304673",
     "exception": false,
     "start_time": "2024-01-26T23:33:21.288688",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "When you read data into R, you need to tell it two things. The first is what type of data structure the data is in. The second is where to find the data.\n",
    "\n",
    "> Data structure: A specfic way of organizing data to store it. There are lots of different types of data structures that you will learn about, including lists and trees. Vectors, which we talked about in the \"First Steps\" part of the tutorial, are a specific data structure.\n",
    "\n",
    "For this tutorial, we're going to use the data_frame data structure (also called a tibble). If you're curious, you can find more information on these [here](https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html). However, this data structure isn't one that comes with base R. To use this data structure, we're going to need to use  a package."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "cdeb6efc",
   "metadata": {
    "_cell_guid": "14b3f40f-85d5-4ba0-9533-75f65c1e0615",
    "_uuid": "16b25ec029df1bc05f5b3882f9bd92f14a84f970",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:21.339613Z",
     "iopub.status.busy": "2024-01-26T23:33:21.337150Z",
     "iopub.status.idle": "2024-01-26T23:33:22.916682Z",
     "shell.execute_reply": "2024-01-26T23:33:22.913863Z"
    },
    "papermill": {
     "duration": 1.601147,
     "end_time": "2024-01-26T23:33:22.920618",
     "exception": false,
     "start_time": "2024-01-26T23:33:21.319471",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.4     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    }
   ],
   "source": [
    "# this line will read in the \"tidyverse\" package. An R package is a collection\n",
    "# of special functions (and sometimes data). Before you use can use the functions in a\n",
    "# package, though, you need to tell R that you want it to use that package using the\n",
    "# library() function.\n",
    "\n",
    "library(tidyverse)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "95382357",
   "metadata": {
    "_cell_guid": "77acb30b-253b-4ab4-af5b-21c130cda200",
    "_uuid": "8203c7c42d0d3656b96beb45934711102687e7c7",
    "papermill": {
     "duration": 0.015977,
     "end_time": "2024-01-26T23:33:22.952074",
     "exception": false,
     "start_time": "2024-01-26T23:33:22.936097",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Alright, now that we've read in the package we need, we're ready to read in data. We can do this using the read_csv() function (which was in the package we just read in--if you try to use this function without loading the package using library() first, you'll get an error!).\n",
    "\n",
    "Let's read  in our file. This file is a .csv file. \"csv\" stands for \"comma separated values\". You can save any spreadsheet at a .csv file, and that will make it easier to read and analyze later: many file types that you can save spreadsheets as can only be read by one specific program. A .csv can be read by pretty much any program.\n",
    "\n",
    "For this tutorial, we'll be using a dataset of ratings of different chocolate bars. You can learn more about this dataset by clicking on the plus sign (+) next to \"input files\" at the top of the page."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "f6d7ecbb",
   "metadata": {
    "_cell_guid": "6beb2066-bfa5-49ac-8e11-2f3c99df435e",
    "_uuid": "66a7d34d60fcc54bfd8ad7f1826c563ddb08ee4a",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:23.030142Z",
     "iopub.status.busy": "2024-01-26T23:33:22.985062Z",
     "iopub.status.idle": "2024-01-26T23:33:23.613475Z",
     "shell.execute_reply": "2024-01-26T23:33:23.610948Z"
    },
    "papermill": {
     "duration": 0.650944,
     "end_time": "2024-01-26T23:33:23.617002",
     "exception": false,
     "start_time": "2024-01-26T23:33:22.966058",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m1795\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m9\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m (6): Company \n",
      "(Maker-if known), Specific Bean Origin\n",
      "or Bar Name, Cocoa\n",
      "...\n",
      "\u001b[32mdbl\u001b[39m (3): REF, Review\n",
      "Date, Rating\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 1795 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin          </td><td>Agua Grande              </td><td>1876</td><td>2016</td><td>63%</td><td>France </td><td>3.75</td><td>                  </td><td>Sao Tome        </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Kpime                    </td><td>1676</td><td>2015</td><td>70%</td><td>France </td><td>2.75</td><td>                  </td><td>Togo            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Atsane                   </td><td>1676</td><td>2015</td><td>70%</td><td>France </td><td>3.00</td><td>                  </td><td>Togo            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Akata                    </td><td>1680</td><td>2015</td><td>70%</td><td>France </td><td>3.50</td><td>                  </td><td>Togo            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Quilla                   </td><td>1704</td><td>2015</td><td>70%</td><td>France </td><td>3.50</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Carenero                 </td><td>1315</td><td>2014</td><td>70%</td><td>France </td><td>2.75</td><td>Criollo           </td><td>Venezuela       </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Cuba                     </td><td>1315</td><td>2014</td><td>70%</td><td>France </td><td>3.50</td><td>                  </td><td>Cuba            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Sur del Lago             </td><td>1315</td><td>2014</td><td>70%</td><td>France </td><td>3.50</td><td>Criollo           </td><td>Venezuela       </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Puerto Cabello           </td><td>1319</td><td>2014</td><td>70%</td><td>France </td><td>3.75</td><td>Criollo           </td><td>Venezuela       </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Pablino                  </td><td>1319</td><td>2014</td><td>70%</td><td>France </td><td>4.00</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Panama                   </td><td>1011</td><td>2013</td><td>70%</td><td>France </td><td>2.75</td><td>                  </td><td>Panama          </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Madagascar               </td><td>1011</td><td>2013</td><td>70%</td><td>France </td><td>3.00</td><td>Criollo           </td><td>Madagascar      </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Brazil                   </td><td>1011</td><td>2013</td><td>70%</td><td>France </td><td>3.25</td><td>                  </td><td>Brazil          </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Equateur                 </td><td>1011</td><td>2013</td><td>70%</td><td>France </td><td>3.75</td><td>                  </td><td>Ecuador         </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Colombie                 </td><td>1015</td><td>2013</td><td>70%</td><td>France </td><td>2.75</td><td>                  </td><td>Colombia        </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Birmanie                 </td><td>1015</td><td>2013</td><td>70%</td><td>France </td><td>3.00</td><td>                  </td><td>Burma           </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Papua New Guinea         </td><td>1015</td><td>2013</td><td>70%</td><td>France </td><td>3.25</td><td>                  </td><td>Papua New Guinea</td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Chuao                    </td><td>1015</td><td>2013</td><td>70%</td><td>France </td><td>4.00</td><td>Trinitario        </td><td>Venezuela       </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Piura                    </td><td>1019</td><td>2013</td><td>70%</td><td>France </td><td>3.25</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Chanchamayo Province     </td><td>1019</td><td>2013</td><td>70%</td><td>France </td><td>3.50</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Chanchamayo Province     </td><td>1019</td><td>2013</td><td>63%</td><td>France </td><td>4.00</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Bolivia                  </td><td> 797</td><td>2012</td><td>70%</td><td>France </td><td>3.50</td><td>                  </td><td>Bolivia         </td></tr>\n",
       "\t<tr><td>A. Morin          </td><td>Peru                     </td><td> 797</td><td>2012</td><td>63%</td><td>France </td><td>3.75</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>Acalli            </td><td>Chulucanas, El Platanal  </td><td>1462</td><td>2015</td><td>70%</td><td>U.S.A. </td><td>3.75</td><td>                  </td><td>Peru            </td></tr>\n",
       "\t<tr><td>Acalli            </td><td>Tumbes, Norandino        </td><td>1470</td><td>2015</td><td>70%</td><td>U.S.A. </td><td>3.75</td><td>Criollo           </td><td>Peru            </td></tr>\n",
       "\t<tr><td>Adi               </td><td>Vanua Levu               </td><td> 705</td><td>2011</td><td>60%</td><td>Fiji   </td><td>2.75</td><td>Trinitario        </td><td>Fiji            </td></tr>\n",
       "\t<tr><td>Adi               </td><td>Vanua Levu, Toto-A       </td><td> 705</td><td>2011</td><td>80%</td><td>Fiji   </td><td>3.25</td><td>Trinitario        </td><td>Fiji            </td></tr>\n",
       "\t<tr><td>Adi               </td><td>Vanua Levu               </td><td> 705</td><td>2011</td><td>88%</td><td>Fiji   </td><td>3.50</td><td>Trinitario        </td><td>Fiji            </td></tr>\n",
       "\t<tr><td>Adi               </td><td>Vanua Levu, Ami-Ami-CA   </td><td> 705</td><td>2011</td><td>72%</td><td>Fiji   </td><td>3.50</td><td>Trinitario        </td><td>Fiji            </td></tr>\n",
       "\t<tr><td>Aequare (Gianduja)</td><td>Los Rios, Quevedo, Arriba</td><td> 370</td><td>2009</td><td>55%</td><td>Ecuador</td><td>2.75</td><td>Forastero (Arriba)</td><td>Ecuador         </td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>Zak's        </td><td>Belize, Batch 2                   </td><td>1578</td><td>2015</td><td>70%</td><td>U.S.A.   </td><td>3.50</td><td>Trinitario          </td><td>Belize            </td></tr>\n",
       "\t<tr><td>Zak's        </td><td>House Blend, Batch 2              </td><td>1582</td><td>2015</td><td>60%</td><td>U.S.A.   </td><td>3.00</td><td>                    </td><td>                  </td></tr>\n",
       "\t<tr><td>Zart Pralinen</td><td>Millot P., Ambanja                </td><td>1820</td><td>2016</td><td>70%</td><td>Austria  </td><td>3.50</td><td>Criollo, Trinitario </td><td>Madagascar        </td></tr>\n",
       "\t<tr><td>Zart Pralinen</td><td>UNOCACE                           </td><td>1824</td><td>2016</td><td>70%</td><td>Austria  </td><td>2.75</td><td>Nacional (Arriba)   </td><td>Ecuador           </td></tr>\n",
       "\t<tr><td>Zart Pralinen</td><td>San Juan Estate                   </td><td>1824</td><td>2016</td><td>85%</td><td>Austria  </td><td>2.75</td><td>Trinitario          </td><td>Trinidad          </td></tr>\n",
       "\t<tr><td>Zart Pralinen</td><td>Kakao Kamili, Kilombero Valley    </td><td>1824</td><td>2016</td><td>85%</td><td>Austria  </td><td>3.00</td><td>Criollo, Trinitario </td><td>Tanzania          </td></tr>\n",
       "\t<tr><td>Zart Pralinen</td><td>Kakao Kamili, Kilombero Valley    </td><td>1824</td><td>2016</td><td>70%</td><td>Austria  </td><td>3.50</td><td>Criollo, Trinitario </td><td>Tanzania          </td></tr>\n",
       "\t<tr><td>Zart Pralinen</td><td>San Juan Estate, Gran Couva       </td><td>1880</td><td>2016</td><td>78%</td><td>Austria  </td><td>3.50</td><td>Trinitario          </td><td>Trinidad          </td></tr>\n",
       "\t<tr><td>Zokoko       </td><td>Guadalcanal                       </td><td>1716</td><td>2016</td><td>78%</td><td>Australia</td><td>3.75</td><td>                    </td><td>Solomon Islands   </td></tr>\n",
       "\t<tr><td>Zokoko       </td><td>Goddess Blend                     </td><td>1780</td><td>2016</td><td>65%</td><td>Australia</td><td>3.25</td><td>                    </td><td>                  </td></tr>\n",
       "\t<tr><td>Zokoko       </td><td>Alto Beni                         </td><td> 697</td><td>2011</td><td>68%</td><td>Australia</td><td>3.50</td><td>                    </td><td>Bolivia           </td></tr>\n",
       "\t<tr><td>Zokoko       </td><td>Tokiala                           </td><td> 701</td><td>2011</td><td>66%</td><td>Australia</td><td>3.50</td><td>Trinitario          </td><td>Papua New Guinea  </td></tr>\n",
       "\t<tr><td>Zokoko       </td><td>Tranquilidad, Baures              </td><td> 701</td><td>2011</td><td>72%</td><td>Australia</td><td>3.75</td><td>                    </td><td>Bolivia           </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Raw                               </td><td>1205</td><td>2014</td><td>80%</td><td>Austria  </td><td>2.75</td><td>                    </td><td>                  </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Bocas del Toro, Cocabo Co-op      </td><td> 801</td><td>2012</td><td>72%</td><td>Austria  </td><td>3.50</td><td>                    </td><td>Panama            </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Amazonas Frucht                   </td><td> 801</td><td>2012</td><td>65%</td><td>Austria  </td><td>3.50</td><td>                    </td><td>                  </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Satipo Pangoa region, 16hr conche </td><td> 875</td><td>2012</td><td>70%</td><td>Austria  </td><td>3.00</td><td>Criollo (Amarru)    </td><td>Peru              </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Satipo Pangoa region, 20hr conche </td><td> 875</td><td>2012</td><td>70%</td><td>Austria  </td><td>3.50</td><td>Criollo (Amarru)    </td><td>Peru              </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Loma Los Pinos, Yacao region, D.R.</td><td> 875</td><td>2012</td><td>62%</td><td>Austria  </td><td>3.75</td><td>                    </td><td>Dominican Republic</td></tr>\n",
       "\t<tr><td>Zotter       </td><td>El Oro                            </td><td> 879</td><td>2012</td><td>75%</td><td>Austria  </td><td>3.00</td><td>Forastero (Nacional)</td><td>Ecuador           </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Huiwani Coop                      </td><td> 879</td><td>2012</td><td>75%</td><td>Austria  </td><td>3.00</td><td>Criollo, Trinitario </td><td>Papua New Guinea  </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>El Ceibo Coop                     </td><td> 879</td><td>2012</td><td>90%</td><td>Austria  </td><td>3.25</td><td>                    </td><td>Bolivia           </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Santo Domingo                     </td><td> 879</td><td>2012</td><td>70%</td><td>Austria  </td><td>3.75</td><td>                    </td><td>Dominican Republic</td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Kongo, Highlands                  </td><td> 883</td><td>2012</td><td>68%</td><td>Austria  </td><td>3.25</td><td>Forastero           </td><td>Congo             </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Indianer, Raw                     </td><td> 883</td><td>2012</td><td>58%</td><td>Austria  </td><td>3.50</td><td>                    </td><td>                  </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Peru                              </td><td> 647</td><td>2011</td><td>70%</td><td>Austria  </td><td>3.75</td><td>                    </td><td>Peru              </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Congo                             </td><td> 749</td><td>2011</td><td>65%</td><td>Austria  </td><td>3.00</td><td>Forastero           </td><td>Congo             </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Kerala State                      </td><td> 749</td><td>2011</td><td>65%</td><td>Austria  </td><td>3.50</td><td>Forastero           </td><td>India             </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Kerala State                      </td><td> 781</td><td>2011</td><td>62%</td><td>Austria  </td><td>3.25</td><td>                    </td><td>India             </td></tr>\n",
       "\t<tr><td>Zotter       </td><td>Brazil, Mitzi Blue                </td><td> 486</td><td>2010</td><td>65%</td><td>Austria  </td><td>3.00</td><td>                    </td><td>Brazil            </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 1795 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin           & Agua Grande               & 1876 & 2016 & 63\\% & France  & 3.75 &                    & Sao Tome        \\\\\n",
       "\t A. Morin           & Kpime                     & 1676 & 2015 & 70\\% & France  & 2.75 &                    & Togo            \\\\\n",
       "\t A. Morin           & Atsane                    & 1676 & 2015 & 70\\% & France  & 3.00 &                    & Togo            \\\\\n",
       "\t A. Morin           & Akata                     & 1680 & 2015 & 70\\% & France  & 3.50 &                    & Togo            \\\\\n",
       "\t A. Morin           & Quilla                    & 1704 & 2015 & 70\\% & France  & 3.50 &                    & Peru            \\\\\n",
       "\t A. Morin           & Carenero                  & 1315 & 2014 & 70\\% & France  & 2.75 & Criollo            & Venezuela       \\\\\n",
       "\t A. Morin           & Cuba                      & 1315 & 2014 & 70\\% & France  & 3.50 &                    & Cuba            \\\\\n",
       "\t A. Morin           & Sur del Lago              & 1315 & 2014 & 70\\% & France  & 3.50 & Criollo            & Venezuela       \\\\\n",
       "\t A. Morin           & Puerto Cabello            & 1319 & 2014 & 70\\% & France  & 3.75 & Criollo            & Venezuela       \\\\\n",
       "\t A. Morin           & Pablino                   & 1319 & 2014 & 70\\% & France  & 4.00 &                    & Peru            \\\\\n",
       "\t A. Morin           & Panama                    & 1011 & 2013 & 70\\% & France  & 2.75 &                    & Panama          \\\\\n",
       "\t A. Morin           & Madagascar                & 1011 & 2013 & 70\\% & France  & 3.00 & Criollo            & Madagascar      \\\\\n",
       "\t A. Morin           & Brazil                    & 1011 & 2013 & 70\\% & France  & 3.25 &                    & Brazil          \\\\\n",
       "\t A. Morin           & Equateur                  & 1011 & 2013 & 70\\% & France  & 3.75 &                    & Ecuador         \\\\\n",
       "\t A. Morin           & Colombie                  & 1015 & 2013 & 70\\% & France  & 2.75 &                    & Colombia        \\\\\n",
       "\t A. Morin           & Birmanie                  & 1015 & 2013 & 70\\% & France  & 3.00 &                    & Burma           \\\\\n",
       "\t A. Morin           & Papua New Guinea          & 1015 & 2013 & 70\\% & France  & 3.25 &                    & Papua New Guinea\\\\\n",
       "\t A. Morin           & Chuao                     & 1015 & 2013 & 70\\% & France  & 4.00 & Trinitario         & Venezuela       \\\\\n",
       "\t A. Morin           & Piura                     & 1019 & 2013 & 70\\% & France  & 3.25 &                    & Peru            \\\\\n",
       "\t A. Morin           & Chanchamayo Province      & 1019 & 2013 & 70\\% & France  & 3.50 &                    & Peru            \\\\\n",
       "\t A. Morin           & Chanchamayo Province      & 1019 & 2013 & 63\\% & France  & 4.00 &                    & Peru            \\\\\n",
       "\t A. Morin           & Bolivia                   &  797 & 2012 & 70\\% & France  & 3.50 &                    & Bolivia         \\\\\n",
       "\t A. Morin           & Peru                      &  797 & 2012 & 63\\% & France  & 3.75 &                    & Peru            \\\\\n",
       "\t Acalli             & Chulucanas, El Platanal   & 1462 & 2015 & 70\\% & U.S.A.  & 3.75 &                    & Peru            \\\\\n",
       "\t Acalli             & Tumbes, Norandino         & 1470 & 2015 & 70\\% & U.S.A.  & 3.75 & Criollo            & Peru            \\\\\n",
       "\t Adi                & Vanua Levu                &  705 & 2011 & 60\\% & Fiji    & 2.75 & Trinitario         & Fiji            \\\\\n",
       "\t Adi                & Vanua Levu, Toto-A        &  705 & 2011 & 80\\% & Fiji    & 3.25 & Trinitario         & Fiji            \\\\\n",
       "\t Adi                & Vanua Levu                &  705 & 2011 & 88\\% & Fiji    & 3.50 & Trinitario         & Fiji            \\\\\n",
       "\t Adi                & Vanua Levu, Ami-Ami-CA    &  705 & 2011 & 72\\% & Fiji    & 3.50 & Trinitario         & Fiji            \\\\\n",
       "\t Aequare (Gianduja) & Los Rios, Quevedo, Arriba &  370 & 2009 & 55\\% & Ecuador & 2.75 & Forastero (Arriba) & Ecuador         \\\\\n",
       "\t ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t Zak's         & Belize, Batch 2                    & 1578 & 2015 & 70\\% & U.S.A.    & 3.50 & Trinitario           & Belize            \\\\\n",
       "\t Zak's         & House Blend, Batch 2               & 1582 & 2015 & 60\\% & U.S.A.    & 3.00 &                      &                   \\\\\n",
       "\t Zart Pralinen & Millot P., Ambanja                 & 1820 & 2016 & 70\\% & Austria   & 3.50 & Criollo, Trinitario  & Madagascar        \\\\\n",
       "\t Zart Pralinen & UNOCACE                            & 1824 & 2016 & 70\\% & Austria   & 2.75 & Nacional (Arriba)    & Ecuador           \\\\\n",
       "\t Zart Pralinen & San Juan Estate                    & 1824 & 2016 & 85\\% & Austria   & 2.75 & Trinitario           & Trinidad          \\\\\n",
       "\t Zart Pralinen & Kakao Kamili, Kilombero Valley     & 1824 & 2016 & 85\\% & Austria   & 3.00 & Criollo, Trinitario  & Tanzania          \\\\\n",
       "\t Zart Pralinen & Kakao Kamili, Kilombero Valley     & 1824 & 2016 & 70\\% & Austria   & 3.50 & Criollo, Trinitario  & Tanzania          \\\\\n",
       "\t Zart Pralinen & San Juan Estate, Gran Couva        & 1880 & 2016 & 78\\% & Austria   & 3.50 & Trinitario           & Trinidad          \\\\\n",
       "\t Zokoko        & Guadalcanal                        & 1716 & 2016 & 78\\% & Australia & 3.75 &                      & Solomon Islands   \\\\\n",
       "\t Zokoko        & Goddess Blend                      & 1780 & 2016 & 65\\% & Australia & 3.25 &                      &                   \\\\\n",
       "\t Zokoko        & Alto Beni                          &  697 & 2011 & 68\\% & Australia & 3.50 &                      & Bolivia           \\\\\n",
       "\t Zokoko        & Tokiala                            &  701 & 2011 & 66\\% & Australia & 3.50 & Trinitario           & Papua New Guinea  \\\\\n",
       "\t Zokoko        & Tranquilidad, Baures               &  701 & 2011 & 72\\% & Australia & 3.75 &                      & Bolivia           \\\\\n",
       "\t Zotter        & Raw                                & 1205 & 2014 & 80\\% & Austria   & 2.75 &                      &                   \\\\\n",
       "\t Zotter        & Bocas del Toro, Cocabo Co-op       &  801 & 2012 & 72\\% & Austria   & 3.50 &                      & Panama            \\\\\n",
       "\t Zotter        & Amazonas Frucht                    &  801 & 2012 & 65\\% & Austria   & 3.50 &                      &                   \\\\\n",
       "\t Zotter        & Satipo Pangoa region, 16hr conche  &  875 & 2012 & 70\\% & Austria   & 3.00 & Criollo (Amarru)     & Peru              \\\\\n",
       "\t Zotter        & Satipo Pangoa region, 20hr conche  &  875 & 2012 & 70\\% & Austria   & 3.50 & Criollo (Amarru)     & Peru              \\\\\n",
       "\t Zotter        & Loma Los Pinos, Yacao region, D.R. &  875 & 2012 & 62\\% & Austria   & 3.75 &                      & Dominican Republic\\\\\n",
       "\t Zotter        & El Oro                             &  879 & 2012 & 75\\% & Austria   & 3.00 & Forastero (Nacional) & Ecuador           \\\\\n",
       "\t Zotter        & Huiwani Coop                       &  879 & 2012 & 75\\% & Austria   & 3.00 & Criollo, Trinitario  & Papua New Guinea  \\\\\n",
       "\t Zotter        & El Ceibo Coop                      &  879 & 2012 & 90\\% & Austria   & 3.25 &                      & Bolivia           \\\\\n",
       "\t Zotter        & Santo Domingo                      &  879 & 2012 & 70\\% & Austria   & 3.75 &                      & Dominican Republic\\\\\n",
       "\t Zotter        & Kongo, Highlands                   &  883 & 2012 & 68\\% & Austria   & 3.25 & Forastero            & Congo             \\\\\n",
       "\t Zotter        & Indianer, Raw                      &  883 & 2012 & 58\\% & Austria   & 3.50 &                      &                   \\\\\n",
       "\t Zotter        & Peru                               &  647 & 2011 & 70\\% & Austria   & 3.75 &                      & Peru              \\\\\n",
       "\t Zotter        & Congo                              &  749 & 2011 & 65\\% & Austria   & 3.00 & Forastero            & Congo             \\\\\n",
       "\t Zotter        & Kerala State                       &  749 & 2011 & 65\\% & Austria   & 3.50 & Forastero            & India             \\\\\n",
       "\t Zotter        & Kerala State                       &  781 & 2011 & 62\\% & Austria   & 3.25 &                      & India             \\\\\n",
       "\t Zotter        & Brazil, Mitzi Blue                 &  486 & 2010 & 65\\% & Austria   & 3.00 &                      & Brazil            \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 1795 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin           | Agua Grande               | 1876 | 2016 | 63% | France  | 3.75 |                    | Sao Tome         |\n",
       "| A. Morin           | Kpime                     | 1676 | 2015 | 70% | France  | 2.75 |                    | Togo             |\n",
       "| A. Morin           | Atsane                    | 1676 | 2015 | 70% | France  | 3.00 |                    | Togo             |\n",
       "| A. Morin           | Akata                     | 1680 | 2015 | 70% | France  | 3.50 |                    | Togo             |\n",
       "| A. Morin           | Quilla                    | 1704 | 2015 | 70% | France  | 3.50 |                    | Peru             |\n",
       "| A. Morin           | Carenero                  | 1315 | 2014 | 70% | France  | 2.75 | Criollo            | Venezuela        |\n",
       "| A. Morin           | Cuba                      | 1315 | 2014 | 70% | France  | 3.50 |                    | Cuba             |\n",
       "| A. Morin           | Sur del Lago              | 1315 | 2014 | 70% | France  | 3.50 | Criollo            | Venezuela        |\n",
       "| A. Morin           | Puerto Cabello            | 1319 | 2014 | 70% | France  | 3.75 | Criollo            | Venezuela        |\n",
       "| A. Morin           | Pablino                   | 1319 | 2014 | 70% | France  | 4.00 |                    | Peru             |\n",
       "| A. Morin           | Panama                    | 1011 | 2013 | 70% | France  | 2.75 |                    | Panama           |\n",
       "| A. Morin           | Madagascar                | 1011 | 2013 | 70% | France  | 3.00 | Criollo            | Madagascar       |\n",
       "| A. Morin           | Brazil                    | 1011 | 2013 | 70% | France  | 3.25 |                    | Brazil           |\n",
       "| A. Morin           | Equateur                  | 1011 | 2013 | 70% | France  | 3.75 |                    | Ecuador          |\n",
       "| A. Morin           | Colombie                  | 1015 | 2013 | 70% | France  | 2.75 |                    | Colombia         |\n",
       "| A. Morin           | Birmanie                  | 1015 | 2013 | 70% | France  | 3.00 |                    | Burma            |\n",
       "| A. Morin           | Papua New Guinea          | 1015 | 2013 | 70% | France  | 3.25 |                    | Papua New Guinea |\n",
       "| A. Morin           | Chuao                     | 1015 | 2013 | 70% | France  | 4.00 | Trinitario         | Venezuela        |\n",
       "| A. Morin           | Piura                     | 1019 | 2013 | 70% | France  | 3.25 |                    | Peru             |\n",
       "| A. Morin           | Chanchamayo Province      | 1019 | 2013 | 70% | France  | 3.50 |                    | Peru             |\n",
       "| A. Morin           | Chanchamayo Province      | 1019 | 2013 | 63% | France  | 4.00 |                    | Peru             |\n",
       "| A. Morin           | Bolivia                   |  797 | 2012 | 70% | France  | 3.50 |                    | Bolivia          |\n",
       "| A. Morin           | Peru                      |  797 | 2012 | 63% | France  | 3.75 |                    | Peru             |\n",
       "| Acalli             | Chulucanas, El Platanal   | 1462 | 2015 | 70% | U.S.A.  | 3.75 |                    | Peru             |\n",
       "| Acalli             | Tumbes, Norandino         | 1470 | 2015 | 70% | U.S.A.  | 3.75 | Criollo            | Peru             |\n",
       "| Adi                | Vanua Levu                |  705 | 2011 | 60% | Fiji    | 2.75 | Trinitario         | Fiji             |\n",
       "| Adi                | Vanua Levu, Toto-A        |  705 | 2011 | 80% | Fiji    | 3.25 | Trinitario         | Fiji             |\n",
       "| Adi                | Vanua Levu                |  705 | 2011 | 88% | Fiji    | 3.50 | Trinitario         | Fiji             |\n",
       "| Adi                | Vanua Levu, Ami-Ami-CA    |  705 | 2011 | 72% | Fiji    | 3.50 | Trinitario         | Fiji             |\n",
       "| Aequare (Gianduja) | Los Rios, Quevedo, Arriba |  370 | 2009 | 55% | Ecuador | 2.75 | Forastero (Arriba) | Ecuador          |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| Zak's         | Belize, Batch 2                    | 1578 | 2015 | 70% | U.S.A.    | 3.50 | Trinitario           | Belize             |\n",
       "| Zak's         | House Blend, Batch 2               | 1582 | 2015 | 60% | U.S.A.    | 3.00 |                      |                    |\n",
       "| Zart Pralinen | Millot P., Ambanja                 | 1820 | 2016 | 70% | Austria   | 3.50 | Criollo, Trinitario  | Madagascar         |\n",
       "| Zart Pralinen | UNOCACE                            | 1824 | 2016 | 70% | Austria   | 2.75 | Nacional (Arriba)    | Ecuador            |\n",
       "| Zart Pralinen | San Juan Estate                    | 1824 | 2016 | 85% | Austria   | 2.75 | Trinitario           | Trinidad           |\n",
       "| Zart Pralinen | Kakao Kamili, Kilombero Valley     | 1824 | 2016 | 85% | Austria   | 3.00 | Criollo, Trinitario  | Tanzania           |\n",
       "| Zart Pralinen | Kakao Kamili, Kilombero Valley     | 1824 | 2016 | 70% | Austria   | 3.50 | Criollo, Trinitario  | Tanzania           |\n",
       "| Zart Pralinen | San Juan Estate, Gran Couva        | 1880 | 2016 | 78% | Austria   | 3.50 | Trinitario           | Trinidad           |\n",
       "| Zokoko        | Guadalcanal                        | 1716 | 2016 | 78% | Australia | 3.75 |                      | Solomon Islands    |\n",
       "| Zokoko        | Goddess Blend                      | 1780 | 2016 | 65% | Australia | 3.25 |                      |                    |\n",
       "| Zokoko        | Alto Beni                          |  697 | 2011 | 68% | Australia | 3.50 |                      | Bolivia            |\n",
       "| Zokoko        | Tokiala                            |  701 | 2011 | 66% | Australia | 3.50 | Trinitario           | Papua New Guinea   |\n",
       "| Zokoko        | Tranquilidad, Baures               |  701 | 2011 | 72% | Australia | 3.75 |                      | Bolivia            |\n",
       "| Zotter        | Raw                                | 1205 | 2014 | 80% | Austria   | 2.75 |                      |                    |\n",
       "| Zotter        | Bocas del Toro, Cocabo Co-op       |  801 | 2012 | 72% | Austria   | 3.50 |                      | Panama             |\n",
       "| Zotter        | Amazonas Frucht                    |  801 | 2012 | 65% | Austria   | 3.50 |                      |                    |\n",
       "| Zotter        | Satipo Pangoa region, 16hr conche  |  875 | 2012 | 70% | Austria   | 3.00 | Criollo (Amarru)     | Peru               |\n",
       "| Zotter        | Satipo Pangoa region, 20hr conche  |  875 | 2012 | 70% | Austria   | 3.50 | Criollo (Amarru)     | Peru               |\n",
       "| Zotter        | Loma Los Pinos, Yacao region, D.R. |  875 | 2012 | 62% | Austria   | 3.75 |                      | Dominican Republic |\n",
       "| Zotter        | El Oro                             |  879 | 2012 | 75% | Austria   | 3.00 | Forastero (Nacional) | Ecuador            |\n",
       "| Zotter        | Huiwani Coop                       |  879 | 2012 | 75% | Austria   | 3.00 | Criollo, Trinitario  | Papua New Guinea   |\n",
       "| Zotter        | El Ceibo Coop                      |  879 | 2012 | 90% | Austria   | 3.25 |                      | Bolivia            |\n",
       "| Zotter        | Santo Domingo                      |  879 | 2012 | 70% | Austria   | 3.75 |                      | Dominican Republic |\n",
       "| Zotter        | Kongo, Highlands                   |  883 | 2012 | 68% | Austria   | 3.25 | Forastero            | Congo              |\n",
       "| Zotter        | Indianer, Raw                      |  883 | 2012 | 58% | Austria   | 3.50 |                      |                    |\n",
       "| Zotter        | Peru                               |  647 | 2011 | 70% | Austria   | 3.75 |                      | Peru               |\n",
       "| Zotter        | Congo                              |  749 | 2011 | 65% | Austria   | 3.00 | Forastero            | Congo              |\n",
       "| Zotter        | Kerala State                       |  749 | 2011 | 65% | Austria   | 3.50 | Forastero            | India              |\n",
       "| Zotter        | Kerala State                       |  781 | 2011 | 62% | Austria   | 3.25 |                      | India              |\n",
       "| Zotter        | Brazil, Mitzi Blue                 |  486 | 2010 | 65% | Austria   | 3.00 |                      | Brazil             |\n",
       "\n"
      ],
      "text/plain": [
       "     Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name   REF \n",
       "1    A. Morin                  Agua Grande                        1876\n",
       "2    A. Morin                  Kpime                              1676\n",
       "3    A. Morin                  Atsane                             1676\n",
       "4    A. Morin                  Akata                              1680\n",
       "5    A. Morin                  Quilla                             1704\n",
       "6    A. Morin                  Carenero                           1315\n",
       "7    A. Morin                  Cuba                               1315\n",
       "8    A. Morin                  Sur del Lago                       1315\n",
       "9    A. Morin                  Puerto Cabello                     1319\n",
       "10   A. Morin                  Pablino                            1319\n",
       "11   A. Morin                  Panama                             1011\n",
       "12   A. Morin                  Madagascar                         1011\n",
       "13   A. Morin                  Brazil                             1011\n",
       "14   A. Morin                  Equateur                           1011\n",
       "15   A. Morin                  Colombie                           1015\n",
       "16   A. Morin                  Birmanie                           1015\n",
       "17   A. Morin                  Papua New Guinea                   1015\n",
       "18   A. Morin                  Chuao                              1015\n",
       "19   A. Morin                  Piura                              1019\n",
       "20   A. Morin                  Chanchamayo Province               1019\n",
       "21   A. Morin                  Chanchamayo Province               1019\n",
       "22   A. Morin                  Bolivia                             797\n",
       "23   A. Morin                  Peru                                797\n",
       "24   Acalli                    Chulucanas, El Platanal            1462\n",
       "25   Acalli                    Tumbes, Norandino                  1470\n",
       "26   Adi                       Vanua Levu                          705\n",
       "27   Adi                       Vanua Levu, Toto-A                  705\n",
       "28   Adi                       Vanua Levu                          705\n",
       "29   Adi                       Vanua Levu, Ami-Ami-CA              705\n",
       "30   Aequare (Gianduja)        Los Rios, Quevedo, Arriba           370\n",
       "⋮    ⋮                         ⋮                                  ⋮   \n",
       "1766 Zak's                     Belize, Batch 2                    1578\n",
       "1767 Zak's                     House Blend, Batch 2               1582\n",
       "1768 Zart Pralinen             Millot P., Ambanja                 1820\n",
       "1769 Zart Pralinen             UNOCACE                            1824\n",
       "1770 Zart Pralinen             San Juan Estate                    1824\n",
       "1771 Zart Pralinen             Kakao Kamili, Kilombero Valley     1824\n",
       "1772 Zart Pralinen             Kakao Kamili, Kilombero Valley     1824\n",
       "1773 Zart Pralinen             San Juan Estate, Gran Couva        1880\n",
       "1774 Zokoko                    Guadalcanal                        1716\n",
       "1775 Zokoko                    Goddess Blend                      1780\n",
       "1776 Zokoko                    Alto Beni                           697\n",
       "1777 Zokoko                    Tokiala                             701\n",
       "1778 Zokoko                    Tranquilidad, Baures                701\n",
       "1779 Zotter                    Raw                                1205\n",
       "1780 Zotter                    Bocas del Toro, Cocabo Co-op        801\n",
       "1781 Zotter                    Amazonas Frucht                     801\n",
       "1782 Zotter                    Satipo Pangoa region, 16hr conche   875\n",
       "1783 Zotter                    Satipo Pangoa region, 20hr conche   875\n",
       "1784 Zotter                    Loma Los Pinos, Yacao region, D.R.  875\n",
       "1785 Zotter                    El Oro                              879\n",
       "1786 Zotter                    Huiwani Coop                        879\n",
       "1787 Zotter                    El Ceibo Coop                       879\n",
       "1788 Zotter                    Santo Domingo                       879\n",
       "1789 Zotter                    Kongo, Highlands                    883\n",
       "1790 Zotter                    Indianer, Raw                       883\n",
       "1791 Zotter                    Peru                                647\n",
       "1792 Zotter                    Congo                               749\n",
       "1793 Zotter                    Kerala State                        749\n",
       "1794 Zotter                    Kerala State                        781\n",
       "1795 Zotter                    Brazil, Mitzi Blue                  486\n",
       "     Review.Date Cocoa.Percent Company.Location Rating Bean.Type           \n",
       "1    2016        63%           France           3.75                       \n",
       "2    2015        70%           France           2.75                       \n",
       "3    2015        70%           France           3.00                       \n",
       "4    2015        70%           France           3.50                       \n",
       "5    2015        70%           France           3.50                       \n",
       "6    2014        70%           France           2.75   Criollo             \n",
       "7    2014        70%           France           3.50                       \n",
       "8    2014        70%           France           3.50   Criollo             \n",
       "9    2014        70%           France           3.75   Criollo             \n",
       "10   2014        70%           France           4.00                       \n",
       "11   2013        70%           France           2.75                       \n",
       "12   2013        70%           France           3.00   Criollo             \n",
       "13   2013        70%           France           3.25                       \n",
       "14   2013        70%           France           3.75                       \n",
       "15   2013        70%           France           2.75                       \n",
       "16   2013        70%           France           3.00                       \n",
       "17   2013        70%           France           3.25                       \n",
       "18   2013        70%           France           4.00   Trinitario          \n",
       "19   2013        70%           France           3.25                       \n",
       "20   2013        70%           France           3.50                       \n",
       "21   2013        63%           France           4.00                       \n",
       "22   2012        70%           France           3.50                       \n",
       "23   2012        63%           France           3.75                       \n",
       "24   2015        70%           U.S.A.           3.75                       \n",
       "25   2015        70%           U.S.A.           3.75   Criollo             \n",
       "26   2011        60%           Fiji             2.75   Trinitario          \n",
       "27   2011        80%           Fiji             3.25   Trinitario          \n",
       "28   2011        88%           Fiji             3.50   Trinitario          \n",
       "29   2011        72%           Fiji             3.50   Trinitario          \n",
       "30   2009        55%           Ecuador          2.75   Forastero (Arriba)  \n",
       "⋮    ⋮           ⋮             ⋮                ⋮      ⋮                   \n",
       "1766 2015        70%           U.S.A.           3.50   Trinitario          \n",
       "1767 2015        60%           U.S.A.           3.00                       \n",
       "1768 2016        70%           Austria          3.50   Criollo, Trinitario \n",
       "1769 2016        70%           Austria          2.75   Nacional (Arriba)   \n",
       "1770 2016        85%           Austria          2.75   Trinitario          \n",
       "1771 2016        85%           Austria          3.00   Criollo, Trinitario \n",
       "1772 2016        70%           Austria          3.50   Criollo, Trinitario \n",
       "1773 2016        78%           Austria          3.50   Trinitario          \n",
       "1774 2016        78%           Australia        3.75                       \n",
       "1775 2016        65%           Australia        3.25                       \n",
       "1776 2011        68%           Australia        3.50                       \n",
       "1777 2011        66%           Australia        3.50   Trinitario          \n",
       "1778 2011        72%           Australia        3.75                       \n",
       "1779 2014        80%           Austria          2.75                       \n",
       "1780 2012        72%           Austria          3.50                       \n",
       "1781 2012        65%           Austria          3.50                       \n",
       "1782 2012        70%           Austria          3.00   Criollo (Amarru)    \n",
       "1783 2012        70%           Austria          3.50   Criollo (Amarru)    \n",
       "1784 2012        62%           Austria          3.75                       \n",
       "1785 2012        75%           Austria          3.00   Forastero (Nacional)\n",
       "1786 2012        75%           Austria          3.00   Criollo, Trinitario \n",
       "1787 2012        90%           Austria          3.25                       \n",
       "1788 2012        70%           Austria          3.75                       \n",
       "1789 2012        68%           Austria          3.25   Forastero           \n",
       "1790 2012        58%           Austria          3.50                       \n",
       "1791 2011        70%           Austria          3.75                       \n",
       "1792 2011        65%           Austria          3.00   Forastero           \n",
       "1793 2011        65%           Austria          3.50   Forastero           \n",
       "1794 2011        62%           Austria          3.25                       \n",
       "1795 2010        65%           Austria          3.00                       \n",
       "     Broad.Bean.Origin \n",
       "1    Sao Tome          \n",
       "2    Togo              \n",
       "3    Togo              \n",
       "4    Togo              \n",
       "5    Peru              \n",
       "6    Venezuela         \n",
       "7    Cuba              \n",
       "8    Venezuela         \n",
       "9    Venezuela         \n",
       "10   Peru              \n",
       "11   Panama            \n",
       "12   Madagascar        \n",
       "13   Brazil            \n",
       "14   Ecuador           \n",
       "15   Colombia          \n",
       "16   Burma             \n",
       "17   Papua New Guinea  \n",
       "18   Venezuela         \n",
       "19   Peru              \n",
       "20   Peru              \n",
       "21   Peru              \n",
       "22   Bolivia           \n",
       "23   Peru              \n",
       "24   Peru              \n",
       "25   Peru              \n",
       "26   Fiji              \n",
       "27   Fiji              \n",
       "28   Fiji              \n",
       "29   Fiji              \n",
       "30   Ecuador           \n",
       "⋮    ⋮                 \n",
       "1766 Belize            \n",
       "1767                   \n",
       "1768 Madagascar        \n",
       "1769 Ecuador           \n",
       "1770 Trinidad          \n",
       "1771 Tanzania          \n",
       "1772 Tanzania          \n",
       "1773 Trinidad          \n",
       "1774 Solomon Islands   \n",
       "1775                   \n",
       "1776 Bolivia           \n",
       "1777 Papua New Guinea  \n",
       "1778 Bolivia           \n",
       "1779                   \n",
       "1780 Panama            \n",
       "1781                   \n",
       "1782 Peru              \n",
       "1783 Peru              \n",
       "1784 Dominican Republic\n",
       "1785 Ecuador           \n",
       "1786 Papua New Guinea  \n",
       "1787 Bolivia           \n",
       "1788 Dominican Republic\n",
       "1789 Congo             \n",
       "1790                   \n",
       "1791 Peru              \n",
       "1792 Congo             \n",
       "1793 India             \n",
       "1794 India             \n",
       "1795 Brazil            "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Read our data into R. The argument here is a file path. The \"..\" means \"look at the \n",
    "# folder above this one\", \"input\" is a specific folder, \"chocolate-bar-ratings\" is\n",
    "# a folder wihtin the \"input\" folder, and and \"flavors_of_cacao.csv\" is \n",
    "# the specific file we're reading from inside that file.\n",
    "\n",
    "chocolateData <- read_csv(\"../input/chocolate-bar-ratings/flavors_of_cacao.csv\")\n",
    "\n",
    "# some of our column names have spaces in them. This line changes the column names to \n",
    "# versions without spaces, which let's us talk about the columns by their names.\n",
    "names(chocolateData) <- make.names(names(chocolateData), unique=TRUE)\n",
    "\n",
    "chocolateData"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "2b1537de",
   "metadata": {
    "_cell_guid": "dca5cba4-5cdd-47bb-adce-3c0c8f6edfad",
    "_uuid": "54aca9c4d0a06f234af0d1e27181505474a323d3",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:23.657184Z",
     "iopub.status.busy": "2024-01-26T23:33:23.654397Z",
     "iopub.status.idle": "2024-01-26T23:33:24.209598Z",
     "shell.execute_reply": "2024-01-26T23:33:24.207069Z"
    },
    "papermill": {
     "duration": 0.577995,
     "end_time": "2024-01-26T23:33:24.213320",
     "exception": false,
     "start_time": "2024-01-26T23:33:23.635325",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22mNew names:\n",
      "\u001b[36m•\u001b[39m `comfort_food_reasons_coded` -> `comfort_food_reasons_coded...10`\n",
      "\u001b[36m•\u001b[39m `comfort_food_reasons_coded` -> `comfort_food_reasons_coded...12`\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m125\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m61\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m (14): GPA, comfort_food, comfort_food_reasons, diet_current, eating_chan...\n",
      "\u001b[32mdbl\u001b[39m (47): Gender, breakfast, calories_chicken, calories_day, calories_scone,...\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 125 × 61</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>GPA</th><th scope=col>Gender</th><th scope=col>breakfast</th><th scope=col>calories_chicken</th><th scope=col>calories_day</th><th scope=col>calories_scone</th><th scope=col>coffee</th><th scope=col>comfort_food</th><th scope=col>comfort_food_reasons</th><th scope=col>comfort_food_reasons_coded...10</th><th scope=col>⋯</th><th scope=col>soup</th><th scope=col>sports</th><th scope=col>thai_food</th><th scope=col>tortilla_calories</th><th scope=col>turkey_calories</th><th scope=col>type_sports</th><th scope=col>veggies_day</th><th scope=col>vitamins</th><th scope=col>waffle_calories</th><th scope=col>weight</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2.4  </td><td>2</td><td>1</td><td>430</td><td>NaN</td><td>315</td><td>1</td><td>none                                                    </td><td>we dont have comfort                                                                                                             </td><td>9</td><td>⋯</td><td>1</td><td>  1</td><td>1</td><td>1165</td><td>345</td><td>car racing           </td><td>5</td><td>1</td><td>1315</td><td>187                    </td></tr>\n",
       "\t<tr><td>3.654</td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>chocolate, chips, ice cream                             </td><td>Stress, bored, anger                                                                                                             </td><td>1</td><td>⋯</td><td>1</td><td>  1</td><td>2</td><td> 725</td><td>690</td><td>Basketball           </td><td>4</td><td>2</td><td> 900</td><td>155                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>720</td><td>  4</td><td>420</td><td>2</td><td>frozen yogurt, pizza, fast food                         </td><td>stress, sadness                                                                                                                  </td><td>1</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td>1165</td><td>500</td><td>none                 </td><td>5</td><td>1</td><td> 900</td><td>I'm not answering this.</td></tr>\n",
       "\t<tr><td>3.2  </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>2</td><td>Pizza, Mac and cheese, ice cream                        </td><td>Boredom                                                                                                                          </td><td>2</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td> 725</td><td>690</td><td>nan                  </td><td>3</td><td>1</td><td>1315</td><td>Not sure, 240          </td></tr>\n",
       "\t<tr><td>3.5  </td><td>1</td><td>1</td><td>720</td><td>  2</td><td>420</td><td>2</td><td>Ice cream, chocolate, chips                             </td><td>Stress, boredom, cravings                                                                                                        </td><td>1</td><td>⋯</td><td>1</td><td>  1</td><td>4</td><td> 940</td><td>500</td><td>Softball             </td><td>4</td><td>2</td><td> 760</td><td>190                    </td></tr>\n",
       "\t<tr><td>2.25 </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>980</td><td>2</td><td>Candy, brownies and soda.                               </td><td>None, i don't eat comfort food. I just eat when i'm hungry.                                                                      </td><td>4</td><td>⋯</td><td>1</td><td>  2</td><td>4</td><td> 940</td><td>345</td><td>None.                </td><td>1</td><td>2</td><td>1315</td><td>190                    </td></tr>\n",
       "\t<tr><td>3.8  </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>Chocolate, ice cream, french fries, pretzels            </td><td>stress, boredom                                                                                                                  </td><td>1</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td> 940</td><td>690</td><td>soccer               </td><td>4</td><td>1</td><td>1315</td><td>180                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>720</td><td>  3</td><td>420</td><td>1</td><td>Ice cream, cheeseburgers, chips.                        </td><td>I eat comfort food when im stressed out from school(finals week), when I`m sad, or when i am dealing with personal family issues.</td><td>1</td><td>⋯</td><td>1</td><td>  2</td><td>1</td><td> 725</td><td>500</td><td>none                 </td><td>4</td><td>2</td><td>1315</td><td>137                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>430</td><td>NaN</td><td>420</td><td>1</td><td>Donuts, ice cream, chips                                </td><td>Boredom                                                                                                                          </td><td>2</td><td>⋯</td><td>2</td><td>  2</td><td>5</td><td> 725</td><td>345</td><td>none                 </td><td>3</td><td>2</td><td> 760</td><td>180                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>315</td><td>2</td><td>Mac and cheese, chocolate, and pasta                    </td><td>Stress, anger and sadness                                                                                                        </td><td>1</td><td>⋯</td><td>1</td><td>  1</td><td>4</td><td> 580</td><td>345</td><td>field hockey         </td><td>5</td><td>1</td><td> 900</td><td>125                    </td></tr>\n",
       "\t<tr><td>3.5  </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>980</td><td>2</td><td>Pasta, grandma homemade chocolate cake anything homemade</td><td>Boredom                                                                                                                          </td><td>2</td><td>⋯</td><td>1</td><td>  1</td><td>2</td><td> 940</td><td>345</td><td>soccer               </td><td>5</td><td>2</td><td> 900</td><td>116                    </td></tr>\n",
       "\t<tr><td>3.904</td><td>1</td><td>1</td><td>720</td><td>  4</td><td>420</td><td>2</td><td>chocolate, pasta, soup, chips, popcorn                  </td><td>sadness, stress, cold weather                                                                                                    </td><td>3</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td> 940</td><td>500</td><td>Running              </td><td>5</td><td>1</td><td> 900</td><td>110                    </td></tr>\n",
       "\t<tr><td>3.4  </td><td>2</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>2</td><td>Cookies, popcorn, and chips                             </td><td>Sadness, boredom, late night snack                                                                                               </td><td>3</td><td>⋯</td><td>2</td><td>  1</td><td>3</td><td> 940</td><td>500</td><td>Soccer and basketball</td><td>3</td><td>2</td><td> 575</td><td>264                    </td></tr>\n",
       "\t<tr><td>3.6  </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>ice cream, cake, chocolate                              </td><td>stress,  boredom, special occasions                                                                                              </td><td>1</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td>1165</td><td>850</td><td>intramural volleyball</td><td>5</td><td>2</td><td>1315</td><td>123                    </td></tr>\n",
       "\t<tr><td>3.1  </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>Pizza, fruit, spaghetti, chicken and Potatoes           </td><td>Friends, environment and boredom                                                                                                 </td><td>2</td><td>⋯</td><td>1</td><td>  1</td><td>4</td><td> 940</td><td>500</td><td>Hockey               </td><td>5</td><td>1</td><td> 900</td><td>185                    </td></tr>\n",
       "\t<tr><td>nan  </td><td>2</td><td>2</td><td>430</td><td>NaN</td><td>980</td><td>2</td><td>cookies, donuts, candy bars                             </td><td>boredom                                                                                                                          </td><td>2</td><td>⋯</td><td>2</td><td>  1</td><td>1</td><td> 940</td><td>345</td><td>Hockey               </td><td>1</td><td>2</td><td>1315</td><td>180                    </td></tr>\n",
       "\t<tr><td>4    </td><td>1</td><td>1</td><td>265</td><td>  3</td><td>420</td><td>1</td><td>Saltfish, Candy and Kit Kat                             </td><td>Stress                                                                                                                           </td><td>1</td><td>⋯</td><td>1</td><td>  2</td><td>1</td><td> 580</td><td>345</td><td>nan                  </td><td>5</td><td>1</td><td> 760</td><td>145                    </td></tr>\n",
       "\t<tr><td>3.6  </td><td>2</td><td>1</td><td>430</td><td>  3</td><td>980</td><td>2</td><td>chips, cookies, ice cream                               </td><td>I usually only eat comfort food when I'm bored, if i am doing something, i can go for hours without eating                       </td><td>2</td><td>⋯</td><td>1</td><td>  1</td><td>3</td><td> 940</td><td>500</td><td>hockey               </td><td>4</td><td>2</td><td> 900</td><td>170                    </td></tr>\n",
       "\t<tr><td>3.4  </td><td>1</td><td>1</td><td>720</td><td>  3</td><td>980</td><td>1</td><td>Chocolate, ice crea                                     </td><td>Sadness, stress                                                                                                                  </td><td>3</td><td>⋯</td><td>2</td><td>  2</td><td>1</td><td>1165</td><td>690</td><td>dancing              </td><td>5</td><td>1</td><td>1315</td><td>135                    </td></tr>\n",
       "\t<tr><td>2.2  </td><td>2</td><td>1</td><td>430</td><td>  2</td><td>420</td><td>2</td><td>pizza, wings, Chinese                                   </td><td>boredom, sadness, hungry                                                                                                         </td><td>2</td><td>⋯</td><td>1</td><td>NaN</td><td>3</td><td> 940</td><td>345</td><td>basketball           </td><td>2</td><td>2</td><td> 900</td><td>165                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>980</td><td>2</td><td>Fast food, pizza, subs                                  </td><td>happiness, satisfaction                                                                                                          </td><td>7</td><td>⋯</td><td>1</td><td>  1</td><td>1</td><td>1165</td><td>850</td><td>Soccer               </td><td>3</td><td>2</td><td>1315</td><td>175                    </td></tr>\n",
       "\t<tr><td>3.87 </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>315</td><td>1</td><td>chocolate, sweets, ice cream                            </td><td>Mostly boredom                                                                                                                   </td><td>2</td><td>⋯</td><td>2</td><td>  1</td><td>5</td><td> 725</td><td>500</td><td>Tennis               </td><td>2</td><td>2</td><td> 900</td><td>195                    </td></tr>\n",
       "\t<tr><td>3.7  </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>1</td><td>burgers, chips, cookies                                 </td><td>sadness, depression                                                                                                              </td><td>3</td><td>⋯</td><td>1</td><td>  1</td><td>4</td><td> 940</td><td>850</td><td>tennis soccer gym    </td><td>3</td><td>1</td><td>1315</td><td>185                    </td></tr>\n",
       "\t<tr><td>3.7  </td><td>2</td><td>2</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>Chilli, soup, pot pie                                   </td><td>Stress and boredom                                                                                                               </td><td>1</td><td>⋯</td><td>1</td><td>  1</td><td>4</td><td> 940</td><td>690</td><td>Gaelic Football      </td><td>4</td><td>1</td><td>1315</td><td>185                    </td></tr>\n",
       "\t<tr><td>3.9  </td><td>1</td><td>1</td><td>720</td><td>  2</td><td>420</td><td>2</td><td>Soup, pasta, brownies, cake                             </td><td>A long day, not feeling well, winter                                                                                             </td><td>6</td><td>⋯</td><td>2</td><td>  2</td><td>4</td><td> 940</td><td>500</td><td>none                 </td><td>4</td><td>2</td><td>1315</td><td>105                    </td></tr>\n",
       "\t<tr><td>2.8  </td><td>1</td><td>2</td><td>720</td><td>  3</td><td>420</td><td>2</td><td>chocolate, ice cream/milkshake, cookies                 </td><td>boredom                                                                                                                          </td><td>2</td><td>⋯</td><td>1</td><td>  1</td><td>3</td><td>1165</td><td>690</td><td>Ice hockey           </td><td>3</td><td>2</td><td> 760</td><td>125                    </td></tr>\n",
       "\t<tr><td>3.7  </td><td>2</td><td>1</td><td>610</td><td>  2</td><td>420</td><td>1</td><td>Chips, ice cream, microwaveable foods                   </td><td>Boredom, lazyniss                                                                                                                </td><td>2</td><td>⋯</td><td>2</td><td>  1</td><td>2</td><td>1165</td><td>850</td><td>Hockey               </td><td>3</td><td>2</td><td>1315</td><td>160                    </td></tr>\n",
       "\t<tr><td>3    </td><td>2</td><td>1</td><td>610</td><td>  4</td><td>980</td><td>2</td><td>Chicken fingers, pizza                                  </td><td>Boredom                                                                                                                          </td><td>2</td><td>⋯</td><td>1</td><td>  1</td><td>3</td><td>1165</td><td>500</td><td>Lacrosse             </td><td>5</td><td>1</td><td>1315</td><td>175                    </td></tr>\n",
       "\t<tr><td>3.2  </td><td>2</td><td>1</td><td>610</td><td>  2</td><td>420</td><td>2</td><td>cookies, hot chocolate, beef jerky                      </td><td>survival, bored                                                                                                                  </td><td>2</td><td>⋯</td><td>1</td><td>  2</td><td>1</td><td> 940</td><td>500</td><td>nan                  </td><td>2</td><td>1</td><td>1315</td><td>180                    </td></tr>\n",
       "\t<tr><td>3.5  </td><td>2</td><td>1</td><td>265</td><td>  2</td><td>420</td><td>2</td><td>Tomato soup, pizza, Fritos, Meatball sub, Dr. Pepper    </td><td>Boredom, anger, drunkeness                                                                                                       </td><td>2</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td> 580</td><td>500</td><td>nan                  </td><td>4</td><td>1</td><td> 760</td><td>167                    </td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋱</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>3.5    </td><td>2</td><td>1</td><td>265</td><td>NaN</td><td>420</td><td>2</td><td>Doritos, mac and cheese, ice cream                                                               </td><td>Boredom, hunger, snacking.                                                        </td><td> 2</td><td>⋯</td><td>2</td><td>  1</td><td>4</td><td>1165</td><td>690</td><td>Wrestling                                                  </td><td>4</td><td>2</td><td>1315</td><td>184</td></tr>\n",
       "\t<tr><td>3.92   </td><td>2</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>2</td><td>Ice cream, cake, pop, pizza, and milkshakes.                                                     </td><td>Happiness, sadness, celebration.                                                  </td><td> 7</td><td>⋯</td><td>1</td><td>  2</td><td>3</td><td> 725</td><td>500</td><td>Soccer                                                     </td><td>2</td><td>1</td><td> 900</td><td>210</td></tr>\n",
       "\t<tr><td>3.9    </td><td>1</td><td>1</td><td>720</td><td>  3</td><td>420</td><td>2</td><td>Mac and Cheese, Pizza, Ice Cream and French Fries                                                </td><td>Boredom, anger and just being hungry in general.                                  </td><td> 2</td><td>⋯</td><td>1</td><td>  1</td><td>3</td><td>1165</td><td>500</td><td>Running                                                    </td><td>5</td><td>2</td><td> 760</td><td>155</td></tr>\n",
       "\t<tr><td>3.9    </td><td>2</td><td>1</td><td>720</td><td>  3</td><td>315</td><td>1</td><td>Soup, pasta, cake                                                                                </td><td>Depression, comfort, accessibility                                                </td><td> 3</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td>1165</td><td>690</td><td>Tennis                                                     </td><td>4</td><td>1</td><td>1315</td><td>185</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>3.2    </span></td><td>1</td><td>1</td><td>430</td><td><span style=white-space:pre-wrap>  4</span></td><td>420</td><td>1</td><td><span style=white-space:pre-wrap>mac &amp; cheese, frosted brownies, chicken nuggs                                                    </span></td><td><span style=white-space:pre-wrap>they are yummy, my boyfriend sometimes makes me sad, boredom                      </span></td><td> 3</td><td>⋯</td><td>1</td><td><span style=white-space:pre-wrap>  1</span></td><td>1</td><td>1165</td><td>690</td><td><span style=white-space:pre-wrap>softball                                                   </span></td><td>5</td><td>1</td><td> 900</td><td>165</td></tr>\n",
       "\t<tr><td>3.5    </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>NaN</td><td>2</td><td>watermelon, grapes, ice cream                                                                    </td><td>Sad, bored, excited                                                               </td><td> 3</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td> NaN</td><td>500</td><td>Volleyball, Track                                          </td><td>5</td><td>2</td><td> 900</td><td>125</td></tr>\n",
       "\t<tr><td>3.4    </td><td>1</td><td>1</td><td>610</td><td>NaN</td><td>420</td><td>2</td><td>macaroni and cheese, stuffed peppers, hamburgers, french fries                                   </td><td>boredom, stress, mood swings                                                      </td><td> 2</td><td>⋯</td><td>1</td><td>  2</td><td>3</td><td>1165</td><td>500</td><td>nan                                                        </td><td>5</td><td>2</td><td>1315</td><td>160</td></tr>\n",
       "\t<tr><td>nan    </td><td>1</td><td>1</td><td>610</td><td>  4</td><td>420</td><td>2</td><td>Pizza, mashed potatoes, spaghetti                                                                </td><td>Anger, sadness                                                                    </td><td> 3</td><td>⋯</td><td>1</td><td>  2</td><td>2</td><td> 940</td><td>500</td><td>nan                                                        </td><td>5</td><td>1</td><td> 900</td><td>135</td></tr>\n",
       "\t<tr><td>3.7    </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>dark chocolate, terra chips, reese's cups(dark chocolate), and bread/crackers with cottage cheese</td><td>Anxiousness, watching TV I desire \"comfort food\"                                  </td><td> 8</td><td>⋯</td><td>1</td><td>  2</td><td>3</td><td> 725</td><td>345</td><td>When I can, rarely though play pool, darts, and basketball.</td><td>5</td><td>1</td><td> 760</td><td>130</td></tr>\n",
       "\t<tr><td>Unknown</td><td>1</td><td>1</td><td>720</td><td>  3</td><td>420</td><td>2</td><td>Chips, chocolate, ,mozzarella sticks                                                             </td><td>Boredom, sadness, anxiety                                                         </td><td> 2</td><td>⋯</td><td>2</td><td>  2</td><td>5</td><td> 940</td><td>690</td><td>None at the moment                                         </td><td>5</td><td>1</td><td>1315</td><td>230</td></tr>\n",
       "\t<tr><td>3      </td><td>1</td><td>1</td><td>720</td><td>  3</td><td>420</td><td>2</td><td>ice cream, chips, candy                                                                          </td><td>Boredom, laziness, anger                                                          </td><td> 2</td><td>⋯</td><td>2</td><td>  1</td><td>3</td><td>1165</td><td>690</td><td>volleyball                                                 </td><td>2</td><td>2</td><td>1315</td><td>125</td></tr>\n",
       "\t<tr><td>3      </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>315</td><td>2</td><td>Pizza, soda, chocolate brownie, chicken tikka masala and butter naan                             </td><td>Stress and sadness                                                                </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>4</td><td> 580</td><td>500</td><td>None                                                       </td><td>5</td><td>2</td><td> 760</td><td>130</td></tr>\n",
       "\t<tr><td>3.8    </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>1</td><td>Chocolate, Pasta, Cookies                                                                        </td><td>I am always stressed out, and bored when I am in my apartment.                    </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td>1165</td><td>690</td><td>I used to play softball                                    </td><td>4</td><td>2</td><td> 900</td><td>165</td></tr>\n",
       "\t<tr><td>3.8    </td><td>1</td><td>1</td><td>430</td><td>  2</td><td>420</td><td>2</td><td>Candy, salty snacks, toast                                                                       </td><td>Stress, sadness, boredom                                                          </td><td>NA</td><td>⋯</td><td>1</td><td>  1</td><td>2</td><td> 580</td><td>345</td><td>Ice hockey                                                 </td><td>5</td><td>2</td><td> 760</td><td>128</td></tr>\n",
       "\t<tr><td>3.4    </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>Mac in cheese, pizza, mozzarella sticks                                                          </td><td>Stress, frustration, self-consciousness                                           </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>2</td><td> 940</td><td>690</td><td>None                                                       </td><td>3</td><td>1</td><td>1315</td><td>200</td></tr>\n",
       "\t<tr><td>3.7    </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>315</td><td>1</td><td>Ice-cream, pizza, chocolate                                                                      </td><td>Sadness and cravings                                                              </td><td>NA</td><td>⋯</td><td>1</td><td>  1</td><td>3</td><td> 580</td><td>690</td><td>Volleyball                                                 </td><td>3</td><td>2</td><td> 900</td><td>160</td></tr>\n",
       "\t<tr><td>2.9    </td><td>2</td><td>1</td><td>265</td><td>  2</td><td>980</td><td>2</td><td>snacks, chips,                                                                                   </td><td>boredom                                                                           </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>1</td><td> 725</td><td>345</td><td>nan                                                        </td><td>3</td><td>2</td><td>1315</td><td>170</td></tr>\n",
       "\t<tr><td>3.9    </td><td>1</td><td>1</td><td>610</td><td>  4</td><td>315</td><td>2</td><td>Chocolate, Ice cream, pizza                                                                      </td><td>Sadness, happiness and boredom                                                    </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td> 725</td><td>500</td><td>nan                                                        </td><td>3</td><td>2</td><td> 900</td><td>129</td></tr>\n",
       "\t<tr><td>3.6    </td><td>1</td><td>1</td><td>430</td><td>  2</td><td>420</td><td>1</td><td>ice cream, pizza, Chinese food                                                                   </td><td>Boredom and sadness                                                               </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>2</td><td>1165</td><td>690</td><td>None                                                       </td><td>2</td><td>2</td><td> 900</td><td>170</td></tr>\n",
       "\t<tr><td>2.8    </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>315</td><td>2</td><td>Burgers, indian and korean food                                                                  </td><td>sadness, happiness and hunger                                                     </td><td>NA</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td> 940</td><td>850</td><td>Tennis, Basketball                                         </td><td>3</td><td>2</td><td> 760</td><td>138</td></tr>\n",
       "\t<tr><td>3.3    </td><td>2</td><td>1</td><td>610</td><td>  4</td><td>980</td><td>2</td><td>chocolate bar, ice cream, pretzels, potato chips and protein bars.                               </td><td>Stress, boredom and physical activity                                             </td><td>NA</td><td>⋯</td><td>1</td><td>  1</td><td>1</td><td>1165</td><td>690</td><td>Hockey                                                     </td><td>2</td><td>2</td><td>1315</td><td>150</td></tr>\n",
       "\t<tr><td>3.4    </td><td>1</td><td>1</td><td>610</td><td>NaN</td><td>420</td><td>2</td><td>Ice cream, chocolate, pizza, cucumber                                                            </td><td>loneliness, homework, boredom                                                     </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td> 725</td><td>345</td><td>none                                                       </td><td>5</td><td>1</td><td>1315</td><td>170</td></tr>\n",
       "\t<tr><td>3.77   </td><td>1</td><td>1</td><td>610</td><td>NaN</td><td>315</td><td>2</td><td>Noodle ( any kinds of noodle), Tuna sandwich, and Egg.                                           </td><td>When i'm  eating with my close friends/ Food smell or look good/ when I feel tired</td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td> 725</td><td>690</td><td>No, I don't play sport.                                    </td><td>3</td><td>1</td><td> 760</td><td>113</td></tr>\n",
       "\t<tr><td>3.63   </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>1</td><td>Chinese, chips, cake                                                                             </td><td>Stress and boredom                                                                </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>4</td><td> 940</td><td>345</td><td>None                                                       </td><td>5</td><td>2</td><td>1315</td><td>140</td></tr>\n",
       "\t<tr><td>3.2    </td><td>2</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>chips, rice, chicken curry,                                                                      </td><td>Happiness, boredom, social event                                                  </td><td>NA</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td>1165</td><td>690</td><td>Soccer                                                     </td><td>5</td><td>2</td><td>1315</td><td>185</td></tr>\n",
       "\t<tr><td>3.5    </td><td>1</td><td>1</td><td>610</td><td>  4</td><td>420</td><td>2</td><td>wine. mac and cheese, pizza, ice cream                                                           </td><td>boredom and sadness                                                               </td><td>NA</td><td>⋯</td><td>1</td><td>  1</td><td>5</td><td> 940</td><td>500</td><td>Softball                                                   </td><td>5</td><td>1</td><td>1315</td><td>156</td></tr>\n",
       "\t<tr><td>3      </td><td>1</td><td>1</td><td>265</td><td>  2</td><td>315</td><td>2</td><td>Pizza / Wings / Cheesecake                                                                       </td><td>Loneliness / Homesick / Sadness                                                   </td><td>NA</td><td>⋯</td><td>1</td><td>NaN</td><td>4</td><td> 940</td><td>500</td><td>basketball                                                 </td><td>5</td><td>2</td><td>1315</td><td>180</td></tr>\n",
       "\t<tr><td>3.882  </td><td>1</td><td>1</td><td>720</td><td>NaN</td><td>420</td><td>1</td><td>rice, potato, seaweed soup                                                                       </td><td>sadness                                                                           </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>5</td><td> 580</td><td>690</td><td>none                                                       </td><td>4</td><td>2</td><td>1315</td><td>120</td></tr>\n",
       "\t<tr><td>3      </td><td>2</td><td>1</td><td>720</td><td>  4</td><td>420</td><td>1</td><td>Mac n Cheese, Lasagna, Pizza                                                                     </td><td>happiness, they are some of my favorite foods                                     </td><td>NA</td><td>⋯</td><td>2</td><td>  2</td><td>1</td><td> 940</td><td>500</td><td>nan                                                        </td><td>3</td><td>1</td><td>1315</td><td>135</td></tr>\n",
       "\t<tr><td>3.9    </td><td>1</td><td>1</td><td>430</td><td>NaN</td><td>315</td><td>2</td><td>Chocolates, pizza, and Ritz.                                                                     </td><td>hormones, Premenstrual syndrome.                                                  </td><td>NA</td><td>⋯</td><td>1</td><td>  2</td><td>2</td><td> 725</td><td>345</td><td>nan                                                        </td><td>4</td><td>2</td><td> 575</td><td>135</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 125 × 61\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " GPA & Gender & breakfast & calories\\_chicken & calories\\_day & calories\\_scone & coffee & comfort\\_food & comfort\\_food\\_reasons & comfort\\_food\\_reasons\\_coded...10 & ⋯ & soup & sports & thai\\_food & tortilla\\_calories & turkey\\_calories & type\\_sports & veggies\\_day & vitamins & waffle\\_calories & weight\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2.4   & 2 & 1 & 430 & NaN & 315 & 1 & none                                                     & we dont have comfort                                                                                                              & 9 & ⋯ & 1 &   1 & 1 & 1165 & 345 & car racing            & 5 & 1 & 1315 & 187                    \\\\\n",
       "\t 3.654 & 1 & 1 & 610 &   3 & 420 & 2 & chocolate, chips, ice cream                              & Stress, bored, anger                                                                                                              & 1 & ⋯ & 1 &   1 & 2 &  725 & 690 & Basketball            & 4 & 2 &  900 & 155                    \\\\\n",
       "\t 3.3   & 1 & 1 & 720 &   4 & 420 & 2 & frozen yogurt, pizza, fast food                          & stress, sadness                                                                                                                   & 1 & ⋯ & 1 &   2 & 5 & 1165 & 500 & none                  & 5 & 1 &  900 & I'm not answering this.\\\\\n",
       "\t 3.2   & 1 & 1 & 430 &   3 & 420 & 2 & Pizza, Mac and cheese, ice cream                         & Boredom                                                                                                                           & 2 & ⋯ & 1 &   2 & 5 &  725 & 690 & nan                   & 3 & 1 & 1315 & Not sure, 240          \\\\\n",
       "\t 3.5   & 1 & 1 & 720 &   2 & 420 & 2 & Ice cream, chocolate, chips                              & Stress, boredom, cravings                                                                                                         & 1 & ⋯ & 1 &   1 & 4 &  940 & 500 & Softball              & 4 & 2 &  760 & 190                    \\\\\n",
       "\t 2.25  & 1 & 1 & 610 &   3 & 980 & 2 & Candy, brownies and soda.                                & None, i don't eat comfort food. I just eat when i'm hungry.                                                                       & 4 & ⋯ & 1 &   2 & 4 &  940 & 345 & None.                 & 1 & 2 & 1315 & 190                    \\\\\n",
       "\t 3.8   & 2 & 1 & 610 &   3 & 420 & 2 & Chocolate, ice cream, french fries, pretzels             & stress, boredom                                                                                                                   & 1 & ⋯ & 1 &   1 & 5 &  940 & 690 & soccer                & 4 & 1 & 1315 & 180                    \\\\\n",
       "\t 3.3   & 1 & 1 & 720 &   3 & 420 & 1 & Ice cream, cheeseburgers, chips.                         & I eat comfort food when im stressed out from school(finals week), when I`m sad, or when i am dealing with personal family issues. & 1 & ⋯ & 1 &   2 & 1 &  725 & 500 & none                  & 4 & 2 & 1315 & 137                    \\\\\n",
       "\t 3.3   & 1 & 1 & 430 & NaN & 420 & 1 & Donuts, ice cream, chips                                 & Boredom                                                                                                                           & 2 & ⋯ & 2 &   2 & 5 &  725 & 345 & none                  & 3 & 2 &  760 & 180                    \\\\\n",
       "\t 3.3   & 1 & 1 & 430 &   3 & 315 & 2 & Mac and cheese, chocolate, and pasta                     & Stress, anger and sadness                                                                                                         & 1 & ⋯ & 1 &   1 & 4 &  580 & 345 & field hockey          & 5 & 1 &  900 & 125                    \\\\\n",
       "\t 3.5   & 1 & 1 & 610 &   3 & 980 & 2 & Pasta, grandma homemade chocolate cake anything homemade & Boredom                                                                                                                           & 2 & ⋯ & 1 &   1 & 2 &  940 & 345 & soccer                & 5 & 2 &  900 & 116                    \\\\\n",
       "\t 3.904 & 1 & 1 & 720 &   4 & 420 & 2 & chocolate, pasta, soup, chips, popcorn                   & sadness, stress, cold weather                                                                                                     & 3 & ⋯ & 1 &   1 & 5 &  940 & 500 & Running               & 5 & 1 &  900 & 110                    \\\\\n",
       "\t 3.4   & 2 & 1 & 430 &   3 & 420 & 2 & Cookies, popcorn, and chips                              & Sadness, boredom, late night snack                                                                                                & 3 & ⋯ & 2 &   1 & 3 &  940 & 500 & Soccer and basketball & 3 & 2 &  575 & 264                    \\\\\n",
       "\t 3.6   & 1 & 1 & 610 &   3 & 420 & 2 & ice cream, cake, chocolate                               & stress,  boredom, special occasions                                                                                               & 1 & ⋯ & 1 &   1 & 5 & 1165 & 850 & intramural volleyball & 5 & 2 & 1315 & 123                    \\\\\n",
       "\t 3.1   & 2 & 1 & 610 &   3 & 420 & 2 & Pizza, fruit, spaghetti, chicken and Potatoes            & Friends, environment and boredom                                                                                                  & 2 & ⋯ & 1 &   1 & 4 &  940 & 500 & Hockey                & 5 & 1 &  900 & 185                    \\\\\n",
       "\t nan   & 2 & 2 & 430 & NaN & 980 & 2 & cookies, donuts, candy bars                              & boredom                                                                                                                           & 2 & ⋯ & 2 &   1 & 1 &  940 & 345 & Hockey                & 1 & 2 & 1315 & 180                    \\\\\n",
       "\t 4     & 1 & 1 & 265 &   3 & 420 & 1 & Saltfish, Candy and Kit Kat                              & Stress                                                                                                                            & 1 & ⋯ & 1 &   2 & 1 &  580 & 345 & nan                   & 5 & 1 &  760 & 145                    \\\\\n",
       "\t 3.6   & 2 & 1 & 430 &   3 & 980 & 2 & chips, cookies, ice cream                                & I usually only eat comfort food when I'm bored, if i am doing something, i can go for hours without eating                        & 2 & ⋯ & 1 &   1 & 3 &  940 & 500 & hockey                & 4 & 2 &  900 & 170                    \\\\\n",
       "\t 3.4   & 1 & 1 & 720 &   3 & 980 & 1 & Chocolate, ice crea                                      & Sadness, stress                                                                                                                   & 3 & ⋯ & 2 &   2 & 1 & 1165 & 690 & dancing               & 5 & 1 & 1315 & 135                    \\\\\n",
       "\t 2.2   & 2 & 1 & 430 &   2 & 420 & 2 & pizza, wings, Chinese                                    & boredom, sadness, hungry                                                                                                          & 2 & ⋯ & 1 & NaN & 3 &  940 & 345 & basketball            & 2 & 2 &  900 & 165                    \\\\\n",
       "\t 3.3   & 2 & 1 & 610 &   3 & 980 & 2 & Fast food, pizza, subs                                   & happiness, satisfaction                                                                                                           & 7 & ⋯ & 1 &   1 & 1 & 1165 & 850 & Soccer                & 3 & 2 & 1315 & 175                    \\\\\n",
       "\t 3.87  & 2 & 1 & 610 &   3 & 315 & 1 & chocolate, sweets, ice cream                             & Mostly boredom                                                                                                                    & 2 & ⋯ & 2 &   1 & 5 &  725 & 500 & Tennis                & 2 & 2 &  900 & 195                    \\\\\n",
       "\t 3.7   & 2 & 1 & 610 &   3 & 420 & 1 & burgers, chips, cookies                                  & sadness, depression                                                                                                               & 3 & ⋯ & 1 &   1 & 4 &  940 & 850 & tennis soccer gym     & 3 & 1 & 1315 & 185                    \\\\\n",
       "\t 3.7   & 2 & 2 & 610 &   3 & 420 & 2 & Chilli, soup, pot pie                                    & Stress and boredom                                                                                                                & 1 & ⋯ & 1 &   1 & 4 &  940 & 690 & Gaelic Football       & 4 & 1 & 1315 & 185                    \\\\\n",
       "\t 3.9   & 1 & 1 & 720 &   2 & 420 & 2 & Soup, pasta, brownies, cake                              & A long day, not feeling well, winter                                                                                              & 6 & ⋯ & 2 &   2 & 4 &  940 & 500 & none                  & 4 & 2 & 1315 & 105                    \\\\\n",
       "\t 2.8   & 1 & 2 & 720 &   3 & 420 & 2 & chocolate, ice cream/milkshake, cookies                  & boredom                                                                                                                           & 2 & ⋯ & 1 &   1 & 3 & 1165 & 690 & Ice hockey            & 3 & 2 &  760 & 125                    \\\\\n",
       "\t 3.7   & 2 & 1 & 610 &   2 & 420 & 1 & Chips, ice cream, microwaveable foods                    & Boredom, lazyniss                                                                                                                 & 2 & ⋯ & 2 &   1 & 2 & 1165 & 850 & Hockey                & 3 & 2 & 1315 & 160                    \\\\\n",
       "\t 3     & 2 & 1 & 610 &   4 & 980 & 2 & Chicken fingers, pizza                                   & Boredom                                                                                                                           & 2 & ⋯ & 1 &   1 & 3 & 1165 & 500 & Lacrosse              & 5 & 1 & 1315 & 175                    \\\\\n",
       "\t 3.2   & 2 & 1 & 610 &   2 & 420 & 2 & cookies, hot chocolate, beef jerky                       & survival, bored                                                                                                                   & 2 & ⋯ & 1 &   2 & 1 &  940 & 500 & nan                   & 2 & 1 & 1315 & 180                    \\\\\n",
       "\t 3.5   & 2 & 1 & 265 &   2 & 420 & 2 & Tomato soup, pizza, Fritos, Meatball sub, Dr. Pepper     & Boredom, anger, drunkeness                                                                                                        & 2 & ⋯ & 1 &   2 & 5 &  580 & 500 & nan                   & 4 & 1 &  760 & 167                    \\\\\n",
       "\t ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋱ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t 3.5     & 2 & 1 & 265 & NaN & 420 & 2 & Doritos, mac and cheese, ice cream                                                                & Boredom, hunger, snacking.                                                         &  2 & ⋯ & 2 &   1 & 4 & 1165 & 690 & Wrestling                                                   & 4 & 2 & 1315 & 184\\\\\n",
       "\t 3.92    & 2 & 1 & 430 &   3 & 420 & 2 & Ice cream, cake, pop, pizza, and milkshakes.                                                      & Happiness, sadness, celebration.                                                   &  7 & ⋯ & 1 &   2 & 3 &  725 & 500 & Soccer                                                      & 2 & 1 &  900 & 210\\\\\n",
       "\t 3.9     & 1 & 1 & 720 &   3 & 420 & 2 & Mac and Cheese, Pizza, Ice Cream and French Fries                                                 & Boredom, anger and just being hungry in general.                                   &  2 & ⋯ & 1 &   1 & 3 & 1165 & 500 & Running                                                     & 5 & 2 &  760 & 155\\\\\n",
       "\t 3.9     & 2 & 1 & 720 &   3 & 315 & 1 & Soup, pasta, cake                                                                                 & Depression, comfort, accessibility                                                 &  3 & ⋯ & 1 &   1 & 5 & 1165 & 690 & Tennis                                                      & 4 & 1 & 1315 & 185\\\\\n",
       "\t 3.2     & 1 & 1 & 430 &   4 & 420 & 1 & mac \\& cheese, frosted brownies, chicken nuggs                                                     & they are yummy, my boyfriend sometimes makes me sad, boredom                       &  3 & ⋯ & 1 &   1 & 1 & 1165 & 690 & softball                                                    & 5 & 1 &  900 & 165\\\\\n",
       "\t 3.5     & 1 & 1 & 610 &   3 & NaN & 2 & watermelon, grapes, ice cream                                                                     & Sad, bored, excited                                                                &  3 & ⋯ & 1 &   1 & 5 &  NaN & 500 & Volleyball, Track                                           & 5 & 2 &  900 & 125\\\\\n",
       "\t 3.4     & 1 & 1 & 610 & NaN & 420 & 2 & macaroni and cheese, stuffed peppers, hamburgers, french fries                                    & boredom, stress, mood swings                                                       &  2 & ⋯ & 1 &   2 & 3 & 1165 & 500 & nan                                                         & 5 & 2 & 1315 & 160\\\\\n",
       "\t nan     & 1 & 1 & 610 &   4 & 420 & 2 & Pizza, mashed potatoes, spaghetti                                                                 & Anger, sadness                                                                     &  3 & ⋯ & 1 &   2 & 2 &  940 & 500 & nan                                                         & 5 & 1 &  900 & 135\\\\\n",
       "\t 3.7     & 1 & 1 & 610 &   3 & 420 & 2 & dark chocolate, terra chips, reese's cups(dark chocolate), and bread/crackers with cottage cheese & Anxiousness, watching TV I desire \"comfort food\"                                   &  8 & ⋯ & 1 &   2 & 3 &  725 & 345 & When I can, rarely though play pool, darts, and basketball. & 5 & 1 &  760 & 130\\\\\n",
       "\t Unknown & 1 & 1 & 720 &   3 & 420 & 2 & Chips, chocolate, ,mozzarella sticks                                                              & Boredom, sadness, anxiety                                                          &  2 & ⋯ & 2 &   2 & 5 &  940 & 690 & None at the moment                                          & 5 & 1 & 1315 & 230\\\\\n",
       "\t 3       & 1 & 1 & 720 &   3 & 420 & 2 & ice cream, chips, candy                                                                           & Boredom, laziness, anger                                                           &  2 & ⋯ & 2 &   1 & 3 & 1165 & 690 & volleyball                                                  & 2 & 2 & 1315 & 125\\\\\n",
       "\t 3       & 1 & 1 & 430 &   3 & 315 & 2 & Pizza, soda, chocolate brownie, chicken tikka masala and butter naan                              & Stress and sadness                                                                 & NA & ⋯ & 1 &   2 & 4 &  580 & 500 & None                                                        & 5 & 2 &  760 & 130\\\\\n",
       "\t 3.8     & 1 & 1 & 430 &   3 & 420 & 1 & Chocolate, Pasta, Cookies                                                                         & I am always stressed out, and bored when I am in my apartment.                     & NA & ⋯ & 1 &   2 & 5 & 1165 & 690 & I used to play softball                                     & 4 & 2 &  900 & 165\\\\\n",
       "\t 3.8     & 1 & 1 & 430 &   2 & 420 & 2 & Candy, salty snacks, toast                                                                        & Stress, sadness, boredom                                                           & NA & ⋯ & 1 &   1 & 2 &  580 & 345 & Ice hockey                                                  & 5 & 2 &  760 & 128\\\\\n",
       "\t 3.4     & 1 & 1 & 610 &   3 & 420 & 2 & Mac in cheese, pizza, mozzarella sticks                                                           & Stress, frustration, self-consciousness                                            & NA & ⋯ & 1 &   2 & 2 &  940 & 690 & None                                                        & 3 & 1 & 1315 & 200\\\\\n",
       "\t 3.7     & 1 & 1 & 610 &   3 & 315 & 1 & Ice-cream, pizza, chocolate                                                                       & Sadness and cravings                                                               & NA & ⋯ & 1 &   1 & 3 &  580 & 690 & Volleyball                                                  & 3 & 2 &  900 & 160\\\\\n",
       "\t 2.9     & 2 & 1 & 265 &   2 & 980 & 2 & snacks, chips,                                                                                    & boredom                                                                            & NA & ⋯ & 1 &   2 & 1 &  725 & 345 & nan                                                         & 3 & 2 & 1315 & 170\\\\\n",
       "\t 3.9     & 1 & 1 & 610 &   4 & 315 & 2 & Chocolate, Ice cream, pizza                                                                       & Sadness, happiness and boredom                                                     & NA & ⋯ & 1 &   2 & 5 &  725 & 500 & nan                                                         & 3 & 2 &  900 & 129\\\\\n",
       "\t 3.6     & 1 & 1 & 430 &   2 & 420 & 1 & ice cream, pizza, Chinese food                                                                    & Boredom and sadness                                                                & NA & ⋯ & 1 &   2 & 2 & 1165 & 690 & None                                                        & 2 & 2 &  900 & 170\\\\\n",
       "\t 2.8     & 2 & 1 & 610 &   3 & 315 & 2 & Burgers, indian and korean food                                                                   & sadness, happiness and hunger                                                      & NA & ⋯ & 1 &   1 & 5 &  940 & 850 & Tennis, Basketball                                          & 3 & 2 &  760 & 138\\\\\n",
       "\t 3.3     & 2 & 1 & 610 &   4 & 980 & 2 & chocolate bar, ice cream, pretzels, potato chips and protein bars.                                & Stress, boredom and physical activity                                              & NA & ⋯ & 1 &   1 & 1 & 1165 & 690 & Hockey                                                      & 2 & 2 & 1315 & 150\\\\\n",
       "\t 3.4     & 1 & 1 & 610 & NaN & 420 & 2 & Ice cream, chocolate, pizza, cucumber                                                             & loneliness, homework, boredom                                                      & NA & ⋯ & 1 &   2 & 5 &  725 & 345 & none                                                        & 5 & 1 & 1315 & 170\\\\\n",
       "\t 3.77    & 1 & 1 & 610 & NaN & 315 & 2 & Noodle ( any kinds of noodle), Tuna sandwich, and Egg.                                            & When i'm  eating with my close friends/ Food smell or look good/ when I feel tired & NA & ⋯ & 1 &   2 & 5 &  725 & 690 & No, I don't play sport.                                     & 3 & 1 &  760 & 113\\\\\n",
       "\t 3.63    & 1 & 1 & 430 &   3 & 420 & 1 & Chinese, chips, cake                                                                              & Stress and boredom                                                                 & NA & ⋯ & 1 &   2 & 4 &  940 & 345 & None                                                        & 5 & 2 & 1315 & 140\\\\\n",
       "\t 3.2     & 2 & 1 & 610 &   3 & 420 & 2 & chips, rice, chicken curry,                                                                       & Happiness, boredom, social event                                                   & NA & ⋯ & 1 &   1 & 5 & 1165 & 690 & Soccer                                                      & 5 & 2 & 1315 & 185\\\\\n",
       "\t 3.5     & 1 & 1 & 610 &   4 & 420 & 2 & wine. mac and cheese, pizza, ice cream                                                            & boredom and sadness                                                                & NA & ⋯ & 1 &   1 & 5 &  940 & 500 & Softball                                                    & 5 & 1 & 1315 & 156\\\\\n",
       "\t 3       & 1 & 1 & 265 &   2 & 315 & 2 & Pizza / Wings / Cheesecake                                                                        & Loneliness / Homesick / Sadness                                                    & NA & ⋯ & 1 & NaN & 4 &  940 & 500 & basketball                                                  & 5 & 2 & 1315 & 180\\\\\n",
       "\t 3.882   & 1 & 1 & 720 & NaN & 420 & 1 & rice, potato, seaweed soup                                                                        & sadness                                                                            & NA & ⋯ & 1 &   2 & 5 &  580 & 690 & none                                                        & 4 & 2 & 1315 & 120\\\\\n",
       "\t 3       & 2 & 1 & 720 &   4 & 420 & 1 & Mac n Cheese, Lasagna, Pizza                                                                      & happiness, they are some of my favorite foods                                      & NA & ⋯ & 2 &   2 & 1 &  940 & 500 & nan                                                         & 3 & 1 & 1315 & 135\\\\\n",
       "\t 3.9     & 1 & 1 & 430 & NaN & 315 & 2 & Chocolates, pizza, and Ritz.                                                                      & hormones, Premenstrual syndrome.                                                   & NA & ⋯ & 1 &   2 & 2 &  725 & 345 & nan                                                         & 4 & 2 &  575 & 135\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 125 × 61\n",
       "\n",
       "| GPA &lt;chr&gt; | Gender &lt;dbl&gt; | breakfast &lt;dbl&gt; | calories_chicken &lt;dbl&gt; | calories_day &lt;dbl&gt; | calories_scone &lt;dbl&gt; | coffee &lt;dbl&gt; | comfort_food &lt;chr&gt; | comfort_food_reasons &lt;chr&gt; | comfort_food_reasons_coded...10 &lt;dbl&gt; | ⋯ ⋯ | soup &lt;dbl&gt; | sports &lt;dbl&gt; | thai_food &lt;dbl&gt; | tortilla_calories &lt;dbl&gt; | turkey_calories &lt;dbl&gt; | type_sports &lt;chr&gt; | veggies_day &lt;dbl&gt; | vitamins &lt;dbl&gt; | waffle_calories &lt;dbl&gt; | weight &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2.4   | 2 | 1 | 430 | NaN | 315 | 1 | none                                                     | we dont have comfort                                                                                                              | 9 | ⋯ | 1 |   1 | 1 | 1165 | 345 | car racing            | 5 | 1 | 1315 | 187                     |\n",
       "| 3.654 | 1 | 1 | 610 |   3 | 420 | 2 | chocolate, chips, ice cream                              | Stress, bored, anger                                                                                                              | 1 | ⋯ | 1 |   1 | 2 |  725 | 690 | Basketball            | 4 | 2 |  900 | 155                     |\n",
       "| 3.3   | 1 | 1 | 720 |   4 | 420 | 2 | frozen yogurt, pizza, fast food                          | stress, sadness                                                                                                                   | 1 | ⋯ | 1 |   2 | 5 | 1165 | 500 | none                  | 5 | 1 |  900 | I'm not answering this. |\n",
       "| 3.2   | 1 | 1 | 430 |   3 | 420 | 2 | Pizza, Mac and cheese, ice cream                         | Boredom                                                                                                                           | 2 | ⋯ | 1 |   2 | 5 |  725 | 690 | nan                   | 3 | 1 | 1315 | Not sure, 240           |\n",
       "| 3.5   | 1 | 1 | 720 |   2 | 420 | 2 | Ice cream, chocolate, chips                              | Stress, boredom, cravings                                                                                                         | 1 | ⋯ | 1 |   1 | 4 |  940 | 500 | Softball              | 4 | 2 |  760 | 190                     |\n",
       "| 2.25  | 1 | 1 | 610 |   3 | 980 | 2 | Candy, brownies and soda.                                | None, i don't eat comfort food. I just eat when i'm hungry.                                                                       | 4 | ⋯ | 1 |   2 | 4 |  940 | 345 | None.                 | 1 | 2 | 1315 | 190                     |\n",
       "| 3.8   | 2 | 1 | 610 |   3 | 420 | 2 | Chocolate, ice cream, french fries, pretzels             | stress, boredom                                                                                                                   | 1 | ⋯ | 1 |   1 | 5 |  940 | 690 | soccer                | 4 | 1 | 1315 | 180                     |\n",
       "| 3.3   | 1 | 1 | 720 |   3 | 420 | 1 | Ice cream, cheeseburgers, chips.                         | I eat comfort food when im stressed out from school(finals week), when I`m sad, or when i am dealing with personal family issues. | 1 | ⋯ | 1 |   2 | 1 |  725 | 500 | none                  | 4 | 2 | 1315 | 137                     |\n",
       "| 3.3   | 1 | 1 | 430 | NaN | 420 | 1 | Donuts, ice cream, chips                                 | Boredom                                                                                                                           | 2 | ⋯ | 2 |   2 | 5 |  725 | 345 | none                  | 3 | 2 |  760 | 180                     |\n",
       "| 3.3   | 1 | 1 | 430 |   3 | 315 | 2 | Mac and cheese, chocolate, and pasta                     | Stress, anger and sadness                                                                                                         | 1 | ⋯ | 1 |   1 | 4 |  580 | 345 | field hockey          | 5 | 1 |  900 | 125                     |\n",
       "| 3.5   | 1 | 1 | 610 |   3 | 980 | 2 | Pasta, grandma homemade chocolate cake anything homemade | Boredom                                                                                                                           | 2 | ⋯ | 1 |   1 | 2 |  940 | 345 | soccer                | 5 | 2 |  900 | 116                     |\n",
       "| 3.904 | 1 | 1 | 720 |   4 | 420 | 2 | chocolate, pasta, soup, chips, popcorn                   | sadness, stress, cold weather                                                                                                     | 3 | ⋯ | 1 |   1 | 5 |  940 | 500 | Running               | 5 | 1 |  900 | 110                     |\n",
       "| 3.4   | 2 | 1 | 430 |   3 | 420 | 2 | Cookies, popcorn, and chips                              | Sadness, boredom, late night snack                                                                                                | 3 | ⋯ | 2 |   1 | 3 |  940 | 500 | Soccer and basketball | 3 | 2 |  575 | 264                     |\n",
       "| 3.6   | 1 | 1 | 610 |   3 | 420 | 2 | ice cream, cake, chocolate                               | stress,  boredom, special occasions                                                                                               | 1 | ⋯ | 1 |   1 | 5 | 1165 | 850 | intramural volleyball | 5 | 2 | 1315 | 123                     |\n",
       "| 3.1   | 2 | 1 | 610 |   3 | 420 | 2 | Pizza, fruit, spaghetti, chicken and Potatoes            | Friends, environment and boredom                                                                                                  | 2 | ⋯ | 1 |   1 | 4 |  940 | 500 | Hockey                | 5 | 1 |  900 | 185                     |\n",
       "| nan   | 2 | 2 | 430 | NaN | 980 | 2 | cookies, donuts, candy bars                              | boredom                                                                                                                           | 2 | ⋯ | 2 |   1 | 1 |  940 | 345 | Hockey                | 1 | 2 | 1315 | 180                     |\n",
       "| 4     | 1 | 1 | 265 |   3 | 420 | 1 | Saltfish, Candy and Kit Kat                              | Stress                                                                                                                            | 1 | ⋯ | 1 |   2 | 1 |  580 | 345 | nan                   | 5 | 1 |  760 | 145                     |\n",
       "| 3.6   | 2 | 1 | 430 |   3 | 980 | 2 | chips, cookies, ice cream                                | I usually only eat comfort food when I'm bored, if i am doing something, i can go for hours without eating                        | 2 | ⋯ | 1 |   1 | 3 |  940 | 500 | hockey                | 4 | 2 |  900 | 170                     |\n",
       "| 3.4   | 1 | 1 | 720 |   3 | 980 | 1 | Chocolate, ice crea                                      | Sadness, stress                                                                                                                   | 3 | ⋯ | 2 |   2 | 1 | 1165 | 690 | dancing               | 5 | 1 | 1315 | 135                     |\n",
       "| 2.2   | 2 | 1 | 430 |   2 | 420 | 2 | pizza, wings, Chinese                                    | boredom, sadness, hungry                                                                                                          | 2 | ⋯ | 1 | NaN | 3 |  940 | 345 | basketball            | 2 | 2 |  900 | 165                     |\n",
       "| 3.3   | 2 | 1 | 610 |   3 | 980 | 2 | Fast food, pizza, subs                                   | happiness, satisfaction                                                                                                           | 7 | ⋯ | 1 |   1 | 1 | 1165 | 850 | Soccer                | 3 | 2 | 1315 | 175                     |\n",
       "| 3.87  | 2 | 1 | 610 |   3 | 315 | 1 | chocolate, sweets, ice cream                             | Mostly boredom                                                                                                                    | 2 | ⋯ | 2 |   1 | 5 |  725 | 500 | Tennis                | 2 | 2 |  900 | 195                     |\n",
       "| 3.7   | 2 | 1 | 610 |   3 | 420 | 1 | burgers, chips, cookies                                  | sadness, depression                                                                                                               | 3 | ⋯ | 1 |   1 | 4 |  940 | 850 | tennis soccer gym     | 3 | 1 | 1315 | 185                     |\n",
       "| 3.7   | 2 | 2 | 610 |   3 | 420 | 2 | Chilli, soup, pot pie                                    | Stress and boredom                                                                                                                | 1 | ⋯ | 1 |   1 | 4 |  940 | 690 | Gaelic Football       | 4 | 1 | 1315 | 185                     |\n",
       "| 3.9   | 1 | 1 | 720 |   2 | 420 | 2 | Soup, pasta, brownies, cake                              | A long day, not feeling well, winter                                                                                              | 6 | ⋯ | 2 |   2 | 4 |  940 | 500 | none                  | 4 | 2 | 1315 | 105                     |\n",
       "| 2.8   | 1 | 2 | 720 |   3 | 420 | 2 | chocolate, ice cream/milkshake, cookies                  | boredom                                                                                                                           | 2 | ⋯ | 1 |   1 | 3 | 1165 | 690 | Ice hockey            | 3 | 2 |  760 | 125                     |\n",
       "| 3.7   | 2 | 1 | 610 |   2 | 420 | 1 | Chips, ice cream, microwaveable foods                    | Boredom, lazyniss                                                                                                                 | 2 | ⋯ | 2 |   1 | 2 | 1165 | 850 | Hockey                | 3 | 2 | 1315 | 160                     |\n",
       "| 3     | 2 | 1 | 610 |   4 | 980 | 2 | Chicken fingers, pizza                                   | Boredom                                                                                                                           | 2 | ⋯ | 1 |   1 | 3 | 1165 | 500 | Lacrosse              | 5 | 1 | 1315 | 175                     |\n",
       "| 3.2   | 2 | 1 | 610 |   2 | 420 | 2 | cookies, hot chocolate, beef jerky                       | survival, bored                                                                                                                   | 2 | ⋯ | 1 |   2 | 1 |  940 | 500 | nan                   | 2 | 1 | 1315 | 180                     |\n",
       "| 3.5   | 2 | 1 | 265 |   2 | 420 | 2 | Tomato soup, pizza, Fritos, Meatball sub, Dr. Pepper     | Boredom, anger, drunkeness                                                                                                        | 2 | ⋯ | 1 |   2 | 5 |  580 | 500 | nan                   | 4 | 1 |  760 | 167                     |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋱ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| 3.5     | 2 | 1 | 265 | NaN | 420 | 2 | Doritos, mac and cheese, ice cream                                                                | Boredom, hunger, snacking.                                                         |  2 | ⋯ | 2 |   1 | 4 | 1165 | 690 | Wrestling                                                   | 4 | 2 | 1315 | 184 |\n",
       "| 3.92    | 2 | 1 | 430 |   3 | 420 | 2 | Ice cream, cake, pop, pizza, and milkshakes.                                                      | Happiness, sadness, celebration.                                                   |  7 | ⋯ | 1 |   2 | 3 |  725 | 500 | Soccer                                                      | 2 | 1 |  900 | 210 |\n",
       "| 3.9     | 1 | 1 | 720 |   3 | 420 | 2 | Mac and Cheese, Pizza, Ice Cream and French Fries                                                 | Boredom, anger and just being hungry in general.                                   |  2 | ⋯ | 1 |   1 | 3 | 1165 | 500 | Running                                                     | 5 | 2 |  760 | 155 |\n",
       "| 3.9     | 2 | 1 | 720 |   3 | 315 | 1 | Soup, pasta, cake                                                                                 | Depression, comfort, accessibility                                                 |  3 | ⋯ | 1 |   1 | 5 | 1165 | 690 | Tennis                                                      | 4 | 1 | 1315 | 185 |\n",
       "| 3.2     | 1 | 1 | 430 |   4 | 420 | 1 | mac &amp; cheese, frosted brownies, chicken nuggs                                                     | they are yummy, my boyfriend sometimes makes me sad, boredom                       |  3 | ⋯ | 1 |   1 | 1 | 1165 | 690 | softball                                                    | 5 | 1 |  900 | 165 |\n",
       "| 3.5     | 1 | 1 | 610 |   3 | NaN | 2 | watermelon, grapes, ice cream                                                                     | Sad, bored, excited                                                                |  3 | ⋯ | 1 |   1 | 5 |  NaN | 500 | Volleyball, Track                                           | 5 | 2 |  900 | 125 |\n",
       "| 3.4     | 1 | 1 | 610 | NaN | 420 | 2 | macaroni and cheese, stuffed peppers, hamburgers, french fries                                    | boredom, stress, mood swings                                                       |  2 | ⋯ | 1 |   2 | 3 | 1165 | 500 | nan                                                         | 5 | 2 | 1315 | 160 |\n",
       "| nan     | 1 | 1 | 610 |   4 | 420 | 2 | Pizza, mashed potatoes, spaghetti                                                                 | Anger, sadness                                                                     |  3 | ⋯ | 1 |   2 | 2 |  940 | 500 | nan                                                         | 5 | 1 |  900 | 135 |\n",
       "| 3.7     | 1 | 1 | 610 |   3 | 420 | 2 | dark chocolate, terra chips, reese's cups(dark chocolate), and bread/crackers with cottage cheese | Anxiousness, watching TV I desire \"comfort food\"                                   |  8 | ⋯ | 1 |   2 | 3 |  725 | 345 | When I can, rarely though play pool, darts, and basketball. | 5 | 1 |  760 | 130 |\n",
       "| Unknown | 1 | 1 | 720 |   3 | 420 | 2 | Chips, chocolate, ,mozzarella sticks                                                              | Boredom, sadness, anxiety                                                          |  2 | ⋯ | 2 |   2 | 5 |  940 | 690 | None at the moment                                          | 5 | 1 | 1315 | 230 |\n",
       "| 3       | 1 | 1 | 720 |   3 | 420 | 2 | ice cream, chips, candy                                                                           | Boredom, laziness, anger                                                           |  2 | ⋯ | 2 |   1 | 3 | 1165 | 690 | volleyball                                                  | 2 | 2 | 1315 | 125 |\n",
       "| 3       | 1 | 1 | 430 |   3 | 315 | 2 | Pizza, soda, chocolate brownie, chicken tikka masala and butter naan                              | Stress and sadness                                                                 | NA | ⋯ | 1 |   2 | 4 |  580 | 500 | None                                                        | 5 | 2 |  760 | 130 |\n",
       "| 3.8     | 1 | 1 | 430 |   3 | 420 | 1 | Chocolate, Pasta, Cookies                                                                         | I am always stressed out, and bored when I am in my apartment.                     | NA | ⋯ | 1 |   2 | 5 | 1165 | 690 | I used to play softball                                     | 4 | 2 |  900 | 165 |\n",
       "| 3.8     | 1 | 1 | 430 |   2 | 420 | 2 | Candy, salty snacks, toast                                                                        | Stress, sadness, boredom                                                           | NA | ⋯ | 1 |   1 | 2 |  580 | 345 | Ice hockey                                                  | 5 | 2 |  760 | 128 |\n",
       "| 3.4     | 1 | 1 | 610 |   3 | 420 | 2 | Mac in cheese, pizza, mozzarella sticks                                                           | Stress, frustration, self-consciousness                                            | NA | ⋯ | 1 |   2 | 2 |  940 | 690 | None                                                        | 3 | 1 | 1315 | 200 |\n",
       "| 3.7     | 1 | 1 | 610 |   3 | 315 | 1 | Ice-cream, pizza, chocolate                                                                       | Sadness and cravings                                                               | NA | ⋯ | 1 |   1 | 3 |  580 | 690 | Volleyball                                                  | 3 | 2 |  900 | 160 |\n",
       "| 2.9     | 2 | 1 | 265 |   2 | 980 | 2 | snacks, chips,                                                                                    | boredom                                                                            | NA | ⋯ | 1 |   2 | 1 |  725 | 345 | nan                                                         | 3 | 2 | 1315 | 170 |\n",
       "| 3.9     | 1 | 1 | 610 |   4 | 315 | 2 | Chocolate, Ice cream, pizza                                                                       | Sadness, happiness and boredom                                                     | NA | ⋯ | 1 |   2 | 5 |  725 | 500 | nan                                                         | 3 | 2 |  900 | 129 |\n",
       "| 3.6     | 1 | 1 | 430 |   2 | 420 | 1 | ice cream, pizza, Chinese food                                                                    | Boredom and sadness                                                                | NA | ⋯ | 1 |   2 | 2 | 1165 | 690 | None                                                        | 2 | 2 |  900 | 170 |\n",
       "| 2.8     | 2 | 1 | 610 |   3 | 315 | 2 | Burgers, indian and korean food                                                                   | sadness, happiness and hunger                                                      | NA | ⋯ | 1 |   1 | 5 |  940 | 850 | Tennis, Basketball                                          | 3 | 2 |  760 | 138 |\n",
       "| 3.3     | 2 | 1 | 610 |   4 | 980 | 2 | chocolate bar, ice cream, pretzels, potato chips and protein bars.                                | Stress, boredom and physical activity                                              | NA | ⋯ | 1 |   1 | 1 | 1165 | 690 | Hockey                                                      | 2 | 2 | 1315 | 150 |\n",
       "| 3.4     | 1 | 1 | 610 | NaN | 420 | 2 | Ice cream, chocolate, pizza, cucumber                                                             | loneliness, homework, boredom                                                      | NA | ⋯ | 1 |   2 | 5 |  725 | 345 | none                                                        | 5 | 1 | 1315 | 170 |\n",
       "| 3.77    | 1 | 1 | 610 | NaN | 315 | 2 | Noodle ( any kinds of noodle), Tuna sandwich, and Egg.                                            | When i'm  eating with my close friends/ Food smell or look good/ when I feel tired | NA | ⋯ | 1 |   2 | 5 |  725 | 690 | No, I don't play sport.                                     | 3 | 1 |  760 | 113 |\n",
       "| 3.63    | 1 | 1 | 430 |   3 | 420 | 1 | Chinese, chips, cake                                                                              | Stress and boredom                                                                 | NA | ⋯ | 1 |   2 | 4 |  940 | 345 | None                                                        | 5 | 2 | 1315 | 140 |\n",
       "| 3.2     | 2 | 1 | 610 |   3 | 420 | 2 | chips, rice, chicken curry,                                                                       | Happiness, boredom, social event                                                   | NA | ⋯ | 1 |   1 | 5 | 1165 | 690 | Soccer                                                      | 5 | 2 | 1315 | 185 |\n",
       "| 3.5     | 1 | 1 | 610 |   4 | 420 | 2 | wine. mac and cheese, pizza, ice cream                                                            | boredom and sadness                                                                | NA | ⋯ | 1 |   1 | 5 |  940 | 500 | Softball                                                    | 5 | 1 | 1315 | 156 |\n",
       "| 3       | 1 | 1 | 265 |   2 | 315 | 2 | Pizza / Wings / Cheesecake                                                                        | Loneliness / Homesick / Sadness                                                    | NA | ⋯ | 1 | NaN | 4 |  940 | 500 | basketball                                                  | 5 | 2 | 1315 | 180 |\n",
       "| 3.882   | 1 | 1 | 720 | NaN | 420 | 1 | rice, potato, seaweed soup                                                                        | sadness                                                                            | NA | ⋯ | 1 |   2 | 5 |  580 | 690 | none                                                        | 4 | 2 | 1315 | 120 |\n",
       "| 3       | 2 | 1 | 720 |   4 | 420 | 1 | Mac n Cheese, Lasagna, Pizza                                                                      | happiness, they are some of my favorite foods                                      | NA | ⋯ | 2 |   2 | 1 |  940 | 500 | nan                                                         | 3 | 1 | 1315 | 135 |\n",
       "| 3.9     | 1 | 1 | 430 | NaN | 315 | 2 | Chocolates, pizza, and Ritz.                                                                      | hormones, Premenstrual syndrome.                                                   | NA | ⋯ | 1 |   2 | 2 |  725 | 345 | nan                                                         | 4 | 2 |  575 | 135 |\n",
       "\n"
      ],
      "text/plain": [
       "    GPA     Gender breakfast calories_chicken calories_day calories_scone\n",
       "1   2.4     2      1         430              NaN          315           \n",
       "2   3.654   1      1         610                3          420           \n",
       "3   3.3     1      1         720                4          420           \n",
       "4   3.2     1      1         430                3          420           \n",
       "5   3.5     1      1         720                2          420           \n",
       "6   2.25    1      1         610                3          980           \n",
       "7   3.8     2      1         610                3          420           \n",
       "8   3.3     1      1         720                3          420           \n",
       "9   3.3     1      1         430              NaN          420           \n",
       "10  3.3     1      1         430                3          315           \n",
       "11  3.5     1      1         610                3          980           \n",
       "12  3.904   1      1         720                4          420           \n",
       "13  3.4     2      1         430                3          420           \n",
       "14  3.6     1      1         610                3          420           \n",
       "15  3.1     2      1         610                3          420           \n",
       "16  nan     2      2         430              NaN          980           \n",
       "17  4       1      1         265                3          420           \n",
       "18  3.6     2      1         430                3          980           \n",
       "19  3.4     1      1         720                3          980           \n",
       "20  2.2     2      1         430                2          420           \n",
       "21  3.3     2      1         610                3          980           \n",
       "22  3.87    2      1         610                3          315           \n",
       "23  3.7     2      1         610                3          420           \n",
       "24  3.7     2      2         610                3          420           \n",
       "25  3.9     1      1         720                2          420           \n",
       "26  2.8     1      2         720                3          420           \n",
       "27  3.7     2      1         610                2          420           \n",
       "28  3       2      1         610                4          980           \n",
       "29  3.2     2      1         610                2          420           \n",
       "30  3.5     2      1         265                2          420           \n",
       "⋮   ⋮       ⋮      ⋮         ⋮                ⋮            ⋮             \n",
       "96  3.5     2      1         265              NaN          420           \n",
       "97  3.92    2      1         430                3          420           \n",
       "98  3.9     1      1         720                3          420           \n",
       "99  3.9     2      1         720                3          315           \n",
       "100 3.2     1      1         430                4          420           \n",
       "101 3.5     1      1         610                3          NaN           \n",
       "102 3.4     1      1         610              NaN          420           \n",
       "103 nan     1      1         610                4          420           \n",
       "104 3.7     1      1         610                3          420           \n",
       "105 Unknown 1      1         720                3          420           \n",
       "106 3       1      1         720                3          420           \n",
       "107 3       1      1         430                3          315           \n",
       "108 3.8     1      1         430                3          420           \n",
       "109 3.8     1      1         430                2          420           \n",
       "110 3.4     1      1         610                3          420           \n",
       "111 3.7     1      1         610                3          315           \n",
       "112 2.9     2      1         265                2          980           \n",
       "113 3.9     1      1         610                4          315           \n",
       "114 3.6     1      1         430                2          420           \n",
       "115 2.8     2      1         610                3          315           \n",
       "116 3.3     2      1         610                4          980           \n",
       "117 3.4     1      1         610              NaN          420           \n",
       "118 3.77    1      1         610              NaN          315           \n",
       "119 3.63    1      1         430                3          420           \n",
       "120 3.2     2      1         610                3          420           \n",
       "121 3.5     1      1         610                4          420           \n",
       "122 3       1      1         265                2          315           \n",
       "123 3.882   1      1         720              NaN          420           \n",
       "124 3       2      1         720                4          420           \n",
       "125 3.9     1      1         430              NaN          315           \n",
       "    coffee\n",
       "1   1     \n",
       "2   2     \n",
       "3   2     \n",
       "4   2     \n",
       "5   2     \n",
       "6   2     \n",
       "7   2     \n",
       "8   1     \n",
       "9   1     \n",
       "10  2     \n",
       "11  2     \n",
       "12  2     \n",
       "13  2     \n",
       "14  2     \n",
       "15  2     \n",
       "16  2     \n",
       "17  1     \n",
       "18  2     \n",
       "19  1     \n",
       "20  2     \n",
       "21  2     \n",
       "22  1     \n",
       "23  1     \n",
       "24  2     \n",
       "25  2     \n",
       "26  2     \n",
       "27  1     \n",
       "28  2     \n",
       "29  2     \n",
       "30  2     \n",
       "⋮   ⋮     \n",
       "96  2     \n",
       "97  2     \n",
       "98  2     \n",
       "99  1     \n",
       "100 1     \n",
       "101 2     \n",
       "102 2     \n",
       "103 2     \n",
       "104 2     \n",
       "105 2     \n",
       "106 2     \n",
       "107 2     \n",
       "108 1     \n",
       "109 2     \n",
       "110 2     \n",
       "111 1     \n",
       "112 2     \n",
       "113 2     \n",
       "114 1     \n",
       "115 2     \n",
       "116 2     \n",
       "117 2     \n",
       "118 2     \n",
       "119 1     \n",
       "120 2     \n",
       "121 2     \n",
       "122 2     \n",
       "123 1     \n",
       "124 1     \n",
       "125 2     \n",
       "    comfort_food                                                                                     \n",
       "1   none                                                                                             \n",
       "2   chocolate, chips, ice cream                                                                      \n",
       "3   frozen yogurt, pizza, fast food                                                                  \n",
       "4   Pizza, Mac and cheese, ice cream                                                                 \n",
       "5   Ice cream, chocolate, chips                                                                      \n",
       "6   Candy, brownies and soda.                                                                        \n",
       "7   Chocolate, ice cream, french fries, pretzels                                                     \n",
       "8   Ice cream, cheeseburgers, chips.                                                                 \n",
       "9   Donuts, ice cream, chips                                                                         \n",
       "10  Mac and cheese, chocolate, and pasta                                                             \n",
       "11  Pasta, grandma homemade chocolate cake anything homemade                                         \n",
       "12  chocolate, pasta, soup, chips, popcorn                                                           \n",
       "13  Cookies, popcorn, and chips                                                                      \n",
       "14  ice cream, cake, chocolate                                                                       \n",
       "15  Pizza, fruit, spaghetti, chicken and Potatoes                                                    \n",
       "16  cookies, donuts, candy bars                                                                      \n",
       "17  Saltfish, Candy and Kit Kat                                                                      \n",
       "18  chips, cookies, ice cream                                                                        \n",
       "19  Chocolate, ice crea                                                                              \n",
       "20  pizza, wings, Chinese                                                                            \n",
       "21  Fast food, pizza, subs                                                                           \n",
       "22  chocolate, sweets, ice cream                                                                     \n",
       "23  burgers, chips, cookies                                                                          \n",
       "24  Chilli, soup, pot pie                                                                            \n",
       "25  Soup, pasta, brownies, cake                                                                      \n",
       "26  chocolate, ice cream/milkshake, cookies                                                          \n",
       "27  Chips, ice cream, microwaveable foods                                                            \n",
       "28  Chicken fingers, pizza                                                                           \n",
       "29  cookies, hot chocolate, beef jerky                                                               \n",
       "30  Tomato soup, pizza, Fritos, Meatball sub, Dr. Pepper                                             \n",
       "⋮   ⋮                                                                                                \n",
       "96  Doritos, mac and cheese, ice cream                                                               \n",
       "97  Ice cream, cake, pop, pizza, and milkshakes.                                                     \n",
       "98  Mac and Cheese, Pizza, Ice Cream and French Fries                                                \n",
       "99  Soup, pasta, cake                                                                                \n",
       "100 mac & cheese, frosted brownies, chicken nuggs                                                    \n",
       "101 watermelon, grapes, ice cream                                                                    \n",
       "102 macaroni and cheese, stuffed peppers, hamburgers, french fries                                   \n",
       "103 Pizza, mashed potatoes, spaghetti                                                                \n",
       "104 dark chocolate, terra chips, reese's cups(dark chocolate), and bread/crackers with cottage cheese\n",
       "105 Chips, chocolate, ,mozzarella sticks                                                             \n",
       "106 ice cream, chips, candy                                                                          \n",
       "107 Pizza, soda, chocolate brownie, chicken tikka masala and butter naan                             \n",
       "108 Chocolate, Pasta, Cookies                                                                        \n",
       "109 Candy, salty snacks, toast                                                                       \n",
       "110 Mac in cheese, pizza, mozzarella sticks                                                          \n",
       "111 Ice-cream, pizza, chocolate                                                                      \n",
       "112 snacks, chips,                                                                                   \n",
       "113 Chocolate, Ice cream, pizza                                                                      \n",
       "114 ice cream, pizza, Chinese food                                                                   \n",
       "115 Burgers, indian and korean food                                                                  \n",
       "116 chocolate bar, ice cream, pretzels, potato chips and protein bars.                               \n",
       "117 Ice cream, chocolate, pizza, cucumber                                                            \n",
       "118 Noodle ( any kinds of noodle), Tuna sandwich, and Egg.                                           \n",
       "119 Chinese, chips, cake                                                                             \n",
       "120 chips, rice, chicken curry,                                                                      \n",
       "121 wine. mac and cheese, pizza, ice cream                                                           \n",
       "122 Pizza / Wings / Cheesecake                                                                       \n",
       "123 rice, potato, seaweed soup                                                                       \n",
       "124 Mac n Cheese, Lasagna, Pizza                                                                     \n",
       "125 Chocolates, pizza, and Ritz.                                                                     \n",
       "    comfort_food_reasons                                                                                                             \n",
       "1   we dont have comfort                                                                                                             \n",
       "2   Stress, bored, anger                                                                                                             \n",
       "3   stress, sadness                                                                                                                  \n",
       "4   Boredom                                                                                                                          \n",
       "5   Stress, boredom, cravings                                                                                                        \n",
       "6   None, i don't eat comfort food. I just eat when i'm hungry.                                                                      \n",
       "7   stress, boredom                                                                                                                  \n",
       "8   I eat comfort food when im stressed out from school(finals week), when I`m sad, or when i am dealing with personal family issues.\n",
       "9   Boredom                                                                                                                          \n",
       "10  Stress, anger and sadness                                                                                                        \n",
       "11  Boredom                                                                                                                          \n",
       "12  sadness, stress, cold weather                                                                                                    \n",
       "13  Sadness, boredom, late night snack                                                                                               \n",
       "14  stress,  boredom, special occasions                                                                                              \n",
       "15  Friends, environment and boredom                                                                                                 \n",
       "16  boredom                                                                                                                          \n",
       "17  Stress                                                                                                                           \n",
       "18  I usually only eat comfort food when I'm bored, if i am doing something, i can go for hours without eating                       \n",
       "19  Sadness, stress                                                                                                                  \n",
       "20  boredom, sadness, hungry                                                                                                         \n",
       "21  happiness, satisfaction                                                                                                          \n",
       "22  Mostly boredom                                                                                                                   \n",
       "23  sadness, depression                                                                                                              \n",
       "24  Stress and boredom                                                                                                               \n",
       "25  A long day, not feeling well, winter                                                                                             \n",
       "26  boredom                                                                                                                          \n",
       "27  Boredom, lazyniss                                                                                                                \n",
       "28  Boredom                                                                                                                          \n",
       "29  survival, bored                                                                                                                  \n",
       "30  Boredom, anger, drunkeness                                                                                                       \n",
       "⋮   ⋮                                                                                                                                \n",
       "96  Boredom, hunger, snacking.                                                                                                       \n",
       "97  Happiness, sadness, celebration.                                                                                                 \n",
       "98  Boredom, anger and just being hungry in general.                                                                                 \n",
       "99  Depression, comfort, accessibility                                                                                               \n",
       "100 they are yummy, my boyfriend sometimes makes me sad, boredom                                                                     \n",
       "101 Sad, bored, excited                                                                                                              \n",
       "102 boredom, stress, mood swings                                                                                                     \n",
       "103 Anger, sadness                                                                                                                   \n",
       "104 Anxiousness, watching TV I desire \"comfort food\"                                                                                 \n",
       "105 Boredom, sadness, anxiety                                                                                                        \n",
       "106 Boredom, laziness, anger                                                                                                         \n",
       "107 Stress and sadness                                                                                                               \n",
       "108 I am always stressed out, and bored when I am in my apartment.                                                                   \n",
       "109 Stress, sadness, boredom                                                                                                         \n",
       "110 Stress, frustration, self-consciousness                                                                                          \n",
       "111 Sadness and cravings                                                                                                             \n",
       "112 boredom                                                                                                                          \n",
       "113 Sadness, happiness and boredom                                                                                                   \n",
       "114 Boredom and sadness                                                                                                              \n",
       "115 sadness, happiness and hunger                                                                                                    \n",
       "116 Stress, boredom and physical activity                                                                                            \n",
       "117 loneliness, homework, boredom                                                                                                    \n",
       "118 When i'm  eating with my close friends/ Food smell or look good/ when I feel tired                                               \n",
       "119 Stress and boredom                                                                                                               \n",
       "120 Happiness, boredom, social event                                                                                                 \n",
       "121 boredom and sadness                                                                                                              \n",
       "122 Loneliness / Homesick / Sadness                                                                                                  \n",
       "123 sadness                                                                                                                          \n",
       "124 happiness, they are some of my favorite foods                                                                                    \n",
       "125 hormones, Premenstrual syndrome.                                                                                                 \n",
       "    comfort_food_reasons_coded...10 ⋯ soup sports thai_food tortilla_calories\n",
       "1   9                               ⋯ 1      1    1         1165             \n",
       "2   1                               ⋯ 1      1    2          725             \n",
       "3   1                               ⋯ 1      2    5         1165             \n",
       "4   2                               ⋯ 1      2    5          725             \n",
       "5   1                               ⋯ 1      1    4          940             \n",
       "6   4                               ⋯ 1      2    4          940             \n",
       "7   1                               ⋯ 1      1    5          940             \n",
       "8   1                               ⋯ 1      2    1          725             \n",
       "9   2                               ⋯ 2      2    5          725             \n",
       "10  1                               ⋯ 1      1    4          580             \n",
       "11  2                               ⋯ 1      1    2          940             \n",
       "12  3                               ⋯ 1      1    5          940             \n",
       "13  3                               ⋯ 2      1    3          940             \n",
       "14  1                               ⋯ 1      1    5         1165             \n",
       "15  2                               ⋯ 1      1    4          940             \n",
       "16  2                               ⋯ 2      1    1          940             \n",
       "17  1                               ⋯ 1      2    1          580             \n",
       "18  2                               ⋯ 1      1    3          940             \n",
       "19  3                               ⋯ 2      2    1         1165             \n",
       "20  2                               ⋯ 1    NaN    3          940             \n",
       "21  7                               ⋯ 1      1    1         1165             \n",
       "22  2                               ⋯ 2      1    5          725             \n",
       "23  3                               ⋯ 1      1    4          940             \n",
       "24  1                               ⋯ 1      1    4          940             \n",
       "25  6                               ⋯ 2      2    4          940             \n",
       "26  2                               ⋯ 1      1    3         1165             \n",
       "27  2                               ⋯ 2      1    2         1165             \n",
       "28  2                               ⋯ 1      1    3         1165             \n",
       "29  2                               ⋯ 1      2    1          940             \n",
       "30  2                               ⋯ 1      2    5          580             \n",
       "⋮   ⋮                               ⋱ ⋮    ⋮      ⋮         ⋮                \n",
       "96   2                              ⋯ 2      1    4         1165             \n",
       "97   7                              ⋯ 1      2    3          725             \n",
       "98   2                              ⋯ 1      1    3         1165             \n",
       "99   3                              ⋯ 1      1    5         1165             \n",
       "100  3                              ⋯ 1      1    1         1165             \n",
       "101  3                              ⋯ 1      1    5          NaN             \n",
       "102  2                              ⋯ 1      2    3         1165             \n",
       "103  3                              ⋯ 1      2    2          940             \n",
       "104  8                              ⋯ 1      2    3          725             \n",
       "105  2                              ⋯ 2      2    5          940             \n",
       "106  2                              ⋯ 2      1    3         1165             \n",
       "107 NA                              ⋯ 1      2    4          580             \n",
       "108 NA                              ⋯ 1      2    5         1165             \n",
       "109 NA                              ⋯ 1      1    2          580             \n",
       "110 NA                              ⋯ 1      2    2          940             \n",
       "111 NA                              ⋯ 1      1    3          580             \n",
       "112 NA                              ⋯ 1      2    1          725             \n",
       "113 NA                              ⋯ 1      2    5          725             \n",
       "114 NA                              ⋯ 1      2    2         1165             \n",
       "115 NA                              ⋯ 1      1    5          940             \n",
       "116 NA                              ⋯ 1      1    1         1165             \n",
       "117 NA                              ⋯ 1      2    5          725             \n",
       "118 NA                              ⋯ 1      2    5          725             \n",
       "119 NA                              ⋯ 1      2    4          940             \n",
       "120 NA                              ⋯ 1      1    5         1165             \n",
       "121 NA                              ⋯ 1      1    5          940             \n",
       "122 NA                              ⋯ 1    NaN    4          940             \n",
       "123 NA                              ⋯ 1      2    5          580             \n",
       "124 NA                              ⋯ 2      2    1          940             \n",
       "125 NA                              ⋯ 1      2    2          725             \n",
       "    turkey_calories type_sports                                                \n",
       "1   345             car racing                                                 \n",
       "2   690             Basketball                                                 \n",
       "3   500             none                                                       \n",
       "4   690             nan                                                        \n",
       "5   500             Softball                                                   \n",
       "6   345             None.                                                      \n",
       "7   690             soccer                                                     \n",
       "8   500             none                                                       \n",
       "9   345             none                                                       \n",
       "10  345             field hockey                                               \n",
       "11  345             soccer                                                     \n",
       "12  500             Running                                                    \n",
       "13  500             Soccer and basketball                                      \n",
       "14  850             intramural volleyball                                      \n",
       "15  500             Hockey                                                     \n",
       "16  345             Hockey                                                     \n",
       "17  345             nan                                                        \n",
       "18  500             hockey                                                     \n",
       "19  690             dancing                                                    \n",
       "20  345             basketball                                                 \n",
       "21  850             Soccer                                                     \n",
       "22  500             Tennis                                                     \n",
       "23  850             tennis soccer gym                                          \n",
       "24  690             Gaelic Football                                            \n",
       "25  500             none                                                       \n",
       "26  690             Ice hockey                                                 \n",
       "27  850             Hockey                                                     \n",
       "28  500             Lacrosse                                                   \n",
       "29  500             nan                                                        \n",
       "30  500             nan                                                        \n",
       "⋮   ⋮               ⋮                                                          \n",
       "96  690             Wrestling                                                  \n",
       "97  500             Soccer                                                     \n",
       "98  500             Running                                                    \n",
       "99  690             Tennis                                                     \n",
       "100 690             softball                                                   \n",
       "101 500             Volleyball, Track                                          \n",
       "102 500             nan                                                        \n",
       "103 500             nan                                                        \n",
       "104 345             When I can, rarely though play pool, darts, and basketball.\n",
       "105 690             None at the moment                                         \n",
       "106 690             volleyball                                                 \n",
       "107 500             None                                                       \n",
       "108 690             I used to play softball                                    \n",
       "109 345             Ice hockey                                                 \n",
       "110 690             None                                                       \n",
       "111 690             Volleyball                                                 \n",
       "112 345             nan                                                        \n",
       "113 500             nan                                                        \n",
       "114 690             None                                                       \n",
       "115 850             Tennis, Basketball                                         \n",
       "116 690             Hockey                                                     \n",
       "117 345             none                                                       \n",
       "118 690             No, I don't play sport.                                    \n",
       "119 345             None                                                       \n",
       "120 690             Soccer                                                     \n",
       "121 500             Softball                                                   \n",
       "122 500             basketball                                                 \n",
       "123 690             none                                                       \n",
       "124 500             nan                                                        \n",
       "125 345             nan                                                        \n",
       "    veggies_day vitamins waffle_calories weight                 \n",
       "1   5           1        1315            187                    \n",
       "2   4           2         900            155                    \n",
       "3   5           1         900            I'm not answering this.\n",
       "4   3           1        1315            Not sure, 240          \n",
       "5   4           2         760            190                    \n",
       "6   1           2        1315            190                    \n",
       "7   4           1        1315            180                    \n",
       "8   4           2        1315            137                    \n",
       "9   3           2         760            180                    \n",
       "10  5           1         900            125                    \n",
       "11  5           2         900            116                    \n",
       "12  5           1         900            110                    \n",
       "13  3           2         575            264                    \n",
       "14  5           2        1315            123                    \n",
       "15  5           1         900            185                    \n",
       "16  1           2        1315            180                    \n",
       "17  5           1         760            145                    \n",
       "18  4           2         900            170                    \n",
       "19  5           1        1315            135                    \n",
       "20  2           2         900            165                    \n",
       "21  3           2        1315            175                    \n",
       "22  2           2         900            195                    \n",
       "23  3           1        1315            185                    \n",
       "24  4           1        1315            185                    \n",
       "25  4           2        1315            105                    \n",
       "26  3           2         760            125                    \n",
       "27  3           2        1315            160                    \n",
       "28  5           1        1315            175                    \n",
       "29  2           1        1315            180                    \n",
       "30  4           1         760            167                    \n",
       "⋮   ⋮           ⋮        ⋮               ⋮                      \n",
       "96  4           2        1315            184                    \n",
       "97  2           1         900            210                    \n",
       "98  5           2         760            155                    \n",
       "99  4           1        1315            185                    \n",
       "100 5           1         900            165                    \n",
       "101 5           2         900            125                    \n",
       "102 5           2        1315            160                    \n",
       "103 5           1         900            135                    \n",
       "104 5           1         760            130                    \n",
       "105 5           1        1315            230                    \n",
       "106 2           2        1315            125                    \n",
       "107 5           2         760            130                    \n",
       "108 4           2         900            165                    \n",
       "109 5           2         760            128                    \n",
       "110 3           1        1315            200                    \n",
       "111 3           2         900            160                    \n",
       "112 3           2        1315            170                    \n",
       "113 3           2         900            129                    \n",
       "114 2           2         900            170                    \n",
       "115 3           2         760            138                    \n",
       "116 2           2        1315            150                    \n",
       "117 5           1        1315            170                    \n",
       "118 3           1         760            113                    \n",
       "119 5           2        1315            140                    \n",
       "120 5           2        1315            185                    \n",
       "121 5           1        1315            156                    \n",
       "122 5           2        1315            180                    \n",
       "123 4           2        1315            120                    \n",
       "124 3           1        1315            135                    \n",
       "125 4           2         575            135                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Your turn!\n",
    "\n",
    "# To give you practice reading in files, I've added a second dataset to this notebook\n",
    "# as well. This dataset is in the following place: ../input/food-choices/food_coded.csv\n",
    "\n",
    "# read in your dataset and save it as a variable called \"foodPreferences\"\n",
    "foodPreferences <- read_csv(\"../input/food-choices/food_coded.csv\")\n",
    "\n",
    "foodPreferences\n",
    "# looks like the spaces are already dealt with, so I won't do anything for that?\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e9cea227",
   "metadata": {
    "_cell_guid": "f5056892-414e-481c-be1e-6c865010a25a",
    "_uuid": "dad981a3709f79829b3a35d47f56f0809ad21b93",
    "papermill": {
     "duration": 0.019801,
     "end_time": "2024-01-26T23:33:24.253275",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.233474",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Look at the data we've read in"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "06d2ec31",
   "metadata": {
    "_cell_guid": "61b890e9-8de5-4f40-99dd-6284ddc4d195",
    "_uuid": "41c19197dfb5d784e9fa254bc4be1d33ad885c2a",
    "papermill": {
     "duration": 0.018707,
     "end_time": "2024-01-26T23:33:24.291309",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.272602",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Congrats, you've gotten some data into R! Now we want to make sure that it all read in correctly, and get an idea of what's in our data file."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "ffede347",
   "metadata": {
    "_cell_guid": "b71e609c-b4de-4358-9d03-26d91bd36178",
    "_uuid": "391c8ff8aea3fb1dfb05be82553f89a99002104f",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:24.333809Z",
     "iopub.status.busy": "2024-01-26T23:33:24.331869Z",
     "iopub.status.idle": "2024-01-26T23:33:24.410735Z",
     "shell.execute_reply": "2024-01-26T23:33:24.408148Z"
    },
    "papermill": {
     "duration": 0.103934,
     "end_time": "2024-01-26T23:33:24.414239",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.310305",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Agua Grande</td><td>1876</td><td>2016</td><td>63%</td><td>France</td><td>3.75</td><td>       </td><td>Sao Tome </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Kpime      </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>2.75</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Atsane     </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>3.00</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Akata      </td><td>1680</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Quilla     </td><td>1704</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Peru     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Carenero   </td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Agua Grande & 1876 & 2016 & 63\\% & France & 3.75 &         & Sao Tome \\\\\n",
       "\t A. Morin & Kpime       & 1676 & 2015 & 70\\% & France & 2.75 &         & Togo     \\\\\n",
       "\t A. Morin & Atsane      & 1676 & 2015 & 70\\% & France & 3.00 &         & Togo     \\\\\n",
       "\t A. Morin & Akata       & 1680 & 2015 & 70\\% & France & 3.50 &         & Togo     \\\\\n",
       "\t A. Morin & Quilla      & 1704 & 2015 & 70\\% & France & 3.50 &         & Peru     \\\\\n",
       "\t A. Morin & Carenero    & 1315 & 2014 & 70\\% & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Agua Grande | 1876 | 2016 | 63% | France | 3.75 |         | Sao Tome  |\n",
       "| A. Morin | Kpime       | 1676 | 2015 | 70% | France | 2.75 |         | Togo      |\n",
       "| A. Morin | Atsane      | 1676 | 2015 | 70% | France | 3.00 |         | Togo      |\n",
       "| A. Morin | Akata       | 1680 | 2015 | 70% | France | 3.50 |         | Togo      |\n",
       "| A. Morin | Quilla      | 1704 | 2015 | 70% | France | 3.50 |         | Peru      |\n",
       "| A. Morin | Carenero    | 1315 | 2014 | 70% | France | 2.75 | Criollo | Venezuela |\n",
       "\n"
      ],
      "text/plain": [
       "  Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name REF  Review.Date\n",
       "1 A. Morin                  Agua Grande                      1876 2016       \n",
       "2 A. Morin                  Kpime                            1676 2015       \n",
       "3 A. Morin                  Atsane                           1676 2015       \n",
       "4 A. Morin                  Akata                            1680 2015       \n",
       "5 A. Morin                  Quilla                           1704 2015       \n",
       "6 A. Morin                  Carenero                         1315 2014       \n",
       "  Cocoa.Percent Company.Location Rating Bean.Type Broad.Bean.Origin\n",
       "1 63%           France           3.75             Sao Tome         \n",
       "2 70%           France           2.75             Togo             \n",
       "3 70%           France           3.00             Togo             \n",
       "4 70%           France           3.50             Togo             \n",
       "5 70%           France           3.50             Peru             \n",
       "6 70%           France           2.75   Criollo   Venezuela        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 3 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Zotter</td><td>Kerala State      </td><td>749</td><td>2011</td><td>65%</td><td>Austria</td><td>3.50</td><td>Forastero</td><td>India </td></tr>\n",
       "\t<tr><td>Zotter</td><td>Kerala State      </td><td>781</td><td>2011</td><td>62%</td><td>Austria</td><td>3.25</td><td>         </td><td>India </td></tr>\n",
       "\t<tr><td>Zotter</td><td>Brazil, Mitzi Blue</td><td>486</td><td>2010</td><td>65%</td><td>Austria</td><td>3.00</td><td>         </td><td>Brazil</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 3 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t Zotter & Kerala State       & 749 & 2011 & 65\\% & Austria & 3.50 & Forastero & India \\\\\n",
       "\t Zotter & Kerala State       & 781 & 2011 & 62\\% & Austria & 3.25 &           & India \\\\\n",
       "\t Zotter & Brazil, Mitzi Blue & 486 & 2010 & 65\\% & Austria & 3.00 &           & Brazil\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 3 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| Zotter | Kerala State       | 749 | 2011 | 65% | Austria | 3.50 | Forastero | India  |\n",
       "| Zotter | Kerala State       | 781 | 2011 | 62% | Austria | 3.25 |           | India  |\n",
       "| Zotter | Brazil, Mitzi Blue | 486 | 2010 | 65% | Austria | 3.00 |           | Brazil |\n",
       "\n"
      ],
      "text/plain": [
       "  Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name REF Review.Date\n",
       "1 Zotter                    Kerala State                     749 2011       \n",
       "2 Zotter                    Kerala State                     781 2011       \n",
       "3 Zotter                    Brazil, Mitzi Blue               486 2010       \n",
       "  Cocoa.Percent Company.Location Rating Bean.Type Broad.Bean.Origin\n",
       "1 65%           Austria          3.50   Forastero India            \n",
       "2 62%           Austria          3.25             India            \n",
       "3 65%           Austria          3.00             Brazil           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# the head() function reads just the first few lines of a file. \n",
    "head(chocolateData)\n",
    "\n",
    "# the tail() function reads in the just the last few lines of a file. \n",
    "# we can also give both functions a specific number of lines to read.\n",
    "# This line will read in the last three lines of \"chocolateData\".\n",
    "tail(chocolateData, 3)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "c8efb074",
   "metadata": {
    "_cell_guid": "bcbda527-f15c-4ed0-b82f-8a9ec1a4557e",
    "_uuid": "6b4bad60d896250123b6985140efc7f9ba5cd2c0",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:24.456019Z",
     "iopub.status.busy": "2024-01-26T23:33:24.454227Z",
     "iopub.status.idle": "2024-01-26T23:33:24.626670Z",
     "shell.execute_reply": "2024-01-26T23:33:24.623621Z"
    },
    "papermill": {
     "duration": 0.196936,
     "end_time": "2024-01-26T23:33:24.630284",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.433348",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 61</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>GPA</th><th scope=col>Gender</th><th scope=col>breakfast</th><th scope=col>calories_chicken</th><th scope=col>calories_day</th><th scope=col>calories_scone</th><th scope=col>coffee</th><th scope=col>comfort_food</th><th scope=col>comfort_food_reasons</th><th scope=col>comfort_food_reasons_coded...10</th><th scope=col>⋯</th><th scope=col>soup</th><th scope=col>sports</th><th scope=col>thai_food</th><th scope=col>tortilla_calories</th><th scope=col>turkey_calories</th><th scope=col>type_sports</th><th scope=col>veggies_day</th><th scope=col>vitamins</th><th scope=col>waffle_calories</th><th scope=col>weight</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2.4  </td><td>2</td><td>1</td><td>430</td><td>NaN</td><td>315</td><td>1</td><td>none                            </td><td>we dont have comfort                                       </td><td>9</td><td>⋯</td><td>1</td><td>1</td><td>1</td><td>1165</td><td>345</td><td>car racing</td><td>5</td><td>1</td><td>1315</td><td>187                    </td></tr>\n",
       "\t<tr><td>3.654</td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>chocolate, chips, ice cream     </td><td>Stress, bored, anger                                       </td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>2</td><td> 725</td><td>690</td><td>Basketball</td><td>4</td><td>2</td><td> 900</td><td>155                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>720</td><td>  4</td><td>420</td><td>2</td><td>frozen yogurt, pizza, fast food </td><td>stress, sadness                                            </td><td>1</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td>1165</td><td>500</td><td>none      </td><td>5</td><td>1</td><td> 900</td><td>I'm not answering this.</td></tr>\n",
       "\t<tr><td>3.2  </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>2</td><td>Pizza, Mac and cheese, ice cream</td><td>Boredom                                                    </td><td>2</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td> 725</td><td>690</td><td>nan       </td><td>3</td><td>1</td><td>1315</td><td>Not sure, 240          </td></tr>\n",
       "\t<tr><td>3.5  </td><td>1</td><td>1</td><td>720</td><td>  2</td><td>420</td><td>2</td><td>Ice cream, chocolate, chips     </td><td>Stress, boredom, cravings                                  </td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>4</td><td> 940</td><td>500</td><td>Softball  </td><td>4</td><td>2</td><td> 760</td><td>190                    </td></tr>\n",
       "\t<tr><td>2.25 </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>980</td><td>2</td><td>Candy, brownies and soda.       </td><td>None, i don't eat comfort food. I just eat when i'm hungry.</td><td>4</td><td>⋯</td><td>1</td><td>2</td><td>4</td><td> 940</td><td>345</td><td>None.     </td><td>1</td><td>2</td><td>1315</td><td>190                    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 61\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " GPA & Gender & breakfast & calories\\_chicken & calories\\_day & calories\\_scone & coffee & comfort\\_food & comfort\\_food\\_reasons & comfort\\_food\\_reasons\\_coded...10 & ⋯ & soup & sports & thai\\_food & tortilla\\_calories & turkey\\_calories & type\\_sports & veggies\\_day & vitamins & waffle\\_calories & weight\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2.4   & 2 & 1 & 430 & NaN & 315 & 1 & none                             & we dont have comfort                                        & 9 & ⋯ & 1 & 1 & 1 & 1165 & 345 & car racing & 5 & 1 & 1315 & 187                    \\\\\n",
       "\t 3.654 & 1 & 1 & 610 &   3 & 420 & 2 & chocolate, chips, ice cream      & Stress, bored, anger                                        & 1 & ⋯ & 1 & 1 & 2 &  725 & 690 & Basketball & 4 & 2 &  900 & 155                    \\\\\n",
       "\t 3.3   & 1 & 1 & 720 &   4 & 420 & 2 & frozen yogurt, pizza, fast food  & stress, sadness                                             & 1 & ⋯ & 1 & 2 & 5 & 1165 & 500 & none       & 5 & 1 &  900 & I'm not answering this.\\\\\n",
       "\t 3.2   & 1 & 1 & 430 &   3 & 420 & 2 & Pizza, Mac and cheese, ice cream & Boredom                                                     & 2 & ⋯ & 1 & 2 & 5 &  725 & 690 & nan        & 3 & 1 & 1315 & Not sure, 240          \\\\\n",
       "\t 3.5   & 1 & 1 & 720 &   2 & 420 & 2 & Ice cream, chocolate, chips      & Stress, boredom, cravings                                   & 1 & ⋯ & 1 & 1 & 4 &  940 & 500 & Softball   & 4 & 2 &  760 & 190                    \\\\\n",
       "\t 2.25  & 1 & 1 & 610 &   3 & 980 & 2 & Candy, brownies and soda.        & None, i don't eat comfort food. I just eat when i'm hungry. & 4 & ⋯ & 1 & 2 & 4 &  940 & 345 & None.      & 1 & 2 & 1315 & 190                    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 61\n",
       "\n",
       "| GPA &lt;chr&gt; | Gender &lt;dbl&gt; | breakfast &lt;dbl&gt; | calories_chicken &lt;dbl&gt; | calories_day &lt;dbl&gt; | calories_scone &lt;dbl&gt; | coffee &lt;dbl&gt; | comfort_food &lt;chr&gt; | comfort_food_reasons &lt;chr&gt; | comfort_food_reasons_coded...10 &lt;dbl&gt; | ⋯ ⋯ | soup &lt;dbl&gt; | sports &lt;dbl&gt; | thai_food &lt;dbl&gt; | tortilla_calories &lt;dbl&gt; | turkey_calories &lt;dbl&gt; | type_sports &lt;chr&gt; | veggies_day &lt;dbl&gt; | vitamins &lt;dbl&gt; | waffle_calories &lt;dbl&gt; | weight &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2.4   | 2 | 1 | 430 | NaN | 315 | 1 | none                             | we dont have comfort                                        | 9 | ⋯ | 1 | 1 | 1 | 1165 | 345 | car racing | 5 | 1 | 1315 | 187                     |\n",
       "| 3.654 | 1 | 1 | 610 |   3 | 420 | 2 | chocolate, chips, ice cream      | Stress, bored, anger                                        | 1 | ⋯ | 1 | 1 | 2 |  725 | 690 | Basketball | 4 | 2 |  900 | 155                     |\n",
       "| 3.3   | 1 | 1 | 720 |   4 | 420 | 2 | frozen yogurt, pizza, fast food  | stress, sadness                                             | 1 | ⋯ | 1 | 2 | 5 | 1165 | 500 | none       | 5 | 1 |  900 | I'm not answering this. |\n",
       "| 3.2   | 1 | 1 | 430 |   3 | 420 | 2 | Pizza, Mac and cheese, ice cream | Boredom                                                     | 2 | ⋯ | 1 | 2 | 5 |  725 | 690 | nan        | 3 | 1 | 1315 | Not sure, 240           |\n",
       "| 3.5   | 1 | 1 | 720 |   2 | 420 | 2 | Ice cream, chocolate, chips      | Stress, boredom, cravings                                   | 1 | ⋯ | 1 | 1 | 4 |  940 | 500 | Softball   | 4 | 2 |  760 | 190                     |\n",
       "| 2.25  | 1 | 1 | 610 |   3 | 980 | 2 | Candy, brownies and soda.        | None, i don't eat comfort food. I just eat when i'm hungry. | 4 | ⋯ | 1 | 2 | 4 |  940 | 345 | None.      | 1 | 2 | 1315 | 190                     |\n",
       "\n"
      ],
      "text/plain": [
       "  GPA   Gender breakfast calories_chicken calories_day calories_scone coffee\n",
       "1 2.4   2      1         430              NaN          315            1     \n",
       "2 3.654 1      1         610                3          420            2     \n",
       "3 3.3   1      1         720                4          420            2     \n",
       "4 3.2   1      1         430                3          420            2     \n",
       "5 3.5   1      1         720                2          420            2     \n",
       "6 2.25  1      1         610                3          980            2     \n",
       "  comfort_food                    \n",
       "1 none                            \n",
       "2 chocolate, chips, ice cream     \n",
       "3 frozen yogurt, pizza, fast food \n",
       "4 Pizza, Mac and cheese, ice cream\n",
       "5 Ice cream, chocolate, chips     \n",
       "6 Candy, brownies and soda.       \n",
       "  comfort_food_reasons                                       \n",
       "1 we dont have comfort                                       \n",
       "2 Stress, bored, anger                                       \n",
       "3 stress, sadness                                            \n",
       "4 Boredom                                                    \n",
       "5 Stress, boredom, cravings                                  \n",
       "6 None, i don't eat comfort food. I just eat when i'm hungry.\n",
       "  comfort_food_reasons_coded...10 ⋯ soup sports thai_food tortilla_calories\n",
       "1 9                               ⋯ 1    1      1         1165             \n",
       "2 1                               ⋯ 1    1      2          725             \n",
       "3 1                               ⋯ 1    2      5         1165             \n",
       "4 2                               ⋯ 1    2      5          725             \n",
       "5 1                               ⋯ 1    1      4          940             \n",
       "6 4                               ⋯ 1    2      4          940             \n",
       "  turkey_calories type_sports veggies_day vitamins waffle_calories\n",
       "1 345             car racing  5           1        1315           \n",
       "2 690             Basketball  4           2         900           \n",
       "3 500             none        5           1         900           \n",
       "4 690             nan         3           1        1315           \n",
       "5 500             Softball    4           2         760           \n",
       "6 345             None.       1           2        1315           \n",
       "  weight                 \n",
       "1 187                    \n",
       "2 155                    \n",
       "3 I'm not answering this.\n",
       "4 Not sure, 240          \n",
       "5 190                    \n",
       "6 190                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 61</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>GPA</th><th scope=col>Gender</th><th scope=col>breakfast</th><th scope=col>calories_chicken</th><th scope=col>calories_day</th><th scope=col>calories_scone</th><th scope=col>coffee</th><th scope=col>comfort_food</th><th scope=col>comfort_food_reasons</th><th scope=col>comfort_food_reasons_coded...10</th><th scope=col>⋯</th><th scope=col>soup</th><th scope=col>sports</th><th scope=col>thai_food</th><th scope=col>tortilla_calories</th><th scope=col>turkey_calories</th><th scope=col>type_sports</th><th scope=col>veggies_day</th><th scope=col>vitamins</th><th scope=col>waffle_calories</th><th scope=col>weight</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2.4  </td><td>2</td><td>1</td><td>430</td><td>NaN</td><td>315</td><td>1</td><td>none                            </td><td>we dont have comfort                                       </td><td>9</td><td>⋯</td><td>1</td><td>1</td><td>1</td><td>1165</td><td>345</td><td>car racing</td><td>5</td><td>1</td><td>1315</td><td>187                    </td></tr>\n",
       "\t<tr><td>3.654</td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>chocolate, chips, ice cream     </td><td>Stress, bored, anger                                       </td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>2</td><td> 725</td><td>690</td><td>Basketball</td><td>4</td><td>2</td><td> 900</td><td>155                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>720</td><td>  4</td><td>420</td><td>2</td><td>frozen yogurt, pizza, fast food </td><td>stress, sadness                                            </td><td>1</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td>1165</td><td>500</td><td>none      </td><td>5</td><td>1</td><td> 900</td><td>I'm not answering this.</td></tr>\n",
       "\t<tr><td>3.2  </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>2</td><td>Pizza, Mac and cheese, ice cream</td><td>Boredom                                                    </td><td>2</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td> 725</td><td>690</td><td>nan       </td><td>3</td><td>1</td><td>1315</td><td>Not sure, 240          </td></tr>\n",
       "\t<tr><td>3.5  </td><td>1</td><td>1</td><td>720</td><td>  2</td><td>420</td><td>2</td><td>Ice cream, chocolate, chips     </td><td>Stress, boredom, cravings                                  </td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>4</td><td> 940</td><td>500</td><td>Softball  </td><td>4</td><td>2</td><td> 760</td><td>190                    </td></tr>\n",
       "\t<tr><td>2.25 </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>980</td><td>2</td><td>Candy, brownies and soda.       </td><td>None, i don't eat comfort food. I just eat when i'm hungry.</td><td>4</td><td>⋯</td><td>1</td><td>2</td><td>4</td><td> 940</td><td>345</td><td>None.     </td><td>1</td><td>2</td><td>1315</td><td>190                    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 61\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " GPA & Gender & breakfast & calories\\_chicken & calories\\_day & calories\\_scone & coffee & comfort\\_food & comfort\\_food\\_reasons & comfort\\_food\\_reasons\\_coded...10 & ⋯ & soup & sports & thai\\_food & tortilla\\_calories & turkey\\_calories & type\\_sports & veggies\\_day & vitamins & waffle\\_calories & weight\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2.4   & 2 & 1 & 430 & NaN & 315 & 1 & none                             & we dont have comfort                                        & 9 & ⋯ & 1 & 1 & 1 & 1165 & 345 & car racing & 5 & 1 & 1315 & 187                    \\\\\n",
       "\t 3.654 & 1 & 1 & 610 &   3 & 420 & 2 & chocolate, chips, ice cream      & Stress, bored, anger                                        & 1 & ⋯ & 1 & 1 & 2 &  725 & 690 & Basketball & 4 & 2 &  900 & 155                    \\\\\n",
       "\t 3.3   & 1 & 1 & 720 &   4 & 420 & 2 & frozen yogurt, pizza, fast food  & stress, sadness                                             & 1 & ⋯ & 1 & 2 & 5 & 1165 & 500 & none       & 5 & 1 &  900 & I'm not answering this.\\\\\n",
       "\t 3.2   & 1 & 1 & 430 &   3 & 420 & 2 & Pizza, Mac and cheese, ice cream & Boredom                                                     & 2 & ⋯ & 1 & 2 & 5 &  725 & 690 & nan        & 3 & 1 & 1315 & Not sure, 240          \\\\\n",
       "\t 3.5   & 1 & 1 & 720 &   2 & 420 & 2 & Ice cream, chocolate, chips      & Stress, boredom, cravings                                   & 1 & ⋯ & 1 & 1 & 4 &  940 & 500 & Softball   & 4 & 2 &  760 & 190                    \\\\\n",
       "\t 2.25  & 1 & 1 & 610 &   3 & 980 & 2 & Candy, brownies and soda.        & None, i don't eat comfort food. I just eat when i'm hungry. & 4 & ⋯ & 1 & 2 & 4 &  940 & 345 & None.      & 1 & 2 & 1315 & 190                    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 61\n",
       "\n",
       "| GPA &lt;chr&gt; | Gender &lt;dbl&gt; | breakfast &lt;dbl&gt; | calories_chicken &lt;dbl&gt; | calories_day &lt;dbl&gt; | calories_scone &lt;dbl&gt; | coffee &lt;dbl&gt; | comfort_food &lt;chr&gt; | comfort_food_reasons &lt;chr&gt; | comfort_food_reasons_coded...10 &lt;dbl&gt; | ⋯ ⋯ | soup &lt;dbl&gt; | sports &lt;dbl&gt; | thai_food &lt;dbl&gt; | tortilla_calories &lt;dbl&gt; | turkey_calories &lt;dbl&gt; | type_sports &lt;chr&gt; | veggies_day &lt;dbl&gt; | vitamins &lt;dbl&gt; | waffle_calories &lt;dbl&gt; | weight &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2.4   | 2 | 1 | 430 | NaN | 315 | 1 | none                             | we dont have comfort                                        | 9 | ⋯ | 1 | 1 | 1 | 1165 | 345 | car racing | 5 | 1 | 1315 | 187                     |\n",
       "| 3.654 | 1 | 1 | 610 |   3 | 420 | 2 | chocolate, chips, ice cream      | Stress, bored, anger                                        | 1 | ⋯ | 1 | 1 | 2 |  725 | 690 | Basketball | 4 | 2 |  900 | 155                     |\n",
       "| 3.3   | 1 | 1 | 720 |   4 | 420 | 2 | frozen yogurt, pizza, fast food  | stress, sadness                                             | 1 | ⋯ | 1 | 2 | 5 | 1165 | 500 | none       | 5 | 1 |  900 | I'm not answering this. |\n",
       "| 3.2   | 1 | 1 | 430 |   3 | 420 | 2 | Pizza, Mac and cheese, ice cream | Boredom                                                     | 2 | ⋯ | 1 | 2 | 5 |  725 | 690 | nan        | 3 | 1 | 1315 | Not sure, 240           |\n",
       "| 3.5   | 1 | 1 | 720 |   2 | 420 | 2 | Ice cream, chocolate, chips      | Stress, boredom, cravings                                   | 1 | ⋯ | 1 | 1 | 4 |  940 | 500 | Softball   | 4 | 2 |  760 | 190                     |\n",
       "| 2.25  | 1 | 1 | 610 |   3 | 980 | 2 | Candy, brownies and soda.        | None, i don't eat comfort food. I just eat when i'm hungry. | 4 | ⋯ | 1 | 2 | 4 |  940 | 345 | None.      | 1 | 2 | 1315 | 190                     |\n",
       "\n"
      ],
      "text/plain": [
       "  GPA   Gender breakfast calories_chicken calories_day calories_scone coffee\n",
       "1 2.4   2      1         430              NaN          315            1     \n",
       "2 3.654 1      1         610                3          420            2     \n",
       "3 3.3   1      1         720                4          420            2     \n",
       "4 3.2   1      1         430                3          420            2     \n",
       "5 3.5   1      1         720                2          420            2     \n",
       "6 2.25  1      1         610                3          980            2     \n",
       "  comfort_food                    \n",
       "1 none                            \n",
       "2 chocolate, chips, ice cream     \n",
       "3 frozen yogurt, pizza, fast food \n",
       "4 Pizza, Mac and cheese, ice cream\n",
       "5 Ice cream, chocolate, chips     \n",
       "6 Candy, brownies and soda.       \n",
       "  comfort_food_reasons                                       \n",
       "1 we dont have comfort                                       \n",
       "2 Stress, bored, anger                                       \n",
       "3 stress, sadness                                            \n",
       "4 Boredom                                                    \n",
       "5 Stress, boredom, cravings                                  \n",
       "6 None, i don't eat comfort food. I just eat when i'm hungry.\n",
       "  comfort_food_reasons_coded...10 ⋯ soup sports thai_food tortilla_calories\n",
       "1 9                               ⋯ 1    1      1         1165             \n",
       "2 1                               ⋯ 1    1      2          725             \n",
       "3 1                               ⋯ 1    2      5         1165             \n",
       "4 2                               ⋯ 1    2      5          725             \n",
       "5 1                               ⋯ 1    1      4          940             \n",
       "6 4                               ⋯ 1    2      4          940             \n",
       "  turkey_calories type_sports veggies_day vitamins waffle_calories\n",
       "1 345             car racing  5           1        1315           \n",
       "2 690             Basketball  4           2         900           \n",
       "3 500             none        5           1         900           \n",
       "4 690             nan         3           1        1315           \n",
       "5 500             Softball    4           2         760           \n",
       "6 345             None.       1           2        1315           \n",
       "  weight                 \n",
       "1 187                    \n",
       "2 155                    \n",
       "3 I'm not answering this.\n",
       "4 Not sure, 240          \n",
       "5 190                    \n",
       "6 190                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Your turn!\n",
    "\n",
    "# Get the first four lines of the foodPreferences dataframe you read in earlier\n",
    "head(foodPreferences)\n",
    "\n",
    "# okay actually I'm curious, I'll try the names thing\n",
    "names(foodPreferences) <- make.names(names(foodPreferences), unique=TRUE)\n",
    "\n",
    "# and then test to see if I can see the differences, there don't seem to be any\n",
    "head(foodPreferences)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7af780ef",
   "metadata": {
    "_cell_guid": "4b4d917e-4938-4404-ac90-671a298ac721",
    "_uuid": "fef0a78453749281c885267d68007c8e7342e06a",
    "papermill": {
     "duration": 0.019507,
     "end_time": "2024-01-26T23:33:24.669888",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.650381",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "You'll notice that the data_frame data structure has two dimensions, unlike the vectors we worked with in the \"First Steps\" part of the tutorial. But the secret is that both of these dimensions are actually vectors! This mean that we can access specific cells in our data_frame using the indexes of values we're interested in.\n",
    "\n",
    "A quick refresher on how to acess data by its index: "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "e0613eac",
   "metadata": {
    "_cell_guid": "f8c0303f-13ed-452f-9b84-499f54a23510",
    "_uuid": "67c948e719d8fef52d7c2bb6c0657a748a3c041d",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:24.714121Z",
     "iopub.status.busy": "2024-01-26T23:33:24.712307Z",
     "iopub.status.idle": "2024-01-26T23:33:24.741731Z",
     "shell.execute_reply": "2024-01-26T23:33:24.739761Z"
    },
    "papermill": {
     "duration": 0.054343,
     "end_time": "2024-01-26T23:33:24.744534",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.690191",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>5</li><li>10</li><li>15</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 5\n",
       "\\item 10\n",
       "\\item 15\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 5\n",
       "2. 10\n",
       "3. 15\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1]  5 10 15"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "5"
      ],
      "text/latex": [
       "5"
      ],
      "text/markdown": [
       "5"
      ],
      "text/plain": [
       "[1] 5"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# make a little example vector\n",
    "a <- c(5,10,15)\n",
    "\n",
    "# if you ask for something at an index, but don't say which one, you'll get everything\n",
    "a[]\n",
    "\n",
    "# if you ask for a value at a specific index, you'll only get only that value. In R,\n",
    "# indexes start counting from 1 and go up. (So 3 is the third)\n",
    "a[1]"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "04abe134",
   "metadata": {
    "_cell_guid": "9e30c3db-0af0-4046-b5df-dcc34edfb73a",
    "_uuid": "b3836ba6b2bd158276a40c260a02eda4331258bb",
    "papermill": {
     "duration": 0.021261,
     "end_time": "2024-01-26T23:33:24.786806",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.765545",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Data_frames work the same way, but you need to specify both the row and column, with a comma between them.\n",
    "\n",
    "> In R, if you ask for something from a two dimensional data structure, you'll always ask for the row first and the column second. So \"dataObject[2,4]\" means \"give me whatever is in the 2nd row and 4th column of the data frame called 'dataObject'\".\n",
    ">\n",
    "> One way to remember this is by thinking of \"RC Cola\". In the brand's name, \"RC\" stands for \"Royal Crown\"... but we can pretend it stands for \"Row Column\".\n",
    "\n",
    "![](https://upload.wikimedia.org/wikipedia/commons/e/e9/Drink_Royal_Crown_Cola.jpg)\n",
    "  - image obtained with \\!\\[\\]\\(*imageurl*\\)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "39371bb5",
   "metadata": {
    "_cell_guid": "1a68e491-f468-4de5-a74e-bfb40f669a60",
    "_uuid": "a41a78a3eee2b034ce782cd80da5b3124b61a927",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:24.835707Z",
     "iopub.status.busy": "2024-01-26T23:33:24.833829Z",
     "iopub.status.idle": "2024-01-26T23:33:24.905120Z",
     "shell.execute_reply": "2024-01-26T23:33:24.903037Z"
    },
    "papermill": {
     "duration": 0.099738,
     "end_time": "2024-01-26T23:33:24.908431",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.808693",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Review.Date</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2014</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 1\n",
       "\\begin{tabular}{l}\n",
       " Review.Date\\\\\n",
       " <dbl>\\\\\n",
       "\\hline\n",
       "\t 2014\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 1\n",
       "\n",
       "| Review.Date &lt;dbl&gt; |\n",
       "|---|\n",
       "| 2014 |\n",
       "\n"
      ],
      "text/plain": [
       "  Review.Date\n",
       "1 2014       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Carenero</td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Carenero & 1315 & 2014 & 70\\% & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Carenero | 1315 | 2014 | 70% | France | 2.75 | Criollo | Venezuela |\n",
       "\n"
      ],
      "text/plain": [
       "  Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name REF  Review.Date\n",
       "1 A. Morin                  Carenero                         1315 2014       \n",
       "  Cocoa.Percent Company.Location Rating Bean.Type Broad.Bean.Origin\n",
       "1 70%           France           2.75   Criollo   Venezuela        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company.Location</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>France</td></tr>\n",
       "\t<tr><td>France</td></tr>\n",
       "\t<tr><td>France</td></tr>\n",
       "\t<tr><td>France</td></tr>\n",
       "\t<tr><td>France</td></tr>\n",
       "\t<tr><td>France</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 1\n",
       "\\begin{tabular}{l}\n",
       " Company.Location\\\\\n",
       " <chr>\\\\\n",
       "\\hline\n",
       "\t France\\\\\n",
       "\t France\\\\\n",
       "\t France\\\\\n",
       "\t France\\\\\n",
       "\t France\\\\\n",
       "\t France\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 1\n",
       "\n",
       "| Company.Location &lt;chr&gt; |\n",
       "|---|\n",
       "| France |\n",
       "| France |\n",
       "| France |\n",
       "| France |\n",
       "| France |\n",
       "| France |\n",
       "\n"
      ],
      "text/plain": [
       "  Company.Location\n",
       "1 France          \n",
       "2 France          \n",
       "3 France          \n",
       "4 France          \n",
       "5 France          \n",
       "6 France          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# get the contents in the cell in the sixth row and the forth column\n",
    "chocolateData[6,4]\n",
    "\n",
    "# get the contents of every cell in the 6th row (note that you still need the comma!)\n",
    "chocolateData[6,]\n",
    "\n",
    "# if you forget the coulmn, you'll get the 6th *column* instead of the 6th *row*\n",
    "head(chocolateData[6])\n",
    "# I've used \"head\" here because the column is very long and I don't want\n",
    "# to fill up the screen by printing the whole thing out"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "737e68f8",
   "metadata": {
    "_cell_guid": "d99f7bdb-ba65-48d9-b909-6a310d16a79f",
    "_uuid": "2d26906e171275e7d659fae58f9e6250703b85c5",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:24.957686Z",
     "iopub.status.busy": "2024-01-26T23:33:24.955954Z",
     "iopub.status.idle": "2024-01-26T23:33:25.118753Z",
     "shell.execute_reply": "2024-01-26T23:33:25.116767Z"
    },
    "papermill": {
     "duration": 0.191593,
     "end_time": "2024-01-26T23:33:25.122090",
     "exception": false,
     "start_time": "2024-01-26T23:33:24.930497",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 61</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>GPA</th><th scope=col>Gender</th><th scope=col>breakfast</th><th scope=col>calories_chicken</th><th scope=col>calories_day</th><th scope=col>calories_scone</th><th scope=col>coffee</th><th scope=col>comfort_food</th><th scope=col>comfort_food_reasons</th><th scope=col>comfort_food_reasons_coded...10</th><th scope=col>⋯</th><th scope=col>soup</th><th scope=col>sports</th><th scope=col>thai_food</th><th scope=col>tortilla_calories</th><th scope=col>turkey_calories</th><th scope=col>type_sports</th><th scope=col>veggies_day</th><th scope=col>vitamins</th><th scope=col>waffle_calories</th><th scope=col>weight</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2.4</td><td>2</td><td>1</td><td>430</td><td>NaN</td><td>315</td><td>1</td><td>none</td><td>we dont have comfort</td><td>9</td><td>⋯</td><td>1</td><td>1</td><td>1</td><td>1165</td><td>345</td><td>car racing</td><td>5</td><td>1</td><td>1315</td><td>187</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 61\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " GPA & Gender & breakfast & calories\\_chicken & calories\\_day & calories\\_scone & coffee & comfort\\_food & comfort\\_food\\_reasons & comfort\\_food\\_reasons\\_coded...10 & ⋯ & soup & sports & thai\\_food & tortilla\\_calories & turkey\\_calories & type\\_sports & veggies\\_day & vitamins & waffle\\_calories & weight\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2.4 & 2 & 1 & 430 & NaN & 315 & 1 & none & we dont have comfort & 9 & ⋯ & 1 & 1 & 1 & 1165 & 345 & car racing & 5 & 1 & 1315 & 187\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 61\n",
       "\n",
       "| GPA &lt;chr&gt; | Gender &lt;dbl&gt; | breakfast &lt;dbl&gt; | calories_chicken &lt;dbl&gt; | calories_day &lt;dbl&gt; | calories_scone &lt;dbl&gt; | coffee &lt;dbl&gt; | comfort_food &lt;chr&gt; | comfort_food_reasons &lt;chr&gt; | comfort_food_reasons_coded...10 &lt;dbl&gt; | ⋯ ⋯ | soup &lt;dbl&gt; | sports &lt;dbl&gt; | thai_food &lt;dbl&gt; | tortilla_calories &lt;dbl&gt; | turkey_calories &lt;dbl&gt; | type_sports &lt;chr&gt; | veggies_day &lt;dbl&gt; | vitamins &lt;dbl&gt; | waffle_calories &lt;dbl&gt; | weight &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2.4 | 2 | 1 | 430 | NaN | 315 | 1 | none | we dont have comfort | 9 | ⋯ | 1 | 1 | 1 | 1165 | 345 | car racing | 5 | 1 | 1315 | 187 |\n",
       "\n"
      ],
      "text/plain": [
       "  GPA Gender breakfast calories_chicken calories_day calories_scone coffee\n",
       "1 2.4 2      1         430              NaN          315            1     \n",
       "  comfort_food comfort_food_reasons comfort_food_reasons_coded...10 ⋯ soup\n",
       "1 none         we dont have comfort 9                               ⋯ 1   \n",
       "  sports thai_food tortilla_calories turkey_calories type_sports veggies_day\n",
       "1 1      1         1165              345             car racing  5          \n",
       "  vitamins waffle_calories weight\n",
       "1 1        1315            187   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 61</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>GPA</th><th scope=col>Gender</th><th scope=col>breakfast</th><th scope=col>calories_chicken</th><th scope=col>calories_day</th><th scope=col>calories_scone</th><th scope=col>coffee</th><th scope=col>comfort_food</th><th scope=col>comfort_food_reasons</th><th scope=col>comfort_food_reasons_coded...10</th><th scope=col>⋯</th><th scope=col>soup</th><th scope=col>sports</th><th scope=col>thai_food</th><th scope=col>tortilla_calories</th><th scope=col>turkey_calories</th><th scope=col>type_sports</th><th scope=col>veggies_day</th><th scope=col>vitamins</th><th scope=col>waffle_calories</th><th scope=col>weight</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2.4  </td><td>2</td><td>1</td><td>430</td><td>NaN</td><td>315</td><td>1</td><td>none                            </td><td>we dont have comfort                                       </td><td>9</td><td>⋯</td><td>1</td><td>1</td><td>1</td><td>1165</td><td>345</td><td>car racing</td><td>5</td><td>1</td><td>1315</td><td>187                    </td></tr>\n",
       "\t<tr><td>3.654</td><td>1</td><td>1</td><td>610</td><td>  3</td><td>420</td><td>2</td><td>chocolate, chips, ice cream     </td><td>Stress, bored, anger                                       </td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>2</td><td> 725</td><td>690</td><td>Basketball</td><td>4</td><td>2</td><td> 900</td><td>155                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>720</td><td>  4</td><td>420</td><td>2</td><td>frozen yogurt, pizza, fast food </td><td>stress, sadness                                            </td><td>1</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td>1165</td><td>500</td><td>none      </td><td>5</td><td>1</td><td> 900</td><td>I'm not answering this.</td></tr>\n",
       "\t<tr><td>3.2  </td><td>1</td><td>1</td><td>430</td><td>  3</td><td>420</td><td>2</td><td>Pizza, Mac and cheese, ice cream</td><td>Boredom                                                    </td><td>2</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td> 725</td><td>690</td><td>nan       </td><td>3</td><td>1</td><td>1315</td><td>Not sure, 240          </td></tr>\n",
       "\t<tr><td>3.5  </td><td>1</td><td>1</td><td>720</td><td>  2</td><td>420</td><td>2</td><td>Ice cream, chocolate, chips     </td><td>Stress, boredom, cravings                                  </td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>4</td><td> 940</td><td>500</td><td>Softball  </td><td>4</td><td>2</td><td> 760</td><td>190                    </td></tr>\n",
       "\t<tr><td>2.25 </td><td>1</td><td>1</td><td>610</td><td>  3</td><td>980</td><td>2</td><td>Candy, brownies and soda.       </td><td>None, i don't eat comfort food. I just eat when i'm hungry.</td><td>4</td><td>⋯</td><td>1</td><td>2</td><td>4</td><td> 940</td><td>345</td><td>None.     </td><td>1</td><td>2</td><td>1315</td><td>190                    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 61\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " GPA & Gender & breakfast & calories\\_chicken & calories\\_day & calories\\_scone & coffee & comfort\\_food & comfort\\_food\\_reasons & comfort\\_food\\_reasons\\_coded...10 & ⋯ & soup & sports & thai\\_food & tortilla\\_calories & turkey\\_calories & type\\_sports & veggies\\_day & vitamins & waffle\\_calories & weight\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2.4   & 2 & 1 & 430 & NaN & 315 & 1 & none                             & we dont have comfort                                        & 9 & ⋯ & 1 & 1 & 1 & 1165 & 345 & car racing & 5 & 1 & 1315 & 187                    \\\\\n",
       "\t 3.654 & 1 & 1 & 610 &   3 & 420 & 2 & chocolate, chips, ice cream      & Stress, bored, anger                                        & 1 & ⋯ & 1 & 1 & 2 &  725 & 690 & Basketball & 4 & 2 &  900 & 155                    \\\\\n",
       "\t 3.3   & 1 & 1 & 720 &   4 & 420 & 2 & frozen yogurt, pizza, fast food  & stress, sadness                                             & 1 & ⋯ & 1 & 2 & 5 & 1165 & 500 & none       & 5 & 1 &  900 & I'm not answering this.\\\\\n",
       "\t 3.2   & 1 & 1 & 430 &   3 & 420 & 2 & Pizza, Mac and cheese, ice cream & Boredom                                                     & 2 & ⋯ & 1 & 2 & 5 &  725 & 690 & nan        & 3 & 1 & 1315 & Not sure, 240          \\\\\n",
       "\t 3.5   & 1 & 1 & 720 &   2 & 420 & 2 & Ice cream, chocolate, chips      & Stress, boredom, cravings                                   & 1 & ⋯ & 1 & 1 & 4 &  940 & 500 & Softball   & 4 & 2 &  760 & 190                    \\\\\n",
       "\t 2.25  & 1 & 1 & 610 &   3 & 980 & 2 & Candy, brownies and soda.        & None, i don't eat comfort food. I just eat when i'm hungry. & 4 & ⋯ & 1 & 2 & 4 &  940 & 345 & None.      & 1 & 2 & 1315 & 190                    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 61\n",
       "\n",
       "| GPA &lt;chr&gt; | Gender &lt;dbl&gt; | breakfast &lt;dbl&gt; | calories_chicken &lt;dbl&gt; | calories_day &lt;dbl&gt; | calories_scone &lt;dbl&gt; | coffee &lt;dbl&gt; | comfort_food &lt;chr&gt; | comfort_food_reasons &lt;chr&gt; | comfort_food_reasons_coded...10 &lt;dbl&gt; | ⋯ ⋯ | soup &lt;dbl&gt; | sports &lt;dbl&gt; | thai_food &lt;dbl&gt; | tortilla_calories &lt;dbl&gt; | turkey_calories &lt;dbl&gt; | type_sports &lt;chr&gt; | veggies_day &lt;dbl&gt; | vitamins &lt;dbl&gt; | waffle_calories &lt;dbl&gt; | weight &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2.4   | 2 | 1 | 430 | NaN | 315 | 1 | none                             | we dont have comfort                                        | 9 | ⋯ | 1 | 1 | 1 | 1165 | 345 | car racing | 5 | 1 | 1315 | 187                     |\n",
       "| 3.654 | 1 | 1 | 610 |   3 | 420 | 2 | chocolate, chips, ice cream      | Stress, bored, anger                                        | 1 | ⋯ | 1 | 1 | 2 |  725 | 690 | Basketball | 4 | 2 |  900 | 155                     |\n",
       "| 3.3   | 1 | 1 | 720 |   4 | 420 | 2 | frozen yogurt, pizza, fast food  | stress, sadness                                             | 1 | ⋯ | 1 | 2 | 5 | 1165 | 500 | none       | 5 | 1 |  900 | I'm not answering this. |\n",
       "| 3.2   | 1 | 1 | 430 |   3 | 420 | 2 | Pizza, Mac and cheese, ice cream | Boredom                                                     | 2 | ⋯ | 1 | 2 | 5 |  725 | 690 | nan        | 3 | 1 | 1315 | Not sure, 240           |\n",
       "| 3.5   | 1 | 1 | 720 |   2 | 420 | 2 | Ice cream, chocolate, chips      | Stress, boredom, cravings                                   | 1 | ⋯ | 1 | 1 | 4 |  940 | 500 | Softball   | 4 | 2 |  760 | 190                     |\n",
       "| 2.25  | 1 | 1 | 610 |   3 | 980 | 2 | Candy, brownies and soda.        | None, i don't eat comfort food. I just eat when i'm hungry. | 4 | ⋯ | 1 | 2 | 4 |  940 | 345 | None.      | 1 | 2 | 1315 | 190                     |\n",
       "\n"
      ],
      "text/plain": [
       "  GPA   Gender breakfast calories_chicken calories_day calories_scone coffee\n",
       "1 2.4   2      1         430              NaN          315            1     \n",
       "2 3.654 1      1         610                3          420            2     \n",
       "3 3.3   1      1         720                4          420            2     \n",
       "4 3.2   1      1         430                3          420            2     \n",
       "5 3.5   1      1         720                2          420            2     \n",
       "6 2.25  1      1         610                3          980            2     \n",
       "  comfort_food                    \n",
       "1 none                            \n",
       "2 chocolate, chips, ice cream     \n",
       "3 frozen yogurt, pizza, fast food \n",
       "4 Pizza, Mac and cheese, ice cream\n",
       "5 Ice cream, chocolate, chips     \n",
       "6 Candy, brownies and soda.       \n",
       "  comfort_food_reasons                                       \n",
       "1 we dont have comfort                                       \n",
       "2 Stress, bored, anger                                       \n",
       "3 stress, sadness                                            \n",
       "4 Boredom                                                    \n",
       "5 Stress, boredom, cravings                                  \n",
       "6 None, i don't eat comfort food. I just eat when i'm hungry.\n",
       "  comfort_food_reasons_coded...10 ⋯ soup sports thai_food tortilla_calories\n",
       "1 9                               ⋯ 1    1      1         1165             \n",
       "2 1                               ⋯ 1    1      2          725             \n",
       "3 1                               ⋯ 1    2      5         1165             \n",
       "4 2                               ⋯ 1    2      5          725             \n",
       "5 1                               ⋯ 1    1      4          940             \n",
       "6 4                               ⋯ 1    2      4          940             \n",
       "  turkey_calories type_sports veggies_day vitamins waffle_calories\n",
       "1 345             car racing  5           1        1315           \n",
       "2 690             Basketball  4           2         900           \n",
       "3 500             none        5           1         900           \n",
       "4 690             nan         3           1        1315           \n",
       "5 500             Softball    4           2         760           \n",
       "6 345             None.       1           2        1315           \n",
       "  weight                 \n",
       "1 187                    \n",
       "2 155                    \n",
       "3 I'm not answering this.\n",
       "4 Not sure, 240          \n",
       "5 190                    \n",
       "6 190                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>calories_chicken</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>430</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 1\n",
       "\\begin{tabular}{l}\n",
       " calories\\_chicken\\\\\n",
       " <dbl>\\\\\n",
       "\\hline\n",
       "\t 430\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 1\n",
       "\n",
       "| calories_chicken &lt;dbl&gt; |\n",
       "|---|\n",
       "| 430 |\n",
       "\n"
      ],
      "text/plain": [
       "  calories_chicken\n",
       "1 430             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Your turn!\n",
    "# dataframe[row,column]\n",
    "# Get the first row of your \"foodPreferences\" data_frame\n",
    "foodPreferences[1,]\n",
    "# check if it's actually the first row bc ngl the one-based numbering is confusing\n",
    "head(foodPreferences)\n",
    "\n",
    "# Get the value from the cell in the 100th row and 4th column\n",
    "foodPreferences[100,4]"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cf2b707d",
   "metadata": {
    "_cell_guid": "5d8d7b67-5831-4914-bc75-3e59a81d1b6b",
    "_uuid": "fc5eacb92814a6c451c15884865f428df0684acc",
    "papermill": {
     "duration": 0.023388,
     "end_time": "2024-01-26T23:33:25.167252",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.143864",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Remove unwanted data\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "034815ab",
   "metadata": {
    "_cell_guid": "be055462-a712-4583-bf83-a00ba8202574",
    "_uuid": "cfd8da3bea705c0aabba0c0843004b01d931ba30",
    "papermill": {
     "duration": 0.022718,
     "end_time": "2024-01-26T23:33:25.211774",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.189056",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "In addition to using indexes to get certain values, we can also use them to *remove* data we're not interested in. You can do this by putting a minus sign (-) in front of the index you don't want.\n",
    "\n",
    "You may have noticed earlier that the first row of the \"chocolateData\" data_frame is the same as the column names. Let's remove it."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "cb45cd9d",
   "metadata": {
    "_cell_guid": "b9d67442-fe79-4f24-9a4c-d7484a7f622f",
    "_uuid": "5e0309fe4413ea6906e787a877253445cdcd72bb",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:25.261356Z",
     "iopub.status.busy": "2024-01-26T23:33:25.259662Z",
     "iopub.status.idle": "2024-01-26T23:33:25.332767Z",
     "shell.execute_reply": "2024-01-26T23:33:25.330826Z"
    },
    "papermill": {
     "duration": 0.100922,
     "end_time": "2024-01-26T23:33:25.335992",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.235070",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Agua Grande</td><td>1876</td><td>2016</td><td>63%</td><td>France</td><td>3.75</td><td>       </td><td>Sao Tome </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Kpime      </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>2.75</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Atsane     </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>3.00</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Akata      </td><td>1680</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Quilla     </td><td>1704</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Peru     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Carenero   </td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Agua Grande & 1876 & 2016 & 63\\% & France & 3.75 &         & Sao Tome \\\\\n",
       "\t A. Morin & Kpime       & 1676 & 2015 & 70\\% & France & 2.75 &         & Togo     \\\\\n",
       "\t A. Morin & Atsane      & 1676 & 2015 & 70\\% & France & 3.00 &         & Togo     \\\\\n",
       "\t A. Morin & Akata       & 1680 & 2015 & 70\\% & France & 3.50 &         & Togo     \\\\\n",
       "\t A. Morin & Quilla      & 1704 & 2015 & 70\\% & France & 3.50 &         & Peru     \\\\\n",
       "\t A. Morin & Carenero    & 1315 & 2014 & 70\\% & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Agua Grande | 1876 | 2016 | 63% | France | 3.75 |         | Sao Tome  |\n",
       "| A. Morin | Kpime       | 1676 | 2015 | 70% | France | 2.75 |         | Togo      |\n",
       "| A. Morin | Atsane      | 1676 | 2015 | 70% | France | 3.00 |         | Togo      |\n",
       "| A. Morin | Akata       | 1680 | 2015 | 70% | France | 3.50 |         | Togo      |\n",
       "| A. Morin | Quilla      | 1704 | 2015 | 70% | France | 3.50 |         | Peru      |\n",
       "| A. Morin | Carenero    | 1315 | 2014 | 70% | France | 2.75 | Criollo | Venezuela |\n",
       "\n"
      ],
      "text/plain": [
       "  Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name REF  Review.Date\n",
       "1 A. Morin                  Agua Grande                      1876 2016       \n",
       "2 A. Morin                  Kpime                            1676 2015       \n",
       "3 A. Morin                  Atsane                           1676 2015       \n",
       "4 A. Morin                  Akata                            1680 2015       \n",
       "5 A. Morin                  Quilla                           1704 2015       \n",
       "6 A. Morin                  Carenero                         1315 2014       \n",
       "  Cocoa.Percent Company.Location Rating Bean.Type Broad.Bean.Origin\n",
       "1 63%           France           3.75             Sao Tome         \n",
       "2 70%           France           2.75             Togo             \n",
       "3 70%           France           3.00             Togo             \n",
       "4 70%           France           3.50             Togo             \n",
       "5 70%           France           3.50             Peru             \n",
       "6 70%           France           2.75   Criollo   Venezuela        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 0 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 0 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 0 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "\n"
      ],
      "text/plain": [
       "     Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name REF Review.Date\n",
       "     Cocoa.Percent Company.Location Rating Bean.Type Broad.Bean.Origin"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(chocolateData)\n",
    "# huh?? is it not one-based then?? Or maybe this is just a way to access column names?\n",
    "chocolateData[0,]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "a4c600b5",
   "metadata": {
    "_cell_guid": "79312270-618e-4181-a2ca-da3379ca1a9d",
    "_uuid": "ce61c0c80a3f29662fe568248110a612018f566d",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:25.397660Z",
     "iopub.status.busy": "2024-01-26T23:33:25.394809Z",
     "iopub.status.idle": "2024-01-26T23:33:25.454591Z",
     "shell.execute_reply": "2024-01-26T23:33:25.452483Z"
    },
    "papermill": {
     "duration": 0.095428,
     "end_time": "2024-01-26T23:33:25.457570",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.362142",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company...Maker.if.known.</th><th scope=col>Specific.Bean.Origin.or.Bar.Name</th><th scope=col>REF</th><th scope=col>Review.Date</th><th scope=col>Cocoa.Percent</th><th scope=col>Company.Location</th><th scope=col>Rating</th><th scope=col>Bean.Type</th><th scope=col>Broad.Bean.Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Kpime   </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>2.75</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Atsane  </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>3.00</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Akata   </td><td>1680</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Quilla  </td><td>1704</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Peru     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Carenero</td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Cuba    </td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Cuba     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company...Maker.if.known. & Specific.Bean.Origin.or.Bar.Name & REF & Review.Date & Cocoa.Percent & Company.Location & Rating & Bean.Type & Broad.Bean.Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Kpime    & 1676 & 2015 & 70\\% & France & 2.75 &         & Togo     \\\\\n",
       "\t A. Morin & Atsane   & 1676 & 2015 & 70\\% & France & 3.00 &         & Togo     \\\\\n",
       "\t A. Morin & Akata    & 1680 & 2015 & 70\\% & France & 3.50 &         & Togo     \\\\\n",
       "\t A. Morin & Quilla   & 1704 & 2015 & 70\\% & France & 3.50 &         & Peru     \\\\\n",
       "\t A. Morin & Carenero & 1315 & 2014 & 70\\% & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\t A. Morin & Cuba     & 1315 & 2014 & 70\\% & France & 3.50 &         & Cuba     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| Company...Maker.if.known. &lt;chr&gt; | Specific.Bean.Origin.or.Bar.Name &lt;chr&gt; | REF &lt;dbl&gt; | Review.Date &lt;dbl&gt; | Cocoa.Percent &lt;chr&gt; | Company.Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean.Type &lt;chr&gt; | Broad.Bean.Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Kpime    | 1676 | 2015 | 70% | France | 2.75 |         | Togo      |\n",
       "| A. Morin | Atsane   | 1676 | 2015 | 70% | France | 3.00 |         | Togo      |\n",
       "| A. Morin | Akata    | 1680 | 2015 | 70% | France | 3.50 |         | Togo      |\n",
       "| A. Morin | Quilla   | 1704 | 2015 | 70% | France | 3.50 |         | Peru      |\n",
       "| A. Morin | Carenero | 1315 | 2014 | 70% | France | 2.75 | Criollo | Venezuela |\n",
       "| A. Morin | Cuba     | 1315 | 2014 | 70% | France | 3.50 |         | Cuba      |\n",
       "\n"
      ],
      "text/plain": [
       "  Company...Maker.if.known. Specific.Bean.Origin.or.Bar.Name REF  Review.Date\n",
       "1 A. Morin                  Kpime                            1676 2015       \n",
       "2 A. Morin                  Atsane                           1676 2015       \n",
       "3 A. Morin                  Akata                            1680 2015       \n",
       "4 A. Morin                  Quilla                           1704 2015       \n",
       "5 A. Morin                  Carenero                         1315 2014       \n",
       "6 A. Morin                  Cuba                             1315 2014       \n",
       "  Cocoa.Percent Company.Location Rating Bean.Type Broad.Bean.Origin\n",
       "1 70%           France           2.75             Togo             \n",
       "2 70%           France           3.00             Togo             \n",
       "3 70%           France           3.50             Togo             \n",
       "4 70%           France           3.50             Peru             \n",
       "5 70%           France           2.75   Criollo   Venezuela        \n",
       "6 70%           France           3.50             Cuba             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# get all rows EXCEPT the first row and all columns of chocolateData\n",
    "# By putting it back in the same variable, we're overwriting what was in \n",
    "# that variable before, so be careful with this!\n",
    "chocolateData <- chocolateData[-1,] \n",
    "\n",
    "# make sure we removed the row we didn't want (this is still sus)\n",
    "head(chocolateData)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "16ea83f6",
   "metadata": {
    "_cell_guid": "71a8e3c4-1049-4e9c-8025-c764fbab716c",
    "_uuid": "79aeb9b58fdd4d40e8053857f50e77eb8dae914f",
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:25.516911Z",
     "iopub.status.busy": "2024-01-26T23:33:25.514267Z",
     "iopub.status.idle": "2024-01-26T23:33:25.655339Z",
     "shell.execute_reply": "2024-01-26T23:33:25.653150Z"
    },
    "papermill": {
     "duration": 0.17795,
     "end_time": "2024-01-26T23:33:25.658313",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.480363",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>calories_day</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>NaN</td></tr>\n",
       "\t<tr><td>  3</td></tr>\n",
       "\t<tr><td>  4</td></tr>\n",
       "\t<tr><td>  3</td></tr>\n",
       "\t<tr><td>  2</td></tr>\n",
       "\t<tr><td>  3</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 1\n",
       "\\begin{tabular}{l}\n",
       " calories\\_day\\\\\n",
       " <dbl>\\\\\n",
       "\\hline\n",
       "\t NaN\\\\\n",
       "\t   3\\\\\n",
       "\t   4\\\\\n",
       "\t   3\\\\\n",
       "\t   2\\\\\n",
       "\t   3\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 1\n",
       "\n",
       "| calories_day &lt;dbl&gt; |\n",
       "|---|\n",
       "| NaN |\n",
       "|   3 |\n",
       "|   4 |\n",
       "|   3 |\n",
       "|   2 |\n",
       "|   3 |\n",
       "\n"
      ],
      "text/plain": [
       "  calories_day\n",
       "1 NaN         \n",
       "2   3         \n",
       "3   4         \n",
       "4   3         \n",
       "5   2         \n",
       "6   3         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 60</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>GPA</th><th scope=col>Gender</th><th scope=col>breakfast</th><th scope=col>calories_chicken</th><th scope=col>calories_scone</th><th scope=col>coffee</th><th scope=col>comfort_food</th><th scope=col>comfort_food_reasons</th><th scope=col>comfort_food_reasons_coded...10</th><th scope=col>cook</th><th scope=col>⋯</th><th scope=col>soup</th><th scope=col>sports</th><th scope=col>thai_food</th><th scope=col>tortilla_calories</th><th scope=col>turkey_calories</th><th scope=col>type_sports</th><th scope=col>veggies_day</th><th scope=col>vitamins</th><th scope=col>waffle_calories</th><th scope=col>weight</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2.4  </td><td>2</td><td>1</td><td>430</td><td>315</td><td>1</td><td>none                            </td><td>we dont have comfort                                       </td><td>9</td><td>2</td><td>⋯</td><td>1</td><td>1</td><td>1</td><td>1165</td><td>345</td><td>car racing</td><td>5</td><td>1</td><td>1315</td><td>187                    </td></tr>\n",
       "\t<tr><td>3.654</td><td>1</td><td>1</td><td>610</td><td>420</td><td>2</td><td>chocolate, chips, ice cream     </td><td>Stress, bored, anger                                       </td><td>1</td><td>3</td><td>⋯</td><td>1</td><td>1</td><td>2</td><td> 725</td><td>690</td><td>Basketball</td><td>4</td><td>2</td><td> 900</td><td>155                    </td></tr>\n",
       "\t<tr><td>3.3  </td><td>1</td><td>1</td><td>720</td><td>420</td><td>2</td><td>frozen yogurt, pizza, fast food </td><td>stress, sadness                                            </td><td>1</td><td>1</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td>1165</td><td>500</td><td>none      </td><td>5</td><td>1</td><td> 900</td><td>I'm not answering this.</td></tr>\n",
       "\t<tr><td>3.2  </td><td>1</td><td>1</td><td>430</td><td>420</td><td>2</td><td>Pizza, Mac and cheese, ice cream</td><td>Boredom                                                    </td><td>2</td><td>2</td><td>⋯</td><td>1</td><td>2</td><td>5</td><td> 725</td><td>690</td><td>nan       </td><td>3</td><td>1</td><td>1315</td><td>Not sure, 240          </td></tr>\n",
       "\t<tr><td>3.5  </td><td>1</td><td>1</td><td>720</td><td>420</td><td>2</td><td>Ice cream, chocolate, chips     </td><td>Stress, boredom, cravings                                  </td><td>1</td><td>1</td><td>⋯</td><td>1</td><td>1</td><td>4</td><td> 940</td><td>500</td><td>Softball  </td><td>4</td><td>2</td><td> 760</td><td>190                    </td></tr>\n",
       "\t<tr><td>2.25 </td><td>1</td><td>1</td><td>610</td><td>980</td><td>2</td><td>Candy, brownies and soda.       </td><td>None, i don't eat comfort food. I just eat when i'm hungry.</td><td>4</td><td>3</td><td>⋯</td><td>1</td><td>2</td><td>4</td><td> 940</td><td>345</td><td>None.     </td><td>1</td><td>2</td><td>1315</td><td>190                    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 60\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " GPA & Gender & breakfast & calories\\_chicken & calories\\_scone & coffee & comfort\\_food & comfort\\_food\\_reasons & comfort\\_food\\_reasons\\_coded...10 & cook & ⋯ & soup & sports & thai\\_food & tortilla\\_calories & turkey\\_calories & type\\_sports & veggies\\_day & vitamins & waffle\\_calories & weight\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t 2.4   & 2 & 1 & 430 & 315 & 1 & none                             & we dont have comfort                                        & 9 & 2 & ⋯ & 1 & 1 & 1 & 1165 & 345 & car racing & 5 & 1 & 1315 & 187                    \\\\\n",
       "\t 3.654 & 1 & 1 & 610 & 420 & 2 & chocolate, chips, ice cream      & Stress, bored, anger                                        & 1 & 3 & ⋯ & 1 & 1 & 2 &  725 & 690 & Basketball & 4 & 2 &  900 & 155                    \\\\\n",
       "\t 3.3   & 1 & 1 & 720 & 420 & 2 & frozen yogurt, pizza, fast food  & stress, sadness                                             & 1 & 1 & ⋯ & 1 & 2 & 5 & 1165 & 500 & none       & 5 & 1 &  900 & I'm not answering this.\\\\\n",
       "\t 3.2   & 1 & 1 & 430 & 420 & 2 & Pizza, Mac and cheese, ice cream & Boredom                                                     & 2 & 2 & ⋯ & 1 & 2 & 5 &  725 & 690 & nan        & 3 & 1 & 1315 & Not sure, 240          \\\\\n",
       "\t 3.5   & 1 & 1 & 720 & 420 & 2 & Ice cream, chocolate, chips      & Stress, boredom, cravings                                   & 1 & 1 & ⋯ & 1 & 1 & 4 &  940 & 500 & Softball   & 4 & 2 &  760 & 190                    \\\\\n",
       "\t 2.25  & 1 & 1 & 610 & 980 & 2 & Candy, brownies and soda.        & None, i don't eat comfort food. I just eat when i'm hungry. & 4 & 3 & ⋯ & 1 & 2 & 4 &  940 & 345 & None.      & 1 & 2 & 1315 & 190                    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 60\n",
       "\n",
       "| GPA &lt;chr&gt; | Gender &lt;dbl&gt; | breakfast &lt;dbl&gt; | calories_chicken &lt;dbl&gt; | calories_scone &lt;dbl&gt; | coffee &lt;dbl&gt; | comfort_food &lt;chr&gt; | comfort_food_reasons &lt;chr&gt; | comfort_food_reasons_coded...10 &lt;dbl&gt; | cook &lt;dbl&gt; | ⋯ ⋯ | soup &lt;dbl&gt; | sports &lt;dbl&gt; | thai_food &lt;dbl&gt; | tortilla_calories &lt;dbl&gt; | turkey_calories &lt;dbl&gt; | type_sports &lt;chr&gt; | veggies_day &lt;dbl&gt; | vitamins &lt;dbl&gt; | waffle_calories &lt;dbl&gt; | weight &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2.4   | 2 | 1 | 430 | 315 | 1 | none                             | we dont have comfort                                        | 9 | 2 | ⋯ | 1 | 1 | 1 | 1165 | 345 | car racing | 5 | 1 | 1315 | 187                     |\n",
       "| 3.654 | 1 | 1 | 610 | 420 | 2 | chocolate, chips, ice cream      | Stress, bored, anger                                        | 1 | 3 | ⋯ | 1 | 1 | 2 |  725 | 690 | Basketball | 4 | 2 |  900 | 155                     |\n",
       "| 3.3   | 1 | 1 | 720 | 420 | 2 | frozen yogurt, pizza, fast food  | stress, sadness                                             | 1 | 1 | ⋯ | 1 | 2 | 5 | 1165 | 500 | none       | 5 | 1 |  900 | I'm not answering this. |\n",
       "| 3.2   | 1 | 1 | 430 | 420 | 2 | Pizza, Mac and cheese, ice cream | Boredom                                                     | 2 | 2 | ⋯ | 1 | 2 | 5 |  725 | 690 | nan        | 3 | 1 | 1315 | Not sure, 240           |\n",
       "| 3.5   | 1 | 1 | 720 | 420 | 2 | Ice cream, chocolate, chips      | Stress, boredom, cravings                                   | 1 | 1 | ⋯ | 1 | 1 | 4 |  940 | 500 | Softball   | 4 | 2 |  760 | 190                     |\n",
       "| 2.25  | 1 | 1 | 610 | 980 | 2 | Candy, brownies and soda.        | None, i don't eat comfort food. I just eat when i'm hungry. | 4 | 3 | ⋯ | 1 | 2 | 4 |  940 | 345 | None.      | 1 | 2 | 1315 | 190                     |\n",
       "\n"
      ],
      "text/plain": [
       "  GPA   Gender breakfast calories_chicken calories_scone coffee\n",
       "1 2.4   2      1         430              315            1     \n",
       "2 3.654 1      1         610              420            2     \n",
       "3 3.3   1      1         720              420            2     \n",
       "4 3.2   1      1         430              420            2     \n",
       "5 3.5   1      1         720              420            2     \n",
       "6 2.25  1      1         610              980            2     \n",
       "  comfort_food                    \n",
       "1 none                            \n",
       "2 chocolate, chips, ice cream     \n",
       "3 frozen yogurt, pizza, fast food \n",
       "4 Pizza, Mac and cheese, ice cream\n",
       "5 Ice cream, chocolate, chips     \n",
       "6 Candy, brownies and soda.       \n",
       "  comfort_food_reasons                                       \n",
       "1 we dont have comfort                                       \n",
       "2 Stress, bored, anger                                       \n",
       "3 stress, sadness                                            \n",
       "4 Boredom                                                    \n",
       "5 Stress, boredom, cravings                                  \n",
       "6 None, i don't eat comfort food. I just eat when i'm hungry.\n",
       "  comfort_food_reasons_coded...10 cook ⋯ soup sports thai_food\n",
       "1 9                               2    ⋯ 1    1      1        \n",
       "2 1                               3    ⋯ 1    1      2        \n",
       "3 1                               1    ⋯ 1    2      5        \n",
       "4 2                               2    ⋯ 1    2      5        \n",
       "5 1                               1    ⋯ 1    1      4        \n",
       "6 4                               3    ⋯ 1    2      4        \n",
       "  tortilla_calories turkey_calories type_sports veggies_day vitamins\n",
       "1 1165              345             car racing  5           1       \n",
       "2  725              690             Basketball  4           2       \n",
       "3 1165              500             none        5           1       \n",
       "4  725              690             nan         3           1       \n",
       "5  940              500             Softball    4           2       \n",
       "6  940              345             None.       1           2       \n",
       "  waffle_calories weight                 \n",
       "1 1315            187                    \n",
       "2  900            155                    \n",
       "3  900            I'm not answering this.\n",
       "4 1315            Not sure, 240          \n",
       "5  760            190                    \n",
       "6 1315            190                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Your turn!\n",
    "\n",
    "# The 5th column in the \"foodPreferences\" dataset has a lot of values that aren't \n",
    "# numbers (nan means \"not a number\"). Can you remove the 5th column from the dataset?\n",
    "head(foodPreferences[5])\n",
    "\n",
    "foodPreferences <- foodPreferences[-5]\n",
    "\n",
    "head(foodPreferences)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "486a8d7a",
   "metadata": {
    "_cell_guid": "95d15958-a8b3-43c2-8940-95b0e2271db4",
    "_uuid": "b01695617265d19aeee7393215c45cab50f7ba44",
    "papermill": {
     "duration": 0.025686,
     "end_time": "2024-01-26T23:33:25.708349",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.682663",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Alright, now that we've read our data into R, checked that it looks alright and gotten rid of a row we didn't want, it's time to get down to doing some analysis. In the next section, we'll learn how to summerize our data and get into some basic statistics!"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1fccb4e4",
   "metadata": {
    "_cell_guid": "ddd3caf3-4b6e-43a5-aea3-015ee692fc4b",
    "_uuid": "de957e271c7fa03464825f3d93793caec7042a53",
    "papermill": {
     "duration": 0.029863,
     "end_time": "2024-01-26T23:33:25.769554",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.739691",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Next step: [Summarize our data](https://www.kaggle.com/rtatman/getting-started-in-r-summarize-data/)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "bea285b8",
   "metadata": {
    "papermill": {
     "duration": 0.024838,
     "end_time": "2024-01-26T23:33:25.857927",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.833089",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Because the summarize our data thing isn't working, I'll just do it from here"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "2f9f220c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:25.910538Z",
     "iopub.status.busy": "2024-01-26T23:33:25.908665Z",
     "iopub.status.idle": "2024-01-26T23:33:26.060727Z",
     "shell.execute_reply": "2024-01-26T23:33:26.058758Z"
    },
    "papermill": {
     "duration": 0.18145,
     "end_time": "2024-01-26T23:33:26.063974",
     "exception": false,
     "start_time": "2024-01-26T23:33:25.882524",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m1795\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m9\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m (6): Company \n",
      "(Maker-if known), Specific Bean Origin\n",
      "or Bar Name, Cocoa\n",
      "...\n",
      "\u001b[32mdbl\u001b[39m (3): REF, Review\n",
      "Date, Rating\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company \n",
       "(Maker-if known)</th><th scope=col>Specific Bean Origin\n",
       "or Bar Name</th><th scope=col>REF</th><th scope=col>Review\n",
       "Date</th><th scope=col>Cocoa\n",
       "Percent</th><th scope=col>Company\n",
       "Location</th><th scope=col>Rating</th><th scope=col>Bean\n",
       "Type</th><th scope=col>Broad Bean\n",
       "Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Agua Grande</td><td>1876</td><td>2016</td><td>63%</td><td>France</td><td>3.75</td><td>       </td><td>Sao Tome </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Kpime      </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>2.75</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Atsane     </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>3.00</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Akata      </td><td>1680</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Quilla     </td><td>1704</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Peru     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Carenero   </td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company \n",
       "(Maker-if known) & Specific Bean Origin\n",
       "or Bar Name & REF & Review\n",
       "Date & Cocoa\n",
       "Percent & Company\n",
       "Location & Rating & Bean\n",
       "Type & Broad Bean\n",
       "Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Agua Grande & 1876 & 2016 & 63\\% & France & 3.75 &         & Sao Tome \\\\\n",
       "\t A. Morin & Kpime       & 1676 & 2015 & 70\\% & France & 2.75 &         & Togo     \\\\\n",
       "\t A. Morin & Atsane      & 1676 & 2015 & 70\\% & France & 3.00 &         & Togo     \\\\\n",
       "\t A. Morin & Akata       & 1680 & 2015 & 70\\% & France & 3.50 &         & Togo     \\\\\n",
       "\t A. Morin & Quilla      & 1704 & 2015 & 70\\% & France & 3.50 &         & Peru     \\\\\n",
       "\t A. Morin & Carenero    & 1315 & 2014 & 70\\% & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| Company \n",
       "(Maker-if known) &lt;chr&gt; | Specific Bean Origin\n",
       "or Bar Name &lt;chr&gt; | REF &lt;dbl&gt; | Review\n",
       "Date &lt;dbl&gt; | Cocoa\n",
       "Percent &lt;chr&gt; | Company\n",
       "Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean\n",
       "Type &lt;chr&gt; | Broad Bean\n",
       "Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Agua Grande | 1876 | 2016 | 63% | France | 3.75 |         | Sao Tome  |\n",
       "| A. Morin | Kpime       | 1676 | 2015 | 70% | France | 2.75 |         | Togo      |\n",
       "| A. Morin | Atsane      | 1676 | 2015 | 70% | France | 3.00 |         | Togo      |\n",
       "| A. Morin | Akata       | 1680 | 2015 | 70% | France | 3.50 |         | Togo      |\n",
       "| A. Morin | Quilla      | 1704 | 2015 | 70% | France | 3.50 |         | Peru      |\n",
       "| A. Morin | Carenero    | 1315 | 2014 | 70% | France | 2.75 | Criollo | Venezuela |\n",
       "\n"
      ],
      "text/plain": [
       "  Company \\n(Maker-if known) Specific Bean Origin\\nor Bar Name REF \n",
       "1 A. Morin                   Agua Grande                       1876\n",
       "2 A. Morin                   Kpime                             1676\n",
       "3 A. Morin                   Atsane                            1676\n",
       "4 A. Morin                   Akata                             1680\n",
       "5 A. Morin                   Quilla                            1704\n",
       "6 A. Morin                   Carenero                          1315\n",
       "  Review\\nDate Cocoa\\nPercent Company\\nLocation Rating Bean\\nType\n",
       "1 2016         63%            France            3.75             \n",
       "2 2015         70%            France            2.75             \n",
       "3 2015         70%            France            3.00             \n",
       "4 2015         70%            France            3.50             \n",
       "5 2015         70%            France            3.50             \n",
       "6 2014         70%            France            2.75   Criollo   \n",
       "  Broad Bean\\nOrigin\n",
       "1 Sao Tome          \n",
       "2 Togo              \n",
       "3 Togo              \n",
       "4 Togo              \n",
       "5 Peru              \n",
       "6 Venezuela         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company \n",
       "(Maker-if known)</th><th scope=col>Specific Bean Origin\n",
       "or Bar Name</th><th scope=col>REF</th><th scope=col>Review\n",
       "Date</th><th scope=col>Cocoa\n",
       "Percent</th><th scope=col>Company\n",
       "Location</th><th scope=col>Rating</th><th scope=col>Bean\n",
       "Type</th><th scope=col>Broad Bean\n",
       "Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Kpime   </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>2.75</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Atsane  </td><td>1676</td><td>2015</td><td>70%</td><td>France</td><td>3.00</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Akata   </td><td>1680</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Quilla  </td><td>1704</td><td>2015</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Peru     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Carenero</td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Cuba    </td><td>1315</td><td>2014</td><td>70%</td><td>France</td><td>3.50</td><td>       </td><td>Cuba     </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company \n",
       "(Maker-if known) & Specific Bean Origin\n",
       "or Bar Name & REF & Review\n",
       "Date & Cocoa\n",
       "Percent & Company\n",
       "Location & Rating & Bean\n",
       "Type & Broad Bean\n",
       "Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Kpime    & 1676 & 2015 & 70\\% & France & 2.75 &         & Togo     \\\\\n",
       "\t A. Morin & Atsane   & 1676 & 2015 & 70\\% & France & 3.00 &         & Togo     \\\\\n",
       "\t A. Morin & Akata    & 1680 & 2015 & 70\\% & France & 3.50 &         & Togo     \\\\\n",
       "\t A. Morin & Quilla   & 1704 & 2015 & 70\\% & France & 3.50 &         & Peru     \\\\\n",
       "\t A. Morin & Carenero & 1315 & 2014 & 70\\% & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\t A. Morin & Cuba     & 1315 & 2014 & 70\\% & France & 3.50 &         & Cuba     \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| Company \n",
       "(Maker-if known) &lt;chr&gt; | Specific Bean Origin\n",
       "or Bar Name &lt;chr&gt; | REF &lt;dbl&gt; | Review\n",
       "Date &lt;dbl&gt; | Cocoa\n",
       "Percent &lt;chr&gt; | Company\n",
       "Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean\n",
       "Type &lt;chr&gt; | Broad Bean\n",
       "Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Kpime    | 1676 | 2015 | 70% | France | 2.75 |         | Togo      |\n",
       "| A. Morin | Atsane   | 1676 | 2015 | 70% | France | 3.00 |         | Togo      |\n",
       "| A. Morin | Akata    | 1680 | 2015 | 70% | France | 3.50 |         | Togo      |\n",
       "| A. Morin | Quilla   | 1704 | 2015 | 70% | France | 3.50 |         | Peru      |\n",
       "| A. Morin | Carenero | 1315 | 2014 | 70% | France | 2.75 | Criollo | Venezuela |\n",
       "| A. Morin | Cuba     | 1315 | 2014 | 70% | France | 3.50 |         | Cuba      |\n",
       "\n"
      ],
      "text/plain": [
       "  Company \\n(Maker-if known) Specific Bean Origin\\nor Bar Name REF \n",
       "1 A. Morin                   Kpime                             1676\n",
       "2 A. Morin                   Atsane                            1676\n",
       "3 A. Morin                   Akata                             1680\n",
       "4 A. Morin                   Quilla                            1704\n",
       "5 A. Morin                   Carenero                          1315\n",
       "6 A. Morin                   Cuba                              1315\n",
       "  Review\\nDate Cocoa\\nPercent Company\\nLocation Rating Bean\\nType\n",
       "1 2015         70%            France            2.75             \n",
       "2 2015         70%            France            3.00             \n",
       "3 2015         70%            France            3.50             \n",
       "4 2015         70%            France            3.50             \n",
       "5 2014         70%            France            2.75   Criollo   \n",
       "6 2014         70%            France            3.50             \n",
       "  Broad Bean\\nOrigin\n",
       "1 Togo              \n",
       "2 Togo              \n",
       "3 Togo              \n",
       "4 Peru              \n",
       "5 Venezuela         \n",
       "6 Cuba              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# \"reset\" our data\n",
    "chocolateData <- read_csv(\"../input/chocolate-bar-ratings/flavors_of_cacao.csv\")\n",
    "head(chocolateData)\n",
    "\n",
    "# remove the first row\n",
    "chocolateData <- chocolateData[-1,]\n",
    "head(chocolateData)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "676b3aa7",
   "metadata": {
    "papermill": {
     "duration": 0.024919,
     "end_time": "2024-01-26T23:33:26.116109",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.091190",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Data Cleaning"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "4b830f0a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:26.170902Z",
     "iopub.status.busy": "2024-01-26T23:33:26.169119Z",
     "iopub.status.idle": "2024-01-26T23:33:26.205818Z",
     "shell.execute_reply": "2024-01-26T23:33:26.203083Z"
    },
    "papermill": {
     "duration": 0.067171,
     "end_time": "2024-01-26T23:33:26.208922",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.141751",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "tibble [1,794 × 9] (S3: tbl_df/tbl/data.frame)\n",
      " $ Company _(Maker-if_known)       : chr [1:1794] \"A. Morin\" \"A. Morin\" \"A. Morin\" \"A. Morin\" ...\n",
      " $ Specific_Bean_Origin_or_Bar_Name: chr [1:1794] \"Kpime\" \"Atsane\" \"Akata\" \"Quilla\" ...\n",
      " $ REF                             : num [1:1794] 1676 1676 1680 1704 1315 ...\n",
      " $ Review_Date                     : num [1:1794] 2015 2015 2015 2015 2014 ...\n",
      " $ Cocoa_Percent                   : chr [1:1794] \"70%\" \"70%\" \"70%\" \"70%\" ...\n",
      " $ Company_Location                : chr [1:1794] \"France\" \"France\" \"France\" \"France\" ...\n",
      " $ Rating                          : num [1:1794] 2.75 3 3.5 3.5 2.75 3.5 3.5 3.75 4 2.75 ...\n",
      " $ Bean_Type                       : chr [1:1794] \" \" \" \" \" \" \" \" ...\n",
      " $ Broad_Bean_Origin               : chr [1:1794] \"Togo\" \"Togo\" \"Togo\" \"Peru\" ...\n"
     ]
    }
   ],
   "source": [
    "# remove white space in column names of dataset (taken directly from the other source)\n",
    "names(chocolateData) <- gsub(\"[[:space:]+]\", \"_\", names(chocolateData))\n",
    "str(chocolateData)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "ce6f05a9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:26.263136Z",
     "iopub.status.busy": "2024-01-26T23:33:26.261173Z",
     "iopub.status.idle": "2024-01-26T23:33:26.288367Z",
     "shell.execute_reply": "2024-01-26T23:33:26.286236Z"
    },
    "papermill": {
     "duration": 0.057164,
     "end_time": "2024-01-26T23:33:26.291193",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.234029",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "tibble [0 × 9] (S3: tbl_df/tbl/data.frame)\n",
      " $ Company _(Maker-if_known)       : chr(0) \n",
      " $ Specific_Bean_Origin_or_Bar_Name: chr(0) \n",
      " $ REF                             : num(0) \n",
      " $ Review_Date                     : num(0) \n",
      " $ Cocoa_Percent                   : chr(0) \n",
      " $ Company_Location                : chr(0) \n",
      " $ Rating                          : num(0) \n",
      " $ Bean_Type                       : chr(0) \n",
      " $ Broad_Bean_Origin               : chr(0) \n"
     ]
    }
   ],
   "source": [
    "# check data type of columns\n",
    "str(chocolateData[0,])\n",
    "# you could also just use str(chocolateData) like in the previous cell, and it\n",
    "#will provide more information"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6ea99274",
   "metadata": {
    "papermill": {
     "duration": 0.024872,
     "end_time": "2024-01-26T23:33:26.341556",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.316684",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "```R```: whatever comes right after it is a column in a data_frame. You can use this to look at specific columns in a data_frame, like so:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "de5d553e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:26.396638Z",
     "iopub.status.busy": "2024-01-26T23:33:26.394886Z",
     "iopub.status.idle": "2024-01-26T23:33:26.419878Z",
     "shell.execute_reply": "2024-01-26T23:33:26.417269Z"
    },
    "papermill": {
     "duration": 0.056979,
     "end_time": "2024-01-26T23:33:26.423532",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.366553",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>2.75</li><li>3</li><li>3.5</li><li>3.5</li><li>2.75</li><li>3.5</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 2.75\n",
       "\\item 3\n",
       "\\item 3.5\n",
       "\\item 3.5\n",
       "\\item 2.75\n",
       "\\item 3.5\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 2.75\n",
       "2. 3\n",
       "3. 3.5\n",
       "4. 3.5\n",
       "5. 2.75\n",
       "6. 3.5\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 2.75 3.00 3.50 3.50 2.75 3.50"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#print the first few values from the column named \"Rating\" in the dataframe \"chocolateData\" \n",
    "head(chocolateData$Rating)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8c112bf0",
   "metadata": {
    "papermill": {
     "duration": 0.025782,
     "end_time": "2024-01-26T23:33:26.474161",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.448379",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Thing says to convert columns to num with ```as.numeric()``` or ```type_convert()```, but they have already been converted here.\n",
    "- btw ```type_convert()``` looks at the first 1000 rows of each column to guess waht data type that column should be, then converts the data in the column to that type.\n",
    "\n",
    "There is one thing we still have to convert though, column \"Cocoa_Percent\" which is likely still a character because of the % symbol. Thus we can remove the percent symbols and then convert"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "a55dc80e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:26.530215Z",
     "iopub.status.busy": "2024-01-26T23:33:26.528330Z",
     "iopub.status.idle": "2024-01-26T23:33:26.589903Z",
     "shell.execute_reply": "2024-01-26T23:33:26.587179Z"
    },
    "papermill": {
     "duration": 0.094414,
     "end_time": "2024-01-26T23:33:26.593820",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.499406",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "tibble [1,794 × 9] (S3: tbl_df/tbl/data.frame)\n",
      " $ Company _(Maker-if_known)       : chr [1:1794] \"A. Morin\" \"A. Morin\" \"A. Morin\" \"A. Morin\" ...\n",
      " $ Specific_Bean_Origin_or_Bar_Name: chr [1:1794] \"Kpime\" \"Atsane\" \"Akata\" \"Quilla\" ...\n",
      " $ REF                             : num [1:1794] 1676 1676 1680 1704 1315 ...\n",
      " $ Review_Date                     : num [1:1794] 2015 2015 2015 2015 2014 ...\n",
      " $ Cocoa_Percent                   : num [1:1794] 70 70 70 70 70 70 70 70 70 70 ...\n",
      " $ Company_Location                : chr [1:1794] \"France\" \"France\" \"France\" \"France\" ...\n",
      " $ Rating                          : num [1:1794] 2.75 3 3.5 3.5 2.75 3.5 3.5 3.75 4 2.75 ...\n",
      " $ Bean_Type                       : chr [1:1794] \" \" \" \" \" \" \" \" ...\n",
      " $ Broad_Bean_Origin               : chr [1:1794] \"Togo\" \"Togo\" \"Togo\" \"Peru\" ...\n"
     ]
    }
   ],
   "source": [
    "# remove all percent signs in the fifth (Cocoa_Percent) column\n",
    "# apparently we don't really need to know what's going on rn\n",
    "chocolateData$Cocoa_Percent <- sapply(chocolateData$Cocoa_Percent, function(x) gsub(\"%\", \"\", x))\n",
    "                                      \n",
    "# use type_convert(), except I'm gonna see if I can get away with just\n",
    "#converting the 5th column\n",
    "#chocolateData$Cocoa_Percent <- type_convert(chocolateData$Cocoa_Percent)\n",
    "# turns out you can't do that bc you need to use type_convert on a dataset.\n",
    "#Will try as.numeric() then\n",
    "chocolateData$Cocoa_Percent <- as.numeric(chocolateData$Cocoa_Percent)\n",
    "\n",
    "# check\n",
    "str(chocolateData)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ea44db31",
   "metadata": {
    "papermill": {
     "duration": 0.026073,
     "end_time": "2024-01-26T23:33:26.649070",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.622997",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Summarizing Data\n",
    "\n",
    "Turns out R is kinda cool and you have multiple ways to summarize it, allowing a lot of flexibility.\n",
    "\n",
    "We will try two functions\n",
    "- ```summary()``` from base R\n",
    "- ```summarise_all()``` from Tidyverse\n",
    "\n",
    "You can find more about any function by looking at the documentation\n",
    "- in kernel via a ? in frnt of the function name, with no parentheses after the function (will only show the last one in a cell though)\n",
    "- search engines also help"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "903ed71f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:26.706084Z",
     "iopub.status.busy": "2024-01-26T23:33:26.704097Z",
     "iopub.status.idle": "2024-01-26T23:33:26.989580Z",
     "shell.execute_reply": "2024-01-26T23:33:26.986828Z"
    },
    "papermill": {
     "duration": 0.318362,
     "end_time": "2024-01-26T23:33:26.993411",
     "exception": false,
     "start_time": "2024-01-26T23:33:26.675049",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# find more about summary()\n",
    "?summary"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "3980d886",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:27.047531Z",
     "iopub.status.busy": "2024-01-26T23:33:27.045777Z",
     "iopub.status.idle": "2024-01-26T23:33:27.222795Z",
     "shell.execute_reply": "2024-01-26T23:33:27.219287Z"
    },
    "papermill": {
     "duration": 0.209713,
     "end_time": "2024-01-26T23:33:27.228007",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.018294",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# learn about summarise_all()\n",
    "?summarise_all()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "290b2ff9",
   "metadata": {
    "papermill": {
     "duration": 0.025563,
     "end_time": "2024-01-26T23:33:27.280683",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.255120",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "I'm not gonna lie, I barely understood any of that"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "f43b9488",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:27.339663Z",
     "iopub.status.busy": "2024-01-26T23:33:27.337677Z",
     "iopub.status.idle": "2024-01-26T23:33:27.364452Z",
     "shell.execute_reply": "2024-01-26T23:33:27.361785Z"
    },
    "papermill": {
     "duration": 0.059639,
     "end_time": "2024-01-26T23:33:27.367467",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.307828",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       " Company _(Maker-if_known) Specific_Bean_Origin_or_Bar_Name      REF      \n",
       " Length:1794               Length:1794                      Min.   :   5  \n",
       " Class :character          Class :character                 1st Qu.: 576  \n",
       " Mode  :character          Mode  :character                 Median :1069  \n",
       "                                                            Mean   :1035  \n",
       "                                                            3rd Qu.:1502  \n",
       "                                                            Max.   :1952  \n",
       "  Review_Date   Cocoa_Percent   Company_Location       Rating     \n",
       " Min.   :2006   Min.   : 42.0   Length:1794        Min.   :1.000  \n",
       " 1st Qu.:2010   1st Qu.: 70.0   Class :character   1st Qu.:2.812  \n",
       " Median :2013   Median : 70.0   Mode  :character   Median :3.250  \n",
       " Mean   :2012   Mean   : 71.7                      Mean   :3.186  \n",
       " 3rd Qu.:2015   3rd Qu.: 75.0                      3rd Qu.:3.500  \n",
       " Max.   :2017   Max.   :100.0                      Max.   :5.000  \n",
       "  Bean_Type         Broad_Bean_Origin \n",
       " Length:1794        Length:1794       \n",
       " Class :character   Class :character  \n",
       " Mode  :character   Mode  :character  \n",
       "                                      \n",
       "                                      \n",
       "                                      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(chocolateData)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "4917ff06",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:27.429883Z",
     "iopub.status.busy": "2024-01-26T23:33:27.427992Z",
     "iopub.status.idle": "2024-01-26T23:33:27.634557Z",
     "shell.execute_reply": "2024-01-26T23:33:27.632356Z"
    },
    "papermill": {
     "duration": 0.242406,
     "end_time": "2024-01-26T23:33:27.637275",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.394869",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“\u001b[1m\u001b[22mThere were 5 warnings in `summarise()`.\n",
      "The first warning was:\n",
      "\u001b[1m\u001b[22m\u001b[36mℹ\u001b[39m In argument: `Company _(Maker-if_known) = (function (x, ...) ...`.\n",
      "Caused by warning in `mean.default()`:\n",
      "\u001b[33m!\u001b[39m argument is not numeric or logical: returning NA\n",
      "\u001b[1m\u001b[22m\u001b[36mℹ\u001b[39m Run `dplyr::last_dplyr_warnings()` to see the 4 remaining warnings.”\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company _(Maker-if_known)</th><th scope=col>Specific_Bean_Origin_or_Bar_Name</th><th scope=col>REF</th><th scope=col>Review_Date</th><th scope=col>Cocoa_Percent</th><th scope=col>Company_Location</th><th scope=col>Rating</th><th scope=col>Bean_Type</th><th scope=col>Broad_Bean_Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>NA</td><td>NA</td><td>1035.436</td><td>2012.323</td><td>71.70318</td><td>NA</td><td>3.185619</td><td>NA</td><td>NA</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company \\_(Maker-if\\_known) & Specific\\_Bean\\_Origin\\_or\\_Bar\\_Name & REF & Review\\_Date & Cocoa\\_Percent & Company\\_Location & Rating & Bean\\_Type & Broad\\_Bean\\_Origin\\\\\n",
       " <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t NA & NA & 1035.436 & 2012.323 & 71.70318 & NA & 3.185619 & NA & NA\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 9\n",
       "\n",
       "| Company _(Maker-if_known) &lt;dbl&gt; | Specific_Bean_Origin_or_Bar_Name &lt;dbl&gt; | REF &lt;dbl&gt; | Review_Date &lt;dbl&gt; | Cocoa_Percent &lt;dbl&gt; | Company_Location &lt;dbl&gt; | Rating &lt;dbl&gt; | Bean_Type &lt;dbl&gt; | Broad_Bean_Origin &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| NA | NA | 1035.436 | 2012.323 | 71.70318 | NA | 3.185619 | NA | NA |\n",
       "\n"
      ],
      "text/plain": [
       "  Company _(Maker-if_known) Specific_Bean_Origin_or_Bar_Name REF     \n",
       "1 NA                        NA                               1035.436\n",
       "  Review_Date Cocoa_Percent Company_Location Rating   Bean_Type\n",
       "1 2012.323    71.70318      NA               3.185619 NA       \n",
       "  Broad_Bean_Origin\n",
       "1 NA               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# from dplyr in Tidyverse\n",
    "# needs to tell which dataset to summarize, and what function to use\n",
    "# we are using the one to find average using list(mean) (funs() is deprecated)\n",
    "summarise_all(chocolateData, list(mean))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "061c736e",
   "metadata": {
    "papermill": {
     "duration": 0.026725,
     "end_time": "2024-01-26T23:33:27.691329",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.664604",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "I assume the 5 warnings are becuase of the character columns. \n",
    "\n",
    "Should probably then try ```summarise_at()``` or ```summarise_if()``` but I can't get them to work."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "d660c1d5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:27.750632Z",
     "iopub.status.busy": "2024-01-26T23:33:27.748731Z",
     "iopub.status.idle": "2024-01-26T23:33:27.940993Z",
     "shell.execute_reply": "2024-01-26T23:33:27.937305Z"
    },
    "papermill": {
     "duration": 0.226697,
     "end_time": "2024-01-26T23:33:27.945207",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.718510",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“\u001b[1m\u001b[22mThere were 5 warnings in `summarise()`.\n",
      "The first warning was:\n",
      "\u001b[1m\u001b[22m\u001b[36mℹ\u001b[39m In argument: `Company _(Maker-if_known) = (function (x, na.rm = FALSE) ...`.\n",
      "Caused by warning in `var()`:\n",
      "\u001b[33m!\u001b[39m NAs introduced by coercion\n",
      "\u001b[1m\u001b[22m\u001b[36mℹ\u001b[39m Run `dplyr::last_dplyr_warnings()` to see the 4 remaining warnings.”\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company _(Maker-if_known)</th><th scope=col>Specific_Bean_Origin_or_Bar_Name</th><th scope=col>REF</th><th scope=col>Review_Date</th><th scope=col>Cocoa_Percent</th><th scope=col>Company_Location</th><th scope=col>Rating</th><th scope=col>Bean_Type</th><th scope=col>Broad_Bean_Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>NA</td><td>NA</td><td>552.6843</td><td>2.926739</td><td>6.321543</td><td>NA</td><td>0.47801</td><td>NA</td><td>NA</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company \\_(Maker-if\\_known) & Specific\\_Bean\\_Origin\\_or\\_Bar\\_Name & REF & Review\\_Date & Cocoa\\_Percent & Company\\_Location & Rating & Bean\\_Type & Broad\\_Bean\\_Origin\\\\\n",
       " <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t NA & NA & 552.6843 & 2.926739 & 6.321543 & NA & 0.47801 & NA & NA\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 9\n",
       "\n",
       "| Company _(Maker-if_known) &lt;dbl&gt; | Specific_Bean_Origin_or_Bar_Name &lt;dbl&gt; | REF &lt;dbl&gt; | Review_Date &lt;dbl&gt; | Cocoa_Percent &lt;dbl&gt; | Company_Location &lt;dbl&gt; | Rating &lt;dbl&gt; | Bean_Type &lt;dbl&gt; | Broad_Bean_Origin &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| NA | NA | 552.6843 | 2.926739 | 6.321543 | NA | 0.47801 | NA | NA |\n",
       "\n"
      ],
      "text/plain": [
       "  Company _(Maker-if_known) Specific_Bean_Origin_or_Bar_Name REF     \n",
       "1 NA                        NA                               552.6843\n",
       "  Review_Date Cocoa_Percent Company_Location Rating  Bean_Type\n",
       "1 2.926739    6.321543      NA               0.47801 NA       \n",
       "  Broad_Bean_Origin\n",
       "1 NA               "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summarise_all(chocolateData, list(sd))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "eca4bd3e",
   "metadata": {
    "papermill": {
     "duration": 0.027686,
     "end_time": "2024-01-26T23:33:28.001434",
     "exception": false,
     "start_time": "2024-01-26T23:33:27.973748",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Summarizing a specific variable\n",
    "\n",
    "We can look at specific stuff using ```summarise()``` and pipes. Pipes are part of the Tidyverse package.\n",
    "> pipes apparently look like this ```%>%``` and pass right side output to the left side.\n",
    "\n",
    "Let's take our chocolate dataset and then pipe it to the summarise() function. The summarise() function will return a data_frame, where each column contains a specific type of information we've asked for and has a name we've given in. In this example, we're going to get back two columns. One, called \"averageRating\" will have the average of the Rating column in it, while the second, called \"sdRating\" will have the standard deviation of the Rating column in it."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "0ac183a5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:28.070287Z",
     "iopub.status.busy": "2024-01-26T23:33:28.067993Z",
     "iopub.status.idle": "2024-01-26T23:33:28.112755Z",
     "shell.execute_reply": "2024-01-26T23:33:28.109320Z"
    },
    "papermill": {
     "duration": 0.084387,
     "end_time": "2024-01-26T23:33:28.117176",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.032789",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>averageRating</th><th scope=col>sdRating</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>3.185619</td><td>0.47801</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 2\n",
       "\\begin{tabular}{ll}\n",
       " averageRating & sdRating\\\\\n",
       " <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 3.185619 & 0.47801\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 2\n",
       "\n",
       "| averageRating &lt;dbl&gt; | sdRating &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| 3.185619 | 0.47801 |\n",
       "\n"
      ],
      "text/plain": [
       "  averageRating sdRating\n",
       "1 3.185619      0.47801 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# return a data_frame with the mean and sd of the Rating column, from the chocolate\n",
    "# dataset in it\n",
    "chocolateData %>%\n",
    "    summarise(averageRating = mean(Rating),\n",
    "             sdRating = sd(Rating))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b9d1b2fa",
   "metadata": {
    "papermill": {
     "duration": 0.028526,
     "end_time": "2024-01-26T23:33:28.174223",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.145697",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Why the funky formatting?\n",
    "- makes it easier to read as code lines get really long\n",
    "For R line breaks only work after specific characters like ```,```, ```%?%```, and ```+```, but we will learn more about it later."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "5fa53108",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:28.236544Z",
     "iopub.status.busy": "2024-01-26T23:33:28.234462Z",
     "iopub.status.idle": "2024-01-26T23:33:28.272927Z",
     "shell.execute_reply": "2024-01-26T23:33:28.269845Z"
    },
    "papermill": {
     "duration": 0.073743,
     "end_time": "2024-01-26T23:33:28.277148",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.203405",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>averageCocoaPerc</th><th scope=col>sdCocoaPerc</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>71.70318</td><td>6.321543</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 2\n",
       "\\begin{tabular}{ll}\n",
       " averageCocoaPerc & sdCocoaPerc\\\\\n",
       " <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 71.70318 & 6.321543\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 2\n",
       "\n",
       "| averageCocoaPerc &lt;dbl&gt; | sdCocoaPerc &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| 71.70318 | 6.321543 |\n",
       "\n"
      ],
      "text/plain": [
       "  averageCocoaPerc sdCocoaPerc\n",
       "1 71.70318         6.321543   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# try it on my own but with the Cocoa_Percent column\n",
    "chocolateData %>%\n",
    "    summarise(averageCocoaPerc = mean(Cocoa_Percent),\n",
    "             sdCocoaPerc = sd(Cocoa_Percent))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "800f8cfd",
   "metadata": {
    "papermill": {
     "duration": 0.030739,
     "end_time": "2024-01-26T23:33:28.337349",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.306610",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Summarize a specific variable by group\n",
    "\n",
    "At first pass, it may seem a bit silly to do things like calculate the mean and standard deviation this way. You can see why this is such a power technique, however, when we look at the the same variable across groups.\n",
    "\n",
    "We can use this with a hand function called ```group_by()```. When you pipe a dataset into the ```group_by()``` function and tell it the name of a specific column, then it will look at all the values in that column and group together all the rows that have the same value in a given column. Then, when you pipe that data into the summarise() function, it will return the values you asked for for each group separately. Like so:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "543f6de1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:28.398615Z",
     "iopub.status.busy": "2024-01-26T23:33:28.396746Z",
     "iopub.status.idle": "2024-01-26T23:33:28.448594Z",
     "shell.execute_reply": "2024-01-26T23:33:28.445979Z"
    },
    "papermill": {
     "duration": 0.085902,
     "end_time": "2024-01-26T23:33:28.451842",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.365940",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Review_Date</th><th scope=col>averageRating</th><th scope=col>sdRating</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2006</td><td>3.125000</td><td>0.7691224</td></tr>\n",
       "\t<tr><td>2007</td><td>3.162338</td><td>0.6998193</td></tr>\n",
       "\t<tr><td>2008</td><td>2.994624</td><td>0.5442118</td></tr>\n",
       "\t<tr><td>2009</td><td>3.073171</td><td>0.4591195</td></tr>\n",
       "\t<tr><td>2010</td><td>3.148649</td><td>0.4663426</td></tr>\n",
       "\t<tr><td>2011</td><td>3.256061</td><td>0.4899536</td></tr>\n",
       "\t<tr><td>2012</td><td>3.178205</td><td>0.4835962</td></tr>\n",
       "\t<tr><td>2013</td><td>3.197011</td><td>0.4461178</td></tr>\n",
       "\t<tr><td>2014</td><td>3.189271</td><td>0.4148615</td></tr>\n",
       "\t<tr><td>2015</td><td>3.246491</td><td>0.3810960</td></tr>\n",
       "\t<tr><td>2016</td><td>3.223624</td><td>0.4200386</td></tr>\n",
       "\t<tr><td>2017</td><td>3.312500</td><td>0.3317444</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Review\\_Date & averageRating & sdRating\\\\\n",
       " <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2006 & 3.125000 & 0.7691224\\\\\n",
       "\t 2007 & 3.162338 & 0.6998193\\\\\n",
       "\t 2008 & 2.994624 & 0.5442118\\\\\n",
       "\t 2009 & 3.073171 & 0.4591195\\\\\n",
       "\t 2010 & 3.148649 & 0.4663426\\\\\n",
       "\t 2011 & 3.256061 & 0.4899536\\\\\n",
       "\t 2012 & 3.178205 & 0.4835962\\\\\n",
       "\t 2013 & 3.197011 & 0.4461178\\\\\n",
       "\t 2014 & 3.189271 & 0.4148615\\\\\n",
       "\t 2015 & 3.246491 & 0.3810960\\\\\n",
       "\t 2016 & 3.223624 & 0.4200386\\\\\n",
       "\t 2017 & 3.312500 & 0.3317444\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 3\n",
       "\n",
       "| Review_Date &lt;dbl&gt; | averageRating &lt;dbl&gt; | sdRating &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2006 | 3.125000 | 0.7691224 |\n",
       "| 2007 | 3.162338 | 0.6998193 |\n",
       "| 2008 | 2.994624 | 0.5442118 |\n",
       "| 2009 | 3.073171 | 0.4591195 |\n",
       "| 2010 | 3.148649 | 0.4663426 |\n",
       "| 2011 | 3.256061 | 0.4899536 |\n",
       "| 2012 | 3.178205 | 0.4835962 |\n",
       "| 2013 | 3.197011 | 0.4461178 |\n",
       "| 2014 | 3.189271 | 0.4148615 |\n",
       "| 2015 | 3.246491 | 0.3810960 |\n",
       "| 2016 | 3.223624 | 0.4200386 |\n",
       "| 2017 | 3.312500 | 0.3317444 |\n",
       "\n"
      ],
      "text/plain": [
       "   Review_Date averageRating sdRating \n",
       "1  2006        3.125000      0.7691224\n",
       "2  2007        3.162338      0.6998193\n",
       "3  2008        2.994624      0.5442118\n",
       "4  2009        3.073171      0.4591195\n",
       "5  2010        3.148649      0.4663426\n",
       "6  2011        3.256061      0.4899536\n",
       "7  2012        3.178205      0.4835962\n",
       "8  2013        3.197011      0.4461178\n",
       "9  2014        3.189271      0.4148615\n",
       "10 2015        3.246491      0.3810960\n",
       "11 2016        3.223624      0.4200386\n",
       "12 2017        3.312500      0.3317444"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Return the average and sd of ratings by the year a rating was given\n",
    "chocolateData %>%\n",
    "    group_by(Review_Date) %>%\n",
    "    summarise(averageRating = mean(Rating),\n",
    "             sdRating = sd(Rating))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "f2972bc3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:28.511394Z",
     "iopub.status.busy": "2024-01-26T23:33:28.509589Z",
     "iopub.status.idle": "2024-01-26T23:33:28.552263Z",
     "shell.execute_reply": "2024-01-26T23:33:28.549274Z"
    },
    "papermill": {
     "duration": 0.07653,
     "end_time": "2024-01-26T23:33:28.555913",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.479383",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Review_Date</th><th scope=col>averageCocoaPerc</th><th scope=col>sdCocoaPerc</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2006</td><td>71.00000</td><td>7.424740</td></tr>\n",
       "\t<tr><td>2007</td><td>72.03896</td><td>6.951792</td></tr>\n",
       "\t<tr><td>2008</td><td>72.69892</td><td>8.412962</td></tr>\n",
       "\t<tr><td>2009</td><td>70.44309</td><td>6.895057</td></tr>\n",
       "\t<tr><td>2010</td><td>70.77928</td><td>7.424678</td></tr>\n",
       "\t<tr><td>2011</td><td>70.96970</td><td>5.377714</td></tr>\n",
       "\t<tr><td>2012</td><td>71.52821</td><td>5.725056</td></tr>\n",
       "\t<tr><td>2013</td><td>72.26630</td><td>8.325992</td></tr>\n",
       "\t<tr><td>2014</td><td>72.25304</td><td>5.201014</td></tr>\n",
       "\t<tr><td>2015</td><td>72.01404</td><td>5.258777</td></tr>\n",
       "\t<tr><td>2016</td><td>71.79817</td><td>5.490301</td></tr>\n",
       "\t<tr><td>2017</td><td>71.54167</td><td>2.702321</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Review\\_Date & averageCocoaPerc & sdCocoaPerc\\\\\n",
       " <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2006 & 71.00000 & 7.424740\\\\\n",
       "\t 2007 & 72.03896 & 6.951792\\\\\n",
       "\t 2008 & 72.69892 & 8.412962\\\\\n",
       "\t 2009 & 70.44309 & 6.895057\\\\\n",
       "\t 2010 & 70.77928 & 7.424678\\\\\n",
       "\t 2011 & 70.96970 & 5.377714\\\\\n",
       "\t 2012 & 71.52821 & 5.725056\\\\\n",
       "\t 2013 & 72.26630 & 8.325992\\\\\n",
       "\t 2014 & 72.25304 & 5.201014\\\\\n",
       "\t 2015 & 72.01404 & 5.258777\\\\\n",
       "\t 2016 & 71.79817 & 5.490301\\\\\n",
       "\t 2017 & 71.54167 & 2.702321\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 3\n",
       "\n",
       "| Review_Date &lt;dbl&gt; | averageCocoaPerc &lt;dbl&gt; | sdCocoaPerc &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2006 | 71.00000 | 7.424740 |\n",
       "| 2007 | 72.03896 | 6.951792 |\n",
       "| 2008 | 72.69892 | 8.412962 |\n",
       "| 2009 | 70.44309 | 6.895057 |\n",
       "| 2010 | 70.77928 | 7.424678 |\n",
       "| 2011 | 70.96970 | 5.377714 |\n",
       "| 2012 | 71.52821 | 5.725056 |\n",
       "| 2013 | 72.26630 | 8.325992 |\n",
       "| 2014 | 72.25304 | 5.201014 |\n",
       "| 2015 | 72.01404 | 5.258777 |\n",
       "| 2016 | 71.79817 | 5.490301 |\n",
       "| 2017 | 71.54167 | 2.702321 |\n",
       "\n"
      ],
      "text/plain": [
       "   Review_Date averageCocoaPerc sdCocoaPerc\n",
       "1  2006        71.00000         7.424740   \n",
       "2  2007        72.03896         6.951792   \n",
       "3  2008        72.69892         8.412962   \n",
       "4  2009        70.44309         6.895057   \n",
       "5  2010        70.77928         7.424678   \n",
       "6  2011        70.96970         5.377714   \n",
       "7  2012        71.52821         5.725056   \n",
       "8  2013        72.26630         8.325992   \n",
       "9  2014        72.25304         5.201014   \n",
       "10 2015        72.01404         5.258777   \n",
       "11 2016        71.79817         5.490301   \n",
       "12 2017        71.54167         2.702321   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# ngl that was pretty cool, trying it with Cocoa_Percent now\n",
    "chocolateData %>%\n",
    "    group_by(Review_Date) %>% # still same thing we are groupding by\n",
    "    summarise(averageCocoaPerc = mean(Cocoa_Percent),\n",
    "              sdCocoaPerc = sd(Cocoa_Percent))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2e45a44e",
   "metadata": {
    "papermill": {
     "duration": 0.027583,
     "end_time": "2024-01-26T23:33:28.610872",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.583289",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "This is a really efficient way to start understanding your data. For example, it looks like chocolate bar ratings might be trending slightly upwards by year. In the mid 2000's they were around 3.0, and now they're closer to 3.3.\n",
    "\n",
    "On the other hand, there don't seem to be much changes in CocoaPercent, although maybe they're less volatile now bc the sd seems to be just slightly decreasing?\n",
    "\n",
    "To really get a better understanding of this, however, I really want to want to graph this data so that I can see if there's been reliable change over time. So let's move on to the final part of this tutorial: graphing!"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5320bef5",
   "metadata": {
    "papermill": {
     "duration": 0.027212,
     "end_time": "2024-01-26T23:33:28.665304",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.638092",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Graphing Data\n",
    "\n",
    "hey guess who can't load their data again"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "3bf44754",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-26T23:33:28.725126Z",
     "iopub.status.busy": "2024-01-26T23:33:28.723164Z",
     "iopub.status.idle": "2024-01-26T23:33:28.914246Z",
     "shell.execute_reply": "2024-01-26T23:33:28.911251Z"
    },
    "papermill": {
     "duration": 0.225801,
     "end_time": "2024-01-26T23:33:28.918386",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.692585",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1mRows: \u001b[22m\u001b[34m1795\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m9\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m (6): Company \n",
      "(Maker-if known), Specific Bean Origin\n",
      "or Bar Name, Cocoa\n",
      "...\n",
      "\u001b[32mdbl\u001b[39m (3): REF, Review\n",
      "Date, Rating\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "cols(\n",
      "  `Company _(Maker-if_known)` = \u001b[31mcol_character()\u001b[39m,\n",
      "  Specific_Bean_Origin_or_Bar_Name = \u001b[31mcol_character()\u001b[39m,\n",
      "  Cocoa_Percent = \u001b[32mcol_double()\u001b[39m,\n",
      "  Company_Location = \u001b[31mcol_character()\u001b[39m,\n",
      "  Bean_Type = \u001b[31mcol_character()\u001b[39m,\n",
      "  Broad_Bean_Origin = \u001b[31mcol_character()\u001b[39m\n",
      ")\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Company _(Maker-if_known)</th><th scope=col>Specific_Bean_Origin_or_Bar_Name</th><th scope=col>REF</th><th scope=col>Review_Date</th><th scope=col>Cocoa_Percent</th><th scope=col>Company_Location</th><th scope=col>Rating</th><th scope=col>Bean_Type</th><th scope=col>Broad_Bean_Origin</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>A. Morin</td><td>Agua Grande</td><td>1876</td><td>2016</td><td>63</td><td>France</td><td>3.75</td><td>       </td><td>Sao Tome </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Kpime      </td><td>1676</td><td>2015</td><td>70</td><td>France</td><td>2.75</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Atsane     </td><td>1676</td><td>2015</td><td>70</td><td>France</td><td>3.00</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Akata      </td><td>1680</td><td>2015</td><td>70</td><td>France</td><td>3.50</td><td>       </td><td>Togo     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Quilla     </td><td>1704</td><td>2015</td><td>70</td><td>France</td><td>3.50</td><td>       </td><td>Peru     </td></tr>\n",
       "\t<tr><td>A. Morin</td><td>Carenero   </td><td>1315</td><td>2014</td><td>70</td><td>France</td><td>2.75</td><td>Criollo</td><td>Venezuela</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Company \\_(Maker-if\\_known) & Specific\\_Bean\\_Origin\\_or\\_Bar\\_Name & REF & Review\\_Date & Cocoa\\_Percent & Company\\_Location & Rating & Bean\\_Type & Broad\\_Bean\\_Origin\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t A. Morin & Agua Grande & 1876 & 2016 & 63 & France & 3.75 &         & Sao Tome \\\\\n",
       "\t A. Morin & Kpime       & 1676 & 2015 & 70 & France & 2.75 &         & Togo     \\\\\n",
       "\t A. Morin & Atsane      & 1676 & 2015 & 70 & France & 3.00 &         & Togo     \\\\\n",
       "\t A. Morin & Akata       & 1680 & 2015 & 70 & France & 3.50 &         & Togo     \\\\\n",
       "\t A. Morin & Quilla      & 1704 & 2015 & 70 & France & 3.50 &         & Peru     \\\\\n",
       "\t A. Morin & Carenero    & 1315 & 2014 & 70 & France & 2.75 & Criollo & Venezuela\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 9\n",
       "\n",
       "| Company _(Maker-if_known) &lt;chr&gt; | Specific_Bean_Origin_or_Bar_Name &lt;chr&gt; | REF &lt;dbl&gt; | Review_Date &lt;dbl&gt; | Cocoa_Percent &lt;dbl&gt; | Company_Location &lt;chr&gt; | Rating &lt;dbl&gt; | Bean_Type &lt;chr&gt; | Broad_Bean_Origin &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| A. Morin | Agua Grande | 1876 | 2016 | 63 | France | 3.75 |         | Sao Tome  |\n",
       "| A. Morin | Kpime       | 1676 | 2015 | 70 | France | 2.75 |         | Togo      |\n",
       "| A. Morin | Atsane      | 1676 | 2015 | 70 | France | 3.00 |         | Togo      |\n",
       "| A. Morin | Akata       | 1680 | 2015 | 70 | France | 3.50 |         | Togo      |\n",
       "| A. Morin | Quilla      | 1704 | 2015 | 70 | France | 3.50 |         | Peru      |\n",
       "| A. Morin | Carenero    | 1315 | 2014 | 70 | France | 2.75 | Criollo | Venezuela |\n",
       "\n"
      ],
      "text/plain": [
       "  Company _(Maker-if_known) Specific_Bean_Origin_or_Bar_Name REF  Review_Date\n",
       "1 A. Morin                  Agua Grande                      1876 2016       \n",
       "2 A. Morin                  Kpime                            1676 2015       \n",
       "3 A. Morin                  Atsane                           1676 2015       \n",
       "4 A. Morin                  Akata                            1680 2015       \n",
       "5 A. Morin                  Quilla                           1704 2015       \n",
       "6 A. Morin                  Carenero                         1315 2014       \n",
       "  Cocoa_Percent Company_Location Rating Bean_Type Broad_Bean_Origin\n",
       "1 63            France           3.75             Sao Tome         \n",
       "2 70            France           2.75             Togo             \n",
       "3 70            France           3.00             Togo             \n",
       "4 70            France           3.50             Togo             \n",
       "5 70            France           3.50             Peru             \n",
       "6 70            France           2.75   Criollo   Venezuela        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "spc_tbl_ [1,795 × 9] (S3: spec_tbl_df/tbl_df/tbl/data.frame)\n",
      " $ Company _(Maker-if_known)       : chr [1:1795] \"A. Morin\" \"A. Morin\" \"A. Morin\" \"A. Morin\" ...\n",
      " $ Specific_Bean_Origin_or_Bar_Name: chr [1:1795] \"Agua Grande\" \"Kpime\" \"Atsane\" \"Akata\" ...\n",
      " $ REF                             : num [1:1795] 1876 1676 1676 1680 1704 ...\n",
      " $ Review_Date                     : num [1:1795] 2016 2015 2015 2015 2015 ...\n",
      " $ Cocoa_Percent                   : num [1:1795] 63 70 70 70 70 70 70 70 70 70 ...\n",
      " $ Company_Location                : chr [1:1795] \"France\" \"France\" \"France\" \"France\" ...\n",
      " $ Rating                          : num [1:1795] 3.75 2.75 3 3.5 3.5 2.75 3.5 3.5 3.75 4 ...\n",
      " $ Bean_Type                       : chr [1:1795] \" \" \" \" \" \" \" \" ...\n",
      " $ Broad_Bean_Origin               : chr [1:1795] \"Sao Tome\" \"Togo\" \"Togo\" \"Togo\" ...\n",
      " - attr(*, \"problems\")=<externalptr> \n"
     ]
    }
   ],
   "source": [
    "library(tidyverse)\n",
    "\n",
    "# load data again (for practice)\n",
    "chocolateData <- read_csv(\"../input/chocolate-bar-ratings/flavors_of_cacao.csv\")\n",
    "\n",
    "# remove white spaces in column names\n",
    "# names(dataset) returns column names I guess?\n",
    "names(chocolateData) <- gsub(\"[[:space:]+]\", \"_\", names(chocolateData))\n",
    "\n",
    "# remove percentage signs in the Cocoa_Percent \n",
    "chocolateData$Cocoa_Percent <- sapply(chocolateData$Cocoa_Percent, function(x) gsub(\"%\", \"\", x))\n",
    "\n",
    "# automatically try to guess the data type of each column using type_convert\n",
    "chocolateData <- type_convert(chocolateData)\n",
    "    \n",
    "# check the first few lines of our data_frame to make sure everything looks alright.\n",
    "# Do you remember which function we've been using to do this?\n",
    "head(chocolateData)\n",
    "str(chocolateData)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a045162a",
   "metadata": {
    "papermill": {
     "duration": 0.028917,
     "end_time": "2024-01-26T23:33:28.976863",
     "exception": false,
     "start_time": "2024-01-26T23:33:28.947946",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Graph with ggplot2\n",
    "\n",
    "Alright, now we've got our data and it's ready and clean! Time to make some graphs. To do this, we're going to use a library called \"ggplot2\", which is part of the tidyverse collection of packages. (Which means, since we've already imported the \"tidyverse\" library, we don't have to do anything else to start using it.)\n",
    "\n",
    ">The \"gg\" in \"ggplot\" stands for \"the grammar of graphics\". If you're curious, you can learn more about what this means in this paper.\n",
    "\n",
    "Plots in ggplot2 are \"built up\" using multiple functions connected with the plus sign (```+```). The first function, ```ggplot()```, just draws the outline of the plot, including the the axes and tick marks. It takes two arguments.\n",
    "\n",
    "1. The dataset that you want to plot.\n",
    "1. A function, ```aes()```, short for aesthetic. This function itself takes multiple arguments. Let's start by using x & y, which will tell the function which columns of the data_frame to plot on the x axis and y axis."
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 1133,
     "sourceId": 2082,
     "sourceType": "datasetVersion"
    },
    {
     "datasetId": 1919,
     "sourceId": 3310,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 30618,
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
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 11.951621,
   "end_time": "2024-01-26T23:33:29.132223",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2024-01-26T23:33:17.180602",
   "version": "2.5.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
