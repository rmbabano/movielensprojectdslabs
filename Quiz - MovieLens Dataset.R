library(tidyverse)

# Q1
dim(edx)

# Q2
sum(edx$rating == 0)
# ANSWER KEY:
# edx %>% filter(rating == 0) %>% tally()
sum(edx$rating == 3)
# ANSWER KEY:
# edx %>% filter(rating == 3) %>% tally()

# Q3
# edx %>% group_by(movieId) %>% summarize(n()) %>% nrow(.)
nrow(tibble(unique(edx$movieId)))
# ANSWER KEY:
# n_distinct(edx$movieId)

# Q4
nrow(tibble(unique(edx$userId)))
# ANSWER KEY:
# n_distinct(edx$userId)

# Q5
genre_list <- c("Drama", "Comedy", "Thriller", "Romance")
genre_count <- sapply(genre_list, function(x) sum(str_detect(edx$genres, x)))
tibble(genre = genre_list, movie_count = genre_count)
rm(genre_list, genre_count)

# ANSWER KEYS:
# str_detect
genres = c("Drama", "Comedy", "Thriller", "Romance")
sapply(genres, function(g) {
  sum(str_detect(edx$genres, g))
})

# separate_rows, much slower!
edx %>% separate_rows(genres, sep = "\\|") %>%
  group_by(genres) %>%
  summarize(count = n()) %>%
  arrange(desc(count))

# Q6
edx %>%
  group_by(movieId, title) %>%
  summarize(ratings = n()) %>%
  arrange(-ratings)

# Q7
edx %>%
  group_by(rating) %>%
  summarize(n = n()) %>%
  arrange(-n) %>%
  top_n(5) %>%
  pull(rating)

rm(genres)
