# Unit Converter - Scientific

UnitConverter is a SwiftUI-based application that allows users to convert various units across different categories such as length, temperature, time, volume, and more. 
The app supports both SI and non-standard units and includes features like conversion history and localization for multiple languages.

## Features

**Multiple Unit Categories:** Choose from a wide range of unit categories including length, temperature, time, volume, engineering, electricity, and more.

**Comprehensive Units:** Supports SI units and custom units not covered by Apple’s Measurement Framework.

**Conversion History:** Tracks and saves previous conversions for easy access.

**Large & Small Number Handling:** Accurately handles conversions of both very large and very small numbers.

**Localization Support:** The app is available in both Turkish and English.

**Custom Unit Conversions:** Expands beyond Apple's default Measurement framework to include additional conversions.

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
