# Weather


[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger) ![badge-platforms][]

Weather app based on openweathermap.org.

The main purpose of this project is to practice clean architecture approaches and testing. It is still in its really EARLY stages of development.

  - Clean Architecture
  - Composition Root + Dependecny Containter
  - MVVM Presentation layer
  - Feature based modules
  - Loosely coupled code
  - Abstracte Implementation
  - Unit Testing

# New Features!

  - Search for weather forecast by citiy name
  - View 5 days forecast for user's location

### Screenshots
![Alt text](/../master/App/Resources/demo.jpg?raw=true "Demo")


### Dependencies

Weather uses a number of open source projects to work properly:

* [Moya] - Network abstraction layer written in Swift!
* [PromiseKit] - Promises simplify asynchronous programming.
* [SnapKit] - A Swift Autolayout DSL for iOS & OS X.

And of course Weather itself is open source with a [public repository][dill]
 on GitHub.

### Requirements
* iOS 12.0+ 
* Xcode 10+
* Swift 5.0+
* Cocoapods installed
### Installation

Clone the codebase to your machine.

Open a terminal window, and run below command into project directory:
```sh
$ cd Weather
```

Then install the dependencies:
```sh
$ pod install
```

Make sure to open the Xcode workspace instead of the project:

```sh
$ open App.xcworkspace
```

### Unit Testing

To run Test Cases:
Select scheme `WeatherSearch_Example`
Then 
Run the test - ⌘ U

### Run the sample app

Select scheme `App`

Then build and run




### Todos

 - Write MORE Tests
 - Refeactor Network api call implementation to avoid boilerplate code
 - Bind UITableViewCell with CellViewModel
 - Add String Resources file
 - Add Scene Coordinator

License
----

MIT


**Free Software, Yallah!**
   [badge-languages]: https://img.shields.io/badge/languages-Swift-orange.svg
   [Moya]: <https://github.com/Moya/Moya>
   [PromiseKit]: <https://github.com/mxcl/PromiseKit>
   [SnapKit]: <https://github.com/SnapKit/SnapKit>
