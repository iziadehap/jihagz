
# Jihagz

Jihagz is a real-world sports logistics and booking platform built to centralize the exploration and reservation of sports fields. It digitizes the fragmented process of finding and booking sports venues (such as Football pitches, Padel courts, and Tennis courts) into a single, unified mobile interface.

The application replaces informal coordination methods (direct phone calls, scattered social media messages, and manual availability checks) with an automated, location-aware platform used by athletes and venue owners.

## Project Overview

This system is designed to streamline the athletic booking ecosystem by removing the friction of finding open field slots.  
The application manages the entire exploration and submission lifecycle:

- **Discover Venues:** Users browse nearby sports facilities filtered by athletic categories.
- **Real-Time Location Insights:** The application calculates distance metrics to prioritize closest available options.
- **Crowdsourced Database Expansion:** Users can submit unlisted venues to organically grow the platform's reach.
- **Detailed Analytics & Reviews:** Venues showcase real-time crowdsourced ratings, pricing structures, and geographic parameters.

The platform focuses on high operational visibility, crisp map-based delivery, and rapid booking alternatives when a primary venue is occupied.

## Problem Statement

Many athletes and sports enthusiasts rely on informal, decentralized methods to book courts:

- Direct phone calls to venue handlers
- Disorganized WhatsApp coordination
- Unpredictable manual scheduling checks

This fragmentation leads to several common challenges:

- Total lack of visibility into real-time slot availability
- High friction when a target field is fully booked, with no immediate alternative viewable
- Disorganized venue metadata (hidden pricing, missing contact info, vague locations)
- Travel inefficiencies due to lack of distance calculations

**Jihagz** eliminates these bottlenecks by centralizing stadium discovery, proximity calculations, and explicit venue asset tracking in one app.

## Key Features

### Sports Exploration Engine

- Categorized browsing for major sports categories (Football, Padel, Tennis, and Custom variations).
- Advanced venue profiling including high-quality photo galleries, verified contact numbers, and explicit pricing structures.

### Proximity & Mapping System

- Automatic client-side GPS location detection.
- Dynamic distance matrices evaluating physical distance to automatically bubble up the **top 3 closest venues**.
- Visual mapping integration with precise pinpoint coordinates for seamless navigation.

### User Lifecycle & Social Proof

- Secure single-sign-on (SSO) authentication.
- Comprehensive user onboarding forms capturing profiling attributes (Name, Phone, Age, and Gender).
- Deep breakdown of user ratings featuring distribution metrics to guarantee crowd-sourced validation.

### Decentralized Venue Ingestion

- Crowdsourced reporting tools allowing users to submit missing sports clubs (attaching names, imagery, and accurate map markers) for systematic admin approval.

### Performance & Caching

- Local persistence caching mechanisms ensuring instant sub-second page loads and offline data durability.

---

## System Architecture

The project is structured using an organized, predictable architectural flow designed to maintain clean separation of concerns and high scalability.

### Project Layout


lib/
├── core/                  # Shared configurations, app routing, common models, and utilities
├── features/              # Domain-isolated functional modules
│   ├── home/              # Field exploration dashboard and core listing feeds
│   ├── details/           # Venue metadata profiling, map rendering, and review pipelines
│   ├── login/             # Authentication gateways and SSO logic
│   ├── form/              # Profile configuration and user data ingestion
│   ├── add_missing_place/ # Crowd-sourced venue reporting tools
│   └── settings/          # Local preferences and client configurations
└── main.dart              # Application initialization vector


### Architecture Layers

- **Presentation Layer:** Flutter UI design layouts optimized with Material 3 patterns, utilizing **GetX** controllers for structural reactive state management and predictable navigation routing.
- **Domain Layer:** Decoupled business rules, validation models, and explicit core application logic parameters.
- **Data Layer:** High-performance data persistence routing connecting remote **Supabase PostgreSQL** schemas to local client engines via optimized **SharedPreferences** key-value caching.

---

## Engineering Highlights

- **Clean Layered Feature Layout:** Modular codebase built for feature isolation, minimizing code regression during platform scale.
- **Reactive State Tracking:** Ultra-lean reactive state management and route handling using GetX dependencies.
- **Secure Cloud Backend Integration:** Real-time data streams and cloud management utilizing Supabase infrastructure.
- **Geospatial Proximity Calculations:** Client-side GPS spatial lookups calculating nearby field clusters automatically.
- **Robust Relational Schemas:** Strict database integrity and relationship modeling with PostgreSQL architectures.

---

## Tech Stack

### Mobile Frontend

- **Framework:** Flutter (Material 3 UI Architecture)
- **State Management & Routing:** GetX

### Backend & Infrastructure

- **Cloud Platform:** Supabase
- **Database Engine:** PostgreSQL
- **Authentication:** Google Sign-In SDK / Supabase Auth

### Geospatial & Mapping

- `flutter_map`
- `location`

### Storage & Utilities

- `SharedPreferences` (Local metadata caching)

---

## Database Schema (Supabase)

The core relational layout relies on heavily optimized tables enforcing strict database constraints:

| Table Name              | Primary Purpose                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sports_clubs_verified` | Authoritative verified stadium listings containing name, sport type, geographical coordinates, pricing tiers, media links, and aggregate score ratings. |
| `profiles`              | Demographic user data mapped explicitly to unique authentication tokens.                                                                                |
| `stadium_ratings`       | Relational review transactions tracking explicit score weights left by authenticated platform users.                                                    |

---

## Screenshots

| Authentication UI                                         | Field Exploration                                          |
| --------------------------------------------------------- | ---------------------------------------------------------- |
| ![Login UI](jihagz/screenshots/Screenshot_1784500552.png) | ![Home Feed](jihagz/screenshots/Screenshot_1784500558.png) |

| Stadium Profiling                                             | Crowdsourced Submission                                           |
| ------------------------------------------------------------- | ----------------------------------------------------------------- |
| ![Details View](jihagz/screenshots/Screenshot_1784500563.png) | ![Add Missing Form](jihagz/screenshots/Screenshot_1784500572.png) |

---

## Getting Started & Execution

### Prerequisites

- Flutter SDK `^3.8.1`
- Active Supabase project instance
- Configured Google Developer Console OAuth credentials (for Android & iOS SHA signing)

### Installation & Run Steps

```bash
# Fetch and install all project dependencies
flutter pub get

# Launch the application on your active connected device or emulator
flutter run

# Compile a production-ready release APK
flutter build apk
```

**iOS Specific Setup**

```bash
cd ios
pod install
cd ..
flutter run
```

---

## Future Enhancements

- **Direct Slot Booking Pipeline:** Seamless integration of an interactive "Book Now" interface directly within the app details view.
- **Advanced Query Engine:** Multi-parameter search utilities filtering venues by granular regions or text queries.
- **Map-View Filter Matrix:** Interactive spatial search allowing users to find available spots directly by scanning across a map view.
- **Direct Communication Gateways:** Instant, context-aware click-to-call and WhatsApp API integrations for immediate field manager communications.

---

## Author

- **GitHub:** [iziadehap](https://github.com/iziadehap)
- **LinkedIn:** [linkedin.com/in/iziadehap](https://linkedin.com/in/iziadehap)

---

## License

This project is shared strictly for portfolio presentation and demonstration purposes.

`publish_to: "none"`

```

```
