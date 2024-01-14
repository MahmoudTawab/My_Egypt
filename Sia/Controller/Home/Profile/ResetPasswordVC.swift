//
//  ResetPasswordVC.swift
//  Sia
//
//  Created by Emojiios on 14/03/2023.
//

import UIKit
import Firebase

class ResetPasswordVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
    
  fileprivate func SetUpItems() {
      view.addSubview(ImageBackground)
      ImageBackground.frame = view.bounds

      view.addSubview(ViewDismiss)
      ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
        
      view.addSubview(ViewScroll)
      ViewScroll.frame = CGRect(x: 0, y: ViewDismiss.frame.maxY , width: view.frame.width, height: view.frame.height - ViewDismiss.frame.maxY)
      
      ViewScroll.addSubview(StackItems)
      StackItems.frame = CGRect(x: ControlX(20), y: ControlY(20), width: ViewScroll.frame.width - ControlX(40), height:  view.frame.height - ControlY(100))
      
      ViewScroll.updateContentViewSize(ControlX(20))
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
    
    lazy var ImageBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "InformationBackground")
        return ImageView
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
    
    lazy var OldPasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.TitleHidden = false
        tf.Icon.tintColor = .black
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionOldPassword), for: .touchUpInside)
        return tf
    }()
    
    @objc func ActionOldPassword() {
        if OldPasswordTF.IconImage == UIImage(named: "visibility-1") {
            OldPasswordTF.isSecureTextEntry = false
            OldPasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            OldPasswordTF.isSecureTextEntry = true
            OldPasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
  
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.TitleHidden = false
        tf.Icon.tintColor = .black
        tf.clearButtonMode = .never
        tf.isSecureTextEntry = true
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
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
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
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
    
    lazy var DoneButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionDone), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionDone() {
        if OldPasswordTF.NoErrorPassword() && PasswordTF.NoErrorPassword() && PasswordConfirmTF.NoErrorPassword() && IsPasswordConfirm == true {
        guard let OldPassword = self.OldPasswordTF.text else {return}
        guard let NewPassword = self.PasswordTF.text else {return}
        guard let email = Auth.auth().currentUser?.email else {return}
        let user = Auth.auth().currentUser
            
        ViewDots.beginRefreshing()
        let credential = EmailAuthProvider.credential(withEmail: email, password: OldPassword)
        user?.reauthenticate(with: credential, completion: { (Auth, err) in
        if let err = err {
        self.ViewDots.endRefreshing(err.localizedDescription, .error) {}
        return
        }
                
        user?.updatePassword(to: NewPassword, completion: { (err) in
        if let err = err {
        self.ViewDots.endRefreshing(err.localizedDescription, .error) {}
        return
        }
            
        self.PasswordTF.text = ""
        self.OldPasswordTF.text = ""
        self.PasswordConfirmTF.text = ""
        self.ViewDots.endRefreshing("Success Update Password", .success) {}
        })
        })
        }else if PasswordTF.NoEmptyError() && PasswordTF.NoErrorPassword() && !IsPasswordConfirm {
        PasswordConfirmTF.BecomeFirst()
        }
    }

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,OldPasswordTF,PasswordTF,PasswordConfirmTF,UIView(),UIView(),DoneButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(60)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    func SetDataPasswordVC() {
        self.view.subviews.forEach { View in View.alpha = 0}
        UIView.animate(withDuration: 0.4) {
        DataGetScreen(self, 17) { data in
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
        
        let attributedString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 99}).first?.lable ?? "Reset your password", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: " \n ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: Data?.screenElements.filter({$0.id == 100}).first?.lable ?? "Enter a new password to\nyour account", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ]))
        TopLabel.attributedText = attributedString
        
        
        DoneButton.setTitle(Data?.screenElements.filter({$0.id == 103}).first?.lable ?? "Done", for: .normal)
        OldPasswordTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 104}).first?.lable ?? "Old Password", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        PasswordTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 101}).first?.lable ?? "New Password", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        PasswordConfirmTF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 102}).first?.lable ?? "Password Confirm", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
        
        OldPasswordTF.FirstId = 24
        OldPasswordTF.SecondId = 25
        OldPasswordTF.validationMessages = Data?.screenElements.filter({$0.id == 104}).first?.validationMessages ?? [ValidationMessages]()
        
        
        PasswordTF.FirstId = 20
        PasswordTF.SecondId = 21
        PasswordTF.validationMessages = Data?.screenElements.filter({$0.id == 101}).first?.validationMessages ?? [ValidationMessages]()

        
        PasswordConfirmTF.FirstId = 22
        PasswordConfirmTF.SecondId = 23
        PasswordConfirmTF.validationMessages = Data?.screenElements.filter({$0.id == 102}).first?.validationMessages ?? [ValidationMessages]()
    }
    
}

