//
//  TabBarController.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit

@available(iOS 9.0, *)
class TabBarController: UITabBarController, UITabBarControllerDelegate ,TabBarButtonDelegate {

    
   @IBInspectable var selectedTab : Int = 0 {
    didSet{
    selectedIndex = selectedTab
    }
    }
    
    private var buttons = [TabBarButton]()
    private var indexViewCenterXAnchor: NSLayoutConstraint!

    private let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.5525950789, green: 0.6337650418, blue: 0.7296361327, alpha: 1)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indexView: UIView = {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override var viewControllers: [UIViewController]? {
        didSet {
//            createButtonsStack(viewControllers!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupViewController()
        self.selectedIndex = selectedTab
        createButtonsStack(viewControllers!)
        addcoustmeTabBarView()

        autolayout()
        
        indexView.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        indexView.layer.shadowColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        indexView.layer.cornerRadius = ControlX(1.5)
        customTabBarView.layer.cornerRadius = ControlX(20)
        NotificationCenter.default.addObserver(self, selector: #selector(GetHomeRefresh), name: HomeVC.PostHomeRefresh , object: nil)
    }

    @objc func GetHomeRefresh() {
        createButtonsStack(viewControllers!)
    }
    
    fileprivate func setupViewController() {
    let Home = setupNavigationController(HomeVC(),HomeScreenData?.screenData?.Bar?.tab1 ?? "", "Home")

    let Categories = setupNavigationController(CategoriesVC(),HomeScreenData?.screenData?.Bar?.tab2 ?? "", "Categories")

    let Concierge = setupNavigationController(ConciergeVC(),HomeScreenData?.screenData?.Bar?.tab3 ?? "", "Concierge")
        
    let More = setupNavigationController(MoreVC(),HomeScreenData?.screenData?.Bar?.tab4 ?? "", "More")
        
    let Profile = setupNavigationController(ProfileVC(), HomeScreenData?.userData?.firstName?.capitalized ?? HomeScreenData?.screenData?.Bar?.tab5 ?? "Profile", "")

    viewControllers = [Home,Categories,Concierge,More,Profile]
    }
        

    fileprivate func setupNavigationController(_ viewController:UIViewController ,_ title:String ,_ Image:String ) -> UINavigationController {
    let ControllerNav = UINavigationController(rootViewController: viewController)
    ControllerNav.navigationBar.isHidden = true

    ControllerNav.tabBarItem.title = title
    ControllerNav.tabBarItem.image = UIImage(named: Image)
    return ControllerNav
    }
    
    private func createButtonsStack(_ viewControllers: [UIViewController]) {
        
        // clean :
        buttons.removeAll()
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for (index, viewController) in viewControllers.enumerated() {
           
            let button = TabBarButton()
            button.Delegate = self
            button.tag = index
            
            if index == 4 {
            button.Image.isHidden = true
            button.ProfileImage.isHidden = false
            button.ProfileImage.Image.sd_setImage(with: URL(string: HomeScreenData?.userData?.photo ?? ""), placeholderImage: UIImage(named: "Profile"))
            }else{
            button.Image.isHidden = false
            button.ProfileImage.isHidden = true
            button.Image.image = viewController.tabBarItem.image
            }
                
            button.Image.tintColor = index == 0 ? #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.Label.textColor = index == 0 ? #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.Label.text = viewController.tabBarItem.title
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        view.setNeedsLayout()
    }
    
    private func autolayout() {
        customTabBarView.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        customTabBarView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor,constant: ControlX(15)).isActive = true
        customTabBarView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor,constant: ControlX(-15)).isActive = true
        customTabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor,constant: ControlX(-15)).isActive = true
        stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: customTabBarView.heightAnchor).isActive = true
        indexView.heightAnchor.constraint(equalToConstant: ControlWidth(3)).isActive = true
        indexView.widthAnchor.constraint(equalToConstant: customTabBarView.bounds.height - ControlX(5)).isActive = true
        indexView.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor,constant: ControlX(-6)).isActive = true
        
        indexViewCenterXAnchor = indexView.centerXAnchor.constraint(equalTo: buttons[selectedTab].centerXAnchor)
        indexViewCenterXAnchor.isActive = true
    }
     
    private func addcoustmeTabBarView() {
        tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(70))
        customTabBarView.frame = CGRect(x: ControlX(15), y: ControlX(15), width: tabBar.frame.width - ControlX(20), height: ControlWidth(50))
        indexView.frame = CGRect(x: 0, y: customTabBarView.frame.maxY - ControlX(6), width: customTabBarView.bounds.height - ControlX(5), height: ControlWidth(3))
        
        view.bringSubviewToFront(self.tabBar)
        tabBar.addSubview(customTabBarView)
        customTabBarView.addSubview(indexView)
        customTabBarView.addSubview(stackView)
    }
    
    
    func TabBarTarget(_ Button: TabBarButton) {
        let index = Button.tag
        
        if index == 2 {
        ShowMessageAlert("SuccessIcon", "Start Your Chat", "Please contact us to reserve", false, {
         
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
            
        },"Start")

        }else if  index == 4 {
        ActionProfile()
        }else {
            
        if index == 2 && HomeScreenData?.userData?.email == nil {
        ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        Present(ViewController: self, ToViewController: MyAccountVC())
        },"Sign-Up")
        }else if index == 2 && HomeScreenData?.userData?.emailConfirmed == false {
        ShowMessageAlert("ErrorIcon", "Please Confirm your Email",
                                "If you not confirmed your account you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        self.ResendConfirmeation()
        },"Re-send")
        } else {
            
        self.selectedIndex = index
        self.selectedTab = index
            
        for (indx, button) in self.buttons.enumerated() {
            if indx != index {
            button.Image.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
            button.Image.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
            button.Label.textColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
            }
        }
            
        self.indexView.alpha = 0.5
        UIView.transition(from: view, to: view, duration: 0.2, options: [.transitionCrossDissolve,.showHideTransitionViews])
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.indexView.alpha = 1
            self.indexViewCenterXAnchor.isActive = false
            self.indexViewCenterXAnchor = nil
            self.indexViewCenterXAnchor = self.indexView.centerXAnchor.constraint(equalTo: self.buttons[index].centerXAnchor)
            self.indexViewCenterXAnchor.isActive = true
            self.tabBar.layoutIfNeeded()
        }, completion: nil)
        }
        }
    }
    
    func ResendConfirmeation() {
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
                
        let api = "\(url + ResendConfirmeationEmile)"
        let token = defaults.string(forKey: "jwt") ?? ""
                
        PostAPI(timeout: 60 ,api: api, token: token, parameters: [:]) { _ in
        ShowMessageAlert("SuccessIcon", "success", "Success Resend Confirmeation Emile", true, {})
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        ShowMessageAlert("ErrorIcon", "Error", error, true, {})
        }
    }
    
    @objc func ActionProfile() {
    if HomeScreenData?.userData?.email != nil {
    Present(ViewController: self, ToViewController:  ProfileVC())
    }else{
    ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
    Present(ViewController: self, ToViewController: MyAccountVC())
    },"Sign-Up")
    }
    }
    
    // Delegate:
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard
            let items = tabBar.items,
            let index = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
        TabBarTarget(self.buttons[index])
    }
    
    init() {
    super.init(nibName: nil, bundle: nil)
    object_setClass(self.tabBar, WeiTabBar.self)
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    
}


class WeiTabBar: UITabBar {
      override func sizeThatFits(_ size: CGSize) -> CGSize {
          var sizeThatFits = super.sizeThatFits(size)
          sizeThatFits.height = ControlWidth(80)
        
          self.clipsToBounds = false
          self.layer.masksToBounds = false
          self.backgroundColor = .clear
          self.shadowImage = UIImage()
          self.backgroundImage = UIImage()
          self.tintColor = .clear
          self.barTintColor = .clear
          self.unselectedItemTintColor = .clear
          return sizeThatFits
      }
  }


protocol TabBarButtonDelegate {
    func TabBarTarget(_ Button:TabBarButton)
}

class TabBarButton: UIButton {
 
    var Delegate : TabBarButtonDelegate?
    
    lazy var ProfileImage : ImageAddBorder = {
        let ImageView = ImageAddBorder()
        ImageView.isHidden = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(15)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectIndex)))
        ImageView.AddBorder(Color: #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), width: 1.5)
        return ImageView
    }()
    
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.isHidden = false
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectIndex)))
        return ImageView
    }()
    
    lazy var Label : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    Label.textAlignment = .center
    Label.isUserInteractionEnabled = true
    Label.font = UIFont(name: "Nexa-Regular", size: ControlWidth(10))
    Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectIndex)))
    return Label
   }()
    
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ProfileImage,Image,Label])
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.spacing = ControlX(1)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: ControlWidth(12)).isActive = true
        return Stack
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(Stack)
        Stack.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(2)).isActive = true
        Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-2)).isActive = true
        Stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(5)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-5)).isActive = true
        
        self.addTarget(self, action: #selector(didSelectIndex), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didSelectIndex() {
        Delegate?.TabBarTarget(self)
    }
    
}
