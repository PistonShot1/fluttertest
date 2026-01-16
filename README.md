# Flutter Test - E-Commerce App

A modern Flutter e-commerce application featuring product search, shopping cart, and product details. Built with clean architecture principles and state-of-the-art Flutter packages.

## Note For Reviewer :

(refer this section for the change logs by the required instruction and task)
(the instruction are referred from here : [MYEG_Flutter Developer.txt](./MYEG_Flutter%20Developer.txt))

- To test for review refer to branch tags (v1.0.0 + 1, v1.0.1,....)
- The requested pull request to be created already merged , you may refer to the closed PRs in this repository.
- v1.0.0 : Covers instructions from 1-7
- v1.0.1 : Covers additional instruction 1 & 2
- v1.0.2 : (in development)

## Pending Features and Chores (in progress)

- [ ] Product Search & Category Filtering
- [ ] Unit Tests and Integration Tests (only partial completed)

## Features

- 🛍️ **View and Browse Products** - View and browse products (partially developed)
- 🛒 **Shopping Cart** - Add products to cart with persistent local storage
- 📱 **Product Details** - View detailed information about products
- 🎨 **Dark/Light Theme** - Beautiful UI with theme support
- 💾 **Local Storage** - SQLite database for offline data persistence
- 🌐 **API Integration** - Fetch products from external API
- 🔄 **State Management** - Riverpod for reactive state management
- 🧭 **Navigation** - GoRouter for declarative routing

## Tech Stack

### Core Dependencies

- **Flutter SDK**: ^3.9.2
- **State Management**: `flutter_riverpod` (^3.0.3) with `riverpod_annotation` (^4.0.0)
- **Navigation**: `go_router` (^16.0.0)
- **Dependency Injection**: `get_it` (^9.2.0)
- **Local Storage**: `sqflite` (^2.4.2)
- **HTTP Client**: `http` (^1.5.0)
- **Image Loading**: `cached_network_image` (^3.4.1)
- **Environment Variables**: `flutter_dotenv` (^6.0.0)

### Additional Packages

- `freezed` & `json_annotation` - Code generation for models
- `equatable` - Value equality
- `shared_preferences` - Key-value storage
- `connectivity_plus` - Network connectivity checking
- `url_launcher` - Launch URLs
- `share_plus` - Share functionality
- `file_picker` & `image_picker` - File and image selection
- `iconsax_flutter` & `font_awesome_flutter` - Icon libraries
- `flutter_svg` - SVG support

## Project Structure

```
lib/
├── core/
│   ├── router/              # Navigation configuration
│   ├── shared/              # Shared components, themes, constants
│   └── utils/               # Utilities (network, storage, DI)
├── modules/
│   ├── cart/                # Shopping cart feature
│   ├── home/                # Home screen
│   ├── profile/             # Profile screen
│   ├── search/              # Product search & listing
│   └── splash/             # Splash screen
└── main.dart                # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd fluttertest
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up environment variables**

   - Create a `.env` file in the `assets/` directory
   - Add your API base URL and other configuration:
     ```
     API_BASE_URL=https://your-api-url.com
     ```

4. **Generate code (if needed)**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## Build Instructions

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Architecture

### State Management

The app uses **Riverpod** for state management with code generation:

- `@riverpod` annotations for providers
- Automatic code generation with `build_runner`
- Type-safe state management

### Dependency Injection

**GetIt** is used for dependency injection:

- Services registered in `injection_container.dart`
- Singleton pattern for shared services
- Async initialization support

### Data Layer

- **API Services**: HTTP requests via `HttpHandler`
- **Local Storage**: SQLite database for offline support
- **Models**: Freezed classes with JSON serialization

### Navigation

- **GoRouter** for declarative routing
- Route constants defined in `RouteConstant`
- Deep linking support

## Key Features Implementation

### Product Search

- Real-time search with debouncing
- Category filtering
- Product listing with images
- Pagination support

### Shopping Cart

- Add/remove products
- Persistent cart storage
- Cart item count badge
- Cart screen with product management

### Product Details

- Detailed product information
- Image gallery
- Add to cart functionality
- Navigation from search results

## Development

### Code Generation

When modifying models or Riverpod providers, or to just run code gen:

```bash
dart run build_runner watch -d
```

### Testing

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

## Configuration

### Environment Variables

Create `assets/.env` with:

```
API_BASE_URL=your_api_url_here
```

### Fonts

The app uses **Montserrat** font family with multiple weights and styles.

### Icons & Splash

- Configure launcher icons: `flutter_launcher_icons.yaml`
- Configure splash screen: `flutter_native_splash.yaml`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## License

This project is private and not intended for publication.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
