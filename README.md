# ReGlammed

ReGlammed is a SwiftUI-based iOS application built to make buying, renting and selling pre-loved clothes simple and accessible. The idea came from noticing how many students own clothes that are only worn once or twice before being forgotten. Instead of letting them sit in a wardrobe, ReGlammed gives them another life by making them available to someone else.

This project was developed as a personal learning project while exploring iOS development with SwiftUI and Firebase. It combines user authentication, cloud storage, image uploads, database management and a modern user interface into one complete application.

## Features

* Google Sign-In using Firebase Authentication
* User profiles stored in Cloud Firestore
* Upload clothing listings with multiple images
* Buy and rent sections
* Search functionality
* Filters by category, size and brand
* Sorting by newest and price
* Save favourite listings
* Edit and delete your own listings
* WhatsApp integration to contact sellers
* Splash screen and onboarding flow
* Modern reusable SwiftUI components

## Tech Stack

* SwiftUI
* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Google Sign-In
* MVVM Architecture
* Xcode
* Git and GitHub

## Project Structure

```text
ReGlammed
│
├── Models
├── Views
│   ├── Components
│   ├── Home
│   ├── Buy
│   ├── Rent
│   ├── Upload
│   ├── Profile
│   └── Listing Detail
│
├── Assets
├── Fonts
└── Firebase Configuration
```

## What I Learned

This project taught me much more than just SwiftUI.

I learned how to build a complete application from scratch instead of creating isolated screens. Working with Firebase helped me understand authentication, Firestore databases, cloud storage and how data flows between different parts of an app. I also gained experience creating reusable SwiftUI components instead of repeating code across multiple screens.

Another major learning experience was debugging. Throughout development I encountered issues related to Firebase configuration, authentication, navigation, image uploads and state management. Solving these problems helped me become much more comfortable reading errors, understanding documentation and improving the overall architecture of the app.

## Challenges

Some of the challenges I worked through while building ReGlammed included:

* Setting up Firebase Authentication with Google Sign-In
* Uploading multiple images to Firebase Storage
* Managing user data with Firestore
* Designing reusable SwiftUI components
* Creating dynamic filtering and search
* Connecting listings to the currently logged-in user instead of using hardcoded data
* Managing navigation and shared state across multiple screens

Each challenge required several iterations and helped me better understand how larger iOS applications are structured.

## Future Improvements

Although the current version is a functional MVP, there are several ideas I would like to add in the future.

* In-app chat between buyers and sellers
* Apple Sign-In
* Push notifications
* AI-based outfit recommendations
* Seller ratings and reviews
* Wishlist synchronization across devices
* Better recommendation and discovery system

## Running the Project

Clone the repository.

```bash
git clone https://github.com/shivanshiworks/ReGlammed.git
```

Open the project in Xcode.

Add your own `GoogleService-Info.plist` file from Firebase.

Build and run the application.




## Author

**Shivanshi Priyadarshi**

LinkedIn: *(coming soon)*


### Give Fashion A Second Life.
