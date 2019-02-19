# JobFinder

This app built using MVVM (Model–view–viewmodel) "https://en.wikipedia.org/wiki/Model–view–viewmodel" design pattern as the below

* Model as the below:

Models: that contains the objects that built using EVReflection "https://github.com/evermeer/EVReflection" for automatic object parsing

TBConnectionManager: that contains handlers for all api call across the app level using Alamofire "https://github.com/Alamofire/Alamofire"

TBMainBusinessManager: is the connection between the model and the viewmodel

* ViewModels as the below

PSSplashViewController: showen for 2 seconds and move to jobs filter view

PSJobsFiltersViewController: the main filter view

PSJobsViewController: all filtered jobs view

* View as the below

Main.storyboard that contians all ViewControllers view with there Segues
