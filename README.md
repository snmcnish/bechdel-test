# Exploring the Bechdel Test

This project is designed to visualize the patterns and trends of the movies that pass and fail the Bechdel Test. 

To pass the Bechdel test, the movie has to have three criteria:1. It has two women in it2. Who talk to each other3. About something other than a man

Website containing the visualizations can be found here: https://sites.google.com/dons.usfca.edu/bechdel-viz/home

## Data
Bechdel Test data is from: http://bechdeltest.com - 7,656 movies from 1888 to 2018

Supporting IMDB information was pulled from datasets found here: https://datasets.imdbws.com/
* title.basics.tsv
* title.crew.tsv
* title.ratings.tsv
* title.principals.tsv
* name.basics.tsv

The data is organized in this repo in the *data* folder. Within this folder, the *reshaped* folder contains data files mentioned above that was merged and reshaped for analysis. The *clean* folder contains the reshaped data with fixes for missing values and additional features. 

## Code

The code is located in the folder called *code* and contains 3 scripts:

1. acquire_reshape_data.R - Reads in all raw data including pulling the bechdel test data directly from an API. Keeps appropriate columns and merges data where appropriate to make sure names are attached with IDs. Exports three csv's containing crew info, cast info, and bechdel test data.

2. Clean data.ipynb - Reads in the reshaped data and removes rows if the ID variable is null. Assigns gender if possible based on actor/actress designation. Exports clean files. 

3. Final Project Plots.ipynb - Reads in cleaned data sets, prepares data for plotting, creates Plotly plots, and exports html code for embedding into the website.

