# Gallery Application
## Introduction

This project is a basic page gallery application developed for iOS. It allows users to log in with Google, view a list of online images/wallpapers with pagination, and persist images offline using a database. The application is built using the MVVM architecture and follows best coding practices.

## Features

* **Google Sign-In:** Users can log in using their Google account.
* **Online Image Gallery:** Fetch and display images from the Unsplash API with pagination.
* **Offline Persistence:** Save and display images offline using Core Data.
* **Profile Page:** Basic profile page with a logout option.

## Architecture and Framework

* **MVVM Architecture:** The application is structured using the Model-View-ViewModel (MVVM) architecture.
* **Core Data:** Used for offline data persistence.
* **Unsplash API:** Used to fetch online images.
* **Swift 5:** The programming language used for development.
* **Xcode 14.3:** The version of Xcode used.
* **iOS 16.4:** The target iOS version.
* **iPhone 14 Plus:** The device used for testing.

## Setup and Installation

### Prerequisites

 Xcode 12.0 or later
 
 CocoaPods
 
### Installation Steps
1.Clone the repository:
 
   git clone https://github.com/Spriyha/GalleryApp.git

2.Navigate to the project directory:

  cd GalleryApp

3.Install dependencies:

* Ensure you have CocoaPods installed. If not, install CocoaPods:
  sudo gem install cocoapods
  
* Install project dependencies
   pod install

4.Open the project:

  Open yourproject.xcworkspace in Xcode.

5.Configure Google Sign-In:

  * Follow the Google Sign-In for iOS guide to set up your project in the Google Developer Console and download the configuration file.
  * Add the configuration file to your project.

6.Run the project:

  Select the target device and press Cmd + R to run the project.

## Usage
 * **Login with Google:**

  Click on the "Google Login" button on the login screen to sign in with your Google account.
  
* **View Images:**

  After logging in, the gallery screen will display images fetched from the Unsplash API.

  Scroll to view more images with pagination.
  
* **Offline Viewing:**

  Images viewed online are saved offline using Core Data.
  
  These images can be viewed without an internet connection.

* **Logout:**

  Navigate to the profile page and click the "Logout" button to log out of the application.

## Project Structure
* Model
  
  ImageEntity: Core Data entity for storing images with attributes id, imageData, and url.
  
  ImageModel: Struct to map JSON data from Unsplash API.
  
* ViewModel
  
   LoginViewModel: Handles Google Sign-In logic.
  
   GalleryViewModel: Manages fetching and storing images from the Unsplash API and Core Data.
  
* View
  
  LoginViewController: Manages the login screen UI and interactions.
  
  GalleryViewController: Displays the image gallery and handles user interactions.
  
  ProfileViewController: Displays user profile information and logout option.
  
* Dependencies
  
  GoogleSignIn: Used for Google authentication.
  
  CoreData: Used for offline data persistence.
  
  Unsplash API: Used to fetch images.


## ScreenShots and Animated Gif

![pre1](https://github.com/user-attachments/assets/8152f6cc-d815-4b93-b465-761598c55c7a)

![are1](https://github.com/user-attachments/assets/ba451f11-0e4d-4496-baaf-799795e72520)

![Gif](https://github.com/user-attachments/assets/f8090263-f523-4b59-b5aa-4761cec98b61)

## Contact

For any questions or feedback, please contact mauryas00113@gmail.com.

## License

This project is licensed under the MIT License - see the LICENSE file for details.















