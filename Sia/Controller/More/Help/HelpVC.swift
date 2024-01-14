//
//  HelpVC.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

class HelpVC: ViewController {
    
    var screenElements = [ScreenElements]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
      
    view.addSubview(HelpBackground1)
    HelpBackground1.frame = view.bounds
          
    view.addSubview(HelpCollection)
    view.addSubview(HelpBackground2)
    HelpBackground2.frame = view.bounds
                
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    HelpCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    HelpCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    HelpCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    HelpCollection.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
      
    SetDataHelp()
  }
          
    lazy var HelpBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "HelpBackground1")
        return ImageView
    }()
    
    lazy var HelpBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "HelpBackground2")
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

    let HelpId = "Help"
    lazy var  HelpCollection: CollectionAnimations = {
    let layout = RTLCollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = ControlX(15)
    let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
    vc.backgroundColor = .clear
    vc.dataSource = self
    vc.delegate = self
    vc.showsVerticalScrollIndicator = false
    vc.translatesAutoresizingMaskIntoConstraints = false
    vc.register(HelpCell.self, forCellWithReuseIdentifier: HelpId)
    vc.contentInset = UIEdgeInsets(top: ControlY(5), left: 0, bottom: ControlX(15), right: 0)
    return vc
    }()
    
}


extension HelpVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , HelpDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenElements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  HelpId,for: indexPath) as! HelpCell
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.ButtonLabel.setTitle(screenElements[indexPath.item].lable, for: .normal)
        
        cell.IsLeading?.isActive = indexPath.item % 2 == 1 ? false:true
        cell.IsTrailing?.isActive = indexPath.item % 2 != 1 ? false:true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: ControlWidth(220))
    }
    
    func HelpAction(_ Cell:HelpCell) {
       
    if HomeScreenData?.userData?.email != nil {
    if let indexPath = HelpCollection.indexPath(for: Cell) {
    switch screenElements[indexPath.item].id {
    case 152:
    Present(ViewController: self, ToViewController: ReportLostVC())
    case 153:
    Present(ViewController: self, ToViewController: SubmitComplainVC())
            
    default:
    break
    }
    }
    }else{
    ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
    Present(ViewController: self, ToViewController: MyAccountVC())
    },"Sign-Up")
    }
    }
    
    func SetDataHelp() {
    self.view.subviews.forEach { View in View.alpha = 0}
    UIView.animate(withDuration: 0.4) {
    DataGetScreen(self,  23) { data in
    self.screenElements = data.screenElements
    self.ViewDismiss.TextLabel = data.title ?? "Help & Support"
    self.HelpCollection.reloadData()
    } _: { IsError in
    self.view.subviews.forEach { View in
    View.alpha = IsError ? 0:1
    self.ViewNoData.isHidden = IsError ? false:true
                    
    if IsError == true {
    self.SetUpIsError(true) {
    self.SetDataHelp()
    }
    }
    }
    }
    }
    }

}
