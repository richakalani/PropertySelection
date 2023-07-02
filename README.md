# PropertySelection
The Property Selection Project is implemented for iOS devices using swift and MVVM architechture

# Strucutre of the Project
We have used MVVM Architrchture for Propertry Selection. Our structure includes following groups. First we have models(FacilityModel.swift). Its a simple structure of data that we are expecting from our API. 
Next we have ViewModels(FacilitiesViewModel.swift). In our project we are using ViewModel to call our API service. In WebServices we have a file for API Service, which includes the logic for fetching data from the given API. 
For MVVM binding, we create a property in our ViewModel class and this property is getting called in our ViewController. Once we get the response from our API in view model, we can update the UI in our view controller. 
Lastly, in we have ViewController(ViewController.swift). ViewController is handles user interaction and the UI. 
