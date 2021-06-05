/*This script will create the database Movies.  It will then create the tables.
  Script created by Group 3 on 10/22/2020 - 11/27/20
*/
use master
go
drop database Movies
go
Create database Movies
GO
--Making sure we are creating the tables in the right database
Use Movies
GO

--Creating Tables Section was worked on by all 4 of us adding and subtracting or rearranging as needed

--Creating the PEOPLE table
create table PERSON(
PersonID      	int NOT NULL Primary Key identity(1000,1),
FirstName     	varchar(15) NOT NULL,
LastName      	varchar(15) NOT NULL,
Persontype  	varchar(15) NOT NULL,
--constraints
constraint Persontype_person_ck check (persontype in ('Actor/Actress', 'Director', 'Both'))
);
GO
 
create table MOVIE(
MovieID             	int NOT NULL primary key identity(1000,1),
MovieName           	varchar(50) NOT NULL,
YearFirstRelease int,
RunTime                   	int,
Remake                    	varchar(3) default 'No',
PartofSeries       	varchar(3) default 'No',
Synopsis            	text,
Picture                   	varchar(100),
ReviewID            	int,
--constraints
constraint movie_remake_ck check (Remake in ('No' , 'Yes')),
constraint movie_partofseries_ck check (PartofSeries in ('No' , 'Yes')),
constraint movie_runtime_ck check (Runtime > 0),
constraint movie_yearfirstrelease_ck check (YearFirstRelease <= YEAR(getdate())),
--constraint reviewid_movie_fk foreign key(ReviewID) references Review(ReviewID)  on update cascade on delete no action,
);
GO

--Creating the REVIEW table
Create table REVIEW (
ReviewID	int NOT NULL primary key identity(1000,1),
PersonID	int NOT NULL,
MovieID		int NOT NULL,
MovieReview text NOT NULL,
--Constraints
constraint personid_review_fk foreign key(PersonID) references Person(PersonID)  on update cascade on delete no action,
constraint movieid_review_fk foreign key(MovieID) references Movie(MovieID)  on update cascade on delete no action
);
GO
 
--Creating the MOVIE_PERSON table (edited personid constraint for update and delete)
Create table MOVIE_PERSON (
PersonID	int NOT NULL,
MovieID       	int NOT NULL,
RolePlayed varchar(50),
--Constraints
constraint movieperson_pk primary key (PersonID, MovieID),
constraint personid_movieperson_fk foreign key(PersonID) references Person(PersonID) on update cascade on delete no action,
constraint movieid_movieperson_fk foreign key(MovieID) references Movie(MovieID)  on update cascade on delete no action
);
GO
 
--Creating the STORAGE LOCATION table
Create table STORAGE_LOCATION(
StoragelocationID int NOT NULL Primary Key identity(1000,1), --edited by EEH 11/25/20 said loacaction not location
Locationname       	varchar(20) NOT NULL,
--Constraints
);
GO
 
--Creating the GENRE table
Create table GENRE(
GenreID       	int NOT NULL Primary Key identity(1000,1),
Genretype   varchar(15) NOT NULL,
--Constraints
constraint genre_genretype_ck check (genretype in ('Comedy', 'Drama', 'Romance', 'Mystery', 'Thriller', 'Documentary', 'Fantasy', 'Sci-Fi', 'Horror', 'Action', 'Musical', 'GothicRomance', 'Dramedy')) --edited EEH 11/25/20
);
GO
 
--Creating the FORMAT table
Create table FORMAT(
FormatID	int NOT NULL Primary Key identity(1000,1),
Formattype  varchar(25) NOT NULL,
--Constraints
constraint format_formattype_ck check (formattype in ('DVD', 'Blu Ray', 'Digital', 'Special Edition', 'Digital Special Edition', 'VHS', 'LaserDisc')) --edited EEH 11/25/20
);
GO
 
--Creating the MOVIE_STORAGE table
Create table MOVIE_STORAGE(
StoragelocationID int NOT NULL,
MovieID                   	int NOT NULL,
--Constraints
constraint movie_storage_pk primary key (StoragelocationID, MovieID),
);
GO
 
--Creating the MOVIE_GENRE table
Create table MOVIE_GENRE(
GenreID             	int NOT NULL,
MovieID             	int NOT NULL,
--Constraints
constraint moviegenre_pk primary key (GenreID, MovieID),
constraint genreid_moviegenre_fk foreign key(GenreID) references Genre(GenreID) on update cascade on delete no action,
constraint movieid_moviegenre_fk foreign key(MovieID) references Movie(MovieID)  on update cascade on delete no action
);
GO
 
--Creating the MOVIE_FORMAT table
Create table MOVIE_FORMAT(
FormatID      	int NOT NULL,
MovieID             	int NOT NULL,
--Constraints
constraint movieformat_pk primary key (FormatID, MovieID),
constraint genreid_movieformat_fk foreign key(FormatID) references Format(FormatID) on update cascade on delete no action,
constraint movieid_movieformat_fk foreign key(MovieID) references Movie(MovieID)  on update cascade on delete no action
);
GO
--
--End of the area to create the tables, etc to start with
--
--
--Moving on to start the insertion process
--All insertion sections had each of us add to them
--Where it was notated, specific people did it for sure
--But we all added bits and pieces to each insertion section
--Unless before the section it only says a couple people
INSERT INTO PERSON
(FirstName, LastName, PersonType)
VALUES
--Misc Movies (Ken)
('Ryan', 'Reynolds', 'Actor/Actress'),
('Chevy', 'Chase', 'Actor/Actress'),
('Beverly', 'D-Angelo', 'Actor/Actress'),
('Jeremiah', 'Chechik', 'Director'),
('Macaulay', 'Culkin', 'Actor/Actress'),
('Joe ', 'Pesci', 'Actor/Actress'),
('Chris', 'Columbus', 'Director'),
('John ', 'Travolta', 'Actor/Actress'),
('Quentin', 'Tarantino', 'Both'),
('Bill ', 'Murray', 'Actor/Actress'),
('Dan', 'Aykroyd', 'Actor/Actress'),
('Alan', 'Rickman', 'Actor/Actress'),
('Bruce', 'Willis', 'Actor/Actress'),
('John', 'McTiernan', 'Director'),
('Ivan', 'Reitman', 'Director'),
('Tim', 'Miller', 'Director'),--Ken
--Harry Potter (Calley)
('Daniel', 'Radcliffe', 'Actor/Actress'),
('Rupert', 'Grint', 'Actor/Actress'),
('Emma', 'Watson', 'Actor/Actress'),
('Chris', 'Columbus', 'Director'),
-- Les Miserables (Calley)
('Hugh', 'Jackman', 'Actor/Actress'),
('Russell', 'Crowe', 'Actor/Actress'),
('Anne', 'Hathaway', 'Actor/Actress'),
('Tom', 'Hooper', 'Director'),
-- John Wick (Calley)
('Keanu', 'Reeves', 'Actor/Actress'),
('Michael', 'Nyqvist', 'Actor/Actress'),
('Chad', 'Stahelksi', 'Director'),
('David', 'Leitch', 'Director'),
-- Crimson Peak (Calley)
('Tom', 'Hiddleston', 'Actor/Actress'),
('Mia', 'Wasikowska', 'Actor/Actress'),
('Jessica', 'Chastain', 'Actor/Actress'),
('Guillermo', 'del Toro', 'Director'),
-- Avengers: End Game (Calley)
('Robert', 'Downey Jr.', 'Actor/Actress'),
('Chris', 'Evans', 'Actor/Actress'),
('Chris', 'Hemsworth', 'Actor/Actress'),
('Mark', 'Ruffalo', 'Actor/Actress'),
('Scarlett', 'Johansson', 'Actor/Actress'),
('Anthony', 'Russo', 'Director'),
('Joe', 'Russo', 'Director'),
-- Sound of Music (Calley)
('Julie', 'Andrews', 'Actor/Actress'),
('Christopher', 'Plummer', 'Actor/Actress'),
('Robert', 'Wise', 'Director'),
--Snowpiercer (Justin)
('Ed', 'Harris', 'Actor/Actress'),
('Kang-Ho', 'Song', 'Actor/Actress'),
('Bong', 'Joon Ho', 'Director'),
--Exit Through the Fift Shop (Justin)
('Banksy', '', 'Director'),
('Mr.', 'Brainwash', 'Actor/Actress'),
('Space', 'Invader', 'Actor/Actress'),
('Shepard', 'Fairey', 'Actor/Actress'),
--Pacific Rim (Justin)
('Charlie', 'Hunnam', 'Actor/Actress'),
('Idris', 'Elba', 'Actor/Actress'),
('Rinko', 'Kikuchi', 'Actor/Actress'),
--Edies additions
--Harry Potter More people or directors (Edie)
('Jason', 'Isaacs', 'Actor/Actress'),
('Alfonso', 'Cuaron', 'Director'),
('Gary', 'Oldman', 'Actor/Actress'),
('David', 'Thewlis', 'Actor/Actress'),
('David', 'Tennant', 'Actor/Actress'),
('Robert', 'Pattinson', 'Actor/Actress'),
('Mike', 'Newell', 'Director'),
--Indiana Jones Raiders (Edie)
('Harrison', 'Ford', 'Actor/Actress'),
('Karen', 'Allen', 'Actor/Actress'),
('John', 'Rhys-Davies', 'Actor/Actress')
; 
GO

--Ken, Justin, Calley and Edie
INSERT INTO MOVIE
(MovieName, YearFirstRelease, RunTime, Remake, PartofSeries, Synopsis, Picture, ReviewID)
VALUES
('Deadpool', 2016, 108, 'No', 'Yes', 'When an experiment goes wrong, a mercenary seeks revenge', null, null),
('Die Hard', 1988, 132, 'No', 'Yes', 'An NYPD officer tries to save his wife after she was taken hostage by terrorists while at a company Christmas party', null, null),
('Ghostbusters', 1984, 106, 'No', 'Yes', 'Three friends set up a business to fight ghosts in NYC', null, null),
('Pulp Fiction', 1994, 154, 'No', 'No', 'The lives of a boxer, hitman, gangster and his wife, and two thieves intertwine in a tale of violence and redemption', null, null),
('Home Alone', 1990, 103, 'No', 'Yes', 'An eight-year old is accidently left alone and must defend his house against two burglars', null, null),
('National Lampoons Christmas Vacation', 1989, 97, 'No', 'Yes', 'A family must navigate their disastrous big family Christmas celebration', null, null),--1005
--START CALLEY ADDITIONS
('Harry Potter and the Sorcerer''s Stone', 2001, 152, 'No', 'Yes', 'An orphaned boy enrolls in a school of wizardry.', null, null), --Calley
('Les Miserables', 2012, 158, 'No', 'No', 'In 19th-century France, Jean Valjean, who for decades has been hunted by the ruthless policeman Javert after breaking parole, agrees to care for a factory worker''s daughter.', null, null), --Calley
('John Wick', 2014, 101, 'No', 'No', 'An ex-hit-man comes out of retirement to track down the gangsters that killed his dog and took everything from him.', null, null), --Calley
('Crimson Peak', 2015, 119, 'No', 'No', 'In the aftermath of a family tragedy, an aspiring author is torn between love for her childhood friend and the temptation of a mysterious outsider.', null, null), --Calley
('Avengers: Endgame', 2019, 181, 'No', 'Yes', 'The Avengers assemble once more in order to reverse Thanos'' actions and restore balance to the universe.', null, null), --Calley
('Sound of Music', 1965, 172, 'No', 'No', 'A woman leaves an Austrian convent to become a governess to the children of a Naval officer widower.', null, null),
--END CALLEY'S ADDITIONS
('Snowpiercer', 2013, 126, 'No', 'No', 'Survivors of Earth''s second Ice Age live out their days on a luxury train that ploughs through snow and ice. The train''s poorest residents, who live in the squalid caboose, plan to improve their lot by taking over the engine room.', Null, Null),
('Exit Through the Gift Shop', 2010, 87, 'No', 'No', 'Following the style of some of the world''s most prolific street artists, an amateur filmmaker makes a foray into the art world.', Null, Null),
('Pacific Rim', 2013, 133, 'No', 'Yes', 'As a war between humankind and monstrous sea creatures wages on, a former pilot and a trainee are paired up to drive a seemingly obsolete special weapon in a desperate effort to save the world from the apocalypse.', Null, Null),
--START EDIE'S ADDITIONS
('Harry Potter and the Chamber of Secrets', 2002, 161, 'No', 'Yes', 'An ancient prophecy seems to be coming true when a mysterious presence begins stalking the corridors of a school of magic and leaving its victims paralyzed.', NULL, NULL),
('Harry Potter and the Prisoner of Azkaban', 2004, 142, 'No', 'Yes', 'Harry Potter, Ron and Hermione return to Hogwarts School of Witchcraft and Wizardry for their third year of study, where they delve into the mystery surrounding an escaped prisoner who poses a dangerous threat to the young wizard.', NULL, NULL),
('Harry Potter and the Goblet of Fire', 2005, 157, 'No', 'Yes', 'Harry Potter finds himself competing in a hazardous tournament between rival schools of magic, but he is distracted by recurring nightmares.', NULL, NULL),
('Raiders of the Lost Ark', 1981, 115, 'No', 'Yes', 'In 1936, archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before Adolf Hitler''s Nazis can obtain its awesome powers.', NULL, NULL)
--END EDIE'S ADDITIONS
;
GO

--Ken and Justin 
INSERT INTO REVIEW
(PersonID, MovieID, MovieReview)
VALUES
(1000, 1000, 'Best super hero movie ever!'),
(1001, 1005, 'This Christmas movie is the gift that keeps on giving the whole year.'),
(1004, 1004, 'One of my favorite Christmas movies.  But I still do not understand how the parents forgot him at home.'),
(1009, 1002, 'I love this movie, one of the best ever made.'),
(1032, 1010, 'Overall this is a great movie and series but I was not real happy with the ending.'),
(1012, 1001, 'Great Christmas movie.  Even better action movie.  But why cant he find any shoes?'),
(1012, 1003, 'This movie is all over the place.  I am not sure what is going on and I really want to know what was in the breifcase!'),
(1039, 1011, 'A classic movie that gets better with age.  You can never go wrong with this one.'),
(1024, 1008, 'A great action movie and lesson on why you never hurt another persons dog.')
;
GO

--Ken, Calley, Justin and Edie
INSERT INTO MOVIE_PERSON
(PersonID, MovieID, RolePlayed)
VALUES
(1000, 1000, 'Deadpool'),
(1012, 1001, 'John McClane'),
(1011, 1001, 'Hans Gruber'),
(1013, 1001, Null),
(1014, 1002, Null),
(1010, 1002, 'Dr. Raymond'),
(1009, 1002, 'Dr Peter Venkman'),
(1008, 1003, 'Jimmie'),
(1007, 1003, 'Vincent Vega'),
(1012, 1003, 'Butch Coolidge'),
(1006, 1004, Null),
(1005, 1004, 'Harry'),
(1004, 1004, 'Kevin'),
(1003, 1005, Null),
(1002, 1005, 'Ellen'),
(1001, 1005, 'Clark'),
(1015, 1000, 'Null'),
(1016, 1006, 'Harry Potter'),
(1017, 1006, 'Ron Weasley'),
(1018, 1006, 'Hermione Granger'),
(1019, 1006, Null),
(1020, 1007, 'Jean Valjean'),
(1021, 1007, 'Javert'),
(1022, 1007, 'Fantine'),
(1023, 1007, Null),
(1024, 1008, 'John Wick'),
(1025, 1008, 'Viggo Tarasov'),
(1026, 1008, Null),
(1027, 1008, Null),
(1028, 1009, 'Thomas Sharpe'),
(1029, 1009, 'Edith Cushing'),
(1030, 1009, 'Lucille Sharpe'),
(1031, 1009, Null),
(1032, 1010, 'Tony Stark/Iron Man'),
(1033, 1010, 'Steve Rogers/Captain America'),
(1034, 1010, 'Thor'),
(1035, 1010, 'Bruce Banner/Hulk'),
(1036, 1010, 'Natasha Romanoff/Black Widow'),
(1028, 1010, 'Loki'),
(1037, 1010, Null),
(1038, 1010, Null),
(1039, 1011, 'Maria'),
(1040, 1011, 'Christopher Von Trapp'),
(1041, 1011, Null),
(1033, 1012, 'Curtis'),
(1042, 1012, 'Wilford'),
(1043, 1012, 'Namgoong Minsoo'),
(1044, 1012, Null),
(1045, 1013, Null),
(1046, 1013, 'Self'),
(1047, 1013, 'Self'),
(1048, 1013, 'Self'),
(1049, 1014, 'Raleigh Becket'),
(1050, 1014, 'Stacker Pentecost'),
(1051, 1014, 'Mako Mori'),
(1031, 1014, Null),
(1057, 1015, 'Lucius Malfoy'),
(1057, 1016, 'Lucius Malfoy'),
(1019, 1015, NULL),
(1053, 1016, NULL),
(1058, 1017, NULL),
(1054, 1016, 'Sirius Black'),
(1054, 1017, 'Sirius Black'),
(1055, 1016, 'Remus Lupin'),
(1055, 1017, 'Remus Lupin'),
(1057, 1017, 'Cedric Diggory'),
(1059, 1018, 'Professor Indiana Jones'),
(1060, 1018, 'Marion'),
(1061, 1018, 'Sallah')
;
GO

--Justin and Edie
INSERT INTO STORAGE_LOCATION
(Locationname)
VALUES
('Online'),
('EntCenter'), --Edie
('LivingRoom'), --Edie
('Bedroom'), --Edie
('Cabinet'), --Edie
('Bookcase') --Edie
;
GO

--Ken, Justin, Calley and Edie
INSERT INTO GENRE
(Genretype)
VALUES
('Comedy'),
('Drama'),
('Romance'),
('Mystery'),
('Thriller'),
('Documentary'), 
('Fantasy'),
('Sci-Fi'),
('Horror'),
('Action'),
('Musical'),
('GothicRomance'), ---Edie
('Dramedy') --Edie
;
GO

--Ken, Justin, Calley and Edie
INSERT INTO FORMAT
(Formattype)
VALUES
('DVD'),
('Blu Ray'),
('Digital'),
('Special Edition'), 
('Digital Special Edition'),
('VHS'),
('LaserDisc') --Edie
;
GO

--Ken and Edie 
INSERT INTO MOVIE_STORAGE
(StoragelocationID, MovieID)
VALUES
(1000, 1000),
--Edie additions, some have multiple locations because of multiple formats
(1000, 1015),
(1002, 1015),
(1005, 1015),
(1000, 1016),
(1002, 1016),
(1005, 1016),
(1000, 1017),
(1002, 1017),
(1000, 1018),
(1002, 1018),
(1000, 1006),
(1002, 1006),
(1000, 1011),
(1002, 1011),
(1005, 1011),
(1001, 1011),
(1000, 1009),
(1000, 1010),
(1000, 1007),
(1002, 1007),
(1000, 1008)
;
GO

--Ken, Justin, Calley and Edie
INSERT INTO MOVIE_GENRE
(GenreID, MovieID)
VALUES
(1000, 1000),
(1009, 1001),
(1000, 1002),
(1001, 1003),
(1000, 1004),
(1000, 1005),
(1006, 1006),
(1010, 1007),
(1001, 1007),
(1009, 1008),
(1008, 1009),
(1003, 1009),
(1009, 1010),
(1010, 1011),
(1002, 1011),
(1007, 1012),
(1005, 1013),
(1000, 1013),
(1009, 1014),
(1007, 1014),
(1006, 1015),
(1006, 1016),
(1006, 1017),
(1006, 1018),
(1009, 1018)
;
GO

--Ken, Justin, Calley and Edie
INSERT INTO MOVIE_FORMAT
(FormatID, MovieID)
VALUES
(1000, 1000),
(1003, 1001),
(1001, 1002),
(1000, 1002),
(1003, 1002),
(1002, 1003),
(1004, 1004),
(1001, 1004),
(1001, 1005),
(1005, 1005),
(1000, 1006),
(1001, 1006),
(1000, 1007),
(1001, 1007),
(1002, 1007),
(1002, 1008),
(1002, 1009),
(1002, 1010),
(1000, 1011),
(1001, 1011),
(1002, 1011),
(1003, 1011),
(1004, 1011),
(1005, 1011),
(1001, 1012),
(1002, 1013),
(1003, 1014),
(1002, 1014),
--Edie added multiple values for new movies added
(1006, 1011),
(1000, 1015),
(1001, 1015),
(1002, 1015),
(1003, 1015),
(1004, 1015),
(1000, 1016),
(1001, 1016),
(1002, 1016),
(1003, 1016),
(1004, 1016),
(1000, 1017),
(1001, 1017),
(1002, 1017),
(1003, 1017),
(1004, 1017),
(1000, 1018),
(1001, 1018),
(1002, 1018),
(1003, 1018),
(1004, 1018),
(1005, 1018)
;
GO