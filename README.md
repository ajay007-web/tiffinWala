# 🍱 TiffinWala — Premium Homemade Food Subscription Mobile App

<p align="center">
  <img src="assets/svg/tiffin_box.svg" width="90" height="90" alt="TiffinWala Logo" />
</p>

<p align="center">
  <b>Wholesome, healthy homemade meals delivered to your doorstep daily.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.22.0-02569B?logo=flutter" alt="Flutter Version" />
  <img src="https://img.shields.io/badge/Dart-3.4.0-0175C2?logo=dart" alt="Dart Version" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20%2B%20BLoC-87BAAB" alt="Architecture" />
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-green" alt="Platforms" />
  <img src="https://img.shields.io/badge/Design%20System-Sage%20Mint%20(%2387BAAB)-6A9E8F" alt="Theme" />
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License" />
</p>

---

## 🌟 Overview

**TiffinWala** is an ultra-premium, production-grade Flutter mobile application crafted for daily and weekly tiffin subscriptions. Unlike generic food delivery apps, TiffinWala brings back the warmth and health of home-cooked Indian meals through a modern digital subscription experience.

Designed with meticulous attention to detail, the app features:
* Buttery smooth micro-interactions & fluid 60 FPS animations.
* Custom floating frosted-glass bottom navigation bar with backdrop blur.
* Interactive 7-day weekly menu viewer with HD realistic food imagery and nutritional transparency.
* Dynamic subscription plans engine (10, 20, and 30-day options).
* Real-time meal consumption progress tracking with interactive monthly delivery calendars.

---

## ✨ Key Features

### 🔐 1. Frictionless Phone Authentication
* **Phone Login:** Country-code selector (`+91`), auto-formatting, and validation.
* **Smart OTP Screen:** 6-box segmented OTP input with auto-advance, keyboard backspace listeners, 30s resend timer, and animated verification checkmark.

### 🏠 2. Dynamic Home Screen
* **Time-Aware Greeting:** Personalized greeting based on the hour of the day (*"Good Morning / Afternoon / Evening, Ajay 👋"*).
* **Active Plan Status Card:** Live progress bar showing remaining meals, consumed meals, and renewal shortcuts.
* **Today's Hero Meal Card:** High-resolution meal thali photography, 100% vegetarian badge, caloric count, and delivery window.
* **Weekly Menu Day Bar:** Horizontal animated pill selector (MON–SUN) with seamless card transitions.
* **Promotional Card:** Custom value-proposition banner with direct plan onboarding.

### 📋 3. Curated Weekly Menu & Meal Details
* **Day-by-Day Thalis:** Realistic Indian vegetarian thalis (Dal Tadka, Rajma Chawal, Amritsari Chole, Kadhi Pakora, Paneer Butter Masala, Festive Sunday Thali).
* **Shared Element Hero Transitions:** Fluid image expansion from card thumbnail to full-screen hero.
* **Hygiene & Purity Badges:** 100% Pure Veg, Freshly Made Daily, and Homestyle Cooking badges.
* **Nutritional Breakdown:** Caloric metrics, protein, carbohydrates, and fats.
* **Ingredient Chips:** Detailed item checklist for every thali.

### 💳 4. Flexible Subscriptions & Checkout
* **Dynamic Pricing Engine:** Configurable base pricing (₹120/meal) dynamically calculating subtotal, discounts, packaging, and zero delivery fee.
  * **10 Meal Plan (₹1,200):** Starter Plan
  * **20 Meal Plan (₹2,400):** Most Popular
  * **30 Meal Plan (₹3,600):** Best Value
* **Address Management:** Integrated delivery address selector with modal bottom sheet editor.
* **Payment Flow:** Seamless UPI (GPay, PhonePe, Paytm), Cards, Net Banking, and Wallet support.
* **Celebration Success Screen:** Animated success badge, plan dates overview, and instant routing to active plan.

### 📅 5. My Plan & Meal Calendar
* **Circular Progress Ring:** Modern activity-style ring displaying consumed vs remaining meal counts.
* **Interactive Monthly Calendar:** Color-coded dates (Delivered ✓, Today ●, Upcoming ○).
* **Delivery Controls:** One-tap option to pause or skip upcoming delivery dates.

### 👤 6. User Profile & Account Settings
* Account info with avatar initials.
* Active subscription shortcuts.
* Modular grouped settings (Addresses, Orders, Notifications, 24x7 Support).
* Confirmation dialog for sign-out.

---

## 🎨 Design System & Palette

The user interface follows a calming, appetizing aesthetic inspired by world-class wellness and lifestyle products:

| Token | Hex Code | Visual Description |
|---|---|---|
| **Primary** | `#87BAAB` | Sage Mint (Soul of the brand) |
| **Primary Dark** | `#6A9E8F` | Pressed states, active borders |
| **Primary Light** | `#A8D5C6` | Highlights & soft tints |
| **Primary Ultra Light** | `#E8F5F0` | Card & surface backgrounds |
| **Success** | `#2ECC71` | Delivered meals, verified status |
| **Warning** | `#F39C12` | Calories, featured specials |
| **Charcoal 900** | `#1A1D1F` | Primary headings, display text |
| **Charcoal 600** | `#6F767E` | Secondary descriptions |
| **Surface Off-White** | `#FAFBFC` | Screen backgrounds |

* **Typography:** [Google Fonts Lato](https://fonts.google.com/specimen/Lato) with a 15-level type scale.
* **Spacing:** Strict 8px baseline grid (`AppSpacing`).
* **Icons:** [Phosphor Icons](https://phosphoricons.com/) paired with custom vector brand SVGs.

---

## 🏗️ Architecture & Folder Structure

Built using **Clean Architecture** and **BLoC (Business Logic Component)** pattern to ensure testability, scalability, and strict separation of UI from business logic:

```text
lib/
├── core/
│   ├── constants/            # AssetPaths, app constants
│   ├── theme/                # Colors, Typography, Spacing, Shadows, Gradients, AppTheme
│   ├── utils/                # DateUtils, PriceUtils, Validators
│   └── widgets/              # Reusable UI components (FloatingBottomNav, VegBadge, Buttons, etc.)
│
├── data/
│   ├── mock/                 # Mock weekly meals, plans, and user data
│   └── models/               # MealModel, PlanModel, SubscriptionModel, AddressModel, UserModel
│
├── features/
│   ├── auth/                 # AuthCubit, LoginScreen, OtpScreen
│   ├── checkout/             # Checkout review screen & AddressBottomSheet
│   ├── home/                 # HomeCubit, HomeScreen, GreetingHeader, HeroCards
│   ├── meal_detail/          # MealDetailScreen with Hero transitions & nutrition breakdown
│   ├── menu/                 # Weekly MenuScreen with daily expandable cards
│   ├── navigation/           # MainNavigationScreen with FloatingBottomNavBar
│   ├── payment/              # PaymentScreen & PaymentSuccessScreen
│   ├── plans/                # PlansCubit, PlansScreen with animated selection cards
│   ├── profile/              # ProfileScreen with account groups & dialogs
│   ├── splash/               # Animated SplashScreen with floating brand motifs
│   └── subscription/         # SubscriptionCubit, MyPlanScreen & MealCalendar
│
└── main.dart                 # Application entry point, MultiBlocProvider setup
```

---

## 📦 Tech Stack & Packages

| Package | Purpose |
|---|---|
| `flutter_bloc` & `bloc` | Predictable state management across authentication, plans, home & subscription |
| `phosphor_flutter` | Consistent, balanced icon set |
| `google_fonts` | Lato font typography family |
| `flutter_svg` | Custom vector rendering for tiffin icons, delivery scooters & UPI |
| `cached_network_image` | Image caching and smooth memory management |
| `shimmer` | Skeleton shimmer loading states |
| `intl` | Indian currency (`₹`) and date formatting |
| `equatable` | Value equality for BLoC states |

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (3.22.0 or higher)
* Dart SDK (3.4.0 or higher)
* Xcode (for iOS) or Android Studio (for Android)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ajay007-web/tiffinWala.git
   cd tiffinWala
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify code quality:**
   ```bash
   flutter analyze
   flutter test
   ```

4. **Run the application:**
   ```bash
   # Run on connected device or simulator
   flutter run
   ```

---

## 🧪 Testing

Run unit and widget tests:
```bash
flutter test
```

Run static analysis check:
```bash
flutter analyze
```

---

## 👨‍💻 Author

**Ajay Dhiman**
* GitHub: [@ajay007-web](https://github.com/ajay007-web)
* Email: [ajaydhimaan7@gmail.com](mailto:ajaydhimaan7@gmail.com)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
