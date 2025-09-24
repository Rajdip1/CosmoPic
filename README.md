# CosmoPic

CosmoPic is a Flutter application that showcases the "Image of the Day" from NASA's APOD (Astronomy Picture of the Day) API. It allows users to browse through a history of images, view detailed descriptions, and save their favorite images locally.

## Features

*   **Image of the Day:** View the latest image from NASA's APOD API on the home screen.
*   **History:** Browse through past images by selecting a specific date.
*   **Favorites:** Save your favorite images and view them in the favorites screen.
*   **Detailed View:** Get a detailed description of each image.
*   **Local Storage:** Favorites are saved locally on your device using `shared_preferences`.

## Screenshots

*(You can add screenshots of your app here)*

## Getting Started

### Prerequisites

*   Flutter SDK
*   Dart SDK

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/Rajdip1/CosmoPic.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd cosmopic
    ```
3.  Install the dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the app:
    ```bash
    flutter run
    ```

## Project Structure

The project is organized into the following directories:

*   `lib/`: Contains the main Dart code for the application.
    *   `main.dart`: The entry point of the application.
    *   `model/`: Contains the data models for the application.
        *   `api_model.dart`: The data model for the NASA APOD API response.
    *   `screens/`: Contains the UI screens for the application.
        *   `home.dart`: The home screen, which displays the "Image of the Day".
        *   `history.dart`: The history screen, which allows users to browse past images.
        *   `favorite.dart`: The favorites screen, which displays the user's saved images.
        *   `description.dart`: The description screen, which displays a detailed description of an image.
    *   `service/`: Contains the services for the application.
        *   `image_manager.dart`: A service for managing the user's favorite images.
    *   `splash_screen.dart`: The splash screen that is displayed when the app is launched.
    *   `BottomNavigation.dart`: The bottom navigation bar for the application.
*   `assets/`: Contains the assets for the application, such as images and fonts.

## Dependencies

The following packages are used in this project:

*   `flutter`: The Flutter framework.
*   `cupertino_icons`: A set of iOS-style icons.
*   `shimmer`: A package for adding a shimmer effect to widgets.
*   `http`: A package for making HTTP requests.
*   `intl`: A package for internationalization and localization.
*   `provider`: A package for state management.
*   `shared_preferences`: A package for storing data locally.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have any suggestions or find any bugs.

