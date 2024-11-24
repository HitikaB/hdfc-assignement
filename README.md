Overview

This project is a Node.js application that demonstrates how to perform Create, Read, Update, and Delete (CRUD) operations using Express.js and MySQL. It provides a simple example of how to build a web application to manage user records stored in a MySQL database.
Features

  Create: Add new user records to the database.
  Read: Retrieve and display user records.
  Update: Modify existing user records.
   Delete: Remove user records from the database.

Prerequisites

   Node.js and npm (Node Package Manager)
   MySQL database
   Basic understanding of JavaScript, Node.js, and Express.js


Usage
Adding a New User

   Navigate to /adduser.
   Fill in the form with the user's details (name, age, city).
   Click "Save User" to submit the form.

Editing an Existing User

   Navigate to /edituser/:id, replacing :id with the user's ID.
   Update the details as needed.
   Click "Save Changes" to submit the form.

Deleting a User

   Navigate to /deleteuser/:id, replacing :id with the user's ID.
   The user will be removed from the database.
