CREATE DATABASE videostore;

USE videostore;

CREATE TABLE Country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    year INT
);

CREATE TABLE Actors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    country_id INT,
    birthday TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES Country(id)
);

CREATE TABLE Authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country_id INT,
    birthday TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES Country(id)
);

CREATE TABLE Movies_Authors (
    movie_id INT,
    author_id INT,
    PRIMARY KEY (movie_id, author_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(id),
    FOREIGN KEY (author_id) REFERENCES Authors(id)
);

CREATE TABLE Movie_Actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(id),
    FOREIGN KEY (actor_id) REFERENCES Actors(id)
);

INSERT INTO Country (name) VALUES ('USA'), ('UK'), ('Canada');

INSERT INTO Movies (name, description, year) VALUES 
('Inception', 'A thief who steals corporate secrets through the use of dream-sharing technology.', 2010),
('The Dark Knight', 'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.', 2008),
('Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', 2014),
('Titanic', 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', 1997),
('Avatar', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 2009),
('The Matrix', 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 1999),
('The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 1972),
('Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 1994),
('The Shawshank Redemption', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 1994),
('Forrest Gump', 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75.', 1994),
('Fight Club', 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into something much, much more.', 1999),
('The Lord of the Rings: The Fellowship of the Ring', 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', 2001),
('Star Wars: Episode IV - A New Hope', 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire''s world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth Vader.', 1977),
('Jurassic Park', 'During a preview tour, a theme park suffers a major power breakdown that allows its cloned dinosaur exhibits to run amok.', 1993),
('The Lion King', 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.', 1994);

INSERT INTO Actors (name, surname, country_id, birthday) VALUES 
('Leonardo', 'DiCaprio', 1, '1974-11-11 00:00:00'),
('Christian', 'Bale', 2, '1974-01-30 00:00:00'),
('Matthew', 'McConaughey', 1, '1969-11-04 00:00:00'),
('Kate', 'Winslet', 2, '1975-10-05 00:00:00'),
('Sam', 'Worthington', 3, '1976-08-02 00:00:00'),
('Keanu', 'Reeves', 1, '1964-09-02 00:00:00'),
('Marlon', 'Brando', 1, '1924-04-03 00:00:00'),
('John', 'Travolta', 1, '1954-02-18 00:00:00'),
('Tim', 'Robbins', 1, '1958-10-16 00:00:00'),
('Tom', 'Hanks', 1, '1956-07-09 00:00:00'),
('Brad', 'Pitt', 1, '1963-12-18 00:00:00'),
('Elijah', 'Wood', 1, '1981-01-28 00:00:00'),
('Mark', 'Hamill', 1, '1951-09-25 00:00:00'),
('Sam', 'Neill', 3, '1947-09-14 00:00:00'),
('Matthew', 'Broderick', 1, '1962-03-21 00:00:00');

INSERT INTO Authors (name, country_id, birthday) VALUES 
('Christopher Nolan', 2, '1970-07-30 00:00:00'),
('Jonathan Nolan', 2, '1976-06-06 00:00:00'),
('James Cameron', 1, '1954-08-16 00:00:00'),
('Lana Wachowski', 1, '1965-06-21 00:00:00'),
('Lilly Wachowski', 1, '1967-12-29 00:00:00'),
('Francis Ford Coppola', 1, '1939-04-07 00:00:00'),
('Quentin Tarantino', 1, '1963-03-27 00:00:00'),
('Frank Darabont', 1, '1959-01-28 00:00:00'),
('Robert Zemeckis', 1, '1951-05-14 00:00:00'),
('Chuck Palahniuk', 1, '1962-02-21 00:00:00'),
('J.R.R. Tolkien', 2, '1892-01-03 00:00:00'),
('George Lucas', 1, '1944-05-14 00:00:00'),
('Michael Crichton', 1, '1942-10-23 00:00:00'),
('Irene Mecchi', 1, '1949-11-21 00:00:00'),
('Jonathan Roberts', 1, '1956-05-10 00:00:00');

INSERT INTO Movies_Authors (movie_id, author_id) VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 3),
(6, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9),
(11, 10),
(12, 11),
(13, 12),
(14, 13),
(15, 14),
(15, 15);

INSERT INTO Movie_Actors (movie_id, actor_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15);
