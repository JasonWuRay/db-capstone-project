Little Lemon – Coursera Database Capstone

Overview
Little Lemon is a restaurant database project from the Coursera Meta Database Capstone. It manages: 
    Customers and staff
    Menu and menu items
    Orders and delivery status
    Table bookings

The project demonstrates relational database design, SQL queries, views, stored procedures, and Python integration.

Key Tables:
    Table	
    Customer	
    Staff	
    Menu	
    Menu_Items	
    Orders	
    Order_Delivery_Status	
    Bookings	


Relationships:
    Orders → Customer, Staff, Menu, Order_Delivery_Status
    Bookings → Customer
    Menu_Items → Menu

Features
    Views: Orders with quantity > 2
    Queries: Customers with high-value orders, popular menu items
    Procedures: Add, update, cancel orders/bookings, check availability
    Prepared Statements: Dynamic order retrieval
    Python Integration: Fetch and display query results

Setup
    Run the LittleLemonDB.sql script to create the database and tables.
    Insert sample data for Customer, Bookings, Staff, Menu, Menu_Items, Orders.
    Create a MySQL user with access to LittleLemonDB.
    Connect with Python using mysql.connector.

Jason Chen – Coursera Meta Database Capstone Project