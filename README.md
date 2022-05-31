# MessagesApp
To execute the project we just need to run it in Xcode 13 or more

### Description
A Messages iOS app designed to show information about the posts

## Architecture
The code is designed following the [SOLID](https://en.wikipedia.org/wiki/SOLID) principles, implementing:

### MVP architecture
#### Model: 
It contains basic model objects used by the Interactor.
#### View: 
The responsibility of the view is to display the information and handle the user interaction communicating any action to the presenter
#### Presenter: 
Its responsibility is to handle the user input received from the View, process the data using the model and then return the data to the view to be displayed
### Facade Pattern
The Facade design pattern provides a unified interface to a set of interfaces in a subsystem. The pattern defines a higher-level interface that makes the subsystem easier to use by reducing complexity and hiding the communication and dependencies between subsystems.

## External Dependencies
[Alamofire](https://github.com/Alamofire/Alamofire) is used to handle the Http requests and networking, avoiding to do it manually. Mainly speeds up the networking and is easy to use.

## Swift Package Manager (SPM) Integration
Tool for managing the distribution of Swift code. Automate the process of downloading, compiling, and linking dependencies. It's used for link the Alamofire dependency.
No extra instalation is required because is integrated into the swift compiler.
