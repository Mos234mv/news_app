# 📰 News App - Project Overview

A modern Flutter mobile application for browsing top headlines, discovering trending stories, filtering news by category, searching articles, managing user profiles, and bookmarking favorite articles.

---

## 🏗️ Architecture & Structure

The project follows a **Feature-First / Layered Architecture** ensuring separation of concerns, maintainability, and scalability:

- **`lib/core/`**: Reusable infrastructure, services, themes, constants, and shared widgets.
- **`lib/features/`**: Independent feature modules containing their own screens, controllers, models, and components.

### Directory Tree

```text
lib/
├── core/
│   ├── constant/
│   │   ├── app_sizes.dart               # Responsive sizing definitions (ScreenUtil)
│   │   └── constants.dart               # Global keys (Hive boxes, prefs keys)
│   ├── data_source/
│   │   ├── local_data/
│   │   │   ├── prefrence_manager.dart   # SharedPreferences wrapper (singleton)
│   │   │   └── user_repository.dart     # Hive local database for UserModel
│   │   └── remote_data/
│   │       ├── api.config.dart          # NewsAPI base URL, endpoints & API key
│   │       └── api_service.dart         # HTTP network client (BaseApiService)
│   ├── enums/
│   │   └── request_stytas_enum.dart     # RequestStatus enum (initial, loading, success, error)
│   ├── extentions/
│   │   └── date_time_extention.dart     # Date formatting helpers
│   ├── mixin/
│   │   └── safe_notifier_mixin.dart     # SafeNotify mixin to avoid notifying disposed listeners
│   ├── models/
│   │   ├── user_model.dart              # Hive-annotated UserModel
│   │   └── user_model.g.dart            # Generated Hive TypeAdapter
│   ├── repos/
│   │   └── news_repos.dart              # News repository (top headlines & everything)
│   ├── Theme/
│   │   ├── light_color.dart             # Color palette
│   │   └── light_theme.dart             # App theme data
│   └── widgets/
│       ├── custom_cached_network_image.dart
│       └── custom_svg.dart
├── features/
│   ├── auth/                            # Authentication (Login & Register)
│   ├── bookmark/                        # Saved & bookmarked news
│   ├── deatails/                        # Article details view
│   ├── Home/                            # Dashboard (Top headlines, categories, trending)
│   │   ├── components/
│   │   └── models/                      # HomeProvider, NewsArticleModel
│   ├── Navigation/                      # Main screen with BottomNavigationBar
│   ├── onbaording/                      # Intro onboarding slides
│   ├── profile/                         # User profile, country picker & edit profile sheet
│   │   ├── bottom sheet/
│   │   ├── profile_controller.dart
│   │   └── profile_screen.dart
│   ├── search/                          # Article search with query controller
│   └── splash/                          # Animated splash & initial navigation routing
├── hive_registrar.g.dart                # Generated Hive registrar
└── main.dart                            # Application entry point & service initialization
```

---

## ⚙️ Application Initialization (`main.dart`)

The app startup sequence initializes all essential services before rendering the UI:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();  // Screen adaptation init
  await PrefrenceManager().init();       // SharedPreferences instance init
  await UserRepository().init();         // Hive database & adapter init

  runApp(const MyApp());
}
```

- **`ScreenUtilInit`**: Configured with design canvas size `375 x 832` for responsive layouts across all device form factors.
- **Theme**: Light theme configured with custom typography, input borders, and primary colors.

---

## 🚀 Key Features & Modules

### 1. Splash & Routing (`features/splash`)
- Displays launch branding.
- Determines the next destination:
  - If `onboarding_compelete` is `false` → Navigate to `OnboardingScreen`.
  - If `is_loged_in` is `false` → Navigate to `LoginScreen`.
  - If logged in → Navigate directly to `MainScreen`.

### 2. Onboarding (`features/onbaording`)
- Multi-page carousel highlighting app features.
- Powered by `smooth_page_indicator` and PageView.
- Marks `onboarding_compelete = true` upon completion.

### 3. Authentication (`features/auth`)
- **Register**: Creates a new `UserModel` and persists it securely in Hive via `UserRepository().signUp(...)`.
- **Login**: Validates credentials against stored `UserModel` via `UserRepository().login(...)`.
- Maintains active login session flag via `PrefrenceManager`.

### 4. Home & Feed (`features/Home`)
- **Top Headlines Carousel**: Displays breaking news with custom image caching.
- **Category Filter**: Filter articles by categories (Business, Entertainment, General, Health, Science, Sports, Technology).
- **Trending News**: Vertical list of current popular articles with date and author details.
- **Shimmer Placeholders**: Smooth loading skeletons while data is being fetched.

### 5. News Search (`features/search`)
- Real-time or on-demand search across news articles via NewsAPI's `everything` endpoint.

### 6. Article Details (`features/deatails`)
- Comprehensive article view with hero banner, source name, author, published date, and full article text.

### 7. Profile & Settings (`features/profile`)
- **User Information**: Fetched directly from `UserRepository().getUser()` (`UserModel`).
- **Profile Image**: Supports selecting images from Camera or Gallery (`image_picker`).
- **Edit Details**: Bottom sheet to update username, email, and password.
- **Country Selection**: Integrated `country_picker` allowing users to set regional preferences, persisted in `UserModel` and `PrefrenceManager`.
- **Logout**: Clears session preferences and routes back to `LoginScreen`.

### 8. Bookmarks (`features/bookmark`)
- Dedicated space to view and manage saved articles for offline or later reading.

---

## 💾 Data Layer & State Management

| Component | Technology | Purpose |
| :--- | :--- | :--- |
| **State Management** | `Provider` (`ChangeNotifier` + `SafeNotify`) | Reactive state handling without memory leaks on unmounted widgets |
| **Local Database** | `Hive CE` (`hive_ce_flutter`) | Fast, type-safe NoSQL database storing `UserModel` |
| **Key-Value Cache** | `shared_preferences` | Lightweight storage for flags (`is_loged_in`, `onboarding_compelete`) |
| **Networking** | `http` (`BaseApiService`) | REST API client communicating with NewsAPI |
| **Image Caching** | `cached_network_image` | Efficient remote image loading and memory/disk caching |
| **Screen Scaling** | `flutter_screenutil` | Density-independent UI scaling for width, height, and font sizes |

---

## 🛠️ Getting Started & Development

### Prerequisites
- Flutter SDK `^3.13.2` or newer
- Dart SDK `^3.13.2`

### Setup Instructions

1. **Clone and install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate Hive type adapters (if modifying models)**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```
