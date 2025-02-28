# African Countries Explorer

A Flutter application that displays a list of African countries with their details, such as capital, flag, and languages, fetched from the [REST Countries API](https://restcountries.com/). Built with a clean architecture, BLoC state management, and comprehensive test coverage, this project showcases best practices in Flutter development.



## Features

- **Country List**: Displays a scrollable list of African countries with names, capitals, and flags.
- **Country Details**: Shows detailed information (capital, languages, flag) when a country is selected.
- **Error Handling**: Gracefully handles network errors with user-friendly messages.
- **Responsive UI**: Adapts to different screen sizes using Flutter’s native widgets.
- **Unit & Widget Tests**: Includes tests for data, logic, and presentation layers for robust code coverage.



## Project Structure
<details>
     <summary> The project follows a clean architecture with separation of concerns: </summary>



```
├── lib
│   ├── app.dart                                # App widget with BLoC providers
│   ├── data                                    # Data Layer
│   │   ├── data.dart                           # Barrel file for data layer
│   │   ├── models                              # Data models
│   │   │   ├── country.dart                    # Country model with Freezed
│   │   │   ├── country.freezed.dart            # Generated Freezed code
│   │   │   ├── country.g.dart                  # Generated JSON serialization code
│   │   │   └── models.dart                     # Barrel file for models
│   │   └── repositories    
│   │       ├── country_repository.dart         # API interaction logic
│   │       └── repositories.dart               # Barrel file for repositories
│   ├── logic                                   # Business Logic Layer
│   │   ├── blocs                               # BLoC state management
│   │   │   ├── blocs.dart                      # Barrel file for blocs
│   │   │   ├── country_detail                  # Country Detail BLoC
│   │   │   │   ├── country_detail.dart         # Barrel file
│   │   │   │   ├── country_detail_bloc.dart    # BLoC implementation
│   │   │   │   ├── country_detail_bloc.freezed.dart # Generated Freezed code
│   │   │   │   ├── country_detail_event.dart   # Events
│   │   │   │   └── country_detail_state.dart   # States
│   │   │   └── country_list                    # Country List BLoC
│   │   │       ├── country_list.dart           # Barrel file
│   │   │       ├── country_list_bloc.dart      # BLoC implementation
│   │   │       ├── country_list_bloc.freezed.dart # Generated Freezed code
│   │   │       ├── country_list_event.dart     # Events
│   │   │       └── country_list_state.dart     # States
│   │   └── logic.dart                          # Barrel file for logic layer
│   ├── main.dart                               # Entry point
│   └── presentation                            # UI Layer
│       ├── screens
│       │   ├── detail_screen.dart              # Country detail screen
│       │   ├── home_screen.dart                # Country list screen
│       │   └── screens.dart                    # Barrel file for screens
│       └── widgets
│           ├── country_card.dart               # Reusable country list item
│           ├── error_display.dart              # Reusable error message widget
│           └── widgets.dart                    # Barrel file for widgets
├── test                                        # Test directory (not shown but referenced)
├── pubspec.yaml                                # Dependencies and configuration
└── README.md                 
```
</details>


## Dependencies
<details>
     <summary> Key dependencies used in the project: </summary>



- **flutter_bloc**: ^8.1.3 - State management with BLoC pattern.
- **dio**: ^5.4.0 - HTTP client for API requests.
- **freezed**: ^2.4.6 - Immutable data classes and union types.
- **cached_network_image**: ^3.3.1 - Efficient image loading with caching.
- **flutter_test**, **bloc_test**, **mocktail**, **mocktail_image_network** - Testing utilities.

Full list in `pubspec.yaml`.

</details>



## Setup Instructions

### Prerequisites
- Flutter SDK (v3.10.0 or later recommended)
- Dart (v3.0.0 or later)
- An IDE (e.g., VS Code, Android Studio)

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/thealphamerc/country_explorer.git
   cd country_explorer
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate Code**:
   Run the following to generate Freezed and JSON serialization files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**:
   Connect a device or emulator, then:
   ```bash
   flutter run
   ```



## Architecture

The app follows a **clean architecture** with three layers:

1. **Data Layer** (`lib/data`):
   - **Models**: Immutable `Country` class using Freezed for robust data handling.
   - **Repositories**: `CountryRepository` fetches data from the REST Countries API.

2. **Logic Layer** (`lib/logic`):
   - Uses `flutter_bloc` for event-driven state management.
   - Two BLoCs:
     - `CountryListBloc`: Manages the list of African countries.
     - `CountryDetailBloc`: Handles individual country details.
   - States and events are defined with Freezed for immutability.

3. **Presentation Layer** (`lib/presentation`):
   - **Screens**: `HomeScreen` (list) and `DetailScreen` (details).
   - **Widgets**: Reusable components like `CountryCard` and `ErrorDisplay`.

Barrel files (e.g., `models.dart`, `blocs.dart`) simplify imports across layers.



## API Integration

The app uses the [REST Countries API](https://restcountries.com/):
- **List Countries**: `GET https://restcountries.com/v3.1/region/africa?fields=name,languages,capital,flags`
- **Country Details**: `GET https://restcountries.com/v3.1/name/{name}`

The `CountryRepository` handles these requests with `dio`, mapping responses to the `Country` model.



## Testing

The project includes comprehensive unit and widget tests:

### Test Structure
<details>
     <summary> The tests are organized by layer and feature: </summary>

```
├── test
│   ├── data
│   │   ├── models
│   │   │   └── country_test.dart
│   │   └── repository
│   │       └── country_repository_test.dart
│   ├── logic
│   │   └── blocs
│   │       ├── country_detail
│   │       │   ├── country_detail_bloc_test.dart
│   │       │   ├── country_detail_event_test.dart
│   │       │   └── country_detail_state_test.dart
│   │       └── country_list
│   │           ├── country_list_bloc_test.dart
│   │           ├── country_list_event_test.dart
│   │           └── country_list_state_test.dart
│   └── presentation
│       ├── screens
│       │   ├── detail_screen_test.dart
│       │   └── home_screens_test.dart 
│       └── widgets
│           └── country_card_test.dart 
│           └── error_display_test.dart


```
</details>

### Running Tests
1. Run all tests:
   ```bash
   flutter test
   ```
2. Generate coverage report:
   ```bash
   # Generate `coverage/lcov.info` file
    flutter test --coverage
    # Generate HTML report
    # Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
    genhtml coverage/lcov.info -o coverage/html
    # Open the report
    open coverage/html/index.html
   ```
   
### Test Coverage
- **Data Layer**: Tests `CountryRepository` for successful fetches, missing data, and errors.
- **Logic Layer**: Tests `CountryListBloc` and `CountryDetailBloc` for all state transitions.
- **Presentation Layer**: Widget tests for `HomeScreen` and `DetailScreen`, covering UI states, navigation, and interactions.



## Usage

1. **Launch the App**: Start on the `HomeScreen`, which fetches and displays a list of African countries.
2. **View Details**: Tap a country to navigate to the `DetailScreen` for more information.
3. **Error Handling**: Observe error messages when network requests fail.
