# Movie Database

Test Application developed using [TMDb API](https://developers.themoviedb.org)

<img src="screenshots/screen1.png?raw=true" width="250"> <img src="screenshots/screen2.png?raw=true" width="250">

## Requirements

 - Xcode 9
 - Swift 4
 - Cocoapods 1.3.1

## Before Build

Before build the project please run a `pod install` 

## Architecture

I used a layered architecure based on [Domain Driven Design](https://en.wikipedia.org/wiki/Domain-driven_design).

 - *View*: The view layer is an object in the application which is showed to the users. A view object know how and where to display its contents on the screen. It will be responsible for all the UI, user gestures recognizers, animations and custom components. They are also the view objects of our controllers.
 - *Controller*: A controller object acts as an intermediary between one or more of the view objects in an application and its managers. Controller objects are a channel through which objects view are notified of changes to the model and vice-versa. The controller layer will also be responsible for the implementation of flow control (UIStoryboradSegue), responsible for validations and events listening (IBActions). It will implement protocols for UI components such as UITableViewDataSource and UITableViewDelegate.
 - *Model*: A system of abstractions that describes selected aspects of the domain and can be used to solve problems related to the domain.
 - *Infrastructure*: Provides a layer of abstraction for code that is not part of the problems solved by the domain, ex: Api requests

## Dependencies

 - *AlamofireImage*: Used to request and cache poster images.
 - *Alamofire*: Since I've used AlamofireImage, I used Alamofire to make my backend requests simpler
 - *SwiftLint*: Linter used to maintain coding style and patterns
