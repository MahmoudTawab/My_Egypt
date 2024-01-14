//
//  NotificationVC.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit
import SDWebImage


class NotificationVC: ViewController ,UITableViewDelegate , UITableViewDataSource ,SwipeTableViewCellDelegate, NotificationTextOnlyDelegate , NotificationBigImageDelegate {
        
    var NotificationDetails = [ModelNotification]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(ImageBackground)
    ImageBackground.frame = view.bounds
      
    view.addSubview(NotificationTV)
    NotificationTV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    NotificationTV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    NotificationTV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    NotificationTV.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
    NotificationCenter.default.addObserver(self, selector: #selector(GetNotificationsData), name: AppDelegate.PostNotification , object: nil)
    
    GetNotificationsData()
      
    AddRefreshControl(Scroll: NotificationTV, color: #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)) {
    self.GetNotificationsData()
    }
  }

    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.Label.textColor = .black
        View.IconImage.tintColor = .black
        View.IconSize = CGSize(width: ControlWidth(22), height: ControlWidth(22))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    let ShowId = "ShowId"
    let TextId = "TextId"
    let EventId = "EventId"
    let PlaceId = "PlaceId"
    lazy var NotificationTV : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        tv.register(NotificationTextOnly.self, forCellReuseIdentifier: TextId)
        tv.register(NotificationBigImage.self, forCellReuseIdentifier: EventId)
        tv.register(NotificationBigImage.self, forCellReuseIdentifier: ShowId)
        tv.register(NotificationBigImage.self, forCellReuseIdentifier: PlaceId)

        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()
    
    lazy var ImageBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "NotificationVCBackground")
        return ImageView
    }()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch NotificationDetails[indexPath.item].typeName {
        case "Text":
            let cell = tableView.dequeueReusableCell(withIdentifier: TextId, for: indexPath) as! NotificationTextOnly
            cell.delegate = self
            cell.Delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.IconRead.isHidden = NotificationDetails[indexPath.item].read ?? false
            cell.LabelDetails.text = NotificationDetails[indexPath.item].notificationMessage
            cell.LabelDetails.addInterlineSpacing(spacingValue: ControlY(8))
            return cell
            
        case "Place":
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaceId, for: indexPath) as! NotificationBigImage
            cell.Delegate = self
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.TitleLabel.text = NotificationDetails[indexPath.item].placeName
            cell.IconRead.isHidden = NotificationDetails[indexPath.item].read ?? false
            cell.LabelDetails.text = NotificationDetails[indexPath.item].notificationMessage
            cell.LabelDetails.addInterlineSpacing(spacingValue: ControlY(8))
            cell.Image.sd_setImage(with: URL(string: NotificationDetails[indexPath.item].placeImage ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
            cell.RatingButton.isHidden = false
            cell.RatingButton.setTitle("\(NotificationDetails[indexPath.item].ratePlaces ?? 1.0)", for: .normal)
            cell.FavoritesButton.setImage(NotificationDetails[indexPath.item].placeFav ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
            return cell
            
        case "Event":
            let cell = tableView.dequeueReusableCell(withIdentifier: EventId, for: indexPath) as! NotificationBigImage
            cell.Delegate = self
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.TitleLabel.text = NotificationDetails[indexPath.item].eventName
            cell.IconRead.isHidden = NotificationDetails[indexPath.item].read ?? false
            cell.LabelDetails.text = NotificationDetails[indexPath.item].notificationMessage
            cell.LabelDetails.addInterlineSpacing(spacingValue: ControlY(8))
            cell.Image.sd_setImage(with: URL(string: NotificationDetails[indexPath.item].eventImage ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
            cell.RatingButton.isHidden = false
            cell.RatingButton.setTitle("\(NotificationDetails[indexPath.item].rateEvent ?? 1.0)", for: .normal)
            cell.FavoritesButton.setImage(NotificationDetails[indexPath.item].eventFav ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
            return cell
            
        case "Show":
            
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowId, for: indexPath) as! NotificationBigImage
        cell.Delegate = self
        cell.delegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.TitleLabel.text = NotificationDetails[indexPath.item].showName
        cell.IconRead.isHidden = NotificationDetails[indexPath.item].read ?? false
        cell.LabelDetails.text = NotificationDetails[indexPath.item].notificationMessage
        cell.LabelDetails.addInterlineSpacing(spacingValue: ControlY(8))
        cell.Image.sd_setImage(with: URL(string: NotificationDetails[indexPath.item].showImage ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
        cell.RatingButton.isHidden = true
        cell.FavoritesButton.setImage(NotificationDetails[indexPath.item].showFav ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
        return cell
  
        default :
        return UITableViewCell()
        }
    }
    
    
    func CellBigImageAction(_ Cell: NotificationBigImage) {
    if let indexPath = NotificationTV.indexPath(for: Cell) {
    switch NotificationDetails[indexPath.item].typeName {
    case "Place":
    SetReadNotification(indexPath)
    let DetailsVC = PlacesDetailsVC()
    DetailsVC.PlaceId = NotificationDetails[indexPath.item].id ?? 0
    DetailsVC.GetDataPlaceDetails()
    Present(ViewController: self, ToViewController: DetailsVC)
                
    case "Event":
    SetReadNotification(indexPath)
    let DetailsVC = EventsDetailsVC()
    DetailsVC.EventId = NotificationDetails[indexPath.item].id ?? 0
    DetailsVC.GetDataEventDetails()
    Present(ViewController: self, ToViewController: DetailsVC)
            
    case "Show":
    SetReadNotification(indexPath)
    let ShowDetails = ShowDetailsVC()
    ShowDetails.ShowId = NotificationDetails[indexPath.item].id
    Present(ViewController: self, ToViewController: ShowDetails)
                
    default :
    break
    }
    }
    }
    
    
    func NotificationTextAction(_ Cell:NotificationTextOnly) {
    if let indexPath = NotificationTV.indexPath(for: Cell) {
        if let notification = NotificationDetails[indexPath.item].notificationMessage {
            let Controller = PopUpCenterView()
            Controller.MessageDetails = notification
            Controller.StackIsHidden = false
            Controller.RightButton.isHidden = true
            Controller.IconImage.image = UIImage(named: "Notification")?.withInset(UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            SetReadNotification(indexPath)
            Controller.modalPresentationStyle = .overFullScreen
            Controller.modalTransitionStyle = .crossDissolve
            self.present(Controller, animated: true, completion: nil)
        }
    }
    }
    
    
    func SetReadNotification(_ indexPath:IndexPath) {
    if let Id = self.NotificationDetails[indexPath.item].id {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    return
    }

    let api = "\(url + ReadNotification)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters: [String:Any] = ["NotificationId":Id]

    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.NotificationDetails[indexPath.item].read = !(self.NotificationDetails[indexPath.item].read ?? false)
    self.NotificationTV.reloadRows(at: [indexPath], with: .automatic)
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    }
    }
    }
    
    var Selectid : Int?
    var SelectIndex : Int?
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    if "lang".localizable == "ar" {
    guard orientation == .left else { return nil }
    }else{
    guard orientation == .right else { return nil }
    }
    let deleteAction = SwipeAction(style: .destructive, title: nil) { action, index in
        
    self.SelectIndex = indexPath.item
    self.Selectid = self.NotificationDetails[indexPath.item].id
    ShowMessageAlert("ErrorIcon", "Delete Notification", "Are You Sure You Want to Delete this Notifications", false, self.ActionDelete, "Delete")
    }
        
    deleteAction.backgroundColor = UIColor.clear
    deleteAction.image = UIImage(named: "Group 26416")
    return [deleteAction]
    }
    
    var defaultOptions = SwipeOptions()
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        if "lang".localizable == "ar" {
        options.expansionStyle = orientation == .left ? .selection : .destructive
        }else{
        options.expansionStyle = orientation == .right ? .selection : .destructive
        }
        options.transitionStyle = defaultOptions.transitionStyle
        options.backgroundColor = .clear
        return options
    }

    func ActionDelete() {
    if let Id = Selectid , let Index = SelectIndex {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
            
    let api = "\(url + DeleteNotification)"
    let token = defaults.string(forKey: "jwt") ?? ""
            
    self.ViewDots.beginRefreshing()
    let parameters: [String:Any] = ["NotificationId":Id]
            
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.NotificationDetails.remove(at: Index)
    self.NotificationTV.beginUpdates()
    self.NotificationTV.deleteRows(at: [IndexPath(row: Index, section: 0)], with: .right)
    self.NotificationTV.endUpdates()
    self.ViewDots.endRefreshing() {}

    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error) {}
    }
    }
    }
    
    
    @objc func GetNotificationsData() {
    self.view.subviews.forEach { View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetNotificationsData()}
    return
    }
            
    let api = "\(url + GetNotifications)"
    let token = defaults.string(forKey: "jwt") ?? ""
                
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60, api: api, token: token, parameters: [:]) { _ in
    } dictionary: { _ in
    } array: { array in
    self.NotificationDetails.removeAll()
        
    if array.count != 0 {
    for dictionary in array {
    self.NotificationDetails.append(ModelNotification(dictionary: dictionary))
    if self.NotificationDetails.count == array.count {
    self.ViewDismiss.TextLabel = self.NotificationDetails.first?.screenTitle ?? "Notifications"
                    
    UIView.animate(withDuration: 0.5) {
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
                    
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    self.NotificationTV.reloadData()
    }
    }
    }else{
    self.ViewDismiss.alpha = 1
    self.ShowWhatsUp = true
    self.ViewNoData.MessageTitle = HomeScreenData?.screenData?.screenElements.filter({$0.id == 195}).first?.lable ?? "No Notifications Data"
    self.ViewNoData.MessageDetails = ""
    self.ViewNoData.RefreshButton.isHidden = true
    self.SetUpIsError(true) {}
    }
    
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetNotificationsData()
    }
    }
    }
}

