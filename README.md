🌦️ SkyCast - Weather App
📌 Project Overview
SkyCast is a modern weather application built with Flutter. It allows users to search for cities worldwide, providing real-time weather conditions and a comprehensive 5-day forecast.

🛠️ Weather API Integration
This project integrates two primary APIs to deliver accurate data:

Open-Meteo Geocoding API: Used to translate city names into geographic coordinates (Latitude/Longitude).

OpenWeatherMap API: Used to fetch current weather conditions and 5-day forecasts based on coordinates. (Data is retrieved in Metric/Celsius units).

🏗️ Code Architecture
The project is built using Clean Architecture principles combined with the BLoC (Business Logic Component) pattern. This separation of concerns ensures that the codebase is scalable, testable, and maintainable.

1. Data Layer
Models: Responsible for parsing raw JSON responses from APIs into Dart objects (e.g., WeatherDataModel).

Repositories (Implementation): Contains the actual logic for fetching data from network sources.

Network Client: Utilizes http_interceptor to manage API requests, headers, and centralized error handling.

2. Domain Layer
Entities/Models: Core data structures used throughout the application.

UseCases: Encapsulates specific business logic (e.g., SearchNameUsecase).

Repository Interfaces: Abstract classes that define the contract for data operations, decoupling the Domain from the Data layer.

3. Presentation Layer
BLoCs: Manages the application state. It converts user events into states (Loading, Success, Failure) using a predictable flow.

Pages/Screens: The UI layer where users interact with the app.

Widgets: Reusable UI components (e.g., ApiErrorWidget) to ensure a consistent design system.

✨ Key Features & Enhancements
Robust State Management: Implemented using the Flutter BLoC library.

Dynamic UI Theming: The app's background gradient and color scheme change dynamically based on the current weather condition (e.g., Clear, Clouds, Rain).

Animations: Utilizes AnimatedContainer for smooth visual transitions between weather states.

Unit Testing: Includes comprehensive unit tests for Data Models and BLoC logic to ensure reliability.

Advanced Error Handling: User-friendly error messages with a built-in Retry mechanism for network or API failures.

Geolocation: Integrated geolocator to provide immediate weather updates based on the user's current location.