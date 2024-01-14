//
//  LocalizableScreen.swift
//  SHARMIVAL
//
//  Created by Emojiios on 07/09/2022.
//

import UIKit
import SDWebImage

class LocalizableScreen: ViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(BackgroundImage)
        
        view.addSubview(TopLabel)
        TopLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TopLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.2).isActive = true
        TopLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        TopLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: (view.frame.height / 26)).isActive = true
                
        BackgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        BackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1.8).isActive = true
        BackgroundImage.topAnchor.constraint(equalTo: TopLabel.centerYAnchor,constant: (view.frame.height / 30)).isActive = true

        view.addSubview(LocalizableCollection)
        LocalizableCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LocalizableCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/1.2).isActive = true
        LocalizableCollection.heightAnchor.constraint(equalTo: LocalizableCollection.widthAnchor).isActive = true
        LocalizableCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height / 16).isActive = true
        
        view.addSubview(LocalizableCenter)
        LocalizableCenter.widthAnchor.constraint(equalToConstant: ControlWidth(130)).isActive = true
        LocalizableCenter.heightAnchor.constraint(equalTo: LocalizableCenter.widthAnchor).isActive = true
        LocalizableCenter.centerYAnchor.constraint(equalTo: LocalizableCollection.centerYAnchor).isActive = true
        LocalizableCenter.centerXAnchor.constraint(equalTo: LocalizableCollection.centerXAnchor).isActive = true
        FuncGetLanguage()
    }
    
    lazy var BackgroundImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.contentMode = .scaleAspectFill
        Image.image = UIImage(named: "Localizable")
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(15)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Welcome to", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(28)) ?? UIFont.systemFont(ofSize: ControlWidth(28)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        if let Image = UIImage(named: "Group 57485")?.toAttributedString(with: ControlWidth(26), tint: #colorLiteral(red: 0.9256414722, green: 0.7320429352, blue: 0.3116357942, alpha: 1)) {
        attributedString.append(Image)
        }
        
        attributedString.append(NSAttributedString(string: " \n ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Please select your favorite language to continue .. ", attributes: [
            .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LocalizableCenter : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.layer.borderColor = #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.borderWidth = ControlWidth(3)
        ImageView.layer.cornerRadius = ControlWidth(65)
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
        SelectLanguage(LanguageCollection[indexPath.item].id, LanguageCollection[indexPath.item].culture)
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

        print(token)
        print(parameters)
        self.ViewDots.beginRefreshing()
        PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
        } dictionary: { dictionary in
        HomeScreenData = HomeScreen(dictionary: dictionary)
            
        self.ViewDots.endRefreshing() {
        if languageId == 2 {
        MOLH.setLanguageTo("ar")
        MOLH.reset()
        }else{
        MOLH.setLanguageTo("en")
        MOLH.reset()
        }
        }

        defaults.set(true, forKey: "ShowLocalizable")
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
