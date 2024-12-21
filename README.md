# Contextual Cards Flutter

This Flutter project is a plug-and-play container that renders a list of contextual cards dynamically fetched from an API. The container can be added to any screen/widget and functions independently, as per the requirements.

## Features

- Fetches contextual cards from an API and renders them in a list.
- Handles various types of cards, including dynamic images, gradients, buttons, and links.
- Supports deeplink handling for cards, buttons, and formatted text entities.
- Swipe-down-to-refresh functionality.
- Handles loading, error states, and customizable actions (e.g., "remind later", "dismiss now").
- Supports different design types for contextual cards based on the API response.
- Handles swipe actions and dynamic visibility of cards (on "remind later" or "dismiss now" actions).
- Reusable and flexible components, easy to integrate into any screen/widget.

## API Reference

- The API response will provide a list of **Card Groups** containing various **Cards**. The properties of each card (e.g., title, description, images, CTAs, etc.) will be dynamically rendered.


## Project Structure

```bash

├── lib/
│   ├── main.dart                         # App entry point: Contains the main method and widget initialization
│   ├── Hive_Boxes/                       # Local storage (Hive) related files
│   │   ├── HiveBoxes.dart                # Contains Hive database initialization and helper methods
│   ├── global/                           # Global configurations and constants
│   │   ├── constants.dart                # Defines app-wide constants like API URLs, keys, etc.
│   ├── models/                           # Data models to represent API response structures
│   │   ├── DeltedItems.dart              # Stores data for items marked as deleted (if applicable)
│   │   ├── api_response.dart            # Model to parse the API response and handle data
│   │   ├── call_to_action.dart          # Represents the call-to-action button details
│   │   ├── card.dart                    # Model for each individual card (title, description, etc.)
│   │   ├── card_group.dart              # Represents a group of cards (card groups)
│   │   ├── card_image.dart              # Represents the image data Of Card (image URL, asset info)
│   │   ├── entity.dart                  # Represents entities in formatted text (like hyperlinks, bold text)
│   │   ├── formatted_text.dart          # Represents formatted text with placeholder entities
│   │   ├── gradient_data.dart           # Represents gradient data (colors, angles, etc.)
│   ├── providers/                       # State management providers
│   │   ├── Contextual_Cards_Data_Provider.dart  # Provider for managing contextual cards data
│   │   ├── Contextual_Cards_Data_Provider.g.dart # Generated file for provider (automatically created)
│   ├── screens/                         # UI screens and views
│   │   ├── HomeScreen.dart              # Home screen where contextual cards are displayed
│   ├── widgets/                         # Reusable widgets for UI components
│   │   ├── custom_text_icon_button.dart  # Custom button widget with text and an icon
│   │   ├── hc1.dart                     # Widget for rendering HC1 (Small Display Card) design
│   │   ├── hc3.dart                     # Widget for rendering HC3 (Big Display Card) design
│   │   ├── hc5.dart                     # Widget for rendering HC5 (Image Card) design
│   │   ├── hc6.dart                     # Widget for rendering HC6 (Small Card with Arrow) design
│   │   ├── hc9.dart                     # Widget for rendering HC9 (Dynamic Width Card) design

```


## Installation
### 1. Clone the Repository


```bash
git clone https://github.com/yourusername/contextual-cards-flutter.git
cd contextual-cards-flutter
```

### 2. Install Dependencies
Run the following command to install all the required dependencies:

```bash
flutter pub get
```

### 3. Run the Application
To run the app on an emulator or physical device, use the following command:
```bash
flutter run
```
## Screenshots
![App Screenshot](assets/screenshots/image_1.png)
![App Screenshot](assets/screenshots/image_2.png)
![App Screenshot](assets/screenshots/hc3_slide.png)
![App Screenshot](assets/screenshots/hc3_removed.png)




