//
//  GpsTrackingVC.swift
//  Sia
//
//  Created by Emojiios on 02/02/2023.
//

import UIKit

class GpsTrackingVC: ViewController {

    let GpsTrackingTitle = ["Location Regulations","Switch Location","GPS Tracking"]
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
    view.addSubview(GpsTrackingBackground1)
    GpsTrackingBackground1.frame = view.bounds
          
    view.addSubview(GpsTrackingCollection)
    view.addSubview(GpsTrackingBackground2)
    view.addSubview(ViewDismiss)
          
    ViewDismiss.frame = CGRect(x: ControlX(15), y: ControlY(45), width: view.frame.width - ControlX(30), height: ControlWidth(40))
    GpsTrackingBackground2.frame = view.bounds
    GpsTrackingCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    GpsTrackingCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    GpsTrackingCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    GpsTrackingCollection.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
          
    
  }
          
    lazy var GpsTrackingBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "GpsBackground1")
        return ImageView
    }()
    
    lazy var GpsTrackingBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "GpsBackground2")
        return ImageView
    }()
    
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.Label.textColor = .black
        View.IconImage.tintColor = .black
        View.TextLabel = "GPS tracking & Location services".localizable
        View.Label.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    let GpsTrackingId = "GpsTracking"
    lazy var GpsTrackingCollection: CollectionAnimations = {
    let layout = RTLCollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = ControlX(15)
    let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
    vc.backgroundColor = .clear
    vc.dataSource = self
    vc.delegate = self
    vc.showsVerticalScrollIndicator = false
    vc.translatesAutoresizingMaskIntoConstraints = false
    vc.register(GpsTrackingCell.self, forCellWithReuseIdentifier: GpsTrackingId)
    vc.contentInset = UIEdgeInsets(top: ControlY(5), left: 0, bottom: ControlX(15), right: 0)
    return vc
    }()
    
}


extension GpsTrackingVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , GpsTrackingDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GpsTrackingTitle.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  GpsTrackingId,for: indexPath) as! GpsTrackingCell
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.ButtonLabel.setTitle(GpsTrackingTitle[indexPath.item], for: .normal)
        
        cell.IsLeading?.isActive = indexPath.item % 2 == 1 ? false:true
        cell.IsTrailing?.isActive = indexPath.item % 2 != 1 ? false:true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: ControlWidth(280))
    }
    
    func GpsTrackingAction(_ Cell:GpsTrackingCell) {
        if let indexPath = GpsTrackingCollection.indexPath(for: Cell) {
        switch indexPath.item {
        case 0:
            print("")
        Present(ViewController: self, ToViewController: MapKitSearchViewController())
            
        case 1:
            print("")
        Present(ViewController: self, ToViewController: MapKitSearchViewController())
            
        case 2:
            print("")
        Present(ViewController: self, ToViewController: MapKitSearchViewController())
            
        default:
        break
        }
        }
    }


}

