CREATE DATABASE  Task_From_Mike
GO
use Task_From_Mike
GO

CREATE TABLE hotel
 (
	hotel_id int NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	name nvarchar(30) NOT NULL ,
	foundation_year DATE NOT NULL,
	adress nvarchar(30) NOT NULL,
	is_active BIT
 );
 GO

 CREATE TABLE hotelRooms
 (
	room_Id  INT PRIMARY KEY IDENTITY,
	roomNumber int  NOT NULL /*IDENTITY(1,1)*/,
	price MONEY,
	comfort int CONSTRAINT comfort_level CHECK(comfort LIKE '[1-3]') NOT NULL,
	capability int,
	id_hotel int,
	FOREIGN KEY(id_hotel) REFERENCES hotel (hotel_id)
 );
 GO

 CREATE TABLE users 
 (
	users_id int NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	name nvarchar(30) NOT NULL ,
	email nvarchar(30) NOT NULL
 );
 GO

  CREATE TABLE rezervation
  (
	room_reserved int FOREIGN KEY REFERENCES hotelRooms (room_id),
	user_rezervation int NOT NULL FOREIGN KEY REFERENCES users (users_id),
	start_reservation DATE,
	end_reservation DATE
  );
  GO

	INSERT into hotel (name,foundation_year, adress, is_active)
	VALUES  
	('GRAND HOTEL', '1995-01-01', 'Lviv', 1),
	('Edelweiss', '1997-02-02', 'Lviv', 1),
	('Hotel Kyiv', '1977-11-11', 'Kyiv', 1);
	GO

	SELECT * 
	FROM hotel
	GO

	UPDATE hotel 
	SET foundation_year='1937'
	WHERE 
	hotel_id=1;
	GO

	DELETE hotel
	WHERE hotel_id=3;
	GO

	INSERT INTO users(name, email)
	VALUES
	('Andrew', 'Andrew@gmail.com'),
	('Andrew', 'Andrew123@gmail.com'), 
	('Anton', 'Anton@gmail.com'), 
	('Anton', 'Anton123@gmail.com'), 
	('Nansy', 'Nansy@gmail.com'),
	('Nastia', 'Nastia@gmail,com'),
	('Mike', 'Mike@gmail.com'),
	('Nina', 'Nina@gmail.com'),
	('Ighor', 'Ighor@gmail.com'),
	('Sally', 'Sally@gmail.com');
	GO

	SELECT TOP 100 [name]
	FROM users
	WHERE name LIKE 'A%';
	GO

	INSERT INTO hotelRooms (roomNumber, price, comfort, capability, id_hotel)
	VALUES
	(101, 30.0 , 2, 2, 1),
	(102, 33.0 , 2, 3, 1),
	(103, 35.5 , 2, 3, 1),
	(104, 45.5 , 2, 3, 1),
	(103, 25.5 , 1, 2, 1),
	(204, 55.5 , 2, 3, 1),
	(301, 35.5 , 2, 3, 1),
	(103, 65.5 , 3, 3, 2),
	(105, 65.5 , 3, 3, 2),
	(101, 65.5 , 3, 3, 2);
	GO

	SELECT ALL[roomNumber]
	FROM hotelRooms
	ORDER BY price
	GO

	SELECT ALL[roomNumber]
	FROM hotelRooms
	WHERE 
	id_hotel = 2;
	GO

	SELECT * FROM hotelRooms 
	WHERE comfort = 3;
	GO

	SELECT name, hotelRooms.roomNumber FROM hotel
	JOIN hotelRooms ON hotelRooms.id_hotel = hotel.hotel_id
	WHERE hotelRooms.comfort=1;
	GO

	SELECT name,(SELECT COUNT(*) FROM hotelRooms 
	WHERE hotelRooms.id_hotel = hotel.hotel_id) AS [COUNT] 
	FROM hotel
	GO

	INSERT INTO rezervation (room_reserved,user_rezervation,start_reservation,end_reservation)
	VALUES
	(1, 1,'2020-12-21', '2020-12-22'),
	(2, 3,'2020-12-22', '2020-12-23'),
	(3, 4,'2020-12-23', '2020-12-24'),
	(4, 3,'2020-12-24', '2020-12-25'),
	(5, 5,'2020-12-25', '2020-12-26'),
	(2, 7,'2020-12-26', '2020-12-26'),
	(2, 4,'2020-12-21', '2020-12-22'),
	(3, 7,'2020-12-21', '2020-12-22'),
	(7, 8,'2020-12-21', '2020-12-22'),
	(6, 9,'2020-12-21', '2020-12-22');
	GO

	SELECT name, hotelRooms.roomNumber, rezervation.start_reservation, rezervation.end_reservation FROM users
	JOIN rezervation ON rezervation.user_rezervation = users_id
	JOIN hotelRooms ON hotelRooms.room_Id = rezervation.room_reserved
	GO
