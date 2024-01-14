//
//  MapVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class MapVC: ViewController , GMSMapViewDelegate , CLLocationManagerDelegate, UITableViewDelegate ,UITableViewDataSource {

    var ReportLost : ReportLostVC?
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(MapView)
    MapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    MapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    MapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    MapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    MapView.delegate = self
      
    view.addSubview(ViewTop)
    ViewTop.addSubview(tableView)
    ViewTop.addSubview(ActivityIndicator)
    ViewTop.frame = CGRect(x: 0, y: ControlY(-20), width: view.frame.width, height: ControlWidth(160))

    ViewTop.addSubview(Stack)
    Stack.frame = CGRect(x: ControlX(20), y: ControlY(75), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)),
          name: UIResponder.keyboardDidShowNotification, object: nil)
      
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)),
          name: UIResponder.keyboardDidHideNotification, object: nil)
      
      MyLocation()
      openLocation()
  }

    func MyLocation() {
        DispatchQueue.main.async {
        self.MapView.isMyLocationEnabled = true
        // GOOGLE MAPS SDK: BORDER
        let mapInsets = UIEdgeInsets(top: 80.0, left: 0.0, bottom: 45.0, right: 0.0)
        self.MapView.padding = mapInsets
            
        self.locationManager.distanceFilter = 100
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.MapView.camera = GMSCameraPosition.camera(withLatitude: self.locationManager.location?.coordinate.latitude ?? self.ReportLost?.Latitude ?? 30.1000993, longitude: self.locationManager.location?.coordinate.longitude ?? self.ReportLost?.Longitude ?? 31.3528525, zoom: 16.0)
            
        // GOOGLE MAPS SDK: COMPASS
        self.MapView.settings.compassButton = true
            
        // GOOGLE MAPS SDK: USER'S LOCATION
        self.MapView.isMyLocationEnabled = true
        self.MapView.settings.myLocationButton = true
        self.MapView.delegate = self
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let ReportLostVC = ReportLost {
        ReportLostVC.Latitude = lat
        ReportLostVC.Longitude = lon
        if let name = display_name {
        ReportLostVC.LocationButton.setTitle(name, for: .normal)
        }
        }
    }
    
    lazy var ViewTop : UIView = {
        let View = UIView()
        View.layer.shadowRadius = 5
        View.layer.shadowOffset = .zero
        View.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        View.backgroundColor = UIColor.white
        View.layer.cornerRadius = ControlY(15)
        return View
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ViewDismiss,SearchTextField])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        return Stack
    }()
          
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.Label.textColor = .black
        View.IconImage.tintColor = .black
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconSize = CGSize(width: ControlWidth(22), height: ControlWidth(22))
        View.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    let didFindMyLocation = false
    var MapView: GMSMapView = {
        let v = GMSMapView()
        v.mapType = .hybrid
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var SearchTextField : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        tf.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.Icon.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.addTarget(self, action: #selector(SearchMapTF), for: .editingChanged)
        tf.attributedPlaceholder = NSAttributedString(string: "Search", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        return tf
    }()
        
    @objc func keyboardDidShow(_ notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? CGRect else {return}
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8) {
        self.tableView.alpha = 1
        self.ViewTop.frame = CGRect(x: 0, y: ControlY(-20), width: self.view.frame.width, height: self.view.frame.height - kbSize.height)
        self.tableView.frame = CGRect(x: ControlX(10), y: self.Stack.frame.maxY + ControlY(10), width: self.view.frame.width - ControlX(20), height: self.view.frame.height - kbSize.height - ControlWidth(150))
        self.ActivityIndicator.frame = CGRect(x: self.ViewTop.center.x - ControlWidth(20), y: self.ViewTop.center.y + ControlWidth(40), width: ControlWidth(40), height: ControlWidth(40))
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.6) {
        self.tableView.alpha = 0
        self.ViewTop.frame = CGRect(x: 0, y: ControlY(-20), width: self.view.frame.width, height: ControlWidth(160))
        self.tableView.frame = CGRect(x: ControlX(10), y: self.Stack.frame.maxY + ControlY(10), width: self.view.frame.width - ControlX(20), height: 0)
        self.ActivityIndicator.frame = CGRect(x: self.ViewTop.center.x - ControlWidth(20), y: self.ViewTop.center.y + ControlWidth(40), width: ControlWidth(40), height: ControlWidth(40))
        }
    }

    var MapData = [SearchMap]()
    @objc func SearchMapTF() {
        if SearchTextField.text?.TextNull() == true {
        if let Text = SearchTextField.text {
        self.MapData.removeAll()
        self.tableView.reloadData()
        fetchJson(Text)
        }
        }
    }
    
    func fetchJson(_ key: String) {
        ViewTop.isHidden = false
        ActivityIndicator.startAnimating()
       guard let url = URL(string: "https://nominatim.openstreetmap.org/search?q=\(key)&format=json") else {return}
       URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
        print(error)
        return
        }
        
        guard let safeData = data else {return}
        
        do {

        if let Array = try JSONSerialization.jsonObject(with: safeData, options: []) as? [[String: Any]] {
        DispatchQueue.main.async {
        for data in Array {
        self.MapData.append(SearchMap(dictionary: data))
        if self.MapData.count == Array.count {
        self.ActivityIndicator.stopAnimating()
        self.tableView.reloadData()
        }
        }
        }
        }
        } catch {
        print(error)
        }
       }.resume()
   }

    
    
    let CellId = "CellId"
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.alpha = 0
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.rowHeight = ControlWidth(60)
        tv.separatorColor = UIColor.darkGray
        tv.showsVerticalScrollIndicator = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: CellId)
        return tv
    }()
    
    let ActivityIndicator : UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    aiv.hidesWhenStopped = true
    aiv.color = UIColor.darkGray
    return aiv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CellId)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.textLabel?.text = MapData[indexPath.row].display_name
        cell.detailTextLabel?.text = MapData[indexPath.row].type
        cell.textLabel?.textColor = UIColor.black
        cell.detailTextLabel?.textColor = UIColor.darkGray
        cell.textLabel?.font = UIFont(name: "Nexa-Regular", size: ControlWidth(14))
        cell.detailTextLabel?.font = UIFont(name: "Nexa-Light", size: ControlWidth(10))
        return cell
    }
    
    var lat = Double()
    var lon = Double()
    var display_name : String?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(false)
        SearchTextField.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: false)
        
        lat = MapData[indexPath.row].lat?.toDouble() ?? 0
        lon = MapData[indexPath.row].lon?.toDouble() ?? 0
        display_name = MapData[indexPath.row].display_name ?? ""
        createMarker(titleMarker: MapData[indexPath.row].display_name ?? "", latitude: MapData[indexPath.row].lat?.toDouble() ?? 0, longitude: MapData[indexPath.row].lon?.toDouble() ?? 0)
    }
    
    func DetailsFetchJson(_ key: String) {
    self.ViewTop.isHidden = true
    view.addSubview(ViewDismiss)
    ViewDismiss.IconImage.tintColor = .white
    ViewDismiss.translatesAutoresizingMaskIntoConstraints = true
    ViewDismiss.frame = CGRect(x: ControlY(20), y: ControlY(40), width: ControlWidth(40), height: ControlWidth(40))
    guard let url = URL(string: "https://nominatim.openstreetmap.org/search?q=\(key)&format=json") else {return}
    URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let error = error {
    print(error)
    return
    }
                
    guard let safeData = data else {return}
    do {
    if let Array = try JSONSerialization.jsonObject(with: safeData, options: []) as? [[String: Any]] {
    print(SearchMap(dictionary: Array.first ?? [String:Any]()).display_name ?? "")
        
    DispatchQueue.main.async {
    if let first = Array.first {
    self.createMarker(titleMarker: SearchMap(dictionary: first).display_name ?? "", latitude:  SearchMap(dictionary: first).lat?.toDouble() ?? 0, longitude:  SearchMap(dictionary: first).lon?.toDouble() ?? 0)
    }
    }
    }
    } catch {
    print(error)
    }
    }.resume()
   }

    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
    let decoder = CLGeocoder()
    decoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, err in
    if let placeMark = placemarks?.first {
    let plName = placeMark.name ?? placeMark.subThoroughfare ?? placeMark.thoroughfare ?? "" // Place Name
    self.lat = coordinate.latitude
    self.lon = coordinate.longitude
    self.display_name = plName
    self.createMarker(titleMarker: plName, latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    }
    }
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    DispatchQueue.main.async {
    self.MapView.clear()
    let position = CLLocationCoordinate2DMake(latitude,longitude)
    let marker = GMSMarker(position: position)
    marker.title = titleMarker
    marker.map = self.MapView
    self.MapView.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: self.MapView.camera.zoom)
    }
    }
    
    
    var locationStart = CLLocation()
    @objc func openLocation() {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.primaryTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        autoCompleteController.secondaryTextColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        autoCompleteController.delegate = self
        autoCompleteController.modalPresentationStyle = .fullScreen
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension MapVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0
        )
        
        SearchTextField.text = place.name
        locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        createMarker(titleMarker: "You chose this Location", latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        self.MapView.camera = camera
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

public extension UISearchBar {
    
     func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}
