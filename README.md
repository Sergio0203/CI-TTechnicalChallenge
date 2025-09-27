# Technical Challenge - Pokédex App (CI&T)

This is a simple application developed as part of a technical challenge. The goal is to demonstrate skills in consuming APIs, building user interfaces, and architecting scalable solutions on iOS.

## About the Project
The application consists of a Pokédex that consumes data from the PokeAPI to display a list of Pokémon and their details,offering a basic and intuitive browsing experience.

## Features
The application has the following main features:

### Pokémon List:

 Displays a list with the name and image of various Pokémon.
 The data is obtained dynamically through the PokeAPI.

### Details Screen:

When a Pokémon from the list is tapped, the user is redirected to a details screen.

On this screen, specific information about the selected Pokémon is displayed, such as:

Types (e.g., Grass, Poison)

Weight

## Technical Details
UI Framework: Built entirely with SwiftUI, chosen for its declarative syntax and ease of building and managing views.

Networking: A scalable, protocol-oriented networking layer was implemented. This decouples the application from a specific client like URLSession, allowing for easy substitution or addition of other clients in the future as long as they conform to the required protocol.

Concurrency: The project leverages modern Swift Concurrency (async/await) for handling asynchronous operations. This results in cleaner, more readable, and safer code compared to traditional completion handlers.

### API Used
PokeAPI: All information about the Pokémon, including names, images, types, and weight, is obtained through requests to this free and public API.

### System Requirements
Platform: iOS
Minimum Version: 18.0

## Future Improvements
Given more time, the following enhancements would be considered:

Navigation Router: Implement a dedicated Router to manage navigation flows, replacing the standard NavigationLink. This would lead to a more robust and decoupled navigation architecture.

Infinite Scrolling: Enhance the user experience by implementing infinite scrolling on the Pokémon list, removing the need for manual pagination.

Enhanced Error Handling: Develop a more descriptive and user-friendly error screen to provide better feedback on network failures or other issues.
