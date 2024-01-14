//
//  MyAccountVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 07/09/2022.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

class MyAccountVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUpItems()
        ShowWhatsUp =  false
        view.backgroundColor = .white
    }
    
   fileprivate func SetUpItems() {
       view.addSubview(BackgroundImage)

       view.addSubview(StackItems)
       StackItems.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       StackItems.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       StackItems.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.2).isActive = true
       StackItems.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1.6).isActive = true
       
       BackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
       BackgroundImage.topAnchor.constraint(equalTo: SignUp.bottomAnchor).isActive = true
       BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1.8).isActive = true
       
       SetMyAccountData()
    }
    
    lazy var BackgroundImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "BackgroundAccount")
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    

    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return Label
    }()
    
    lazy var Signin : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSignin), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSignin() {
    defaults.set("E", forKey: "signUpType")
    Present(ViewController: self, ToViewController: SignInVC())
    }

    lazy var SignUp : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.borderWidth = ControlWidth(2)
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()
    
    @objc func ActionSignUp() {
    defaults.set("E", forKey: "signUpType")
    Present(ViewController: self, ToViewController: SignUpVC())
    }
    
    lazy var ViewOR : UIStackView = {
        let View = UIStackView(arrangedSubviews: [ViewLine1,LabelOR,ViewLine2])
        View.axis = .horizontal
        View.alignment = .center
        View.backgroundColor = .clear
        View.distribution = .equalSpacing
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        View.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.arrangedSubviews[0].widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: 1/2.5).isActive = true
        View.arrangedSubviews[2].widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: 1/2.5).isActive = true
        return View
    }()
    
    lazy var ViewLine1 : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.layer.cornerRadius = ControlWidth(0.7)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(1.4)).isActive = true
        return View
    }()

    lazy var LabelOR : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var ViewLine2 : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.layer.cornerRadius = ControlWidth(0.7)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(1.4)).isActive = true
        return View
    }()
    
    lazy var Google : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.clipsToBounds = true
        Button.titleEdgeInsets.bottom = -2
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.setImage(UIImage(named: "Google"), for: .normal)
        Button.addTarget(self, action: #selector(ActionGoogle), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular", size: ControlWidth(15))
        return Button
    }()
    
    @objc func ActionGoogle() {
        SignInGoogle()
    }

    lazy var Facebook : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.1952412724, green: 0.5290824175, blue: 0.9440533519, alpha: 1)
        Button.tintColor = .white
        Button.clipsToBounds = true
        Button.titleEdgeInsets.bottom = -4
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.setImage(UIImage(named: "Facebook"), for: .normal)
        Button.addTarget(self, action: #selector(ActionFacebook), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular", size: ControlWidth(15))
        return Button
    }()
    
    @objc func ActionFacebook() {
        SignFacebook()
    }
    
    lazy var StackSocialMedia : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Facebook,Google])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Stack
    }()
    
    lazy var DoItLater : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDoItLater)))
        return Label
    }()
    
    
    let PopUp = PopUpGuest()
    @objc func ActionDoItLater() {
    PopUp.currentState = .open
    PopUp.modalPresentationStyle = .overFullScreen
    PopUp.modalTransitionStyle = .coverVertical
    PopUp.endCardHeight = ControlWidth(360)
    PopUp.radius = 25
    PopUp.ContinueButton.addTarget(self, action: #selector(ContinuePopUp), for: .touchUpInside)
    PopUp.CancelButton.addTarget(self, action: #selector(CancelPopUp), for: .touchUpInside)
    present(PopUp, animated: true)
    }

   @objc func CancelPopUp() {
    PopUp.DismissAction()
   }
    
    @objc func ContinuePopUp() {
        if HomeScreenData?.refreshToken == "" && HomeScreenData?.isUser == false {
            AsGuest()
        }else{
            defaults.removeObject(forKey: "refreshToken")
            AddDevice()
        }
    }
    
    func AsGuest() {
    self.PopUp.DismissAction()
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
                    
    let api = "\(url + GetHomeScreen)"
    let token = defaults.string(forKey: "jwt") ?? ""
                
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: [:]) { _ in
    } dictionary: { dictionary in
    HomeScreenData = HomeScreen(dictionary: dictionary)
    self.ViewDots.endRefreshing() {
    FirstController(TabBarController())
    }
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
    
    
    @objc func AddDevice() {
    self.PopUp.DismissAction()
    let url = defaults.string(forKey: "API") == "" ? "https://siaapi01.azurewebsites.net/api/" : defaults.string(forKey: "API") ?? "https://siaapi01.azurewebsites.net/api/"
    let api = "\(url + SplashScreen)"

    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken") ?? ""
        
    let UUID = UUID().uuidString
    defaults.set(UUID, forKey: "uuidString")
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? UUID
    let RefreshToken = defaults.string(forKey: "refreshToken") ?? ""
        
    let parameters:[String:Any] = ["token": "g0Ru1T8Q8gFElqFQLRxBHxU2FbRfZLoNCx6pPOnCtwwzRs0zw9",
                                "fireToken": fireToken,
                                "deviceID": udid,
                                "deviceModel": modelName,
                                "manuFacturer": "Iphone",
                                "osVersion": version,
                                "versionCode": "1",
                                "RefreshToken":RefreshToken]
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 20,api: api, token: nil, parameters: parameters) { _ in
    } dictionary: { dictionary in
    HomeScreenData = HomeScreen(dictionary: dictionary)
    self.ViewDots.endRefreshing() {
    FirstController(TabBarController())
    }
    } array: { _ in
    } Err: { error in
    defaults.removeObject(forKey: "refreshToken")
    self.perform(#selector(self.AddDevice), with: self, afterDelay: 1)
    }
    }
    
    lazy var ActivateMySIM : UILabel = {
        let Label = UILabel()
        Label.isHidden = true
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionActivateMySIM)))
        return Label
    }()
    
    @objc func ActionActivateMySIM() {
        
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,Signin,SignUp,ViewOR,StackSocialMedia,UIView(),DoItLater,ActivateMySIM])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    func SetMyAccountData() {
        self.view.subviews.forEach { View in View.alpha = 0}
        UIView.animate(withDuration: 0.4) {
        DataGetScreen(self, 1) { data in
        self.SetData(data)
        } _: { IsError in
        self.view.subviews.forEach { View in
        View.alpha = IsError ? 0:1
        self.ViewNoData.isHidden = IsError ? false:true
                    
        if IsError == true {
        self.SetUpIsError(true) {
        self.SetMyAccountData()
        }
        }
        }
        }
        }
    }
    
    func SetData(_ Data:ScreenData?) {
                
        // MARK: Setup TopLabel String
    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlWidth(15)
    style.alignment = .center
        
    let TopLabelString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 1}).first?.lable ?? "Welcome to", attributes: [
        .font: UIFont(name: "Nexa-XBold", size: ControlWidth(28)) ?? UIFont.systemFont(ofSize: ControlWidth(28)),
        .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
        .paragraphStyle:style
    ])
        
    TopLabelString.append(NSAttributedString(string: "  ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:style
    ]))
        
    if let Image = UIImage(named: "Group 57485")?.toAttributedString(with: ControlWidth(26), tint: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1)) {
    TopLabelString.append(Image)
    }
        
    TopLabelString.append(NSAttributedString(string: " \n ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:style
    ]))
        
    TopLabelString.append(NSAttributedString(string: Data?.screenElements.filter({$0.id == 2}).first?.lable ??
                                                        "Sign in to your account or create a new one", attributes: [
        .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style
    ]))
    TopLabel.attributedText = TopLabelString
         
        // MARK: Setup MySIM String
    let MySIMString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 8}).first?.lable ?? "Activate my SIM", attributes: [
        .font: UIFont(name: "Nexa-Bold", size: ControlWidth(17)) ?? UIFont.systemFont(ofSize: ControlWidth(17)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    ActivateMySIM.attributedText = MySIMString
       
       // MARK: Setup DoItLater String
    let DoItLaterString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 76}).first?.lable ?? "Activate my SIM", attributes: [
        .font: UIFont(name: "Nexa-Bold", size: ControlWidth(17)) ?? UIFont.systemFont(ofSize: ControlWidth(17)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    DoItLater.attributedText = DoItLaterString
        
    LabelOR.text = Data?.screenElements.filter({$0.id == 5}).first?.lable ?? "Or"

    Signin.setTitle(Data?.screenElements.filter({$0.id == 3}).first?.lable ?? "Sign in", for: .normal)

    SignUp.setTitle(Data?.screenElements.filter({$0.id == 4}).first?.lable ?? "Sign up", for: .normal)
    
    Google.setTitle( "  " + (Data?.screenElements.filter({$0.id == 7}).first?.lable ?? "Google") +  "  ", for: .normal)
    
    Facebook.setTitle("  " + (Data?.screenElements.filter({$0.id == 6}).first?.lable ?? "Facebook") +  "  ", for: .normal)
        
        
    PopUp.TitleLabel.text = Data?.screenElements.filter({$0.id == 174}).first?.lable ?? "AS Guest"
        
    PopUp.DetailsLabel.text = Data?.screenElements.filter({$0.id == 175}).first?.lable ??
        "…you won’t be able to leave comments, rate, favorite or even reserve places and events. Are you sure that you want to continue without registration?"
    PopUp.DetailsLabel.addInterlineSpacing(spacingValue: ControlWidth(4))
        
    PopUp.ContinueButton.setTitle(Data?.screenElements.filter({$0.id == 176}).first?.lable ?? "Yes, Continue", for: .normal)
        
    PopUp.CancelButton.setTitle(Data?.screenElements.filter({$0.id == 177}).first?.lable ?? "Cancel", for: .normal)
    }
    
    func LoginSocial(_ uid:String ,_ Social:String ,_ email:String ,_ phone:String ,_ ProfileUrl:URL? ,_ lastName:String ,_ firstName:String) {
        
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
        
    let api = "\(url + SignIn)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["uid": uid]

    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in
    self.ViewDots.endRefreshing {}

    if HomeScreen(dictionary: dictionary).isUser == false {
    let SignUp = SignUpVC()
    SignUp.uid = uid
    SignUp.EmailTF.text = email
    SignUp.PhoneNumberTF.text = phone
    SignUp.LastNameTF.text = lastName
    SignUp.FirstNameTF.text = firstName
    defaults.set(Social, forKey: "signUpType")
    SignUp.isValidNumber = true
    Present(ViewController: self, ToViewController: SignUp)
    }else{
    FirstController(TabBarController())
    }

    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
    
}


// Sign in Google
extension MyAccountVC {
    func SignInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in

        if error != nil {
        return
        }
            
        guard let accessToken = user?.user.accessToken.tokenString , let idToken = user?.user.idToken?.tokenString
        else {
        return
        }

        guard let User = user?.user.profile else { return }
        let emailAddress = User.email
        let givenName = User.givenName ?? ""
        let familyName = User.familyName ?? ""
        let profilePicUrl = User.imageURL(withDimension: 320)
    //  let fullName = user.name

            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
        Auth.auth().signIn(with: credential) { authResult, error in
        self.ViewDots.beginRefreshing()
            
        if let error = error {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        guard let uid = authResult?.user.uid else { return }
        self.LoginSocial(uid, "G", emailAddress ,"" , profilePicUrl , familyName, givenName)
        }
        }
    }
}
// Sign in Facebook
extension MyAccountVC {
    func SignFacebook() {
        LoginManager().logIn(permissions: ["email"], from: self) { (result,err) in
        if let error = err {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }


        if result?.isCancelled == true {return}
        guard let accessToken = AccessToken.current else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

        Auth.auth().signIn(with: credential) { authResult, error in
        if let error = error {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        self.ViewDots.beginRefreshing()
        GraphRequest(graphPath: "/me", parameters: ["fields": "email, first_name, last_name, name, picture.width(480).height(480)"]).start { (connection,result,err) in
        if let Error = err {
        self.ViewDots.endRefreshing(Error.localizedDescription, .error) {}
        return
        }

        if let data = result as? NSDictionary {
        guard let uid = authResult?.user.uid else { return }
        let firstName  = data.object(forKey: "first_name") as? String ?? ""
        let lastName  = data.object(forKey: "last_name") as? String ?? ""
        let email = data.object(forKey: "email") as? String ?? ""

        let profilePictureObj = data.object(forKey: "picture") as? NSDictionary
        let data = profilePictureObj?.value(forKey: "data") as? NSDictionary
        let pictureUrlString = data?.value(forKey: "url") as? String
        let pictureUrl = URL(string: pictureUrlString ?? "")

        self.LoginSocial(uid, "F", email ,"" ,pictureUrl , lastName, firstName)
      }
      }
      }
      }
    }
}

