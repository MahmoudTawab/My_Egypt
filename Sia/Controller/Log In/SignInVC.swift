//
//  SignInVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 07/09/2022.
//

import UIKit
import FirebaseAuth

var HomeScreenData : HomeScreen?
class SignInVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp =  false
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(BackgroundImage)

    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: ControlX(20), y: 0, width: view.frame.width - ControlX(40), height:  view.frame.height)
    
    ViewScroll.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: 0, y: ControlY(40), width: ViewScroll.frame.width , height: ControlWidth(40))
    
    ViewScroll.addSubview(StackItems)
    StackItems.frame = CGRect(x: ControlX(20), y: ControlY(90), width: ViewScroll.frame.width - ControlX(40), height:  ViewScroll.frame.height - ControlY(120))
        
    BackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    BackgroundImage.topAnchor.constraint(equalTo: ForgotPassword.bottomAnchor).isActive = true
    BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
    ViewScroll.updateContentViewSize(0)
      
    SetDataSignIn()
    }
    
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconSize = CGSize(width: ControlWidth(25), height: ControlWidth(25))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var BackgroundImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "SignIn")
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()

    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return Label
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.TitleHidden = false
        tf.keyboardType = .emailAddress
        if #available(iOS 11.0, *) {tf.textContentType = .emailAddress} else {}
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        return tf
    }()
      
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.TitleHidden = false
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.Icon.tintColor = .black
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        if #available(iOS 11.0, *) {tf.textContentType = .password} else {}
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        return tf
    }()
    
    @objc func ActionPassword() {
        if PasswordTF.IconImage == UIImage(named: "visibility-1") {
            PasswordTF.isSecureTextEntry = false
            PasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTF.isSecureTextEntry = true
            PasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var ForgotPassword : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionForgotPasswor)))
        return Label
    }()
    
    @objc func ActionForgotPasswor() {
    Present(ViewController: self, ToViewController: ForgotPasswordVC())
    }
    
    lazy var StackForgot : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UIView(),ForgotPassword])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Stack
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
        if EmailTF.NoEmptyError() && PasswordTF.NoEmptyError() && PasswordTF.NoErrorPassword() && EmailTF.NoErrorEmail() {
        guard let email = EmailTF.text else {return}
        guard let password = PasswordTF.text else {return}
            
        ViewDots.beginRefreshing()
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
        if err != nil {
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Sorry, email or Password is not valid. Please try again", true, {})
        return
        }
                
        guard let uid = user?.user.uid else{return}
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
            
        let api = "\(url + SignIn)"
        let token = defaults.string(forKey: "jwt") ?? ""
        let parameters:[String:Any] = ["uid": uid]

        PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
        } dictionary: { dictionary in
        if HomeScreen(dictionary: dictionary).isUser == true {
        self.ViewDots.endRefreshing() {}
        HomeScreenData = HomeScreen(dictionary: dictionary)
        FirstController(TabBarController())
        }else{
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Sorry, email or Password is not valid. Please try again", true, {})
        }
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error, .error, {})
        }
        }
        }
    }
    
    lazy var SignUpLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSignUp)))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    
    @objc func ActionSignUp() {
    Present(ViewController: self, ToViewController: SignUpVC())
    }
    
    lazy var StackTop : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EmailTF,UIView(),UIView(),PasswordTF,UIView(),StackForgot])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
        return Stack
    }()
    
    lazy var StackBottom : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UIView(),Signin,SignUpLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        return Stack
    }()

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,StackTop,UIView(),UIView(),StackBottom])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    
    func SetDataSignIn() {
    self.view.subviews.forEach { View in View.alpha = 0}
    UIView.animate(withDuration: 0.4) {
    DataGetScreen(self, 2) { data in
    self.SetData(data)
    } _: { IsError in
    self.view.subviews.forEach { View in
    View.alpha = IsError ? 0:1
    self.ViewNoData.isHidden = IsError ? false:true
                    
    if IsError == true {
    self.SetUpIsError(true) {
    self.SetDataSignIn()
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
        
        let TopLabelString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 9}).first?.lable ?? "Sign In To Your Account", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(22)) ?? UIFont.systemFont(ofSize: ControlWidth(22)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        TopLabelString.append(NSAttributedString(string: " \n ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        TopLabelString.append(NSAttributedString(string: Data?.screenElements.filter({$0.id == 10}).first?.lable ?? "Enter your email address and your password", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ]))
        TopLabel.attributedText = TopLabelString
        

        // MARK: Setup SignUp String
        let SignUpString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 15}).first?.lable ?? "Don't have an account?", attributes: [
            .font: UIFont(name: "Nexa-Light", size: ControlWidth(17)) ?? UIFont.systemFont(ofSize: ControlWidth(17)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        SignUpString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        SignUpString.append(NSAttributedString(string: Data?.screenElements.filter({$0.id == 16}).first?.lable ?? "Sign Up", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(17)) ?? UIFont.systemFont(ofSize: ControlWidth(17)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]))
        SignUpLabel.attributedText = SignUpString
        
        
        EmailTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 11}).first?.lable ?? "Email", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])

        PasswordTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 12}).first?.lable ?? "Password", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
        let underlinedMessage = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 13}).first?.lable ??  "Forgot password?", attributes: [.foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
                                                        .font:UIFont(name: "Nexa-Bold", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
                                                        .underlineStyle:NSUnderlineStyle.single.rawValue])
        ForgotPassword.attributedText = underlinedMessage

        Signin.setTitle(Data?.screenElements.filter({$0.id == 14}).first?.lable ?? "Sign in", for: .normal)

        EmailTF.FirstId = 8
        EmailTF.SecondId = 9
        EmailTF.validationMessages = Data?.screenElements.filter({$0.id == 11}).first?.validationMessages ?? [ValidationMessages]()
        
        PasswordTF.FirstId = 14
        PasswordTF.SecondId = 11
        PasswordTF.validationMessages = Data?.screenElements.filter({$0.id == 12}).first?.validationMessages ?? [ValidationMessages]()
    }
    
}

