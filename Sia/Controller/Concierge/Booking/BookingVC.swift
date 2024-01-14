//
//  BookingVC.swift
//  Sia
//
//  Created by Emojiios on 20/10/2022.
//

import UIKit

class BookingVC: ViewController {

    let BookingImage = ["Test1","Test2","Test1","Test2","Test1","Test2"]
    let BookingTitle = ["Hotel Booking","Restaurant & Clubs","Concert / Event Booking","Museums","Clinics & Doctors","Hotel Booking"]
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .black
    }
    
    fileprivate func SetUpItems() {
    view.addSubview(BookingCollection)
    BookingCollection.frame = CGRect(x: 0, y: -TopHeight, width: view.frame.width, height: view.frame.height + TopHeight)
        
    BookingCollection.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(15), y: ControlY(50), width: view.frame.width - ControlX(30), height: ControlWidth(40))
    
    BookingCollection.SetAnimations()
    }
    

    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.Label.textColor = .white
        View.IconImage.tintColor = .white
        View.TextLabel = "Booking"
        View.IconSize = CGSize(width: ControlWidth(22), height: ControlWidth(22))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    let BookingId = "BookingId"
    lazy var  BookingCollection: CollectionAnimations = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.bounces = false
        vc.register(BookingCell.self, forCellWithReuseIdentifier: BookingId)
        return vc
    }()
    
}


extension BookingVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,BookingDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BookingTitle.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  BookingId,for: indexPath) as! BookingCell
        cell.Delegate = self
        cell.TopBarView.Label.text = BookingTitle[indexPath.item]
        cell.ImageView.image = UIImage(named: BookingImage[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: ControlWidth(280))
    }
    
    
    func BookingAction(_ Cell:BookingCell) {
        
    }
    
    func BookingBarAction(_ Cell:BookingCell) {
        
    }
}


