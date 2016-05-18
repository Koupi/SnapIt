-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2016-05-17 12:25:53.905

-- tables
-- Table: Picture
CREATE TABLE Picture (
    id integer NOT NULL CONSTRAINT Picture_pk PRIMARY KEY,
    image blob NOT NULL,
    place_id integer NOT NULL,
    CONSTRAINT Picture_Place FOREIGN KEY (place_id)
    REFERENCES Place (id)
);

-- Table: Place
CREATE TABLE Place (
    id integer NOT NULL CONSTRAINT Place_pk PRIMARY KEY,
    name text NOT NULL,
    location text NOT NULL,
    rating integer NOT NULL,
    rating_amount integer NOT NULL,
    longitude double NOT NULL,
    latitude double NOT NULL
);

-- Table: Rating
CREATE TABLE Rating (
    login text NOT NULL CONSTRAINT Rating_pk PRIMARY KEY,
    rating integer NOT NULL,
    place_id integer NOT NULL,
    CONSTRAINT Rating_Place FOREIGN KEY (place_id)
    REFERENCES Place (id),
    CONSTRAINT Rating_User FOREIGN KEY (login)
    REFERENCES User (login)
);

-- Table: User
CREATE TABLE User (
    login text NOT NULL CONSTRAINT User_pk PRIMARY KEY,
    password text NOT NULL,
    email text NOT NULL,
    fbpassword text NOT NULL
);

-- End of file.

