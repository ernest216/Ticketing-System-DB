--update1
UPDATE Releases
SET amount = amount + 100
WHERE eventID = (SELECT eventID FROM Event WHERE title = 'Exeter Food Festival 2023')
AND ticketTypeID = (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Adult>16');

--update2
INSERT INTO Voucher (voucherCode, discountPercentage, eventID)
VALUES ('FOOD10', 10.00, (SELECT eventID FROM Event WHERE title = 'Exeter Food Festival 2023'));

INSERT INTO Card (cardID, cardNumber, cardType, securityCode, expiryDate)
VALUES (2, '9999567890123456', 'Credit', '321', '2024-12-31');
INSERT INTO Credit (cardID)
VALUES (2);

INSERT INTO Visa (cardID)
VALUES (2);

INSERT INTO Customer (customerID, email, firstName, lastName, cardID)
VALUES (2, 'ian@example.com', 'Ian', 'Cooper', 2);

INSERT INTO Booking (bookingID, referenceCode, totalAmount, isPaid, isCancelled, customerID, cardID, voucherCode)
VALUES (3, 'erer11', 63.00, true, false, 2, 2, 'FOOD10');

INSERT INTO Purchases (bookingID, ticketTypeID, quantity)
VALUES (3, 1, 2);

INSERT INTO Purchases (bookingID, ticketTypeID, quantity)
VALUES (3, 2, 1);

UPDATE Releases
SET amount = amount - 2
WHERE eventID = (1)
AND ticketTypeID = (1);

UPDATE Releases
SET amount = amount - 1
WHERE eventID = (1)
AND ticketTypeID = (2);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(6, 'email', 1);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(7, 'email', 1);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(8, 'email', 2);

--update 3
INSERT INTO Card (cardID, cardNumber, cardType, securityCode, expiryDate)
VALUES (3, '9876543210987654', 'Credit', '456', '2024-12-31');

INSERT INTO Credit (cardID)
VALUES (3);

INSERT INTO Visa (cardID)
VALUES (3);

INSERT INTO Customer (customerID, email, firstName, lastName, cardID)
VALUES (3, 'joe@example.com', 'Joe', 'Smiths', 3);

INSERT INTO Booking (bookingID, referenceCode, totalAmount, isPaid, isCancelled, customerID, cardID, voucherCode)
VALUES (4, 'XYZ789', 20.00, true, false, 3, 3, NULL);

INSERT INTO Purchases (bookingID, ticketTypeID, quantity)
VALUES (3, 4, 1);

INSERT INTO Ticket (ticketID, deliveryOptions, ticketTypeID)
VALUES(9, 'email', 4);

UPDATE Releases
SET amount = amount - 1
WHERE eventID = (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023')
  AND ticketTypeID = (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Silver');

UPDATE Booking
SET isCancelled = true
WHERE bookingID = 4;

UPDATE Releases
SET amount = amount + 1
WHERE eventID = (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023')
  AND ticketTypeID = (SELECT ticketTypeID FROM TicketType WHERE typeName = 'Silver');

DELETE FROM Ticket
WHERE ticketID IN (SELECT ticketID FROM Purchases WHERE bookingID = 4);


DELETE FROM Purchases
WHERE bookingID = 4;

--update 4
INSERT INTO Voucher (voucherCode, discountPercentage, eventID)
VALUES ('SUMMER20', 20.00, (SELECT eventID FROM Event WHERE title = 'Exmouth Music Festival 2023'));