# Unit Converter - Scientific

UnitConverter is a SwiftUI-based application that allows users to convert various units across different categories such as length, temperature, time, volume, and more. 
The app supports both SI and non-standard units and includes features like conversion history and localization for multiple languages.

<img src="https://github.com/user-attachments/assets/72d83787-bf98-4460-ba65-90f4238480fb" width="300" height="300" />
<img src="https://github.com/user-attachments/assets/57c175e5-ea36-4b94-a694-002e1b75e5e2" width="300" height="300" />

## Features

**Multiple Unit Categories:** Choose from a wide range of unit categories including length, temperature, time, volume, engineering, electricity, and more.

**Comprehensive Units:** Supports SI units and custom units not covered by Apple’s Measurement Framework.

**Conversion History:** Tracks and saves previous conversions for easy access.

**Large & Small Number Handling:** Accurately handles conversions of both very large and very small numbers.

**Localization Support:** The app is available in both Turkish and English.

**Custom Unit Conversions:** Expands beyond Apple's default Measurement framework to include additional conversions.

<img src="https://github.com/user-attachments/assets/0de0c1ea-1ca6-4bec-87d3-17bb223623bf" width="150" />
<img src="https://github.com/user-attachments/assets/d94fe848-18fa-460f-b777-74670b117f0a" width="150" />
<img src="https://github.com/user-attachments/assets/b38c6894-dc05-4728-ad79-0f859a55aa3f" width="150" />
<img src="https://github.com/user-attachments/assets/e40d6bbe-c3db-4e5c-a576-b234954ef271" width="150" />
<img src="https://github.com/user-attachments/assets/4ff9e899-96c7-454d-8856-9cdfd5ff7850" width="150" />
<img src="https://github.com/user-attachments/assets/09f1f5ae-468f-43ae-88c0-a54cc2771e65" width="150" />


## Technical Overview

The project follows the MVVM (Model-View-ViewModel) architecture to ensure a clean and scalable codebase:

**Model:** Represents the core data structures such as unit categories and conversion logic.

**View:** Handles the UI using SwiftUI, dynamically updating based on user input and selection.

**ViewModel:** Serves as the mediator between the Model and the View, managing the state, handling business logic, and updating the View accordingly.

## Key Technologies:

**SwiftUI:** For building declarative and responsive user interfaces.

**Measurement Framework:** Used for unit conversions where supported.

**Custom Unit Models:** Extends conversions beyond the limitations of the Measurement framework.

**SwiftData:** Utilized for saving and retrieving user favorites.

**NumberFormatter:** To format numbers in a locale-aware manner, ensuring proper decimal and group separators.

## Usage

**Home Screen:** Select a unit category (e.g., Length, Temperature, etc.) to start a conversion.

**Unit Conversion:** Choose base and target units, enter a value, and the result will be displayed instantly.

**Favorites:** View favorite conversions from the favorites tab.

**Localization:** The app automatically adapts to the device's language (Turkish and English supported).
