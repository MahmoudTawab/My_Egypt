//
//  API.swift
//  SHARMIVAL (iOS)
//
//  Created by Emoji Technology on 05/12/2021.
//


import FirebaseFirestore

    let defaults = UserDefaults.standard

    func LodBaseUrl() {
    Firestore.firestore().collection("API").document("IOS").addSnapshotListener { (querySnapshot, err) in
    if let err = err {
    print(err.localizedDescription)
    return
    }
        
    guard let data = querySnapshot?.data() else {
    return
    }
        
    DispatchQueue.main.async {
    let DebugBase = data["DebugBaseUrl"] as? String
    let ReleaseBase = data["ReleaseBaseUrl"] as? String
    let WhatsApp = data["WhatsAppNumber"] as? String

    defaults.set(DebugBase, forKey: "API")
    defaults.set(ReleaseBase, forKey: "Url")
    defaults.set(WhatsApp, forKey: "WhatsApp")
    }
    }
    }


    ///
///
    var GUID = "00000000-0000-0000-0000-000000000000"
///

    let SplashScreen = "SplashScreen"

    let GetLanguage = "GetLanguage"

    let SetLanguage = "SetLanguage"

    let GetTripPurpose = "GetTripPurpose"

    let GetScreenData = "GetScreenData"

    let GetSignUp = "GetSignUp"

    let GetCurrenciesAndCities = "GetCurrenciesAndCities"

    let SetTripPurpose = "SetTripPurpose"

    let SignIn = "SignIn"

    let SignUpApi = "SignUp"

    let GetHomeScreen = "GetHomeScreen"

    let GetAllCategories = "GetAllCategories"

    let GetCategoryPlaces = "GetCategoryPlaces"

    let AddReview = "AddReview"

    let GetReview = "GetReview"

    let GetProfile = "GetProfile"

    let ChangeProfilePhoto = "ChangeProfilePhoto"

    let GetMyInformation = "GetMyInformation"

    let GetPlaceDetails = "GetPlaceDetails"

    let GetEventDetails = "GetEventDetails"

    let GetShowDetails = "GetShowDetails"

    let GetMyFavorite = "GetMyFavorite"

    let AddOrDeleteFavorite = "AddOrDeleteFavorite"

    let UpdateMyInformation = "UpdateMyInformation"

    let AddReportLostItem = "AddReportLostItem"

    let GetSubmitComplain = "GetSubmitComplain"

    let AddComplain = "AddComplain"

    let DeleteNotification = "DeleteNotification"

    let ReadNotification = "ReadNotification"

    let GetNotifications = "GetNotifications"

    let GetEmergencyContacts = "GetEmergencyContacts"

    let ResendConfirmeationEmile = "ResendConfirmeationEmile"

    let ApiSearch = "Search"

    let GetMorPlaces = "GetMorPlaces"

    let GetMorEvents = "GetMorEvents"

    let CheckEmailIsUsed = "CheckEmailIsUsed"
