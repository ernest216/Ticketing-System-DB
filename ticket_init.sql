CREATE TABLE Event (
    eventID INT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    date DATE,
    venue VARCHAR(255),
    startingTime TIME,
    endTime TIME
);

CREATE TABLE TicketType (
    ticketTypeID INT PRIMARY KEY,
    typeName VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Ticket (
    ticketID INT PRIMARY KEY,
    deliveryOptions VARCHAR(255),
    ticketTypeID INT,
    FOREIGN KEY (ticketTypeID) REFERENCES TicketType(ticketTypeID)
);

CREATE TABLE Card (
    cardID INT PRIMARY KEY,
    cardNumber VARCHAR(255),
    cardType VARCHAR(255),
    securityCode VARCHAR(255),
    expiryDate DATE
);

CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    email VARCHAR(255),
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    cardID INT,
    FOREIGN KEY (cardID) REFERENCES Card(cardID)
);

CREATE TABLE Voucher (
    voucherCode VARCHAR(255) PRIMARY KEY,
    discountPercentage DECIMAL(5, 2),
    eventID INT,
    FOREIGN KEY (eventID) REFERENCES Event(eventID)
);

CREATE TABLE Booking (
    bookingID INT PRIMARY KEY,
    referenceCode VARCHAR(255),
    totalAmount DECIMAL(10, 2),
    isPaid BOOLEAN,
    isCancelled BOOLEAN,
    customerID INT,
    cardID INT,
    voucherCode VARCHAR(255),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    FOREIGN KEY (cardID) REFERENCES Card(cardID),
    FOREIGN KEY (voucherCode) REFERENCES Voucher(voucherCode)
);

CREATE TABLE Credit (
    cardID INT PRIMARY KEY,
    FOREIGN KEY (cardID) REFERENCES Card(cardID)
);

CREATE TABLE Debit (
    cardID INT PRIMARY KEY,
    FOREIGN KEY (cardID) REFERENCES Card(cardID)
);

CREATE TABLE Visa (
    cardID INT PRIMARY KEY,
    FOREIGN KEY (cardID) REFERENCES Card(cardID)
);

CREATE TABLE MasterCard (
    cardID INT PRIMARY KEY,
    FOREIGN KEY (cardID) REFERENCES Card(cardID)
);

CREATE TABLE Amex (
    cardID INT PRIMARY KEY,
    FOREIGN KEY (cardID) REFERENCES Card(cardID)
);

CREATE TABLE Releases (
    eventID INT,
    ticketTypeID INT,
    amount INT,
    PRIMARY KEY (eventID, ticketTypeID),
    FOREIGN KEY (eventID) REFERENCES Event(eventID),
    FOREIGN KEY (ticketTypeID) REFERENCES TicketType(ticketTypeID)
);

CREATE TABLE Purchases (
    bookingID INT,
    ticketTypeID INT,
    quantity INT,
    PRIMARY KEY (bookingID, ticketTypeID),
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID),
    FOREIGN KEY (ticketTypeID) REFERENCES TicketType(ticketTypeID)
);

INSERT INTO Event (eventID, title, description, date, venue, startingTime, endTime)
VALUES (1, 'Exeter Food Festival 2023', 'Food Stall', '2023-07-02', 'Exeter', '12:00:00', '22:00:00');

-- Insert data for 'adult' ticket type
INSERT INTO TicketType (ticketTypeID, typeName, price)
VALUES (1, 'Adult>16', 30);

-- Insert data for 'child' ticket type
INSERT INTO TicketType (ticketTypeID, typeName, price)
VALUES (2, 'Child 5-15', 10);

INSERT INTO Releases (eventID, ticketTypeID, amount) 
VALUES (
    (SELECT eventID FROM Event WHERE title = 'Exeter Food Festival 2023'), 
    (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Adult>16'), 
    100
);

INSERT INTO Releases (eventID, ticketTypeID, amount) 
VALUES (
    (SELECT eventID FROM Event WHERE title = 'Exeter Food Festival 2023'), 
    (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Child 5-15'), 
    100
);

INSERT INTO Event (eventID, title, description, date, venue, startingTime, endTime)
VALUES (2, 'Exmouth Music Festival 2023', 'Music Event', '2023-07-05', 'Exmouth', '16:00:00', '22:00:00');

INSERT INTO TicketType (ticketTypeID, typeName, price)
VALUES (3, 'Gold', 30);


INSERT INTO TicketType (ticketTypeID, typeName, price)
VALUES (4, 'Silver', 20);

INSERT INTO TicketType (ticketTypeID, typeName, price)
VALUES (5, 'Bronze', 10);

INSERT INTO Releases (eventID, ticketTypeID, amount) 
VALUES (
    (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023'), 
    (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Gold'), 
    100
);
INSERT INTO Releases (eventID, ticketTypeID, amount) 
VALUES (
    (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023'), 
    (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Silver'), 
    100
);
-- Insert data for 'child' ticket type
INSERT INTO Releases (eventID, ticketTypeID, amount) 
VALUES (
    (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023'), 
    (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Bronze'), 
    100
);
-- Insert James' card information into the Card table
INSERT INTO Card (cardID, cardNumber, cardType, securityCode, expiryDate)
VALUES (1, '1234567890123456', 'Credit', '123', '2024-12-31');

INSERT INTO Debit (cardID)
VALUES (1);

INSERT INTO Visa (cardID)
VALUES (1);

-- Insert James into the Customer table
INSERT INTO Customer (customerID, email, firstName, lastName, cardID)
VALUES (1, 'james@example.com', 'James', 'Doe', 1);

INSERT INTO Booking (bookingID, referenceCode, totalAmount, isPaid, isCancelled, customerID, cardID, voucherCode)
VALUES (1, 'ABC123', 90.00, true, false, 1, 1, NULL);

INSERT INTO Purchases (bookingID, ticketTypeID, quantity)
VALUES (1, 3, 3);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(1, 'email', 3);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(2, 'email', 3);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(3, 'email', 3);

UPDATE Releases
SET amount = amount - 3
WHERE eventID = (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023')
AND ticketTypeID = (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Gold');

INSERT INTO Booking (bookingID, referenceCode, totalAmount, isPaid, isCancelled, customerID, cardID, voucherCode)
VALUES (2, 'ZYX111', 90.00, true, false, 1, 1, NULL);

INSERT INTO Purchases (bookingID, ticketTypeID, quantity)
VALUES (2, 2, 2);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(4, 'email', 2);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(5, 'email', 2);

UPDATE Releases
SET amount = amount - 2
WHERE eventID = (1)
AND ticketTypeID = (2);


