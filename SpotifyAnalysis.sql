use music_db;
/*CREATE TABLES*/
/*CREATE spotify_song_info*/
CREATE TABLE `spotify_song_info` (
  `song_id` varchar(255) NOT NULL unique,
  `artists` varchar(500),
  `name` varchar(255),
  `release_date` varchar(255) null,
  `year` int DEFAULT NULL,
  `popularity` int DEFAULT NULL,
  PRIMARY KEY (song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*CREATE spotify_song_info table*/
CREATE TABLE `spotify_song_features` (
  `song_id` varchar(255) NOT NULL unique,
  `danceability` double DEFAULT NULL,
  `duration_ms` int DEFAULT NULL,
  `energy` double DEFAULT NULL,
  `acousticness` double DEFAULT NULL,
  `explicit` int DEFAULT NULL,
  `instrumentalness` double DEFAULT NULL,
  `key_` int DEFAULT NULL,
  `liveness` double DEFAULT NULL,
  `loudness` double DEFAULT NULL,
  `mode` int DEFAULT NULL,
  `speechiness` double DEFAULT NULL,
  `tempo` double DEFAULT NULL,
  `valence` double DEFAULT NULL,
  PRIMARY KEY (song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Show the folder to move the files into in order to be able to import it into sql*/
SHOW VARIABLES LIKE "secure_file_priv";

/*Insert data into spotify_song_info*/
LOAD DATA INFILE  'D:\\sp-data_analytics\\excel\\spotify_song_info.csv'
INTO TABLE spotify_song_info  
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


/*Insert data into spotify_song_features*/
LOAD DATA INFILE  'D:\\sp-data_analytics\\excel\\spotify_song_features.csv'
INTO TABLE spotify_song_features 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(song_id, danceability, duration_ms, energy, acousticness, explicit, instrumentalness, key_,
liveness, loudness, mode, speechiness, tempo, valence);

/*Show data*/
SELECT * 
FROM spotify_song_features;

SELECT * 
FROM spotify_song_info;

/*Create a view to join song_info to song_features table*/
CREATE VIEW spotify_song_data AS
SELECT a.song_id, a.artists, a.name, a.release_date, a.year, a.popularity,
b.danceability, b.duration_ms, b.energy, b.acousticness, b.explicit, b.instrumentalness, 
b.key_, b.liveness, b.loudness, b.mode, b.speechiness, b.tempo, b.valence
FROM spotify_song_info a
INNER JOIN spotify_song_features b
ON a.song_id = b.song_id;

/*Question one*/
/* Firstly, Creae a view of the songs with popularity btw 0 and 100 for every year in the past 10 years*/
CREATE VIEW top_song_per_year AS
select temp.artists, temp.year, temp.song_id, popularity
from
(select artists, year, song_id, popularity
from spotify_song_data
where year in (2021,2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012, 2011) and popularity between 0 and 100
order by year desc, popularity desc) as temp
where year in (2021,2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012, 2011)
group by artists, year
order by year desc, popularity desc
limit 21656;

/*Get the number of  times an artist featured on the list above*/
select artists, count(song_id) as frequency
from top_song_per_year
group by artists
order by frequency DESC;

/*Question 2: Average song popularity by year*/
select artists, song_id, year, AVG(popularity) as avg_popularity
from spotify_song_data
group by year, song_id
order by avg_popularity DESC, year DESC;

/*Question 3*/
/*Changes observed in song tempo over the years*/
SELECT  year,
		AVG(tempo) as AVG_tempo,
        MAX(tempo) as MAX_tempo,
        MIN(tempo) as MIN_tempo
FROM spotify_song_data
GROUP BY year
ORDER BY year;

/*Question 4*/

CREATE VIEW The_Weeknd AS
select * 
from spotify_song_data
where artists like ('The Weeknd');
/*ALL featured songs*/
select DISTINCT(song_id) as song, artists, year
from The_weeknd;

/*Change in number of songs by year*/
select artists, year, count(song_id) as no_of_songs
from The_weeknd
group by year
Order by year desc, no_of_songs desc;

/*Avg popularity score*/
select artists, AVG(popularity) as avg_popularity_score
from The_weeknd
group by artists
order by avg_popularity_score DESC;

/*Group popularity into segments*/
select artists, song_id, popularity,
case when popularity between 0 and 49 THEN 'Not Popular'
WHEN popularity > 49 AND popularity < 70 THEN 'Popular'
ELSE "Very Popular" 
END AS popularity_segments
FROM The_weeknd;



