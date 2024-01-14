//
//  ChangeLanguageVC.swift
//  Sia
//
//  Created by Emojiios on 22/02/2023.
//

import UIKit

class ChangeLanguageVC: ViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
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
      
    view.addSubview(ChangeLanguageBackground)
    ChangeLanguageBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    ChangeLanguageBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    ChangeLanguageBackground.heightAnchor.constraint(equalToConstant: ControlWidth(640)).isActive = true
    ChangeLanguageBackground.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(50)).isActive = true
                
    view.addSubview(LocalizableCollection)
    LocalizableCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    LocalizableCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.5).isActive = true
    LocalizableCollection.heightAnchor.constraint(equalTo: LocalizableCollection.widthAnchor).isActive = true
    LocalizableCollection.topAnchor.constraint(equalTo: ChangeLanguageBackground.topAnchor, constant: ControlX(90)).isActive = true
      
    view.addSubview(LocalizableCenter)
    LocalizableCenter.widthAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
    LocalizableCenter.heightAnchor.constraint(equalTo: LocalizableCenter.widthAnchor).isActive = true
    LocalizableCenter.centerYAnchor.constraint(equalTo: LocalizableCollection.centerYAnchor).isActive = true
    LocalizableCenter.centerXAnchor.constraint(equalTo: LocalizableCollection.centerXAnchor).isActive = true
      
    FuncGetLanguage()
    ViewScroll.updateContentViewSize(ControlY(10))
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

    lazy var ChangeLanguageBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "ChangeLanguage")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    lazy var LocalizableCenter : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.layer.borderColor = #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.borderWidth = ControlWidth(3)
        ImageView.layer.cornerRadius = ControlWidth(55)
        ImageView.image = UIImage(named: LanguageCenter.flage)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionLocalizableCenter)))
        return ImageView
    }()
    
    @objc func ActionLocalizableCenter() {
    SelectLanguage(LanguageCenter.id,LanguageCenter.culture)
    }
    
    let CircleCellID = "CircleCellID"
    var LanguageCenter : Language = Language(dictionary: [String : Any]())
    var LanguageCollection = [Language]()
    lazy var LocalizableCollection: UICollectionView = {
        let layout = CircleLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.clipsToBounds = false
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(LocalizableCircleCell.self, forCellWithReuseIdentifier: CircleCellID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LanguageCollection.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCellID, for: indexPath) as! LocalizableCircleCell
    cell.backgroundColor = .clear
    cell.clipsToBounds = true
    cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    cell.layer.borderWidth = ControlWidth(2)
    cell.layer.cornerRadius = cell.frame.height / 2
    cell.ImageView.sd_setImage(with: URL(string: LanguageCollection[indexPath.item].flage), placeholderImage: UIImage(named: "Group 26056"))
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if LanguageCollection[indexPath.item].id != HomeScreenData?.lang {
        SelectLanguage(LanguageCollection[indexPath.item].id, LanguageCollection[indexPath.item].culture)
        }
    }
    
    
    func FuncGetLanguage() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.FuncGetLanguage()
    }
    return
    }

    let api = "\(url + GetLanguage)"
    let token = defaults.string(forKey: "jwt") ?? ""

    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { _ in
    } array: { array in
    self.LanguageCenter = Language(dictionary: array.first ?? [:])

    for Item in array {
    self.LanguageCollection.append(Language(dictionary: Item))
    if self.LanguageCollection.count == array.count {
    self.LanguageCollection.removeFirst()
    self.ViewDismiss.TextLabel = self.LanguageCollection.first?.screenTitle ?? "Change Language"
        
    self.SetDataLanguage()
    self.ViewDots.endRefreshing {}
    }
    }
    } Err: { error in
    self.SetUpIsError(true) {
    self.FuncGetLanguage()
    }
    }
    }
    
    func SetDataLanguage() {
    LocalizableCenter.sd_setImage(with: URL(string: LanguageCenter.flage), placeholderImage: UIImage(named: "Group 26056"))
    LocalizableCollection.reloadData()
    self.ViewNoData.isHidden = true
    view.subviews.forEach { View in View.alpha = 1}
    }
    
    func SelectLanguage(_ languageId:Int,_ Language:String) {
        guard let url = defaults.string(forKey: "API") else {
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
        
        let api = "\(url + SetLanguage)"
        let token = defaults.string(forKey: "jwt") ?? ""
        let parameters = ["languageId": "\(languageId)"]

        self.ViewDots.beginRefreshing()
        PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
        } dictionary: { dictionary in
        HomeScreenData = HomeScreen(dictionary: dictionary)
            
        self.ViewDots.endRefreshing() {
        if languageId == 2 && MOLHLanguage.currentAppleLanguage() != "ar" {
        MOLH.setLanguageTo("ar")
        MOLH.reset()
        }else{
        MOLH.setLanguageTo("en")
        MOLH.reset()
        }
        }
            
        } array: { array in
        } Err: { error in
        self.ViewDots.endRefreshing(error, .error) {}
        }
    }
    
    
//    @objc func MOLHSetLanguage(_ lang:String) {
//    if MOLHLanguage.currentAppleLanguage() != lang {
//    MOLH.setLanguageTo(lang)
//    self.ViewDots.endRefreshing() {MOLH.reset()}
//    }
//    }
        
    
}
