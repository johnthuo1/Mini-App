# THE ALIBRARY PROJECT

Here are the resources we used to complete our progress so far:

- [Firebase Authentication](https://youtu.be/4vKiJZNPhss)
- [Login & Signup Fibrebase Sample](https://github.com/Kavit900/flutter_login_signup_firebase)
- Application of class content (message UI class example for notifications page)


To see the UI/UX implementation of our mini-project, view our [UI/UX Implementation on flutterflow](https://app.flutterflow.io/share/mob-dev2-ft2lj0)

A few things to note when navigating through the UI/UX design:
- On opening the link, the first page that appears is the 'upload a book' page.
- This page does not have a back button (Part of the remaining 10% ui/ux design left)
- Use the page's embede forward button (at the top right) to navigate to the next page (homepage) where you can navigate to all other pages in the app
- The UI/UX implementation is with the assumption that a user of the app is already registered in the database. Hence, no need to enter details before clicking login or signup. Also, a you will have to logout to have access to the sign in and signup screens.
- In the drawer, there is a 'logout' button where users can log out of the account.
- On logout, the user can sign in. There is a back button on almost all pages to enhance smooth navigation to previously visited pages.
- The actual implementation will have the drawer on all pages. For now, we have implemented the drawer but it only appears on the homepage. the back button on most pages will help take users back to the homepage.

# ABOUT THE ALIBRARY PROJECT
This is a flutter mobile app that connects the ALU community (students and staff) to exchange books with one another, irrespective of their social circles, cohorts, or courses. This app aims to foster connections and promote a shared community reading culture. Students can upload images of books they own, while others on the platform can 'book' the book they're interested in reading. The app will facilitate communication between the book owner and the interested student, saving the latter the cost of purchasing that book. The app will also track who has booked a particular book, providing a reliable record in case of any misconduct or lost books. In essence, this app will provide students with an opportunity to broaden their horizons, discover new books at no cost, and develop a lifelong love for reading.

Pages available:
List of Application Pages (and the status of the UI design)

- Sign Up Page (done)
- Log In Page (done)
- Terms & Conditions Page (done)
- Drawer Page (Done)
- Home Page (done)
- Book Details Page (not fully done: the images of the books appear on the homepage. Details are not yet added)
- Book Upload Page (done)
- Notifications Page (done. To view, logout and choose to signup instead of signing in. There you can click on the terms and conditions to view)
- Settings Page (done)
- Profile Page (done)

We have implemented 9 of the 10 UI/UX designed screens. That makes 90% as required. The Homepage and the drawer are all within the main.dart file.

### Here is a list of the pages done:
- Sign Up
- Terms and Conditions
- Sign In
- Home
- Drawer (UI/UX fully done, but yet to be put on all pages. Only available on homepage)
- Notifications
- Profile (UI/UX done but is not connected to the database hence does not display profile details of a specific user)
- Settings
- upload_book (Not fully done as some part requires database connection. every other thing is done for this page)

###Page not yet implemented:

Book Details - as it requires connection with the database.
