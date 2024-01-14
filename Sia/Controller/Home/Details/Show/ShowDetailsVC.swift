//
//  ShowDetailsVC.swift
//  Sia
//
//  Created by Emojiios on 16/03/2023.
//

import UIKit
import SDWebImage

class ShowDetailsVC: ViewController ,UITableViewDelegate , UITableViewDataSource ,ShowDetailsDelegate ,UIViewControllerTransitioningDelegate {
    
    var ShowId : Int?
    var ReadMore = false
    var DataShowDetails : ShowDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    
    view.addSubview(TableView)
    TableView.frame = CGRect(x: 0, y: -TopHeight , width: view.frame.width , height:  view.frame.height + TopHeight)
      
    TableView.tableHeaderView = HeaderView
    HeaderView.frame = CGRect(x: 0, y: 0, width: TableView.frame.width, height: ControlWidth(600))
      
    HeaderView.addSubview(EventsBackground1)
    HeaderView.addSubview(ShowImage)
    HeaderView.addSubview(EventsBackground2)
      
    EventsBackground1.frame = CGRect(x: 0, y: 0, width: HeaderView.frame.width, height: HeaderView.frame.height - ControlY(50))
    ShowImage.frame = CGRect(x: 0, y: ControlY(100), width: HeaderView.frame.width, height: HeaderView.frame.height - ControlY(150))
    EventsBackground2.frame = CGRect(x: 0, y: 0, width: HeaderView.frame.width, height: HeaderView.frame.height - ControlY(50))
    ShowImage.layer.cornerRadius = ShowImage.frame.width / 2
            
    HeaderView.addSubview(TopStack)
    TopStack.frame = CGRect(x: ControlY(15), y: ControlY(35), width: view.frame.width - ControlY(30) , height: ControlWidth(60))
      
    HeaderView.addSubview(FavoritesButton)
    FavoritesButton.frame = CGRect(x: view.frame.width - ControlWidth(65), y: EventsBackground2.frame.maxY + ControlY(10), width: ControlWidth(50) , height: ControlWidth(50))
    GetDataShowDetails()
  }

    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconSize = CGSize(width: ControlWidth(25), height: ControlWidth(25))
        View.translatesAutoresizingMaskIntoConstraints = false
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.widthAnchor.constraint(equalToConstant:  ControlWidth(60)).isActive = true
        View.heightAnchor.constraint(equalTo: View.widthAnchor).isActive = true
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var NameLabel : MarqueeLabel = {
        let Label = MarqueeLabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 1
        Label.speed = .rate(70)
        Label.speed = .duration(25)
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.lineBreakMode = .byTruncatingHead
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(20))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pauseTap)))
        return Label
    }()
    
    @objc func pauseTap(_ recognizer: UIGestureRecognizer) {
        let continuousLabel2 = recognizer.view as! MarqueeLabel
        if recognizer.state == .ended {
            continuousLabel2.isPaused ? continuousLabel2.unpauseLabel() : continuousLabel2.pauseLabel()
        }
    }
    
    lazy var OpenMap : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(ActionOpenMap)))
        ImageView.image = UIImage(named: "location-bulk")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        return ImageView
    }()
    
    @objc func ActionOpenMap() {
    let Map = MapKitSearchViewController()
    Map.Textsearch = DataShowDetails?.Details?.showName ?? ""
    Map.modalPresentationStyle = .fullScreen
    present(Map, animated: true, completion: nil)
    }
    
    lazy var ShowDetailsStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameLabel,OpenMap])
        Stack.axis = .horizontal
        Stack.alignment = .trailing
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ViewDismiss,ShowDetailsStack])
        Stack.axis = .horizontal
        Stack.alignment = .top
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    lazy var FavoritesButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.shadowOpacity = 0.6
        Button.layer.shadowOffset = .zero
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.addTarget(self, action: #selector(ActionFavorites), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return Button
    }()
    
    @objc func ActionFavorites() {
    if HomeScreenData?.userData?.emailConfirmed == true && HomeScreenData?.userData?.email != nil {
    AddAndDeleteFavorite()
    }else{
    if HomeScreenData?.userData?.email == nil {
    ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
    Present(ViewController: self, ToViewController: MyAccountVC())
    },"Sign-Up")
    }else{
    ShowMessageAlert("ErrorIcon", "Please Confirm your Email",
                                    "If you not confirmed your account you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
    self.ResendConfirmeation()
    },"Re-send")
    }
    }
    }
    
    let CellId = "CellId"
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.bounces = false
        tv.backgroundColor = .white
        tv.separatorColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.register(ShowDetailsCell.self, forCellReuseIdentifier: CellId)
        return tv
    }()
    
    lazy var HeaderView : UIView = {
        let View = UIView()
        View.clipsToBounds = true
        View.backgroundColor = .white
        return View
    }()

    lazy var EventsBackground1 : SineView = {
        let ImageView = SineView()
        ImageView.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EventsBackground1")
        return ImageView
    }()

    lazy var ShowImage : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .white
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2984042005).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7032852692).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EventsImageAction)))
        return ImageView
    }()

    @objc func EventsImageAction() {
    if let image = ShowImage.image {
    let imageInfo = GSImageInfo(image: image, imageMode: .aspectFit)
    let transitionInfo = GSTransitionInfo(fromView: ShowImage)
    let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
    present(imageViewer, animated: true, completion: nil)
    }
    }
    
    lazy var EventsBackground2 : SineView = {
        let ImageView = SineView()
        ImageView.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EventsBackground2")
        return ImageView
    }()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! ShowDetailsCell
        cell.Show = DataShowDetails

        cell.Delegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        if DataShowDetails?.Details?.description?.TextHeight(cell.frame.width , font: UIFont.systemFont(ofSize: ControlWidth(16)), Spacing: ControlWidth(8)) ?? 0 > ControlWidth(50) {
        cell.LabelDetails.numberOfLines = ReadMore ? 0 : 3
        cell.ReadMore.isHidden = self.ReadMore ? true:false
        }else{
        cell.LabelDetails.numberOfLines = 3
        cell.ReadMore.isHidden = true
        }
        return cell
    }
    
    func ActionReadMore(_ Cell: ShowDetailsCell) {
    if let indexPath = TableView.indexPath(for: Cell) {
    ReadMore = !ReadMore
    TableView.reloadRows(at: [indexPath], with: .automatic)
    }
    }
    
    func ActionReserve(_ Cell: ShowDetailsCell) {
        if HomeScreenData?.userData?.emailConfirmed == true && HomeScreenData?.userData?.email != nil {
        let WhatsappMessage = "Please contact us to reserve".urlEncoded ?? ""
               
        let phone = HomeScreenData?.reserveNumber ?? "+201021111111"
        guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phone)&text=\(WhatsappMessage)") else {return}
        if UIApplication.shared.canOpenURL(whatsappURL) {
        if #available(iOS 10.0, *) {
        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        }else {
        UIApplication.shared.openURL(whatsappURL)
        }
        }
        }else{
        if HomeScreenData?.userData?.email == nil {
        ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        Present(ViewController: self, ToViewController: MyAccountVC())
        },"Sign-Up")
        }else{
        ShowMessageAlert("ErrorIcon", "Please Confirm your Email",
                                        "If you not confirmed your account you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        self.ResendConfirmeation()
        },"Re-send")
        }
        }
    }
    
    func ResendConfirmeation() {
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
                
        let api = "\(url + ResendConfirmeationEmile)"
        let token = defaults.string(forKey: "jwt") ?? ""
                
        self.ViewDots.beginRefreshing()
        PostAPI(timeout: 60 ,api: api, token: token, parameters: [:]) { _ in
        self.ViewDots.endRefreshing("Success Resend Confirmeation Emile", .success) {}
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error,.error) {}
        }
    }
        
    func GetDataShowDetails() {
    self.view.subviews.forEach { View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetDataShowDetails()}
    return
    }

    let api = "\(url + GetShowDetails)"
    let ShowId = ShowId ?? 0
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["ShowId": ShowId]
                
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in

    self.SetData(ShowDetails(dictionary: dictionary))
    } array: { _ in
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetDataShowDetails()
    }
    }
    }
    
    
    func SetData(_ Data: ShowDetails)  {
        DataShowDetails = Data
        NameLabel.text = Data.Details?.showName ?? ""

        FavoritesButton.setImage(Data.Details?.isFavorite ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
        ShowImage.sd_setImage(with: URL(string: Data.Details?.image ?? "")
                              , placeholderImage: UIImage(named: "Group 26056"))
        

        UIView.animate(withDuration: 0.5) {
        self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
        self.ViewNoData.isHidden = true
        ViewDots.endRefreshing() {}
        TableView.reloadData()
    }
    
    func AddAndDeleteFavorite() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
            
    let api = "\(url + AddOrDeleteFavorite)"
    let token = defaults.string(forKey: "jwt") ?? ""
            
    self.ViewDots.beginRefreshing()
    let parameters = ["PlaceId":0,
                      "EventId":0,
                      "ShowId":ShowId ?? 0]
        
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing {}
    UIView.animate(withDuration: 0.3) {
    self.FavoritesButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    } completion: { _ in
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: []) {
    self.FavoritesButton.setImage(self.FavoritesButton.imageView?.image == UIImage(named: "InFavorites") ? UIImage(named: "NotFavorites"):UIImage(named: "InFavorites"), for: .normal)
    }
    }
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error) {}
    }
    }
    
}
