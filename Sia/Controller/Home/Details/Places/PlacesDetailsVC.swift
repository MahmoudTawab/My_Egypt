//
//  PlacesDetailsVC.swift
//  Sia
//
//  Created by Emojiios on 15/03/2023.
//


import UIKit
import SDWebImage

class PlacesDetailsVC: ViewController ,UITableViewDelegate , UITableViewDataSource ,PlacesDetailsDelegate ,UIViewControllerTransitioningDelegate {
    
    var PlaceId : Int?
    var ReadMore = false
    var DataPlaceDetails : PlaceDetails?
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
      
    HeaderView.addSubview(PlacesBackground1)
    HeaderView.addSubview(PlacesImage)
    HeaderView.addSubview(PlacesBackground2)
      
    PlacesBackground1.frame = CGRect(x: 0, y: ControlY(10), width: HeaderView.frame.width, height: HeaderView.frame.height - ControlY(50))
    PlacesImage.frame = CGRect(x: 0, y: ControlY(110), width: HeaderView.frame.width, height: HeaderView.frame.height - ControlY(150))
    PlacesBackground2.frame = CGRect(x: 0, y: ControlY(10), width: HeaderView.frame.width, height: HeaderView.frame.height - ControlY(50))
    PlacesImage.layer.cornerRadius = PlacesImage.frame.width / 2
      
    HeaderView.addSubview(SiaInsightsButton)
    SiaInsightsButton.frame = CGRect(x: PlacesImage.frame.width - ControlX(130), y: PlacesImage.frame.minY + ControlX(50), width: ControlWidth(100), height: ControlWidth(100))

    HeaderView.addSubview(TopStack)
    TopStack.frame = CGRect(x: ControlY(15), y: ControlY(35), width: view.frame.width - ControlY(30) , height: ControlWidth(90))

    HeaderView.addSubview(RatingAndFavorites)
    RatingAndFavorites.frame = CGRect(x: ControlX(15), y: PlacesBackground2.frame.maxY , width: view.frame.width - ControlX(30) , height: ControlWidth(50))
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
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(20))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pauseTap)))
        return Label
    }()
    
    lazy var DetailsLabel : MarqueeLabel = {
        let Label = MarqueeLabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 1
        Label.speed = .rate(70)
        Label.speed = .duration(25)
        Label.textAlignment = .left
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.lineBreakMode = .byTruncatingHead
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pauseTap(_:))))
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
    Map.Textsearch = DataPlaceDetails?.AllDetails?.address ?? ""
    Map.modalPresentationStyle = .fullScreen
    present(Map, animated: true, completion: nil)
    }
    
    lazy var PlacesDetailsStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameLabel,DetailsLabel,OpenMap])
        Stack.axis = .vertical
        Stack.alignment = .trailing
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ViewDismiss,PlacesDetailsStack])
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
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionFavorites), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
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
    let parameters = ["PlaceId": PlaceId ?? 0,
                      "EventId":0,
                      "ShowId": 0]
        
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
    
    
    lazy var RatingButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.backgroundColor = .clear
        Button.contentVerticalAlignment = .center
        Button.titleEdgeInsets.top = ControlWidth(2)
        Button.contentHorizontalAlignment = .trailing
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size:  ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), for: .normal)
        Button.setImage(UIImage(named: "magic-star")?.imageWithImage(scaledToSize: CGSize(width: ControlWidth(20), height: ControlWidth(20))), for: .normal)
        return Button
    }()
    

    lazy var RatingAndFavorites : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [RatingButton,FavoritesButton])
        Stack.axis = .horizontal
        Stack.alignment = .center
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    let CellId = "CellId"
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.bounces = false
        tv.separatorColor = .clear
        tv.backgroundColor = .white
        tv.rowHeight = UITableView.automaticDimension
        tv.register(PlacesDetailsCell.self, forCellReuseIdentifier: CellId)
        return tv
    }()
    
    
    lazy var HeaderView : UIView = {
        let View = UIView()
        View.clipsToBounds = true
        View.backgroundColor = .white
        return View
    }()

    lazy var PlacesBackground1 : SineView = {
        let ImageView = SineView()
        ImageView.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EventsBackground1")
        return ImageView
    }()
    

    lazy var PlacesImage : ImageViewGradient = {
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
    if let image = PlacesImage.image {
    let imageInfo = GSImageInfo(image: image, imageMode: .aspectFit)
    let transitionInfo = GSTransitionInfo(fromView: PlacesImage)
    let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
    present(imageViewer, animated: true, completion: nil)
    }
    }
    
    lazy var PlacesBackground2 : SineView = {
        let ImageView = SineView()
        ImageView.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EventsBackground2")
        return ImageView
    }()
    
    lazy var SiaInsightsButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.titleLabel?.numberOfLines = 2
        Button.titleLabel?.textAlignment = .center
        Button.contentHorizontalAlignment = .center
        Button.setTitle("SIA\nINSIGHTS", for: .normal)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.titleLabel?.addInterlineSpacing(spacingValue: ControlY(1))
        Button.setBackgroundImage(UIImage(named: "SiaInsights"), for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(8))
        Button.addTarget(self, action: #selector(SiaInsightsAction), for: .touchUpInside)
        return Button
    }()
    
    @objc func SiaInsightsAction() {
        if DataPlaceDetails?.AllDetails?.insights == true {
            let SiaInsightsView = SiaInsightsViewVC()
            SiaInsightsView.transitioningDelegate = self
            SiaInsightsView.modalTransitionStyle = .crossDissolve
            SiaInsightsView.modalPresentationStyle = .overFullScreen
            SiaInsightsView.MessageTV.text = DataPlaceDetails?.AllDetails?.insightsContent ?? ""
            SiaInsightsView.MessageTV.addInterlineSpacing(spacingValue: ControlWidth(5))
            SiaInsightsView.MessageTV.ContentSize()
            present(SiaInsightsView, animated: true, completion: nil)
        }
    }
    
    let transition = CircularTransition()
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transtitonMode = .present
        transition.startingPoint = SiaInsightsButton.center
        transition.circleColor = UIColor.black
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transtitonMode = .dismiss
        transition.startingPoint = SiaInsightsButton.center
        transition.circleColor = UIColor.black
        return transition
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! PlacesDetailsCell
        cell.Place = DataPlaceDetails
        
        cell.Delegate = self
        cell.PlacesDetails = self
        cell.selectionStyle = .none
        cell.backgroundColor = .white
    
        if DataPlaceDetails?.AllDetails?.description?.TextHeight(cell.frame.width , font: UIFont.systemFont(ofSize: ControlWidth(16)), Spacing: ControlWidth(8)) ?? 0 > ControlWidth(50) {
        cell.LabelDetails.numberOfLines = ReadMore ? 0 : 3
        cell.ReadMore.isHidden = self.ReadMore ? true:false
        }else{
        cell.LabelDetails.numberOfLines = 3
        cell.ReadMore.isHidden = true
        }
        return cell
    }
    
    func ActionReadMore(_ Cell: PlacesDetailsCell) {
    if let indexPath = TableView.indexPath(for: Cell) {
    ReadMore = !ReadMore
    TableView.reloadRows(at: [indexPath], with: .automatic)
    }
    }
    
    func ActionReserve(_ Cell: PlacesDetailsCell) {
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
    
    func SimilarPlaces(_ id:Int) {
    let PlacesDetailsInstance = PlacesDetailsInstanceVC()
    PlacesDetailsInstance.PlaceInstanceId = id
    Present(ViewController: self, ToViewController: PlacesDetailsInstance)
    }
    
    func ShowsPlace(_ id:Int) {
    let ShowDetails = ShowDetailsVC()
    ShowDetails.ShowId = id
    Present(ViewController: self, ToViewController: ShowDetails)
    }
    
    
    let PopUp = ViewRatingDetails()
    func ActionAddReview(_ Cell: PlacesDetailsCell) {
    if HomeScreenData?.userData?.emailConfirmed == true && HomeScreenData?.userData?.email != nil {
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.endCardHeight = view.frame.height / 1.4
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.View.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    PopUp.radius = 15
    PopUp.Button.addTarget(self, action: #selector(ActionDone), for: .touchUpInside)
   
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
            
    let api = "\(url + GetReview)"
    let PlaceId = PlaceId ?? 0
    let token = defaults.string(forKey: "jwt") ?? ""
        
    let parameters:[String:Any] = ["PlaceId": PlaceId,
                                    "EventId":0]
            
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in
    self.ViewDots.endRefreshing {}
                
    self.PopUp.CommentTV.text = ModelGetReview(dictionary: dictionary).review?.comment ?? ""
    self.PopUp.ViewRating.RatingReading(Rating: Int(ModelGetReview(dictionary: dictionary).review?.rate ?? 1.0), animated: true)
    self.PopUp.LabelRate.text = ModelGetReview(dictionary: dictionary).screenData?.screenElements.filter({$0.id == 87}).first?.lable ?? "Rate"
    self.PopUp.LabelComment.text = ModelGetReview(dictionary: dictionary).screenData?.screenElements.filter({$0.id == 88}).first?.lable ?? "Comment"
    self.PopUp.Button.setTitle(ModelGetReview(dictionary: dictionary).screenData?.screenElements.filter({$0.id == 89}).first?.lable ?? "Done", for: .normal)
    self.PopUp.LabelTitle.text = ModelGetReview(dictionary: dictionary).screenData?.screenElements.filter({$0.id == 86}).first?.lable ?? "Write Your Reviewe"
            
    self.present(self.PopUp, animated: true)
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error) {}
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
        
    
    @objc func ActionDone() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }

    self.dismiss(animated: true)
    let api = "\(url + AddReview)"
    let PlaceId = PlaceId ?? 0
    let token = defaults.string(forKey: "jwt") ?? ""

    let parameters:[String:Any] = ["PlaceId": PlaceId,
                                    "EventId":0,
                                    "Rate": PopUp.ViewRating.rating,
                                    "Comment": PopUp.CommentTV.text ?? ""]
            
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { ـ in
    self.ViewDots.endRefreshing("Success add Review",.success,{})
    } dictionary: { ـ in
    } array: { ـ in
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error) {}
    }
    }
    
    func GetDataPlaceDetails() {
    self.view.subviews.forEach { View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetDataPlaceDetails()}
    return
    }

    let api = "\(url + GetPlaceDetails)"
    let PlaceId = PlaceId ?? 0
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["PlaceId": PlaceId]
                
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in

    self.SetData(PlaceDetails(dictionary: dictionary))
    } array: { _ in
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetDataPlaceDetails()
    }
    }
    }
    

    func SetData(_ Data: PlaceDetails)  {
        DataPlaceDetails = Data
        NameLabel.text = Data.AllDetails?.placeName ?? ""
        DetailsLabel.text = Data.AllDetails?.address ?? ""
        RatingButton.setTitle("\(Data.AllDetails?.rate ?? 1.0)", for: .normal)
        SiaInsightsButton.isHidden = Data.AllDetails?.insights == false ? true : false

        FavoritesButton.setImage(Data.AllDetails?.isFavorite ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
        PlacesImage.sd_setImage(with: URL(string: Data.AllDetails?.image ?? "")
                              , placeholderImage: UIImage(named: "Group 26056"))
        

        UIView.animate(withDuration: 0.5) {
        self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
        self.ViewNoData.isHidden = true
        ViewDots.endRefreshing() {}
        TableView.reloadData()
    }
    
}



class PlacesDetailsInstanceVC: PlacesDetailsVC {
    
    var PlaceInstanceId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaceId = PlaceInstanceId
        GetDataPlaceDetails()
    }
    
}
