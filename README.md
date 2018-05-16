# Exploring the Bechdel Test

This project is designed to visualize the patterns and trends of the movies that pass and fail the Bechdel Test. 

To pass the Bechdel test, the movie has to have three criteria:1. It has two women in it2. Who talk to each other3. About something other than a man

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

1. acquire_reshape_data.R - 