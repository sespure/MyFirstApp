# MyFirstApp

`MyFirstApp` is a SwiftUI-based iOS app for browsing popular movies and TV shows, searching for content, viewing details, and saving favorites to bookmarks. The app works with the **TMDB API** and stores saved items locally using **SwiftData**.

## What this project is about

The main idea of the app is to give users a simple and convenient way to:

- browse trending movies and TV shows;
- explore collections of top-rated titles;
- search for movies or TV shows by name;
- open detailed information for any selected title;
- save favorite items to bookmarks;
- open an external resource to watch or search for the title.

The project is designed to look clean, modern, and easy to understand from the first launch.

## Main features

### 1. Home screen
On the Home screen, the user sees:

- a large hero section with a featured title;
- a details button;
- horizontal lists of:
  - trending movies;
  - trending TV shows;
  - top-rated movies;
  - top-rated TV shows.

### 2. Search
The Search screen allows users to:

- switch between movie and TV show search;
- type a query into the search bar;
- view results as a poster grid;
- open the details page for each result.

### 3. Upcoming
An additional section for upcoming releases.

### 4. Bookmarks
Users can:

- save titles to bookmarks;
- view the list of saved items;
- remove items from the list.

### 5. Detail screen
The detail page shows:

- the poster;
- the title;
- the overview;
- a **Watch** button that opens an external search page;
- a bookmark button to save or remove the title.

## Technologies used

This project uses:

- **SwiftUI** — for building the interface;
- **SwiftData** — for local bookmark storage;
- **URLSession** — for networking;
- **TMDB API** — as the source of movies and TV shows;
- **AsyncImage** — for loading posters from the network;
- **NWPathMonitor** — for checking internet connectivity.

## How the app works

1. The app starts from `ContentView`.
2. The user navigates between these tabs:
   - Home
   - Upcoming
   - Bookmarks
   - Search
3. Screen data is loaded through `DataFetcher`.
4. API responses are decoded into the `Title` model.
5. Bookmarks are stored locally with SwiftData.
6. Poster images are loaded from TMDB using the full image URL.

## Project structure

```text
MyFirstApp/
├── App/
│   ├── ContentView.swift
│   └── MyFirstAppApp.swift
├── Assets.xcassets/
├── Config/
│   └── APIConfig.example.json
├── Core/
│   ├── Models/
│   │   └── Title.swift
│   ├── Networking/
│   │   ├── APIConfig.swift
│   │   └── DataFetcher.swift
│   └── Support/
│       ├── Constants.swift
│       └── Errors.swift
├── Docs/
│   └── README-SECRETS.md
├── Features/
│   ├── Bookmarks/
│   ├── Detail/
│   ├── Home/
│   ├── Search/
│   ├── Shared/
│   └── Upcoming/
└── APIConfig.json
```

## Setup before running

The project uses a local configuration file called `APIConfig.json`, which should not be committed to the repository.

### 1. Create the local config

Copy the template:

```bash
cp MyFirstApp/Config/APIConfig.example.json MyFirstApp/Config/APIConfig.json
```

### 2. Add your TMDB API key

Open `MyFirstApp/Config/APIConfig.json` and replace the value of `tmdbAPIKey` with your own key.

### 3. Make sure the file is included in the bundle

The app expects to find `APIConfig.json` through `Bundle.main`.
If the file is missing or the JSON is invalid, network requests will fail.

## Running in Xcode

1. Open `MyFirstApp.xcodeproj`.
2. Make sure `APIConfig.json` exists in the correct location.
3. Build and run the project on the simulator or a device.

## Secrets and security

The project includes a separate file that explains how secrets are handled:

- `Docs/README-SECRETS.md`

In short:

- do not commit real access keys;
- keep `APIConfig.json` local;
- use `APIConfig.example.json` as a template;
- do not store secrets directly in Swift source code.

## Who this project is for

This app is a good fit for:

- demonstrating SwiftUI and SwiftData skills;
- an educational API-based project;
- an iOS developer portfolio;
- a base for future feature expansion.

## Possible improvements

In the future, the project could be extended with:

- user login;
- a more detailed title screen;
- local filters and sorting;
- trailer support;
- better search and caching;
- improved dark/light theme design.

## In short

`MyFirstApp` is a clean iOS app for searching, browsing, and saving movies and TV shows. It combines a modern SwiftUI interface, API integration, and local data storage.
