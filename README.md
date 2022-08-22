# Yummies - iOS

## About

Yummies is my first attempt at building a native iOS app using Swift and SwiftUI. A recipe browser where you can pin your favorite ones. Powered by [Edamam Recipe Search API](https://developer.edamam.com/edamam-docs-recipe-api).

## Key Features
 - Sign in / Sign up via Google, Apple or email
 - Featured section and recipe search
 - Categories sheet
 - Recipe details (nutrients, ingredients and more)
 - Pinning a recipe
 - Profile screen

![Sign in / Sign up](https://media.giphy.com/media/Ig1aTddmQbkAJuWUyJ/giphy.gif) ![Featured + Search](https://media.giphy.com/media/En3Aa7HC6IDtoTTyvY/giphy.gif) ![Categories](https://media.giphy.com/media/OLSEewYaHbpQUhi20O/giphy.gif) ![Details](https://media.giphy.com/media/WvmbOV9NK1Dx055qNH/giphy.gif) ![Pinning](https://media.giphy.com/media/uqJjpKWM6NNyavmL9y/giphy.gif) ![Profile](https://media.giphy.com/media/TIqe9Go8PgIsVssAwh/giphy.gif)

## Usage
_Prerequisites:_
 - _MacOS_
 - _Xcode 14 beta+_
 - _iOS 16.0+ device or simulator_
 
If you would like to try this app out for yourself, follow these steps:

Steps
 - Clone the repo to your local machine
 - Open `Yummies.xcodeproj` with Xcode
 - Wait for packages and indexing to load
 - In the top bar select your desired iOS device (connected via cable) or simulator
 - Click the `Run` button or press `⌘(Cmd) + R`

## Acceptance Criteria
These are very vague but wanted to have a structure I can follow:

- Authentication
    - Sign up
    - Sign in
    - Sign out
 
- Home Screen
    - Pinned section
    - Featured section
    - Categories section

- Details Screen
    - Image 
    - Title
    - Description
    - Ingredients
    - Nutrients
    - Option to pin
 
- Profile Screen
    - User image
    - User name
    - Profile info
        - Full name
        - Email
        - Date joined
        - Pinned recipes count
    - Sign out button
