# Tractian

## Project description

This app build an Tree View that shows companies Assets.

**Features:**

* Show Assets and Locations in a tree view
* Search Assets and Locations by name
* Filter Assets by status and sensor type

## Installation instructions

* Make sure you have Flutter 3.19.0 or higher installed.
* Make sure you have Dart 3.3.0 or higher installed.

## Run instructions

* To run the app on an emulator, use the command `flutter run`.
* To run the app on a physical device, connect the device to your computer and use the command `flutter run`.

## Approaches, technologies, and packages used
* To get the data from json, the [path_provider](https://pub.dev/packages/path_provider) library was used.
* To create the tree view, the [flutter_fancy_tree_view](https://pub.dev/packages/flutter_fancy_tree_view) library was used.
* To make it simple to connect the reactive data of your application with the UI, the [mobx](https://pub.dev/packages/mobx) library was used.
* To make dependency injection, and route management the [get](https://pub.dev/packages/get) library was used.

## App flow
When entering the project, you will come across a menu to choose the company, this data is stored in a json file and is loaded when the app starts.
The companies are loaded dynamically from the json file and you can select any company from the list. After selecting the company, you will see a tree view of assets and locations, and you can search for assets and locations by name.
You can also filter assets by status and sensor type.

