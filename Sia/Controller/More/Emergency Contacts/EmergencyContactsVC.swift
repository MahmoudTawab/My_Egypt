//
//  EmergencyContactsVC.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

class EmergencyContactsVC: ViewController {


    var ContactsTitle : EmergencyContacts?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = false
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(EmergencyContactsBackground)
    EmergencyContactsBackground.frame = view.bounds
      
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(ContactsCollection)
    ContactsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    ContactsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    ContactsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    ContactsCollection.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
    DataEmergencyContacts()
  }
          
    lazy var EmergencyContactsBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.9432628751, green: 0.8789214492, blue: 0.7612995505, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EmergencyContactsBackground")
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

    let ContactsId = "Contacts"
    lazy var  ContactsCollection: CollectionAnimations = {
    let layout = RTLCollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = ControlX(15)
    let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
    vc.backgroundColor = .clear
    vc.dataSource = self
    vc.delegate = self
    vc.showsVerticalScrollIndicator = false
    vc.translatesAutoresizingMaskIntoConstraints = false
    vc.register(ContactsCell.self, forCellWithReuseIdentifier: ContactsId)
    vc.contentInset = UIEdgeInsets(top: ControlY(5), left: 0, bottom: ControlX(15), right: 0)
    return vc
    }()
    
    
    
}


extension EmergencyContactsVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , ContactsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContactsTitle?.screenData?.screenElements.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  ContactsId,for: indexPath) as! ContactsCell
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.IsLeading?.isActive = indexPath.item % 2 == 1 ? false:true
        cell.IsTrailing?.isActive = indexPath.item % 2 != 1 ? false:true
        cell.ButtonLabel.setTitle(ContactsTitle?.screenData?.screenElements[indexPath.row].lable, for: .normal)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: ControlWidth(170))
    }
    
    
    func ContactsAction(_ Cell:ContactsCell) {
        if let indexPath = ContactsCollection.indexPath(for: Cell) {
        switch indexPath.item {
        case 0:
        ActionCallUs(ContactsTitle?.emergencyContacts?.policeNumber ?? "122")

        case 1:
        ActionCallUs(ContactsTitle?.emergencyContacts?.ambulanceNumber ?? "123")

        case 2:
        ActionCallUs(ContactsTitle?.emergencyContacts?.fireBrigadeNumber ?? "998")

        default:
        break
        }
        }
    }
    
    @objc func ActionCallUs(_ phone:String) {
    if let url = NSURL(string: ("tel:" + (phone))) {
    if #available(iOS 10.0, *) {
    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    } else {
    UIApplication.shared.openURL(url as URL)
    }
    }
    }

    func DataEmergencyContacts() {
    self.view.subviews.forEach { View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.DataEmergencyContacts()}
    return
    }
                
    let api = "\(url + GetEmergencyContacts)"
    let token = defaults.string(forKey: "jwt") ?? ""
                
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: [:]) { _ in
    } dictionary: { dictionary in
    self.ContactsTitle = EmergencyContacts(dictionary: dictionary)
    self.ViewDismiss.TextLabel = self.ContactsTitle?.screenData?.title ?? "Emergency Contacts"
        
    UIView.animate(withDuration: 0.5) {
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing() {}
    self.ContactsCollection.reloadData()
    } array: { _ in
    } Err: { error in
    self.SetUpIsError(true) {
    self.DataEmergencyContacts()
    }
    }
    }

}
