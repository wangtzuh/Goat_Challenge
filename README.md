# Goat_Challenge

### Description
Goat_Challenge is an application architectured with __MVP__ and __Clean Architecture__ concepts

#### MVP Concepts
* `Model` - plain `struct` implementations
  * In this project, it was used to directly be as what to displayed on UITableView
  * The logic to fetch or modify the model entity is one of the responsibilities for `Model` layer but was introduced inside the `usecase` or `gateways` layer in __Clean Architecture__

* `View` - `protocol` defines user interactions and how to display data.
  * `UIView` instance only cares about layouts and by conforming `View` protocols, the instance can display what we want. 

* `Presenter` - contains the presentation logics. 
  *  Handle specific busniess logic for user interactions, like `UITableView.didSelectRowAt`.
  *  Initiate the call to fetch `Model`. 
  *  Tells the `View` what to be displayed

* `ViewController` - In this project, it is considered as part of the `View` layer,
  * However, we can seperate ViewController and View by wrapping the UITableView with its own MVP pattern. Then ViewController instances only responsible to handle the layout, lifecycle management, and routing. 


#### Clean Architecture
Application Logic
* `Usecase/ Interactor` - contains the exact busniess logic for specific use case. 
    * `Gateway` protocol inside Core Group to define overall methods. `Usecase` as the concrete instance to implement. For example, we can have a `UserGateway` define different login methods and we have multiple `Usecase` to implement different login methods. 
    * `Presenter` in MVP reference the `Usecase`.
    * Manipulate the `Model` if needed as part of the business logic.

Gateways & Framework Logic 
* `Gateway` - acutal implementation of protocols defined in Application Logic.
  * `APIGateway` used to perform requests through http request
  * More example, such as `LocalPersistasnceGateway` to interact with the local database.

