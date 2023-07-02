# PropertySelection
The Property Selection Project is implemented for iOS devices using swift and MVVM architechture

# Strucutre of the Project
We have used MVVM Architrchture for Propertry Selection. Our structure includes following groups. First we have models(FacilityModel.swift). Its a simple structure of data that we are expecting from our API. 
Next we have ViewModels(FacilitiesViewModel.swift). In our project we are using ViewModel to call our API service. In WebServices we have a file for API Service, which includes the logic for fetching data from the given API. 
For MVVM binding, we create a property in our ViewModel class and this property is getting called in our ViewController. Once we get the response from our API in view model, we can update the UI in our view controller. 
Lastly, in we have ViewController(ViewController.swift). ViewController is handles user interaction and the UI. 

# Screenshots of Final Result: 

![Simulator Screen Shot - iPhone 14 Pro - 2023-07-01 at 23 56 41](https://github.com/richakalani/PropertySelection/assets/38135380/a87ccdc0-45d1-4443-8d7f-ba683a8a6ddb)
![Simulator Screen Shot - iPhone 14 Pro - 2023-07-02 at 16 51 30](https://github.com/richakalani/PropertySelection/assets/38135380/f5fd1651-9cd2-493b-9f82-7b0b56764533)
![Simulator Screen Shot - iPhone 14 Pro - 2023-07-02 at 16 51 40](https://github.com/richakalani/PropertySelection/assets/38135380/7767cef2-2d26-4e63-a5cf-ce043299f50b)
