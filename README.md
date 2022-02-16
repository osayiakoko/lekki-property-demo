# lekki property task

A Flutter based lekki property CRUD task.

###  TABLE OF CONTENT
- Current version
- Executable APK links
- Getting started
- Description
- Plugins & their use case
- Software design pattern
- Project folder structure

## Current version
v 1.0.0

## Executable APK links
- [For armeabi-v7a:](https://drive.google.com/file/d/1Ew3XRBeB402MTq9WuIrCWMrkmW6lQLIb/view?usp=sharing)
- [for arm64-v8a:](https://drive.google.com/file/d/1IF7pP6eINSaJbZEm1zoO1YiOf_hVS8b9/view?usp=sharing)

## Getting Started

This project is created using the Googles's Flutter software development kit.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Description
This is a simple flutter project that caries out the following operations


- Reads & display a list of properties json objects from an api resource
- Filter properties based on query parameters
- Update a property based on id
- Creates a new property
- Shows a detailed infor about a property

## Plugins and their use case

This project depends on the following important flutter plugins.
- **Flutter riverpod:** for state managment.
- **Flutter DIO:** for http client for making request.
- **pretty_dio_logger:** for logging dio requests and responses.
- **logger:**: plugins for project wide logging.
- **Cached network image:** a flutter plugin to show images from the internet and keep them in the cache directory.
- **Image picker:** plugin for selecting images from the Android and iOS image library.
- **Get it:** a simple Service Locator for Dart and Flutter projects with some additional goodies.
- **intl:** for dealing with internationalized/localized messages, date and number formatting and parsing.
- **Flutter screenutil:** a plugin for adapting screen and font size.
- **Flutter exif rotation:** a plugin that fixes the picture orientation for some devices.
- **Top snackbar flutter:** a plugin for displaying success or error messages.

## Software design pattern

This project uses a Model-View-ViewModel (MVVM) a software design pattern.

MVVM is structured to separate program logic and user interface controls, MVVM helps organize code and break programs into modules to make development, updating and reuse of code simpler and faster. 

The separation of the code in MVVM is divided into View, ViewModel and Model:


## Project folder structure

This project contains the following folders.

- **assets:**.
    - contains assets such as fonts, images, icons etc.
- **lib/models:**
    - This folders contains defined objects for data elements
- **lib/repositories:** 
    - This folder contains classes reponsible for fetching data from services such as api & third party platform.
- **services:** 
    - Contains classes for creating services for api, notification, secure folder etc.
- **lib/utils:** 
    - Contains different classes and functions utilities, such as:
        - constant values used across the program
        - singleton setup (get_it)
        - helper functions
        - color schemes
        - route definitions
- **lib/view_models:** 
    - Contains classes for managing the application business logic
- **lib/views:** 
    - Contains user interfaces implementations for each single screen/page
- **lib/widgets:** 
    - Contains commonly used widget accross the software 
- **lib/main.dart:** 
    - This is the entry point of execution for the project
