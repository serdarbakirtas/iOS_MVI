# Experimantal MVI Project 

## Getting Started

### Tech
***
- Xcode 15.3
- Supported iOS versions: 17.0
- Language: Swift
- Frameworks: SwiftUI, Observable
- Supported devices: iPhone - iPad (portrait and landscape orientation)

### Installation
- [Download Xcode](https://developer.apple.com/download/all/?q=Xcode) from the Apple Developer website.

# ``MVI Design Architecture``

## Introduction

The Model-View-Intent (MVI) architecture is a pattern commonly used in mobile application development, particularly in frameworks like SwiftUI for iOS apps. It provides a structured approach to building user interfaces that are reactive, scalable, and maintainable. This documentation aims to provide an overview of the MVI architecture, its components, and its benefits.
***
## Components

### Model

- The Model represents the data and business logic of the application.
- It encapsulates the state of the application and exposes methods to manipulate that state.
- In MVI, the Model is immutable, meaning that changes to the state result in the creation of a new instance rather than mutating the existing one.
- The Model emits state updates to be consumed by the View.

### View

- The View is implemented using SwiftUI, Apple's modern framework for building user interfaces declaratively.
- Utilizing SwiftUI's reactive nature, async buttons are incorporated to handle user interactions asynchronously without blocking the main thread.
- SwiftUI's built-in support for state management ensures that changes to the View's state trigger automatic updates to the UI, maintaining a reactive and responsive user experience.

### Intent

- The `ProfileFeature` class represents the feature for managing the profile view. It handles intents triggered by user interactions and manages the state of the profile view.

- **Reactive Intent Definition** 
    The `Intent` enum defines the various user actions or intents that can occur within the transaction list feature:
    - `viewAppeared`: Indicates that the view has appeared and requires initial data loading.

## State Management

The `ProfileFeature` manages the state of the profile view using the `ProfileViewState` struct.

## Properties

- `state`: Represents the current state of the profile view.
- `githubRepository`: An instance of `GithubRepository` for fetching transaction data.

## Initializers

- ` @Injected(\.githupRepositoryProvider)`: Initializes the `ProfileFeature` with a GitHub repository. Implementation is like a Enviroment property.

## Intent Handling

The `reduce` method handles incoming intents asynchronously, updating the state of the profile view based on the intent received.

***

## Workflow

1. **User Interaction**: The user interacts with the View, triggering an intent (e.g., tapping a button).
2. **Intent Handling**: The View sends the intent to the Feature for processing.
3. **State Update**: The Feature processes the intent, updates the Model accordingly, and emits a new state.
4. **UI Rendering**: The View observes the state changes emitted by the Feature and updates the UI to reflect the new state.
5. **Feedback Loop**: The process repeats as the user continues to interact with the application, creating a reactive feedback loop.

***

## Benefits

- **Reactive**: MVI promotes a reactive programming paradigm, where changes in state trigger automatic updates to the user interface.
- **Predictable**: By enforcing immutability and separating concerns, MVI makes application behavior more predictable and easier to understand.
- **Testable**: The pure functions and clear separation of concerns in MVI make it easier to write unit tests for individual components.
- **Scalable**: MVI provides a scalable architecture that can accommodate complex user interfaces and evolving application requirements.

***

## Conclusion

The Model-View-Intent (MVI) architecture offers a structured approach to building reactive and maintainable user interfaces in mobile applications. By separating concerns and enforcing immutability, MVI promotes predictability, testability, and scalability, making it a popular choice for modern app development.
