# Managing Secrets Locally

This document explains how to configure API credentials for MyFirstApp
without committing sensitive configuration files to the repository.

## Overview

MyFirstApp uses a JSON configuration file to store API settings required
by the application.

The repository provides an example configuration file containing
placeholder values. Each developer must create their own local
configuration file before running the application.

## Configuration Files

### APIConfig.example.json

Location:

`MyFirstApp/Config/APIConfig.example.json`

This file is a template containing the configuration structure expected
by the application.

It includes:

- `tmdbBaseURL` — the base URL of The Movie Database (TMDB) API.
- `tmdbAPIKey` — the API key used to authenticate TMDB requests.
- `youtubeBaseURL` — the base URL used for YouTube API requests.

This example file is tracked by Git and must not contain real credentials.

### APIConfig.json

Location:

`MyFirstApp/Config/APIConfig.json`

This is the local configuration file created from the example template.

It contains the actual API credentials required by the application.

This file must remain local and must not be committed to the repository.

The application loads the configuration through `APIConfig.swift`
and uses it in `DataFetcher.swift`.

## Setup

### Step 1: Create the local configuration file

From the repository root, run:

```bash
cp MyFirstApp/Config/APIConfig.example.json \
   MyFirstApp/Config/APIConfig.json
```

### Step 2: Configure the TMDB API key

Open `MyFirstApp/Config/APIConfig.json`.

Replace the placeholder value of `tmdbAPIKey` with your own TMDB API key.

Keep the existing JSON structure and property names unchanged.

### Step 3: Verify the configuration

Open the project in Xcode and build the application.

Make sure that:

- `APIConfig.json` exists in the expected location.
- The JSON file contains valid syntax.
- The TMDB API key is configured correctly.
- `APIConfig.json` is included in the application bundle.
- The application can successfully make API requests.

The application expects to find `APIConfig.json` in its main bundle.

If the configuration file cannot be loaded, check the resource configuration
and the error handling in `APIConfig.swift`.

## Git and Security

The following file must remain local:

- `MyFirstApp/Config/APIConfig.json`

The following file must be tracked by Git:

- `MyFirstApp/Config/APIConfig.example.json`

The local configuration file must be excluded through `.gitignore`.

Verify that the ignore rule covers `APIConfig.json` inside the
`MyFirstApp` directory.

Adding a file to `.gitignore` does not automatically remove it
from Git if it was already tracked.

## Security Notes

- Never commit actual API keys, access tokens, or passwords.
- Never put real credentials in example configuration files.
- Do not hardcode API keys in Swift source files or comments.
- If a credential is exposed publicly, revoke or rotate it when appropriate.
- Removing a credential from the current version of a file does not
  remove it from previous Git commits.

API keys included in an iOS application can potentially be extracted
from the built application. Client-side configuration is not a secure
place for credentials that must remain confidential.

For sensitive credentials, consider using a backend service to handle
authenticated requests.
