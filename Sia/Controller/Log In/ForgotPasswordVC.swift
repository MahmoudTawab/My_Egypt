//
//  ForgotPasswordVC.swift
//  Sia
//
//  Created by Emojiios on 22/02/2023.
//

import UIKit
import Firebase

class ForgotPasswordVC: ViewController {
    
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
        BackgroundImage.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
      
        ViewScroll.updateContentViewSize(0)
        SetDataForgotPassword()
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
  
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.TitleHidden = false
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        return tf
    }()
    
    lazy var Send : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSend), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSend() {
    if EmailTF.NoEmptyError() && EmailTF.NoErrorEmail() {
    guard let email = EmailTF.text else { return }
    self.ViewDots.beginRefreshing()
    Auth.auth().sendPasswordReset(withEmail: email) { (err) in
    if let err = err {
    self.ViewDots.endRefreshing() {ShowMessageAlert("ErrorIcon", "Error", err.localizedDescription, false,self.ActionSend)}
    return
    }
        
    self.ViewDots.endRefreshing() {
    self.EmailTF.text = ""
    ShowMessageAlert("SuccessIcon", "Password Reset link", "Password reset link has been successfully sent to your email", true) {}
    }
    }
    }
    }

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,EmailTF,UIView(),UIView(),UIView(),UIView(),Send])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    
    func SetDataForgotPassword() {
        self.view.subviews.forEach { View in View.alpha = 0}
        UIView.animate(withDuration: 0.4) {
        DataGetScreen(self, 3) { data in
        self.SetData(data)
        } _: { IsError in
        self.view.subviews.forEach { View in
        View.alpha = IsError ? 0:1
        self.ViewNoData.isHidden = IsError ? false:true

        if IsError == true {
        self.SetUpIsError(true) {
        self.SetDataForgotPassword()
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
        
        let attributedString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 17}).first?.lable ?? "Forgot Password", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: " \n ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: Data?.screenElements.filter({$0.id == 18}).first?.lable ?? "Enter your email address", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        TopLabel.attributedText = attributedString
        
        Send.setTitle(Data?.screenElements.filter({$0.id == 20}).first?.lable ?? "Send", for: .normal)
        EmailTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 19}).first?.lable ?? "Email", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])

        EmailTF.FirstId = 12
        EmailTF.SecondId = 13
        EmailTF.validationMessages = Data?.screenElements.filter({$0.id == 19}).first?.validationMessages ?? [ValidationMessages]()
    }
}
