//
//  HomeVC.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit
import SDWebImage

class HomeVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
   }
    
    fileprivate func SetUpItems() {

    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ControlY(30), width: view.frame.width , height: view.frame.height - ControlY(30))
        
    ViewScroll.addSubview(TopViewStack)
    TopViewStack.frame = CGRect(x: ControlX(15), y: 0, width: view.frame.width - ControlX(30), height: ControlWidth(40))
    
    ViewScroll.addSubview(CollectionCategories)
    CollectionCategories.frame = CGRect(x: 0, y: TopViewStack.frame.maxY + ControlY(10), width: view.frame.width , height: ControlWidth(120))
        
    ViewScroll.addSubview(CategoriesLine)
    CategoriesLine.frame = CGRect(x: 0, y: CollectionCategories.frame.maxY + ControlY(1), width: view.frame.width , height: ControlWidth(0.4))
                
    ViewScroll.addSubview(HappeningNowBackground1)
    ViewScroll.addSubview(HappeningNowBackground)
    ViewScroll.addSubview(StackHappeningNow)
    ViewScroll.addSubview(HappeningNowBackground2)
    ViewScroll.addSubview(UpcomingEventsBackground1)
    ViewScroll.addSubview(UpcomingEventsBackground)
    ViewScroll.addSubview(StackUpcomingEvents)
    ViewScroll.addSubview(UpcomingEventsBackground2)

    HappeningNowBackground1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    HappeningNowBackground1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    HappeningNowBackground1.heightAnchor.constraint(equalToConstant: ControlWidth(600)).isActive = true
    HappeningNowBackground1.topAnchor.constraint(equalTo: CollectionCategories.bottomAnchor,constant: ControlY(-10)).isActive = true
        
    HappeningNowBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    HappeningNowBackground.heightAnchor.constraint(equalToConstant: ControlWidth(570)).isActive = true
    HappeningNowBackground.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 1/1.1).isActive = true
    HappeningNowBackground.bottomAnchor.constraint(equalTo: HappeningNowBackground1.bottomAnchor).isActive = true
    HappeningNowBackground.layer.cornerRadius = view.frame.width / 2.2
        
    HappeningNowBackground2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    HappeningNowBackground2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    HappeningNowBackground2.heightAnchor.constraint(equalToConstant: ControlWidth(600)).isActive = true
    HappeningNowBackground2.topAnchor.constraint(equalTo: CollectionCategories.bottomAnchor,constant: ControlY(-10)).isActive = true
        
    StackHappeningNow.heightAnchor.constraint(equalToConstant: ControlWidth(440)).isActive = true
    StackHappeningNow.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(65)).isActive = true
    StackHappeningNow.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-35)).isActive = true
    StackHappeningNow.topAnchor.constraint(equalTo: HappeningNowBackground1.topAnchor,constant: ControlY(45)).isActive = true
        
        ///
        
    ViewScroll.addSubview(NotificationBackground)
    NotificationBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    NotificationBackground.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.1).isActive = true
    NotificationBackground.heightAnchor.constraint(equalToConstant: ControlWidth(250)).isActive = true
    NotificationBackground.centerYAnchor.constraint(equalTo: HappeningNowBackground1.bottomAnchor,constant: ControlY(50)).isActive = true
        
    ViewScroll.addSubview(NotificationsView)
    NotificationsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    NotificationsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    NotificationsView.centerYAnchor.constraint(equalTo: NotificationBackground.centerYAnchor).isActive = true
    NotificationsView.heightAnchor.constraint(equalTo: NotificationBackground.heightAnchor, multiplier: 1/2).isActive = true
        
    NotificationBackground.addSubview(NotificationsLabel)
    NotificationsLabel.topAnchor.constraint(equalTo: NotificationsView.bottomAnchor).isActive = true
    NotificationsLabel.heightAnchor.constraint(equalTo: NotificationsView.heightAnchor, multiplier: 1/3).isActive = true
    NotificationsLabel.widthAnchor.constraint(equalTo: NotificationBackground.widthAnchor).isActive = true
    NotificationsLabel.centerXAnchor.constraint(equalTo: NotificationBackground.centerXAnchor).isActive = true
        
        ///
        
    UpcomingEventsBackground1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    UpcomingEventsBackground1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    UpcomingEventsBackground1.heightAnchor.constraint(equalTo: HappeningNowBackground1.heightAnchor).isActive = true
    UpcomingEventsBackground1.topAnchor.constraint(equalTo: NotificationBackground.centerYAnchor,constant: ControlY(50)).isActive = true
        
    UpcomingEventsBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    UpcomingEventsBackground.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-15)).isActive = true
    UpcomingEventsBackground.heightAnchor.constraint(equalTo: UpcomingEventsBackground1.heightAnchor,multiplier: 1/1.2).isActive = true
    UpcomingEventsBackground.centerYAnchor.constraint(equalTo: UpcomingEventsBackground1.centerYAnchor,constant: ControlY(30)).isActive = true
    UpcomingEventsBackground.layer.cornerRadius = view.frame.width / 2.5

    UpcomingEventsBackground2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    UpcomingEventsBackground2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    UpcomingEventsBackground2.heightAnchor.constraint(equalTo: HappeningNowBackground1.heightAnchor).isActive = true
    UpcomingEventsBackground2.topAnchor.constraint(equalTo: NotificationBackground.centerYAnchor,constant: ControlY(50)).isActive = true
        
    StackUpcomingEvents.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(30)).isActive = true
    StackUpcomingEvents.rightAnchor.constraint(equalTo: view.rightAnchor,constant: ControlX(-45)).isActive = true
    StackUpcomingEvents.heightAnchor.constraint(equalTo: UpcomingEventsBackground.heightAnchor, multiplier: 1/1.5).isActive = true
    StackUpcomingEvents.centerYAnchor.constraint(equalTo: UpcomingEventsBackground.centerYAnchor,constant: ControlX(20)).isActive = true

    GetMain(Refresh: false)
    ViewScroll.updateContentViewSize(ControlX(20))
        
    AddRefreshControl(Scroll: ViewScroll, color: #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)) {
    self.GetMain(Refresh: true)
    }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CollectionHappeningToday.layer.cornerRadius = CollectionHappeningToday.frame.width / 2
    }
        
    lazy var LogoImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        ImageView.image = UIImage(named: "Group 57485")?.withInset(UIEdgeInsets(top: 1.5, left: 1.5, bottom: 1.5, right: 1.5))
        return ImageView
    }()
    
    lazy var SearchButton : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .black
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(32)).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSearch)))
        ImageView.image = UIImage(named: "Search")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        return ImageView
    }()
    
    
    @objc func ActionSearch() {
    Present(ViewController: self, ToViewController: SearchResaultVC())
    }
    
    lazy var SearchLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(11))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(12)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSearch)))
        return Label
    }()
    
    lazy var SearchStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SearchButton,SearchLabel])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.isUserInteractionEnabled = true
        Stack.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSearch)))
        return Stack
    }()
    
    var ShoppingHub: BadgeHub?
    lazy var NotificationButton: UIImageView = {
        let ImageView = UIImageView()
        ShoppingHub = BadgeHub(view: ImageView)
        ShoppingHub?.setCircleAtFrame(CGRect(x: 0, y: 0, width: ControlWidth(15), height: ControlWidth(15)))
        ShoppingHub?.moveCircleBy(x: ControlWidth(20), y: ControlWidth(1))
        ShoppingHub?.setCircleColor(#colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1), label: UIColor.black)
        ShoppingHub?.bump()
            
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(32)).isActive = true
        ImageView.image = UIImage(named: "Notification")?.withInset(UIEdgeInsets(top: 1.5, left: 1.5, bottom: 1.5, right: 1.5))
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionNotification)))
        return ImageView
    }()
    
    @objc func ActionNotification() {
    Present(ViewController: self, ToViewController: NotificationVC())
    }
    
    lazy var NotificationLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(11))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(12)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionNotification)))
        return Label
    }()
    
    lazy var NotificationStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NotificationButton,NotificationLabel])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.isUserInteractionEnabled = true
        Stack.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionNotification)))
        return Stack
    }()
    
        
    lazy var FavoritesImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .black
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "Favorites")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(32)).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionFavorites)))
        return ImageView
    }()
    
    
    @objc func ActionFavorites() {
    if HomeScreenData?.userData?.email != nil || HomeScreenData?.userData?.emailConfirmed == false {
    Present(ViewController: self, ToViewController:  FavoritesVC())
    }else{
    ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
    Present(ViewController: self, ToViewController: MyAccountVC())
    },"Sign-Up")
    }
    }
    

    lazy var FavoritesLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(11))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(12)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionFavorites)))
        return Label
    }()
    
    lazy var FavoritesImageStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FavoritesImage,FavoritesLabel])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.isUserInteractionEnabled = true
        Stack.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionFavorites)))
        return Stack
    }()
    
    lazy var TopViewStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LogoImage,SearchStack,FavoritesImageStack,NotificationStack])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .white
        Stack.distribution = .equalSpacing
        return Stack
    }()

    
    // MARK: Set up Scroll View
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.clipsToBounds = true
        Scroll.backgroundColor = .white
        return Scroll
    }()
    
    // MARK: Set up top Collection Categories
    var CategoriesID = "Categories"
    var DataCategories = [Categories]()
    lazy var CollectionCategories: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.register(HomeCategories.self, forCellWithReuseIdentifier: CategoriesID)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlWidth(20), bottom: 0, right: ControlWidth(20))
        return vc
    }()
    
    
    lazy var CategoriesLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return View
    }()
        
    // MARK: Set up Happening Now
    lazy var HappeningNowLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Label
    }()
    
    var HappeningNowID = "HappeningNow"
    var happeningToday = [HappeningToday]()
    lazy var CollectionHappeningToday: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = #colorLiteral(red: 0.9783384204, green: 0.8178021312, blue: 0.4856868386, alpha: 1)
        vc.delegate = self
        vc.dataSource = self
        vc.clipsToBounds = true
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(HappeningNowCell.self, forCellWithReuseIdentifier: HappeningNowID)
        return vc
    }()

    lazy var HappeningNowBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "HappeningNowBackground1")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    
    lazy var HappeningNowBackground : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var HappeningNowBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "HappeningNowBackground2")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var StackHappeningNow : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [CollectionHappeningToday,HappeningNowLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.arrangedSubviews[0].heightAnchor.constraint(equalTo: Stack.heightAnchor, constant: ControlWidth(-60)).isActive = true
        return Stack
    }()
    
    
    // MARK: Set up Notifications View
    lazy var NotificationBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "NotificationBackground")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    
    lazy var NotificationImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    lazy var NotificationsDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        return Label
    }()

    
    lazy var NotificationsView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UIView(),NotificationImage,NotificationsDetails,UIView()])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.7583009601, green: 0.3631356359, blue: 0.1871258616, alpha: 1)
        Stack.spacing = ControlX(5)
        Stack.distribution = .equalSpacing
        Stack.layer.cornerRadius = ControlWidth(14)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.arrangedSubviews[1].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/4).isActive = true
        Stack.arrangedSubviews[2].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/2).isActive = true
        return Stack
    }()

    lazy var NotificationsLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(20))
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    // MARK: Set up Upcoming Events
    lazy var UpcomingEventsLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Label
    }()

    var UpcomingEventsID = "UpcomingEvents"
    var DataUpcomingEvents = [UpcomingEvents]()
    lazy var CollectionUpcomingEvents: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = #colorLiteral(red: 0.5525950789, green: 0.6337650418, blue: 0.7296361327, alpha: 1)
        vc.dataSource = self
        vc.delegate = self
        vc.clipsToBounds = true
        vc.layer.cornerRadius = ControlWidth(25)
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(UpcomingEventsCell.self, forCellWithReuseIdentifier: UpcomingEventsID)
        return vc
    }()

    lazy var StackUpcomingEvents : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UpcomingEventsLabel,CollectionUpcomingEvents])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.arrangedSubviews[1].heightAnchor.constraint(equalTo: Stack.heightAnchor, constant: ControlWidth(-60)).isActive = true
        return Stack
    }()
    
    lazy var UpcomingEventsBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "BackgroundUpcomingEvents1")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var UpcomingEventsBackground : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.490449965, green: 0.5659613609, blue: 0.65646106, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var UpcomingEventsBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "BackgroundUpcomingEvents2")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    static let PostHomeRefresh = NSNotification.Name(rawValue: "HomeRefresh")
    func GetMain(Refresh: Bool) {
    if HomeScreenData == nil || Refresh {
    self.view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetMain(Refresh: true)}
    return
    }
            
    let api = "\(url + GetHomeScreen)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: [:]) { _ in
    } dictionary: { dictionary in
    self.PagePlaces = 0
    self.PageEvents = 0
    UIView.animate(withDuration: 0.5) {
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing() {}

        
    HomeScreenData = HomeScreen(dictionary: dictionary)
    self.SetHomeData(HomeScreen(dictionary: dictionary))
    self.tabBarController?.reloadInputViews()
        
    NotificationCenter.default.post(name: HomeVC.PostHomeRefresh, object: nil)
    } array: { _ in
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetMain(Refresh: true)
    }
    }
    }else{
    if let HomeData = HomeScreenData {
    self.SetHomeData(HomeData)
    }else{
    GetMain(Refresh: true)
    }
    }
    }
    
    
    func SetHomeData(_ Data:HomeScreen) {
    ShoppingHub?.setCount(Data.userData?.notificationsCount ?? 0)

    DataCategories = Data.categories.sorted(by: {$0.id ?? 1 < $1.id ?? 2})
    CollectionCategories.reloadData()
        
    // SetUp happening Today
    happeningToday = Data.happeningToday
    CollectionHappeningToday.reloadData()
        
    let Style = NSMutableParagraphStyle()
    Style.lineSpacing = ControlWidth(2)
    Style.alignment = .center
        
    let HappeningNowString = NSMutableAttributedString(string: Data.screenData?.screenElements.filter({$0.id == 66}).first?.lable ?? "Happening Today!", attributes: [
        .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
        .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
        .paragraphStyle:Style
    ])

    HappeningNowString.append(NSAttributedString(string: " \n ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:Style
    ]))
        
    HappeningNowString.append(NSAttributedString(string: Data.screenData?.screenElements.filter({$0.id == 67}).first?.lable ??  "Swipe for more", attributes: [
        .font: UIFont(name: "Nexa-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
        .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
        .paragraphStyle:Style
    ]))
        
    HappeningNowLabel.attributedText = HappeningNowString
        
    // SetUp notification
    NotificationsDetails.textAlignment =  Data.notification == nil ? .center : .justified
    NotificationsDetails.text = Data.notification?.notificationMessage ?? Data.screenData?.screenElements.filter({$0.id == 195}).first?.lable ?? ""
    NotificationsDetails.addInterlineSpacing(spacingValue: ControlY(4))
    NotificationsLabel.text = Data.screenData?.screenElements.filter({$0.id == 68}).first?.lable ?? "Notifications"
    NotificationImage.sd_setImage(with: URL(string: Data.notification?.icon ?? ""), placeholderImage: UIImage(named: "NotificationImage"))
     
        
    // SetUp Upcoming Events
    DataUpcomingEvents = Data.upcomingEvents
    CollectionUpcomingEvents.reloadData()
        
    let UpcomingEventsString = NSMutableAttributedString(string: Data.screenData?.screenElements.filter({$0.id == 69}).first?.lable ?? "Upcoming Events", attributes: [
        .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
        .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
        .paragraphStyle:Style
    ])

    UpcomingEventsString.append(NSAttributedString(string: " \n ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:Style
    ]))
        
    UpcomingEventsString.append(NSAttributedString(string: Data.screenData?.screenElements.filter({$0.id == 71}).first?.lable ?? "Swipe for more", attributes: [
        .font: UIFont(name: "Nexa-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
        .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
        .paragraphStyle:Style
    ]))
        
    UpcomingEventsLabel.attributedText = UpcomingEventsString
     
    SearchLabel.text = Data.screenData?.screenElements.filter({$0.id == 172}).first?.lable ?? "Search"
    FavoritesLabel.text = Data.screenData?.screenElements.filter({$0.id == 189}).first?.lable ?? "Favorites"
    NotificationLabel.text = Data.screenData?.screenElements.filter({$0.id == 173}).first?.lable ?? "Notification"
    }
    
    
    ///
    
    var PagePlaces = 0
    var FetchingMorePlaces = false
    @objc func DataMorPlaces() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }

    let api = "\(url + GetMorPlaces)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["Page":PagePlaces]
        
    FetchingMorePlaces = true
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { _ in
    } array: { array in
    self.ViewDots.endRefreshing(){}
    for item in array {
    self.happeningToday.append(HappeningToday(dictionary: item))
    self.CollectionHappeningToday.reloadData()
    }
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error){}
    }
    }
    
    
    var PageEvents = 0
    var FetchingMoreEvents = false
    @objc func DataMorEvents() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }

    let api = "\(url + GetMorEvents)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["Page":PageEvents]
        
    FetchingMoreEvents = true
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { _ in
    } array: { array in
    self.ViewDots.endRefreshing(){}
    for item in array {
    self.DataUpcomingEvents.append(UpcomingEvents(dictionary: item))
    self.CollectionUpcomingEvents.reloadData()
    }
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error){}
    }
    }
    
}


extension HomeVC : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout ,HomeCategoriesDelegate ,UpcomingEventsDelegate ,HappeningNowDelegate {
            
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case CollectionCategories:
            return DataCategories.count
          
        case CollectionHappeningToday:
            return happeningToday.count
            
        case CollectionUpcomingEvents:
            return DataUpcomingEvents.count
        
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case CollectionCategories:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesID, for: indexPath) as! HomeCategories
        cell.Delegate = self
        cell.Label.numberOfLines = 2
        cell.Label.textColor = .black
        cell.backgroundColor = .clear
        cell.Label.text = DataCategories[indexPath.item].categoryName
        cell.Image.sd_setImage(with: URL(string: DataCategories[indexPath.item].photo ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
        return cell
        
        case CollectionHappeningToday:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HappeningNowID, for: indexPath) as! HappeningNowCell
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.TitleLabel.text = happeningToday[indexPath.item].placeName
        cell.NameLabel.text = happeningToday[indexPath.item].address
        cell.DateLabel.text = happeningToday[indexPath.item].from?.Formatter(Format: "HH:mm:ss").Formatter("HH:mm a")
        cell.ImageView.sd_setImage(with: URL(string: happeningToday[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
        return cell
            
        case CollectionUpcomingEvents:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventsID, for: indexPath) as! UpcomingEventsCell
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.ImageView.layer.cornerRadius = ControlWidth(25)
        cell.EventTypeLabel.text = DataUpcomingEvents[indexPath.item].eventName
        cell.GovernorateLabel.text = DataUpcomingEvents[indexPath.item].address
        cell.ImageView.sd_setImage(with: URL(string: DataUpcomingEvents[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            
        return cell
            
        default:
        return UICollectionViewCell()
        }
    }
    
    
    func UpcomingEventsAction(_ Cell:UpcomingEventsCell) {
        if let indexPath = CollectionUpcomingEvents.indexPath(for: Cell) {
        if DataUpcomingEvents[indexPath.item].placeId == nil {
            let DetailsVC = EventsDetailsVC()
            DetailsVC.EventId = DataUpcomingEvents[indexPath.item].eventId ?? 0
            DetailsVC.GetDataEventDetails()
            Present(ViewController: self, ToViewController: DetailsVC)
        }else{
            let DetailsVC = PlacesDetailsVC()
            DetailsVC.PlaceId = DataUpcomingEvents[indexPath.item].placeId ?? 0
            DetailsVC.GetDataPlaceDetails()
            Present(ViewController: self, ToViewController: DetailsVC)
        }
        }
    }
    
    func HomeCategoriesAction(_ Cell:HomeCategories) {
        if let indexPath = CollectionCategories.indexPath(for: Cell) {
        let DetailsVC = CategoriesDetailsVC()
        DetailsVC.CategoryId = DataCategories[indexPath.item].id
        DetailsVC.ViewDismiss.TextLabel = DataCategories[indexPath.item].categoryName ?? ""
        Present(ViewController: self, ToViewController: DetailsVC)
        }
    }
    
    func HappeningNowAction(_ Cell: HappeningNowCell) {        
        if let indexPath = CollectionHappeningToday.indexPath(for: Cell) {
        if happeningToday[indexPath.item].placeId == nil {
            let DetailsVC = EventsDetailsVC()
            DetailsVC.EventId = happeningToday[indexPath.item].eventId ?? 0
            DetailsVC.GetDataEventDetails()
            Present(ViewController: self, ToViewController: DetailsVC)
        }else{
            let DetailsVC = PlacesDetailsVC()
            DetailsVC.PlaceId = happeningToday[indexPath.item].placeId ?? 0
            DetailsVC.GetDataPlaceDetails()
            Present(ViewController: self, ToViewController: DetailsVC)
        }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case CollectionCategories:
        return CGSize(width: ControlWidth(94), height: ControlWidth(120))
            
        case CollectionHappeningToday:
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
            
        case CollectionUpcomingEvents:
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
                    
        default:
        return .zero
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    cell.alpha = 0
    UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
    cell.alpha = 1
    }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == CollectionHappeningToday {
        let contentOffsetX = CollectionHappeningToday.contentOffset.x
        if contentOffsetX >= (CollectionHappeningToday.contentSize.width - CollectionHappeningToday.bounds.width) - ControlX(20) {
        guard !self.FetchingMorePlaces else { return }
        self.FetchingMorePlaces = true
        self.PagePlaces += 1
        self.DataMorPlaces()
        }
        }else if scrollView == CollectionUpcomingEvents {
        let contentOffsetX = CollectionUpcomingEvents.contentOffset.x
        if contentOffsetX >= (CollectionUpcomingEvents.contentSize.width - CollectionUpcomingEvents.bounds.width) - ControlX(20) {
        guard !self.FetchingMoreEvents else { return }
        self.FetchingMoreEvents = true
        self.PageEvents += 1
        self.DataMorEvents()
        }
        }
    }
    

}

