//
//  MyInformationVC.swift
//  Sia
//
//  Created by Emojiios on 20/10/2022.
//

import UIKit
import FlagPhoneNumber

class MyInformationVC: ViewController ,FPNTextFieldDelegate, DropDownListDelegate, UIPopoverPresentationControllerDelegate {

    var MyInformationScreen : MyInformation?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        SetUpPhoneNumber()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(ImageBackground)
    ImageBackground.frame = view.bounds
      
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ViewDismiss.frame.maxY , width: view.frame.width , height:  view.frame.height - ControlY(40))
    ViewScroll.addSubview(StackItems)
      
    SetMyInformationData()
  }
    
    
    lazy var ImageBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "InformationBackground")
        return ImageView
    }()
          
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.Label.textColor = .black
        View.IconImage.tintColor = .black
        View.IconSize = CGSize(width: ControlWidth(22), height: ControlWidth(22))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsName
        tf.TitleHidden = false
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
        return tf
    }()
    
    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
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
        tf.alpha = 0.8
        tf.isEnabled = false
        tf.TitleHidden = false
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.keyboardType = .emailAddress
        tf.layer.borderWidth = ControlWidth(1)
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
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
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
    
    
    lazy var PassportNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.keyboardType = .numberPad
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
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
        tf.Icon.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.tintColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
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
    Nationaltyid = MyInformationScreen?.nationalties.filter({$0.nationaltyName == Index}).first?.id ?? 0
    }
    
    lazy var IDNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.ShowError = false
        tf.keyboardType = .numberPad
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return tf
    }()
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.delegate = self
        tf.TitleHidden = false
        tf.displayMode = .list
        tf.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.backgroundColor = .clear
        tf.layer.borderWidth = ControlWidth(1)
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
    
    var isValidNumber = true
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    PhoneNumberTF.PhoneLabel.alpha = isValid ? 0 : 1
    isValidNumber = isValid
    }
    
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Select your country"
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
    
    lazy var SaveButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSave), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSave() {
        UpdateInformation()
    }
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.layer.cornerRadius = ControlWidth(0.7)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(1.4)).isActive = true
        return View
    }()
    
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

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackName,EmailTF,BirthdayTF,GenderStack,ViewLine,PassportNumberTF,NationaltyTF,IDNumberTF,PhoneNumberTF,SaveButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(28)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
    
    func SetMyInformationData() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}

    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.SetMyInformationData()
    }
    return
    }
        
    let api = "\(url + GetMyInformation)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { dictionary in
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.SetData(MyInformation(dictionary: dictionary))
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.SetMyInformationData()
    }
    }
    }
    
    func SetData(_ Data:MyInformation?) {
        self.MyInformationScreen = Data
        
        FirstNameTF.text = Data?.userData?.firstName ?? ""
        LastNameTF.text = Data?.userData?.lastName ?? ""
        EmailTF.text = Data?.userData?.email ?? ""
        BirthdayTF.text = Data?.userData?.birthday?.Formatter().Formatter("yyyy-MM-dd") ?? ""
        DatePicker.setDate(Data?.userData?.birthday?.Formatter() ?? Date(), animated: false)
        
        ViewDismiss.TextLabel = Data?.screenData?.title ?? "My Information"
        PassportNumberTF.text = Data?.userData?.passportOrIdNumber ?? ""
        PhoneNumberTF.text = Data?.userData?.phoneNumber ?? ""
        
        SaveButton.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        SaveButton.setTitle(Data?.screenData?.screenElements.filter({$0.id == 126}).first?.lable ?? "Save", for: .normal)
        FirstNameTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 114}).first?.placeholder ?? "First Name", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        LastNameTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 115}).first?.placeholder ?? "Last Name", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        EmailTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 116}).first?.placeholder ?? "Email Address", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        BirthdayTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 123}).first?.placeholder ?? "Birthday", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        PhoneNumberTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 120}).first?.placeholder ?? "Phone number", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
                
        PassportNumberTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 118}).first?.placeholder ?? "Enter your Passport Number", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        IDNumberTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 121}).first?.placeholder ?? "ID Number", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        NationaltyTF.attributedPlaceholder = NSAttributedString(string: Data?.screenData?.screenElements.filter({$0.id == 128}).first?.placeholder ?? "Nationalty", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        
        RadioGender1.isSelected = Data?.userData?.isMail ?? true
        RadioGender2.isSelected = !(Data?.userData?.isMail ?? false)
        GenderLabel.text = Data?.screenData?.screenElements.filter({$0.id == 124}).first?.lable ?? "Gender"
        RadioGender1.setTitle(Data?.screenData?.screenElements.filter({$0.id == 124}).first?.radioText1 ?? "Male", for: .normal)
        RadioGender2.setTitle(Data?.screenData?.screenElements.filter({$0.id == 124}).first?.radioText2 ?? "FeMale", for: .normal)
        
        
        FirstNameTF.FirstId = 27
        FirstNameTF.SecondId = 28
        FirstNameTF.validationMessages = Data?.screenData?.screenElements.filter({$0.id == 114}).first?.validationMessages ?? [ValidationMessages]()
            
        PhoneNumberTF.PhoneLabel.text = Data?.screenData?.screenElements.filter({$0.id == 120}).first?.validationMessages.filter({$0.id == 7}).first?.errorMessage ?? "Invalid Mobile Number Format"
        
        Data?.nationalties.forEach({ Nationalties in
        if let Nationaltie = Nationalties.nationaltyName {
        self.NationaltyList.append(Nationaltie)
        }
        })
        
        if Data?.userData?.egyptianCitizen == true {
            PassportNumberTF.isHidden = true
            NationaltyTF.isHidden = true
            IDNumberTF.isHidden = false
            StackItems.frame = CGRect(x: ControlX(20), y: ControlY(30), width: ViewScroll.frame.width - ControlX(40), height: ControlWidth(740))
            ViewScroll.contentSize = CGSize(width: view.frame.width, height: ControlWidth(840))
        }else{
            PassportNumberTF.isHidden = false
            NationaltyTF.isHidden = false
            IDNumberTF.isHidden = true
            StackItems.frame = CGRect(x: ControlX(20), y: ControlY(30), width: ViewScroll.frame.width - ControlX(40), height: ControlWidth(800))
            ViewScroll.contentSize = CGSize(width: view.frame.width, height: ControlWidth(900))
        }
    }
    
    
    func UpdateInformation() {
        if PhoneNumberTF.text?.TextNull() == true && !isValidNumber {
        PhoneNumberTF.Shake()
        PhoneNumberTF.PhoneLabel.alpha = 1
        PhoneNumberTF.becomeFirstResponder()
        }else{
        if FirstNameTF.NoEmptyError() && FirstNameTF.NameIsValid() && EmailTF.NoEmptyError() && EmailTF.NoErrorEmail() {
        guard let url = defaults.string(forKey: "API") else {
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
                
        let api = "\(url + UpdateMyInformation)"
        let token = defaults.string(forKey: "jwt") ?? ""
                
        let Gender = Gender
        let Nationaltyid = Nationaltyid
        let LastName = LastNameTF.text ?? ""
        let Birthday = BirthdayTF.text ?? ""
        let PhoneNumber = PhoneNumberTF.text ?? ""
        let PassportNumber = PassportNumberTF.text ?? ""
        guard let FirstName = FirstNameTF.text else { return }
        let IsEgyptian = self.MyInformationScreen?.userData?.emailConfirmed ?? true
            
        let parameters:[String:Any] = ["FirstName": FirstName,
                                        "LastName": LastName,
                                        "Birthday": Birthday,
                                        "IsMail": Gender,
                                        "nationaltyId": Nationaltyid,
                                        "EgyptianCitizen": IsEgyptian,
                                        "PassportOrIdNumber": PassportNumber,
                                        "PhoneNumber": PhoneNumber]
        
        self.ViewDots.beginRefreshing()
        PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
        self.ViewDots.endRefreshing("Success Update My Information",.success) {}
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error,.error) {}
        }
        }
        }
    }
    
}
