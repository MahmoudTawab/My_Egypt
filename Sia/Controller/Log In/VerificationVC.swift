//
//  VerificationVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import FirebaseAuth

class VerificationVC: ViewController {
    
    var IsSignUp = Bool()
    var SignUp : SignUpVC?
    var SignIn : SignInVC?
    var VerificationNumber = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowWhatsUp =  false
        VerificationNumber = "123456"
        view.backgroundColor = .white
        SetUpItems()
    }
    
    fileprivate func SetUpItems() {
        
        view.addSubview(BackgroundImage)
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: ControlX(20), y: 0, width: view.frame.width - ControlX(40), height:  view.frame.height - ControlY(100))
        
        ViewScroll.addSubview(ViewDismiss)
        ViewDismiss.frame = CGRect(x: 0, y: ControlY(50), width: ViewScroll.frame.width , height: ControlWidth(40))
        
        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: 0, y: ControlY(100), width: ViewScroll.frame.width , height: ViewScroll.frame.height - ControlY(115))

        Number1TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number2TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number3TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number4TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number5TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number6TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
               
        
        BackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        BackgroundImage.topAnchor.constraint(equalTo: Labeltimer.topAnchor).isActive = true
        BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
        
        StartTimer()
        ViewScroll.updateContentViewSize(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Number1TF.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewScroll.setContentOffset(CGPoint(x: 0, y: ControlWidth(140)), animated: true)
        }
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
        Image.image = UIImage(named: "Verification")
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
    

    lazy var VerificationLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(15)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Enter Verification Code", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: " \n ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
//        if let PhoneNumber = SignUp?.PhoneNumberTF.text {
        let Number = "lang".localizable == "ar" ? "01204474410".NumAR():"01204474410"
        attributedString.append(NSAttributedString(string: "Enter the code sent to  \(Number)  ", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ]))
//        }
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Edit Number", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:))))
        return Label
    }()
    
    @objc func tapLabel(_ gesture: UITapGestureRecognizer) {
    guard let text = VerificationLabel.attributedText?.string else {return}

    guard let click_range = text.range(of: "Edit Number") else {return}
    if VerificationLabel.didTapAttributedTextInLabel(gesture: gesture, inRange: NSRange(click_range, in: text)) {
    SignUp?.PhoneNumberTF.becomeFirstResponder()
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    lazy var Number1TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number2TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number3TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number4TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number5TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number6TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Number1TF,Number2TF,Number3TF,Number4TF,Number5TF,Number6TF])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Stack
    }()
    
    lazy var ValidateButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.setTitle("Validate", for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionValidate), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()
    
    @objc func ActionValidate() {
    if let Number1 = Number1TF.text ,let Number2 = Number2TF.text ,let Number3 = Number3TF.text , let Number4 = Number4TF.text ,let Number5 = Number5TF.text , let Number6 = Number6TF.text {
    let Text = Number1 + Number2 + Number3 + Number4 + Number5 + Number6

    if Text.count != 6 || Text != VerificationNumber {
    Number1TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number2TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number3TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number4TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number5TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number6TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = false
    }
    
    }else{
    Number1TF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    Number2TF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    Number3TF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    Number4TF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    Number5TF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    Number6TF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = true
    }
        
        

    CreateAccount()
    }
    }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
    let text = textField.text
            
    if let t: String = textField.text {
    textField.text = String(t.prefix(1))
    }
        
    if text?.count == 1 {
    switch textField {
    case Number1TF:
    Number2TF.becomeFirstResponder()
    case Number2TF:
        Number3TF.becomeFirstResponder()
    case Number3TF:
        Number4TF.becomeFirstResponder()
    case Number4TF:
        Number5TF.becomeFirstResponder()
    case Number5TF:
        Number6TF.becomeFirstResponder()
    case Number6TF:
        Number6TF.resignFirstResponder()
    default:
    break
    }
    }
    if text?.count == 0 {
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = true
    }
    switch textField{
    case Number1TF:
        Number1TF.becomeFirstResponder()
    case Number2TF:
        Number1TF.becomeFirstResponder()
    case Number3TF:
        Number2TF.becomeFirstResponder()
    case Number4TF:
        Number3TF.becomeFirstResponder()
    case Number5TF:
        Number4TF.becomeFirstResponder()
    case Number6TF:
        Number5TF.becomeFirstResponder()
    default:
    break
    }
    }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    

    lazy var IsnotCorrect : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        Label.isHidden = true
        Label.backgroundColor = .clear
        Label.text = "OTP is not correct"
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()

    lazy var Labeltimer : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = false
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LabelTimerAction)))
        return Label
    }()
    
    @objc func LabelTimerAction() {
        StartTimer()
        VerificationSend()
    }

    var timer = Timer()
    var newTimer = 120
    @objc func ActionLabeltimer()  {
    let Timer = "lang".localizable == "ar" ? "\(timeFormatted(newTimer))".NumAR() : "\(timeFormatted(newTimer))"
    newTimer -= 1
    AttributedString(Labeltimer, "The code will be resend in", Timer, "sec", NSMakeRange(0,Labeltimer.text?.count ?? 0))
    Labeltimer.isUserInteractionEnabled = false
    if newTimer < -1 {
    let Text = "Resend OTP"
        
    AttributedString(Labeltimer, Text, "", "", NSMakeRange(0,Text.count))
    Labeltimer.isUserInteractionEnabled = true
    timer.invalidate()
    }
    }
    
    
    public func AttributedString(_ Label:UILabel,_ Text1:String,_ Text2:String,_ Text3:String,_ range: NSRange) {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
        
    let underlinedMessage = NSMutableAttributedString(string: Text1 + " ", attributes: [
    .font: UIFont(name: "Nexa-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    .paragraphStyle:style,
    .underlineStyle:NSUnderlineStyle.single.rawValue
    ])
    underlinedMessage.append(NSAttributedString(string: Text2 + " ", attributes: [
    .font: UIFont(name: "Nexa-Regular" , size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    .paragraphStyle:style
    ]))
    
    underlinedMessage.append(NSAttributedString(string: Text3, attributes: [
    .font: UIFont(name: "Nexa-Bold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    .paragraphStyle:style,
    .underlineStyle:NSUnderlineStyle.single.rawValue
    ]))
        
    Label.attributedText = underlinedMessage
    }
    

    
    func StartTimer() {
    newTimer = 120
    timer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector:  #selector(ActionLabeltimer) , userInfo: nil , repeats:  true)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func VerificationSend() {

    }
    
    func CreateAccount() {
        Present(ViewController: self, ToViewController: ScreenPageView())
    }

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [VerificationLabel,StackTF,Labeltimer,IsnotCorrect,UIView(),ValidateButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        return Stack
    }()

}
