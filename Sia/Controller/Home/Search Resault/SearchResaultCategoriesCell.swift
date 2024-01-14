//
//  SearchResaultCategoriesCell.swift
//  Sia
//
//  Created by Emojiios on 16/02/2023.
//

import UIKit
import SDWebImage

protocol SearchCategoriesDelegate {
    func CategoriesAction(_ indexPath:IndexPath)
}

class SearchResaultCategoriesCell: UICollectionViewCell ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , HomeCategoriesDelegate {
        
    let CategoriesId = "CategoriesId"
    var Delegate:SearchCategoriesDelegate?
    
    var SearchCategories : Search? {
        didSet {
            SearchResaultCollection.reloadData()
        }
    }
    
    lazy var SearchResaultCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ControlX(15)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsVerticalScrollIndicator = false
        vc.register(HomeCategories.self, forCellWithReuseIdentifier: CategoriesId)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(-10), bottom: 0, right: 0)
        return vc
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchCategories?.categories.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesId, for: indexPath) as! HomeCategories
        cell.Delegate = self
        cell.Label.textColor = .black
        cell.backgroundColor = .clear
        cell.Label.numberOfLines = 2
        cell.Label.text = SearchCategories?.categories[indexPath.item].categoryName
        cell.Image.sd_setImage(with: URL(string: SearchCategories?.categories[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
    return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: ControlWidth(94), height: ControlWidth(120))
    }
    
    func HomeCategoriesAction(_ Cell: HomeCategories) {
    if let indexPath = SearchResaultCollection.indexPath(for: Cell) {
    Delegate?.CategoriesAction(indexPath)
    }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(SearchResaultCollection)
        SearchResaultCollection.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
