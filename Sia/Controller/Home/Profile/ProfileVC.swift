//
//  ProfileVC.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit
import Firebase
import SDWebImage

class ProfileVC: ViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ViewDismiss.frame.maxY + ControlY(10), width: view.frame.width, height: view.frame.height - ViewDismiss.frame.maxY)
      
    ViewScroll.addSubview(ProfileBackground)
    ProfileBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    ProfileBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    ProfileBackground.heightAnchor.constraint(equalToConstant: ControlWidth(530)).isActive = true
    ProfileBackground.topAnchor.constraint(equalTo: ViewScroll.topAnchor, constant: ControlY(10)).isActive = true
          
    ViewScroll.addSubview(ProfileImage)
    ProfileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    ProfileImage.widthAnchor.constraint(equalToConstant: ControlWidth(235)).isActive = true
    ProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(240)).isActive = true
    ProfileImage.topAnchor.constraint(equalTo: ProfileBackground.topAnchor, constant: ControlX(55)).isActive = true
      
    ViewScroll.addSubview(EditProfileImage)
    EditProfileImage.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
    EditProfileImage.widthAnchor.constraint(equalTo: EditProfileImage.heightAnchor).isActive = true
    EditProfileImage.topAnchor.constraint(equalTo: ProfileImage.topAnchor, constant: ControlY(30)).isActive = true
    EditProfileImage.trailingAnchor.constraint(equalTo: ProfileImage.trailingAnchor, constant: ControlWidth(-35)).isActive = true
      
    ViewScroll.addSubview(StackProfileData)
    StackProfileData.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    StackProfileData.widthAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
    StackProfileData.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    StackProfileData.topAnchor.constraint(equalTo: ProfileImage.bottomAnchor, constant: ControlY(10)).isActive = true
      
    ViewScroll.addSubview(StackAllItem)
    StackAllItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    StackAllItem.heightAnchor.constraint(equalToConstant: ControlWidth(245)).isActive = true
    StackAllItem.topAnchor.constraint(equalTo: StackProfileData.bottomAnchor, constant: ControlY(50)).isActive = true
    StackAllItem.widthAnchor.constraint(equalTo: view.widthAnchor ,multiplier: 1/1.5).isActive = true


    ViewScroll.updateContentViewSize(ControlY(25))
    SetProfileData()
  }
    
     
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor  = .clear
        return Scroll
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
    

    lazy var ProfileBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "ProfileBackground")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()


    lazy var ProfileImage : ImageViewGradient = {
        let ImageView = ImageViewGradient()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(100)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.02018633992).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2011447828).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3955077087).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6033888836).cgColor]
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionProfile)))
        return ImageView
    }()
    
    @objc func ActionProfile() {
    if let image = ProfileImage.image {
    let imageInfo   = GSImageInfo(image: image, imageMode: .aspectFit)
    let transitionInfo = GSTransitionInfo(fromView: ProfileImage)
    let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
    present(imageViewer, animated: true, completion: nil)
    }
    }
    
    lazy var EditProfileImage: UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Edit"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        Button.layer.shadowOffset = .zero
        Button.layer.shadowOpacity = 0.8
        Button.layer.shadowRadius = 8
        Button.addTarget(self, action: #selector(ActionEditProfile), for: .touchUpInside)
        return Button
    }()
    
    
    var Camera = String()
    var Cancel = String()
    var PhotoLibrary = String()
    @objc func ActionEditProfile() {
    let ImagePickerController = UIImagePickerController()
    ImagePickerController.allowsEditing = true
    ImagePickerController.delegate = self
    let Style = UIDevice.current.userInterfaceIdiom == .phone ? UIAlertController.Style.actionSheet:UIAlertController.Style.alert
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: Style)
        alertController.addAction(UIAlertAction(title: Camera, style: .default, handler: { (action:UIAlertAction) in
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
    ImagePickerController.sourceType = .camera
    ImagePickerController.modalPresentationStyle = .fullScreen
    self.present(ImagePickerController, animated: true , completion: nil)
    }else{print("Camera not available")}
    }))
    alertController.addAction(UIAlertAction(title: PhotoLibrary, style: .default, handler: { (action:UIAlertAction) in
    ImagePickerController.sourceType = .photoLibrary
    ImagePickerController.modalPresentationStyle = .fullScreen
    self.present(ImagePickerController, animated: true , completion: nil)
    }))

    alertController.addAction(UIAlertAction(title: Cancel, style: .cancel))
    
    alertController.modalPresentationStyle = .fullScreen
    self.present(alertController, animated: true , completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        ProfileSaveChanges(image)
        ProfileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
    }
    
    func ProfileSaveChanges(_ image:UIImage) {
    guard let Email = EmailLabel.text else { return }
    ViewDots.beginRefreshing()
    Storag(child1: "User Data", child2: "Profile" ,child3: Email , image: image) { Url in
    self.UpdateImage(Url)
    } Err: { Error in
    self.ViewDots.endRefreshing {
    ShowMessageAlert("ErrorIcon", "Error" , "Update image Error", true, {})
    }
    }
    }
    
    func UpdateImage(_ imageUrl:String) {
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
                
    let api = "\(url + ChangeProfilePhoto)"
    let token = defaults.string(forKey: "jwt") ?? ""

    PostAPI(timeout: 60,api: api, token: token, parameters: ["PhotoUrl":imageUrl]) { _ in
    self.ViewDots.endRefreshing("Success Change Profile Photo",.success) {}
    self.ViewDots.endRefreshing {}
    } dictionary: { dictionary in
    } array: { array in
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error) {}
    }
    }
    
    lazy var NameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.5730749965, green: 0.4256919026, blue: 0.1120200828, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var MemberSince : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.5730749965, green: 0.4256919026, blue: 0.1120200828, alpha: 1)
        Label.numberOfLines = 2
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-RegularItalic" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var GenderLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.5730749965, green: 0.4256919026, blue: 0.1120200828, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-RegularItalic" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var EmailLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    
    lazy var StackProfileData : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [NameLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    
    lazy var StackInformation : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [InformationLabel,InformationImage])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.4514514208, green: 0.5774974227, blue: 0.6677470207, alpha: 1)
        Stack.clipsToBounds = true
        Stack.isUserInteractionEnabled = true
        Stack.layer.cornerRadius = ControlX(10)
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionInformation)))
        return Stack
    }()
    
    lazy var InformationLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nexa-XBold", size:  ControlWidth(18))
        button.addTarget(self, action: #selector(ActionInformation), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(8), bottom: 0, right: ControlWidth(8))
        return button
    }()
    
    lazy var InformationImage : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "Information"), for: .normal)
        Button.addTarget(self, action: #selector(ActionInformation), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlWidth(5), left: ControlWidth(10), bottom: ControlWidth(-5), right: ControlWidth(10))
        return Button
    }()


    @objc func ActionInformation() {
    Present(ViewController: self, ToViewController: MyInformationVC())
    }
    
    
    lazy var StackLanguages : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LanguagesLabel,LanguagesImage])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.6254840493, green: 0.6941396594, blue: 0.5239480138, alpha: 1)
        Stack.clipsToBounds = true
        Stack.isUserInteractionEnabled = true
        Stack.layer.cornerRadius = ControlX(10)
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionLanguages)))
        return Stack
    }()
    
    lazy var LanguagesLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nexa-XBold", size:  ControlWidth(18))
        button.addTarget(self, action: #selector(ActionLanguages), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(8), bottom: 0, right: ControlWidth(8))
        return button
    }()
    
    lazy var LanguagesImage : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "Languages"), for: .normal)
        Button.addTarget(self, action: #selector(ActionLanguages), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlWidth(5), left: ControlWidth(10), bottom: ControlWidth(-5), right: ControlWidth(10))
        return Button
    }()
    
    @objc func ActionLanguages() {
        Present(ViewController: self, ToViewController: ChangeLanguageVC())
    }
    
    lazy var StackResetPassword : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ResetPasswordLabel,ResetPasswordImage])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.8220497966, green: 0.4488283396, blue: 0.2891780138, alpha: 1)
        Stack.clipsToBounds = true
        Stack.isUserInteractionEnabled = true
        Stack.layer.cornerRadius = ControlX(10)
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionResetPassword)))
        return Stack
    }()
    
    lazy var ResetPasswordLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nexa-XBold", size:  ControlWidth(18))
        button.addTarget(self, action: #selector(ActionResetPassword), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(8), bottom: 0, right: ControlWidth(8))
        return button
    }()
    
    lazy var ResetPasswordImage : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "ResetPassword"), for: .normal)
        Button.addTarget(self, action: #selector(ActionResetPassword), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlWidth(5), left: ControlWidth(10), bottom: ControlWidth(-5), right: ControlWidth(10))
        return Button
    }()
    
    @objc func ActionResetPassword() {
    Present(ViewController: self, ToViewController: ResetPasswordVC())
    }
    
    lazy var StackLogOut : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LogOutLabel,LogOutImage])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = #colorLiteral(red: 0.7776824832, green: 0.9091050029, blue: 1, alpha: 1)
        Stack.clipsToBounds = true
        Stack.isUserInteractionEnabled = true
        Stack.layer.cornerRadius = ControlX(10)
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionLogOut)))
        return Stack
    }()
    
    lazy var LogOutLabel : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Nexa-XBold", size:  ControlWidth(18))
        button.addTarget(self, action: #selector(ActionLogOut), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(8), bottom: 0, right: ControlWidth(8))
        return button
    }()
    
    lazy var LogOutImage : UIButton = {
        let Button = UIButton()
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "LogOut"), for: .normal)
        Button.addTarget(self, action: #selector(ActionLogOut), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlWidth(5), left: ControlWidth(10), bottom: ControlWidth(-5), right: ControlWidth(10))
        return Button
    }()
    
    var TitleLogOut = String()
    var LogOutMessage = String()
    var LogOutTitleButton = String()
    var CancelTitleButton = String()
    @objc func ActionLogOut() {
    ShowMessageAlert("ErrorService", TitleLogOut, LogOutMessage , false, self.LogOut, LogOutTitleButton,CancelTitleButton)
    }

    @objc func LogOut() {
    DispatchQueue.main.async {
    try? Auth.auth().signOut()
    defaults.removeObject(forKey: "jwt")
    defaults.removeObject(forKey: "refreshToken")
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
    FirstController(LaunchScreen())
    }
    }
    }
    
    lazy var StackAllItem : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackInformation,StackLanguages,StackResetPassword,StackLogOut])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    func SetProfileData() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}

    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.SetProfileData()
    }
    return
    }
                
    let api = "\(url + GetProfile)"
    let token = defaults.string(forKey: "jwt") ?? ""
            
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { dictionary in
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.SetData(HomeScreen(dictionary: dictionary))
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.SetProfileData()
    }
    }
    }
    
    func SetData(_ Data:HomeScreen?) {
    NameLabel.text = Data?.userData?.name ?? ""
    MemberSince.text = Data?.userData?.memberSince ?? ""
    GenderLabel.text = Data?.userData?.genderAndAge ?? ""
    ViewDismiss.TextLabel = Data?.screenData?.title ?? "My Profile"

    let style = NSMutableParagraphStyle()
    style.alignment = .center
    
        let attributedString = NSMutableAttributedString(string: Data?.userData?.email ?? "", attributes: [
        .font: UIFont(name: "Nexa-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
        .foregroundColor: #colorLiteral(red: 0.5730749965, green: 0.4256919026, blue: 0.1120200828, alpha: 1) ,
        .paragraphStyle:style,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    EmailLabel.attributedText = attributedString
        
    InformationLabel.setTitle(Data?.screenData?.screenElements.filter({$0.id == 92}).first?.lable ?? "My Information", for: .normal)
    LanguagesLabel.setTitle(Data?.screenData?.screenElements.filter({$0.id == 93}).first?.lable ??  "Languages", for: .normal)
    ResetPasswordLabel.setTitle(Data?.screenData?.screenElements.filter({$0.id == 98}).first?.lable ??  "Reset password", for: .normal)
    LogOutLabel.setTitle(Data?.screenData?.screenElements.filter({$0.id == 94}).first?.lable ?? "Log out", for: .normal)
    ProfileImage.sd_setImage(with: URL(string: Data?.userData?.photo ?? ""), placeholderImage: UIImage(named: "Profile"))
        
    Camera = Data?.screenData?.screenElements.filter({$0.id == 180}).first?.lable ?? "Camera"
    Cancel = Data?.screenData?.screenElements.filter({$0.id == 182}).first?.lable ?? "Cancel"
    PhotoLibrary = Data?.screenData?.screenElements.filter({$0.id == 181}).first?.lable ?? "Photo Library"
        
        
    TitleLogOut = Data?.screenData?.screenElements.filter({$0.id == 183}).first?.lable ?? "LogOut"
    LogOutTitleButton = Data?.screenData?.screenElements.filter({$0.id == 186}).first?.lable ?? "Log Out"
    CancelTitleButton = Data?.screenData?.screenElements.filter({$0.id == 185}).first?.lable ?? "Cancel"
    LogOutMessage = Data?.screenData?.screenElements.filter({$0.id == 184}).first?.lable ?? "Are You Sure You Want to Log Out"
    }
    
    
}
