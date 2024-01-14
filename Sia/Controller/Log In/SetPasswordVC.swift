//
//  SetPasswordVC.swift
//  Sia
//
//  Created by Emojiios on 17/10/2022.
//

import UIKit
import Firebase

class SetPasswordVC: ViewController {
    
    var SignUp : SignUpVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp =  false
        view.backgroundColor = .white
    }
    
    
  fileprivate func SetUpItems() {
      view.addSubview(BackgroundImage)

      view.addSubview(ViewScroll)
      ViewScroll.frame = CGRect(x: ControlX(20), y: 0, width: view.frame.width - ControlX(40), height:  view.frame.height - ControlY(50))
      
      ViewScroll.addSubview(ViewDismiss)
      ViewDismiss.frame = CGRect(x: 0, y: ControlY(40), width: ViewScroll.frame.width , height: ControlWidth(40))
      
      ViewScroll.addSubview(StackItems)
      StackItems.frame = CGRect(x: ControlX(20), y: ControlY(90), width: ViewScroll.frame.width - ControlX(40), height:  ViewScroll.frame.height - ControlY(120))
      
      BackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
      BackgroundImage.topAnchor.constraint(equalTo: PasswordTF.topAnchor).isActive = true
      BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
    
      ViewScroll.updateContentViewSize(0)
      SetDataPasswordVC()
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
    
    lazy var BackgroundImage:UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "SetPassword")
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
  
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.TitleHidden = false
        tf.Icon.tintColor = .black
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        return tf
    }()

    
    @objc func ActionPassword() {
        if PasswordTF.IconImage == UIImage(named: "visibility-1") {
            PasswordTF.isSecureTextEntry = false
            PasswordConfirmTF.isSecureTextEntry = false
            PasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTF.isSecureTextEntry = true
            PasswordConfirmTF.isSecureTextEntry = true
            PasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    var IsPasswordConfirm = false
    lazy var PasswordConfirmTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.IconImage = UIImage()
        tf.Enum = .IsPasswordConfirm
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.Icon.setTitleColor(UIColor.black, for: .normal)
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.addTarget(self, action: #selector(ConfirmEditingChanged), for: .editingChanged)
        tf.Icon.titleLabel?.font = UIFont.systemFont(ofSize: ControlWidth(22), weight: .bold)
        return tf
    }()

    
    @objc func ConfirmEditingChanged() {
        if PasswordConfirmTF.text == "" {
        PasswordConfirmTF.Icon.setTitle("", for: .normal)
        } else if PasswordConfirmTF.text == PasswordTF.text {
        PasswordConfirmTF.Icon.setTitle("✓", for: .normal)
        IsPasswordConfirm = true
        }else{
        IsPasswordConfirm = false
        PasswordConfirmTF.Icon.setTitle("×", for: .normal)
        }
    }
    
    lazy var SignUpButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSignUp() {
    if PasswordTF.NoErrorPassword() && PasswordConfirmTF.NoErrorPassword() && IsPasswordConfirm {
    guard let Email = SignUp?.EmailTF.text else { return }
    guard let FirstName = SignUp?.FirstNameTF.text else { return }
    guard let password = PasswordTF.text else { return }

    ViewDots.beginRefreshing()
    let uid = SignUp?.uid ?? ""
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
        
    let api = "\(url + SignUpApi)"
    let Gender = self.SignUp?.Gender ?? true
    let IsEgyptian = self.SignUp?.IsEgyptian ?? true
    let Nationaltyid = self.SignUp?.Nationaltyid ?? 0
    let token = defaults.string(forKey: "jwt") ?? ""
    let signUpType = defaults.string(forKey: "signUpType") ?? "e"
    let LastName = self.SignUp?.LastNameTF.text ?? ""
    let Birthday = self.SignUp?.BirthdayTF.text ?? ""
    let PassportNumber = self.SignUp?.PassportNumberTF.text ?? ""
    let PhoneNumber = self.SignUp?.PhoneNumberTF.text ?? ""
    
    let parameters:[String:Any] = ["signUpType": signUpType,
                                    "uId": uid,
                                    "firstName": FirstName,
                                    "lastName": LastName,
                                    "email": Email,
                                    "birthday": Birthday,
                                    "isMail": Gender,
                                    "egyptianCitizen": IsEgyptian,
                                    "passportOrIdNumber": PassportNumber,
                                    "nationaltyId": Nationaltyid,
                                    "phoneNumber": PhoneNumber,
                                    "password": password]

    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in
    HomeScreenData = HomeScreen(dictionary: dictionary)
        
//    if HomeScreen(dictionary: dictionary).userData?.emailConfirmed == false {
//    ShowMessageAlert("ErrorService", "Error", "Something went wrong while processing your request, please try again later", false, {}, "")
//    }else{
//        
//    }
        
        
    self.ViewDots.endRefreshing() {
    Present(ViewController: self, ToViewController: ScreenPageView())
    }
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }else if PasswordTF.NoEmptyError() && PasswordTF.NoErrorPassword() && !IsPasswordConfirm {
    PasswordConfirmTF.BecomeFirst()
    }
    }

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,PasswordTF,PasswordConfirmTF,UIView(),UIView(),UIView(),SignUpButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    func SetDataPasswordVC() {
        self.view.subviews.forEach { View in View.alpha = 0}
        UIView.animate(withDuration: 0.4) {
        DataGetScreen(self, 5) { data in
        self.SetData(data)
        } _: { IsError in
        self.view.subviews.forEach { View in
        View.alpha = IsError ? 0:1
        self.ViewNoData.isHidden = IsError ? false:true

        if IsError == true {
        self.SetUpIsError(true) {
        self.SetDataPasswordVC()
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
        
        let attributedString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 39}).first?.lable ?? "Set your password", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: " \n ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: Data?.screenElements.filter({$0.id == 40}).first?.lable ?? "Set password to your account", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ]))
        TopLabel.attributedText = attributedString
        
        
        SignUpButton.setTitle(Data?.screenElements.filter({$0.id == 43}).first?.lable ?? "Sign Up", for: .normal)
        PasswordTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 41}).first?.lable ?? "Password", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        PasswordConfirmTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 42}).first?.lable ?? "Password Confirm", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
        
        PasswordTF.FirstId = 15
        PasswordTF.SecondId = 16
        PasswordTF.validationMessages = Data?.screenElements.filter({$0.id == 41}).first?.validationMessages ?? [ValidationMessages]()
        
        
        PasswordConfirmTF.FirstId = 17
        PasswordConfirmTF.SecondId = 18
        PasswordConfirmTF.validationMessages = Data?.screenElements.filter({$0.id == 42}).first?.validationMessages ?? [ValidationMessages]()
    }
    
}

