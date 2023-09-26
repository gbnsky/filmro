
# Welcome to *Unroll*!

![Unroll logo](/Unroll/Assets.xcassets/Readme/unroll-readme.imageset/unroll.png)

An application to **find a movie** that you don't know in a place you know. 

## Description

The **Unroll** project is being developed to be a time saver when you want to find a movie to watch. The application consists of three straightforward screens: a welcome screen, a filter screen to choose which features the movie has, and a result screen with a list of movies. It is developed using **one API** but with two data sources: [The Movie Database (TMDb)](https://www.themoviedb.org) and [JustWatch](https://www.justwatch.com).

## Getting Started

- 1. Go to [TMDb](https://www.themoviedb.org), create an account, and generate an API key;
- 2. Clone the repository files to a folder on your Mac;
- 3. Open the project files in Xcode;
- 4. Create a `Keys.plist` in the Unroll folder and add a `Key` named `Movie Api Key` with `String` type and use the generated key as the `Value`;
- 5. Run the app.

> Be free to make any changes and experiments on the application, every suggestion of improvement is welcome. But remember: take a good look before modifying anything, and always open a pull request. That's it.

## Architecture

The initially chosen structural design pattern was the `Model-View-Controller (MVC)` due to its objectivity when starting a new mobile application project but complemented by `Delegates` and `Protocols`.

> To **create a new screen** you can make a view controller, instantiate it, and call `pushViewController` in the method you designed.

## Structure

|Folders         |Function                          |
|----------------|-------------------------------|
|Resources|Files containing non-code features such as fonts and other types of assets|
|Shared          |Classes and structures that can be accessed globally, which contain constants, localizable strings, extensions, and other helper classes.|
|APIs          |Contain classes responsible for HTTP requests in the application.|
|Modules          |Despite the application's absence of the concept of modularity, this folder contains files for each future module, including views and models.|
|UnrollTests          |Project's unit tests folder.|

## Design

Each UI component and screen was designed on [Figma](https://www.figma.com), and you can access the board [here](https://www.figma.com/file/Jj3v4I5qMKSrP6iBpKaKod/unroll?type=design&node-id=0%3A1&mode=design&t=2Yo5Aia7QlRkLnd2-1).

![Unroll mascot called Rolly](/Unroll/Assets.xcassets/Readme/rolly-readme.imageset/rolly.png)
