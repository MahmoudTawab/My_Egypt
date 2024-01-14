//
//  TransportationVC.swift
//  Sia
//
//  Created by Emojiios on 20/10/2022.
//

import UIKit

class TransportationVC: ViewController {
    
    let TransportationImage = ["Test1","Test2","Test1","Test2","Test1"]
    let TransportationTitle = ["Request Limousine","Request Economy Car","Request Taxi","Museums","Request Limousine"]
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .black
    }
    
    fileprivate func SetUpItems() {
    view.addSubview(TransportationCollection)
    TransportationCollection.frame = CGRect(x: 0, y: -TopHeight, width: view.frame.width, height: view.frame.height + TopHeight)
        
    TransportationCollection.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(15), y: ControlY(50), width: view.frame.width - ControlX(30), height: ControlWidth(40))
    
    TransportationCollection.SetAnimations()
    }
    

    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.Label.textColor = .white
        View.IconImage.tintColor = .white
        View.TextLabel = "Transportation"
        View.IconSize = CGSize(width: ControlWidth(22), height: ControlWidth(22))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    let TransportationId = "TransportationId"
    lazy var  TransportationCollection: CollectionAnimations = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.bounces = false
        vc.register(TransportationCell.self, forCellWithReuseIdentifier: TransportationId)
        return vc
    }()
    
}


extension TransportationVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,TransportationDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TransportationTitle.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  TransportationId,for: indexPath) as! TransportationCell
        cell.Delegate = self
        cell.TopBarView.Label.text = TransportationTitle[indexPath.item]
        cell.ImageView.image = UIImage(named: TransportationImage[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: ControlWidth(280))
    }
    
    
    func TransportationAction(_ Cell:TransportationCell) {
        
    }
    
    func TransportationBarAction(_ Cell:TransportationCell) {
        
    }
}


