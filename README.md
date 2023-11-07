
# Spotify Data Analysis using SQL

This project is about analyzing Spotify's song data using SQL. We have two tables: `spotify_song_info` and `spotify_song_features`. The `spotify_song_info` table contains information about the songs, such as the artist, song name, release date, year, and popularity. The `spotify_song_features` table contains features of the songs, such as danceability, duration, energy, acousticness, explicit content, instrumentalness, key, liveness, loudness, mode, speechiness, tempo, and valence.

## Database Setup

First, we create the `spotify_song_info` and `spotify_song_features` tables.

Then, we insert data into these tables. The data files are located in a secure directory, which can be found using the `SHOW VARIABLES LIKE "secure_file_priv";` command.

## Data Analysis

We perform several analyses on the data:

1. **Top Songs per Year**: We create a view of the songs with popularity between 0 and 100 for every year in the past 10 years. Then, we count the number of times an artist featured on this list.

2. **Average Song Popularity by Year**: We calculate the average popularity of songs by year.

3. **Changes in Song Tempo Over the Years**: We observe the changes in song tempo over the years by calculating the average, maximum, and minimum tempo for each year.

4. **Analysis of 'The Weeknd' Songs**: We analyze the songs by 'The Weeknd' in terms of the number of songs per year and the average popularity score.

Please note that the SQL queries for these analyses are not included in this README. They are part of the SQL script that you run to perform the analyses.

## Conclusion

This project demonstrates how to use SQL for data analysis. By analyzing Spotify's song data, we can gain insights into song popularity, artist performance, and music trends over the years. This can be useful for music enthusiasts, artists, and record labels alike. Happy analyzing! 😊
