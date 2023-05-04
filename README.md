# THE ALIBRARY PROJECT

- [Group Video Recording](https://drive.google.com/file/d/1DzPP_T4fZphSydr8XXEQAG-7tadoWukX/view?usp=sharing)


To see the UI/UX implementation of our mini-project, view our [UI/UX Implementation on flutterflow](https://app.flutterflow.io/share/mob-dev2-ft2lj0)

A few things to note when navigating through the UI/UX design:
- On opening the link, the first page that appears is the 'upload a book' page.
- This page does not have a back button (Part of the remaining 10% ui/ux design left)
- Use the page's embede forward button (at the top right) to navigate to the next page (homepage) where you can navigate to all other pages in the app
- The UI/UX implementation is with the assumption that a user of the app is already registered in the database. Hence, no need to enter details before clicking login or signup. Also, a you will have to logout to have access to the sign in and signup screens.
- In the drawer, there is a 'logout' button where users can log out of the account.
- On logout, the user can sign in. There is a back button on almost all pages to enhance smooth navigation to previously visited pages.
- The actual implementation will have the drawer on all pages. For now, we have implemented the drawer but it only appears on the homepage. the back button on most pages will help take users back to the homepage.

# ABOUT THE ALIBRARY PROJECT <br /> 
This is a flutter mobile app that connects the ALU community (students and staff) to exchange books with one another, irrespective of their social circles, cohorts, or courses. This app aims to foster connections and promote a shared community reading culture. Students can upload images of books they own, while others on the platform can 'book' the book they're interested in reading. The app will facilitate communication between the book owner and the interested student, sav ing the latter the cost of purchasing that book. The app will also track who has booked a particular book, providing a reliable record in case of any misconduct or lost books. In essence, this app will provide students with an opportunity to broaden their horizons, discover new books at no cost, and develop a lifelong love for reading.

# Purpose of the App </br>
The A Library App is meant to foster knowledge-sharing on the ALU campus and reduce expenditure spent on purchasing books that can be borrowed through a directed process on campus. Through the knowledge sharing via book exchange, students get to meet others and get acquainted with themselves, creating a more connected community in the diverse ALU environment.

# Development process & challenges </br>
The development process was quite a tough one. Through  planning the app and making rough sketches of the UI to implementing the full functional app, we have encounted several challenges but learnt a lot.
Some challenges we have encountered include having to deal with our different schedules and meeting deadlines for submissions as well as those for other courses. Amidst these, the development process itself required more search for helpful resources to widen our understanding of class content and better implement our project. Getting the firebase authentication to worked on all ends required such extra learning for us to find out that we could all collaborators on one fibrebase project.
Other specific challenges we encountered were populating the drawer functionality on multiple pages. The others were testing and deployment to app tester. Our devices also had some compabilitg issues. But the great news is, we overcame these challenges, which have made this journey more of a learning journey than problematic.
To know the step-by-step stages in our development process, our tracker document [here](https://docs.google.com/spreadsheets/d/1Ee4WV_HzG56ZqHogUjGIBfqj_DGQUVznSIW9S2bAtqY/edit?usp=sharing) can be helpful. 


# UI DESIGN AND IMPLEMENTATION STATUUS: </br>
The UI design is complete except the parts that require database connection.
The app implementation is 100% complete.

Pages available:
List of Application Pages

- Sign Up Page 
- Log In Page 
- Terms & Conditions Page
- Drawer Page
- Home Page
- Book Details Page
- Book Upload Page
- Notifications Page
- Settings Page
- Profile Page
- user_books
- user_information

# Security Measures <br /> 
To secure the application, we set up SHA-256 Certificate. Overall, SHA-256 is considered to be a secure and reliable hashing algorithm and is widely adopted in modern security applications.<br /> 
The command to follow is as follows: <br /> 
    In your project root : <br /> 
         >***cd android ***<br /> 
         >***./gradlew signingReport***<br /> 
    
   This will generate both SHA -1 and SHA-256 fingerprints. We used, SHA-256. <br /> 
   
 **Additionally, we enabled App Check using the SHA-256 fingerprints digits**  <br />
