#  About the Project
## Problem and Solution
The problem was set as follows:
> Create an iOS application written in Swift that fetches a list of dogs from an API endpoint and displays it in a nice looking list using up-to-date common iOS UI practices.
> You may use any 3rd party library.

For this problem, I came up with a simple app which only displays a button "Show Doggies" when it launches. 
When a user taps the button, the app shows a list of 10 random dog breeds and the button title changes to "Show More Doggies".
For each dog in the list, a photo is displayed, and, optionally, a name, life span, breeding purpose and temperament if this information is available.
A user may tap the button as many times as they want, and each tap scrolls the list to the top and refreshes it with new 10 dog breeds.
If there was an error fetching the data from the server or decoding it, the app shows an alert with human-readable error message.

The solution utilizies the Clean Swift architecture pattern for the main (and only) scene to pursue the single-responsibility principle:
    * `ViewController` deals with the view: creating the view, responding to the user actions and updating the view.
    * `DataSource` holds the data that should be displayed in the table view and implements the data source methods for populating the table view cells with content.
    * `Interactor` is responsible for handling requests from the `ViewController` (user tapping the "Show Doggies" button): it calls the `Service` which returns either a data or an error, and passes the result to the `Presenter`.
    * `Presenter` embraces the presentation logic, converting data models or errors received from the `Interactor` to simple objects like view models and error messages respectively, and passing them on to the `ViewController` for displaying.
    
Networking logic is implemented in the `Service` component, which utilizes the shared `URLSession` instance to fetch the data from the server and emit the Single observable.

GUI is implemented using a storyboard.
    
## Choices
* As Marita mentioned in her email, the endpoint referenced in the assessment text is unreachable (the domain name is for sale), and a brief session of googling showed the Dog API moved to thedogapi.com, so I used that one.
* I chose to use Cocoapods for fast and easy integration of the following external frameworks:
    * RxSwift (I love using Singles for downloading data, they provide clean and straightforward flow).
    * Nuke for loading images into the table view, because it provides a simple and efficient way to download and display images in the app.

## Trade-offs
* Documentation efforts (commenting the code and writing this `README`) are beyond the 3 hours.
*  `ViewController` is also responsible for configuring the clean-swift stack, I didn't separate it to a `Configurator` component to save time.
* Internet connection check-up and handling the "no network connection/internet" errors are not implemented due ot the time constraint.
* The requirements on how many dogs should be displayed were implicit (inferring from task details: "*URL: (GET) https://api.thedogapi.co.uk/v2/dog.php?**limit=100***")). Due to the time constraint, I chose to add a button and reload the table with 10 new dogs per button tap instead of fetching 100 items list with pagination (it looks like the pagination is supported by the API, but I decided to save time on researching and implementing it).


