-- query 1
SELECT
    e.eventID,
    e.title,
    e.venue,
    e.startingTime,
    e.endTime,
    GROUP_CONCAT(CONCAT(tt.typeName, ': ', r.amount) ) AS ticketInfo
FROM
    Event e
JOIN
    Releases r ON e.eventID = r.eventID
JOIN
    TicketType tt ON r.ticketTypeID = tt.ticketTypeID
WHERE
    e.title = 'Exeter Food Festival 2023'
GROUP BY
    e.eventID, e.title, e.venue, e.startingTime, e.endTime;

-- query 2
SELECT
    title,
    startingTime, 
    description 
FROM
    Event 
WHERE
    venue = 'Exeter'
    AND date BETWEEN '2023-07-01' AND '2023-07-10';

-- query 3
SELECT
    R.amount,
    TT.price
FROM
    Releases R
JOIN
    Event E ON R.eventID = E.eventID
JOIN
    TicketType TT ON R.ticketTypeID = TT.ticketTypeID
WHERE
    E.title = 'Exmouth Music Festival 2023'
    AND TT.typeName = 'Bronze';

-- query 4
SELECT firstName, lastName, p.quantity fudge
FROM Customer c
JOIN
    Booking b ON c.customerID = b.customerID
JOIN
    Purchases p ON b.bookingID = p.bookingID
JOIN
    TicketType tt ON p.ticketTypeID = tt.ticketTypeID
WHERE
    tt.typeName = 'Gold';

-- query 5
SELECT
    e.title AS eventName,
    COUNT(t.ticketTypeID) AS totalTicketsSold
FROM
    Event e
JOIN
    Releases r ON e.eventID = r.eventID
JOIN
    TicketType tt ON r.ticketTypeID = tt.ticketTypeID
JOIN
    Ticket t ON tt.ticketTypeID = t.ticketTypeID
GROUP BY
    e.title
ORDER BY
    totalTicketsSold DESC;

-- query 6
SELECT *
FROM
    Booking b
JOIN
    Customer c ON b.customerID = c.customerID
JOIN
    Purchases p ON b.bookingID = p.bookingID
JOIN
    TicketType tt ON p.ticketTypeID = tt.ticketTypeID
JOIN
    Ticket t ON tt.ticketTypeID = t.ticketTypeID
JOIN
    Event e ON e.eventID = (
        SELECT eventID FROM Releases r WHERE r.ticketTypeID = tt.ticketTypeID
    )
WHERE
    b.bookingID = 1; 

-- query 7
SELECT
    e.title AS eventTitle,
    SUM(b.totalAmount) AS totalIncome
FROM
    Event e
JOIN
    Releases r ON e.eventID = r.eventID
JOIN
    TicketType tt ON r.ticketTypeID = tt.ticketTypeID
JOIN
    Purchases p ON tt.ticketTypeID = p.ticketTypeID
JOIN
    Booking b ON p.bookingID = b.bookingID
GROUP BY
    e.title
ORDER BY
    totalIncome DESC
LIMIT 1;
