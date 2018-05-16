library(tidyverse)
library(stringr)



# read in data from bechdeltest.com
bechdel <-jsonlite::read_json('http://bechdeltest.com/api/v1/getAllMovies',simplifyVector = TRUE)%>%
  data.frame()%>%
  mutate(year=as.numeric(year),
         id=as.numeric(id))

colnames(bechdel) <- c("tconst", "id", "title", "bechdel_rating", "year")

# read in IMDB ratings data
imdb_ratings <- read.table("~/classes/msan622/project/bechdel-test/title.ratings.tsv", sep="\t", header=TRUE)

# fix ID
imdb_ratings$tconst <- substr(imdb_ratings$tconst, 3, length(imdb_ratings$tconst))

# merge bechdel data and ratings
bechdel.ratings <- merge(x = bechdel, y = imdb_ratings, by = "tconst", all.x = TRUE)

# read in title data
imdb_title <- read.delim("~/classes/msan622/project/bechdel-test/title.basics.tsv", sep="\t", header=TRUE)

# fix ID
imdb_title$tconst <- substr(imdb_title$tconst, 3, length(imdb_title$tconst))

# keep only cols of interest
imdb_title <- subset(imdb_title, select = c(tconst, runtimeMinutes, genres, primaryTitle))

# merge on title basics
bechdel.ratings.title <- merge(x = bechdel.ratings, y = imdb_title, by = "tconst", all.x = TRUE)

# read in crew info
imdb_crew <- read.delim("~/classes/msan622/project/bechdel-test/title.crew.tsv", sep="\t", header=TRUE)

# split writers and directors into multilpe columns
# only keep top 5 even if there are more
imdb_crew <- cbind(imdb_crew, colsplit(imdb_crew$directors, ",", names =  c("dir1", "dir2", "dir3", "dir4", "dir5")))
imdb_crew <- cbind(imdb_crew, colsplit(imdb_crew$writers, ",", names =  c("writ1", "writ2", "writ3", "writ4", "writ5")))

# keep only cols of interest
imdb_crew <- subset(imdb_crew, select = -c(directors, writers))

# transform wide to long
imdb_crew_long <- melt(imdb_crew, id.vars = c("tconst"))
colnames(imdb_crew_long) <- c("tconst", "crew.type", "nconst")

# only keep crew info from movies on our dataset
movies <- subset(bechdel, select = c(tconst))
imdb_crew_long$tconst <- substr(imdb_crew_long$tconst, 3, length(imdb_crew_long$tconst))
imdb_crew_long2 <- merge(x = movies, y = imdb_crew_long, by = "tconst")

# remove empty rows
imdb_crew_long2 <- imdb_crew_long2[imdb_crew_long2$nconst != "", ]

# read in cast info
imdb_cast <- read.delim("~/classes/msan622/project/bechdel-test/title.principals.tsv", sep="\t", header=TRUE)

# only keep cast info from movies on our dataset
imdb_cast$tconst <- substr(imdb_cast$tconst, 3, length(imdb_cast$tconst))
imdb_cast2 <- merge(x = movies, y = imdb_cast, by = "tconst")

# keep only cols of interest
imdb_cast2 <- subset(imdb_cast2, select = c(tconst, ordering, nconst, category))

# read in names info
imdb_names <- read.delim("~/classes/msan622/project/bechdel-test/name.basics.tsv", sep="\t", header=TRUE)

# keep only cols of interest
imdb_names <- subset(imdb_names, select = c(nconst, primaryName, primaryProfession))

# merge names info onto cast and crew
imdb_crew_info <- merge(x = imdb_crew_long2, y = imdb_names, by = "nconst", all.x = TRUE)
imdb_cast_info <- merge(x = imdb_cast2, y = imdb_names, by = "nconst", all.x = TRUE)

# write to csv
write.csv(bechdel.ratings.title, "~/classes/msan622/project/bechdel-test/bechdeltestdata.csv", row.names = FALSE)
write.csv(imdb_crew_info, "~/classes/msan622/project/bechdel-test/crewinfo.csv", row.names = FALSE)
write.csv(imdb_cast_info, "~/classes/msan622/project/bechdel-test/castinfo.csv", row.names = FALSE)

