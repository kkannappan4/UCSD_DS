-- 201 Cats
-- Create Schema

CREATE TABLE users (
 username TEXT NOT NULL UNIQUE PRIMARY KEY,
 facebook TEXT NOT NULL UNIQUE,
 first_name TEXT NOT NULL,
 last_name TEXT NOT NULL,
 );

CREATE TABLE videos (
 ID SERIAL NOT NULL PRIMARY KEY,
 video_name TEXT NOT NULL
 );

CREATE TABLE logins (
 ID SERIAL NOT NULL PRIMARY KEY,
 username TEXT REFERENCES users (username) NOT NULL,
 login_time TIMESTAMP WITHOUT TIME ZONE NOT NULL
 );

CREATE TABLE suggestions (
  ID SERIAL NOT NULL PRIMARY KEY,
  login_id INTEGER references logins (ID) NOT NULL,
  video_id INTEGER references videos (ID) NOT NULL
);

CREATE TABLE views (
 ID SERIAL NOT NULL PRIMARY KEY,
 username TEXT REFERENCES users (username) NOT NULL,
 video_id INTEGER REFERENCES videos (ID) NOT NULL,
 view_time TIMESTAMP WITHOUT TIME ZONE NOT NULL
 );

CREATE TABLE likes (
 ID SERIAL NOT NULL PRIMARY KEY,
 username TEXT REFERENCES users (username) NOT NULL,
 video_id INTEGER REFERENCES videos (ID) NOT NULL,
 like_time TIMESTAMP WITHOUT TIME ZONE NOT NULL
 );

CREATE TABLE friends (
 username TEXT REFERENCES users (username) NOT NULL,
 friend_username TEXT REFERENCES users (username) NOT NULL
 );



