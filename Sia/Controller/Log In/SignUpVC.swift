//
//  SignUpVC.swift
//  Sia
//
//  Created by Emojiios on 16/10/2022.
//

import UIKit
import FlagPhoneNumber

class SignUpVC : ViewController ,FPNTextFieldDelegate, DropDownListDelegate, UIPopoverPresentationControllerDelegate {
    
    var uid : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp =  false
        view.backgroundColor = .white
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(BackgroundImage)

        view.addSubview(ViewScroll)
        ViewScroll.contentSize = CGSize(width: view.frame.width - ControlX(40), height: ControlWidth(1180))
        ViewScroll.frame = CGRect(x: ControlX(20), y: 0, width: view.frame.width - ControlX(40), height: view.frame.height)
        
        ViewScroll.addSubview(ViewDismiss)
        ViewDismiss.frame = CGRect(x: 0, y: ControlY(20), width: ViewScroll.frame.width , height: ControlWidth(40))
        
        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: ControlX(20), y: ControlY(70), width: ViewScroll.frame.width - ControlX(40), height: ControlWidth(1080))
        
        BackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BackgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        
        SetUpPhoneNumber()
        SetModelSignUp()
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
        Image.image = UIImage(named: "SignUp")
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
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        return Label
    }()
    
    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsName
        tf.TitleHidden = false
        return tf
    }()

    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        return tf
    }()
    
    lazy var StackName : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstNameTF,LastNameTF])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Stack
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.TitleHidden = false
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return tf
    }()

    lazy var BirthdayTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.TitleHidden = false
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.addTarget(self, action: #selector(ActionBirthday), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionBirthday), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionBirthday)))
        return tf
    }()
    
    let DatePicker = UIDatePicker()
    @objc func ActionBirthday() {
        
        let PopUp = PopUpDownView()
        PopUp.currentState = .open
        PopUp.modalPresentationStyle = .overFullScreen
        PopUp.modalTransitionStyle = .coverVertical
        PopUp.endCardHeight = ControlWidth(260)
        PopUp.radius = 25

        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = BirthdayTF.placeholder
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(20))
        PopUp.View.addSubview(Label)
        Label.frame = CGRect(x: ControlX(20), y: ControlY(15), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(30))
            
        DatePicker.maximumDate = Date()
        DatePicker.datePickerMode = .date
        DatePicker.backgroundColor = .white
        DatePicker.locale = Locale(identifier: "lang".localizable)
        if #available(iOS 13.4, *) {DatePicker.preferredDatePickerStyle = .wheels} else {}
        
        DatePicker.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        PopUp.View.addSubview(DatePicker)
        DatePicker.frame = CGRect(x: ControlX(20), y: Label.frame.maxY + ControlY(5), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(200))
        present(PopUp, animated: true)
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    BirthdayTF.text = DatePicker.date.Formatter("yyyy-MM-dd")
    }
    
        
    var IsEgyptian = true
    lazy var Egyptian : SSRadioButton = {
        let Button = SSRadioButton()
        Button.isSelected = true
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionEgyptian), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionEgyptian() {
    IsEgyptian = true
    Egyptian.isSelected = true
    Foreigner.isSelected = false
    self.PassportNumberTF.alpha = 0
    self.NationaltyTF.alpha = 0
    self.IDNumberTF.alpha = 1
    UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [], animations: {
    self.PassportNumberTF.isHidden = true
    self.NationaltyTF.isHidden = true
    self.IDNumberTF.isHidden = false
    self.StackItems.frame = CGRect(x: ControlX(20), y: ControlY(70), width: self.ViewScroll.frame.width - ControlX(40), height:  ControlWidth(1080))
    self.ViewScroll.contentSize = CGSize(width: self.view.frame.width - ControlX(40), height: ControlWidth(1180))
    self.view.layoutIfNeeded()
    })
    }

    lazy var Foreigner : SSRadioButton = {
        let Button = SSRadioButton()
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionForeigner), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionForeigner() {
    IsEgyptian = false
    Foreigner.isSelected = true
    Egyptian.isSelected = false
    self.PassportNumberTF.alpha = 1
    self.NationaltyTF.alpha = 1
    self.IDNumberTF.alpha = 0
    UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [], animations: {
    self.PassportNumberTF.isHidden = false
    self.NationaltyTF.isHidden = false
    self.IDNumberTF.isHidden = true
    
    self.StackItems.frame = CGRect(x: ControlX(20), y: ControlY(70), width: self.ViewScroll.frame.width - ControlX(40), height:  ControlWidth(1180))
    self.ViewScroll.contentSize = CGSize(width: self.view.frame.width - ControlX(40), height: ControlWidth(1280))
    self.view.layoutIfNeeded()
    })
    }
    
    lazy var StackRadio : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Egyptian,Foreigner])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        Stack.arrangedSubviews[0].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/1.8).isActive = true
        Stack.arrangedSubviews[1].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/2.5).isActive = true
        return Stack
    }()

    lazy var  EgyptianORForeigner : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
        
    lazy var NationalityStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EgyptianORForeigner,StackRadio])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(65)).isActive = true
        return Stack
    }()
    
    ///
    
    lazy var  GenderLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    var Gender = true
    lazy var RadioGender1 : SSRadioButton = {
        let Button = SSRadioButton()
        Button.isSelected = true
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionRadioGender1), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionRadioGender1() {
    Gender = true
    RadioGender1.isSelected = true
    RadioGender2.isSelected = false
    }

    lazy var RadioGender2 : SSRadioButton = {
        let Button = SSRadioButton()
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionRadioGender2), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionRadioGender2() {
    Gender = false
    RadioGender1.isSelected = false
    RadioGender2.isSelected = true
    }
    
    lazy var StackRadioGender : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [RadioGender1,RadioGender2])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        Stack.arrangedSubviews[0].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/1.8).isActive = true
        Stack.arrangedSubviews[1].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/2.5).isActive = true
        return Stack
    }()
    
    lazy var GenderStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [GenderLabel,StackRadioGender])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(65)).isActive = true
        return Stack
    }()
    
    /// MARK: Set Up Foreigner Stack TF
    
    lazy var PassportNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isHidden = true
        tf.ShowError = false
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return tf
    }()

    lazy var NationaltyTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isHidden = true
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = false
        tf.Icon.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        tf.tintColor = .clear
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.addTarget(self, action: #selector(NationaltyAction), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(NationaltyAction), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NationaltyAction)))
        return tf
    }()
    
    var Nationaltyid = Int()
    var NationaltyList = [String]()
    @objc func NationaltyAction() {
        let DropDown = DropDownList()
        DropDown.DropDownData = NationaltyList
        DropDown.Delegate = self
        if let Select = NationaltyList.firstIndex(where: {$0 == NationaltyTF.text}) {
        DropDown.SelectRow = IndexPath(row: Select, section: 0)
        }
                    
        DropDown.modalPresentationStyle = .popover
        DropDown.preferredContentSize = CGSize(width: ControlWidth(380), height: CGFloat(NationaltyList.count) * ControlWidth(40))

        let popController: UIPopoverPresentationController? = DropDown.popoverPresentationController
        popController?.permittedArrowDirections = [.unknown]
        popController?.delegate = self
        popController?.sourceView = NationaltyTF
        popController?.sourceRect = CGRect(
            x: NationaltyTF.frame.size.width/2,
            y: NationaltyTF.frame.size.height/2,
            width: 1,
            height: 1)
                
        popController?.backgroundColor = .white
        if NationaltyList.count != 0 {
        self.present(DropDown, animated: true, completion: { })
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func DropDownSelect(_ Index: String) {
    NationaltyTF.text = Index
    Nationaltyid = SignUpData?.nationalties.filter({$0.nationaltyName == Index}).first?.id ?? 0
    }
    
    /// MARK: Set Up Egyptian Stack TF

    lazy var IDNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.isHidden = false
        tf.ShowError = false
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return tf
    }()
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.layer.cornerRadius = ControlWidth(0.7)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(1.4)).isActive = true
        return View
    }()
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.TitleHidden = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.addTarget(self, action: #selector(PhoneEditingDidEnd), for: .editingDidEnd)
        tf.addTarget(self, action: #selector(PhoneEditingDidBegin), for: .editingDidBegin)
        return tf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func SetUpPhoneNumber() {
    listController.setup(repository: PhoneNumberTF.countryRepository)
    listController.didSelect = { [weak self] country in
    self?.PhoneNumberTF.setFlag(countryCode: country.code)
    }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    print(name, dialCode, code)
    }
    
    var isValidNumber = false
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    PhoneNumberTF.PhoneLabel.alpha = isValid ? 0 : 1
    isValidNumber = isValid
    }

    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = PhoneNumberTF.title.text
        listController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCountries))
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCountries))
        listController.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        listController.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        listController.searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listController.searchController.searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.modalTransitionStyle = .coverVertical
        present(navigationViewController, animated: true)
    }
    
    @objc func refreshCountries() {
    listController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func dismissCountries() {
    listController.dismiss(animated: true, completion: nil)
    }
    
    @objc func PhoneEditingDidEnd() {
    PhoneNumberTF.PhoneLabel.alpha = 0
    }

    @objc func PhoneEditingDidBegin() {
    PhoneNumberTF.PhoneLabel.alpha = isValidNumber ? 0 : 1
    }
    
    lazy var NextButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionNext() {
        
    if PhoneNumberTF.text?.TextNull() == true && !isValidNumber {
    PhoneNumberTF.Shake()
    PhoneNumberTF.PhoneLabel.alpha = 1
    PhoneNumberTF.becomeFirstResponder()
    }else{
    if FirstNameTF.NoEmptyError() && FirstNameTF.NameIsValid() && EmailTF.NoEmptyError() && EmailTF.NoErrorEmail() {
        
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
    guard let email = EmailTF.text else {return}
    ViewDots.beginRefreshing()
    let api = "\(url + CheckEmailIsUsed)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["email": email]

    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing {}
    let SetPassword = SetPasswordVC()
    SetPassword.SignUp = self
    Present(ViewController: self, ToViewController: SetPassword)
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
        
    }
    }
    
    lazy var SignInLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,StackName,EmailTF,BirthdayTF,GenderStack,NationalityStack,PassportNumberTF,NationaltyTF,IDNumberTF,ViewLine,PhoneNumberTF,NextButton,SignInLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(23)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    var SignUpData : SignUp?
    func SetModelSignUp() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}

    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.SetModelSignUp()
    }
    return
    }
            
    let api = "\(url + GetSignUp)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { dictionary in
    self.SetData(SignUp(dictionary: dictionary))
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.ViewDots.endRefreshing {}
    self.ViewNoData.isHidden = true
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.SetModelSignUp()
    }
    }
    }
    
    
    func SetData(_ data:SignUp) {
    SignUpData = data
        
    // MARK: Setup TopLabel String
    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlWidth(15)
    style.alignment = .center
    
    let TopLabelString = NSMutableAttributedString(string: data.screenData?.screenElements.filter({$0.id == 21}).first?.lable ?? "Sign up for a new Account", attributes: [
        .font: UIFont(name: "Nexa-XBold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
        .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
        .paragraphStyle:style
    ])
        
    TopLabelString.append(NSAttributedString(string: " \n ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:style
    ]))
    
    TopLabelString.append(NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 22}).first?.lable ?? "Fill the required details about you", attributes: [
        .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style
    ]))

    TopLabel.attributedText = TopLabelString
        
        
    // MARK: Setup SignIn String
    let SignInString = NSMutableAttributedString(string: data.screenData?.screenElements.filter({$0.id == 74}).first?.lable ?? "Have an account?", attributes: [
        .font: UIFont(name: "Nexa-Light", size: ControlWidth(17)) ?? UIFont.systemFont(ofSize: ControlWidth(17)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style
    ])
    
    SignInString.append(NSAttributedString(string: "  ", attributes: [
    .foregroundColor: UIColor.clear ,
    .paragraphStyle:style
    ]))
        
    SignInString.append(NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 75}).first?.lable ?? "Sign In", attributes: [
    .font: UIFont(name: "Nexa-Bold", size: ControlWidth(17)) ?? UIFont.systemFont(ofSize: ControlWidth(17)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
    .paragraphStyle:style,
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ]))
    SignInLabel.attributedText = SignInString
    
    
    FirstNameTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 23}).first?.lable ?? "First Name", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    LastNameTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 24}).first?.lable ?? "Last Name", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    EmailTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 25}).first?.lable ?? "Email Address", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    BirthdayTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 72}).first?.lable ?? "Birthday", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
    GenderLabel.text = data.screenData?.screenElements.filter({$0.id == 73}).first?.lable ?? "Gender"
    EgyptianORForeigner.text = data.screenData?.screenElements.filter({$0.id == 26}).first?.lable ?? "Egyptian Citizen / Foreigner"
                
    RadioGender1.setTitle(data.screenData?.screenElements.filter({$0.id == 73}).first?.radioText1 ?? "Male", for: .normal)
    RadioGender2.setTitle(data.screenData?.screenElements.filter({$0.id == 73}).first?.radioText2 ?? "FeMale", for: .normal)
        
    Egyptian.setTitle(data.screenData?.screenElements.filter({$0.id == 26}).first?.radioText1 ?? "Egyptian Citizen", for: .normal)
    Foreigner.setTitle(data.screenData?.screenElements.filter({$0.id == 26}).first?.radioText2 ?? "Foreigner", for: .normal)
        
    PassportNumberTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 27}).first?.lable ??
                                                                "Enter your Passport Number", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
    NationaltyTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 28}).first?.lable ??
                                                                "Select your nationality", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
    PhoneNumberTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 29}).first?.lable ?? "Phone number", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    IDNumberTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 30}).first?.lable ?? "ID Number", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    NextButton.setTitle(data.screenData?.screenElements.filter({$0.id == 31}).first?.lable ?? "Next", for: .normal)
        
    FirstNameTF.FirstId = 1
    FirstNameTF.SecondId = 2
    FirstNameTF.validationMessages = data.screenData?.screenElements.filter({$0.id == 23}).first?.validationMessages ?? [ValidationMessages]()
        
    EmailTF.FirstId = 4
    EmailTF.SecondId = 6
    EmailTF.validationMessages = data.screenData?.screenElements.filter({$0.id == 25}).first?.validationMessages ?? [ValidationMessages]()
        
    PhoneNumberTF.PhoneLabel.text = data.screenData?.screenElements.filter({$0.id == 29}).first?.validationMessages.filter({$0.id == 7}).first?.errorMessage ?? "Invalid Mobile Number Format"
        
    data.nationalties.forEach({ Nationalties in
    if let Nationaltie = Nationalties.nationaltyName {
    self.NationaltyList.append(Nationaltie)
    }
    })
        
    }
    
    
}

