//
//  CategoriesVC.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit
import SDWebImage

class CategoriesVC: ViewController {
    
    var DataCategories = [Categories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        AllCategories()
        ShowWhatsUp = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        
    view.addSubview(ImageBackground1)
    ImageBackground1.frame = view.bounds
        
    view.addSubview(CategoriesCollection)
    view.addSubview(ImageBackground2)
    view.addSubview(CategoriesLabel)
    CategoriesLabel.frame = CGRect(x: ControlX(15), y: ControlY(45), width: view.frame.width - ControlX(30), height: ControlWidth(40))
    
    CategoriesCollection.topAnchor.constraint(equalTo: CategoriesLabel.bottomAnchor, constant: ControlY(10)).isActive = true
    CategoriesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
    CategoriesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    CategoriesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    ImageBackground2.frame = view.bounds
        
    self.view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    }
    
    lazy var CategoriesLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(22))
        return Label
    }()
    
    lazy var ImageBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "CategoriesAll1")
        return ImageView
    }()
    
    lazy var ImageBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "CategoriesAll2")
        return ImageView
    }()

    let CategoriesId = "Categories"
    lazy var  CategoriesCollection: CollectionAnimations = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(5)
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        vc.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        vc.addPullLoadableView(loadMoreView, type: .loadMore)
        
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesId)
        vc.contentInset = UIEdgeInsets(top: ControlY(5), left: 0, bottom: ControlX(15), right: 0)
        return vc
    }()

    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func AllCategories(removeAll:Bool = false, ShowDots:Bool = true) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }

    let api = "\(url + GetAllCategories)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["Take": 15,
                                   "Skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in

    if removeAll {
    self.CategoriesCollection.RemoveAnimations {
    self.DataCategories.removeAll()
    self.Animations = true
    self.AddData(ModelCategories(dictionary: dictionary))
    }
    }else{
    self.AddData(ModelCategories(dictionary: dictionary))
    }
        
    } array: { _ in
    } Err: { error in
    if self.DataCategories.count != 0 {
    return
    }else{
    self.IfNoData()
    self.SetUpIsError(true) {self.refresh()}
    }
    }
    }
    
    func AddData(_ dictionary:ModelCategories) {
    for item in dictionary.categories {
    self.DataCategories.append(item)
    self.skip += 1
    self.fetchingMore = false
    if DataCategories.count == dictionary.categories.count {
    CategoriesLabel.text = dictionary.screenData?.title ?? "All Categories"
    self.Animations == true ? self.CategoriesCollection.SetAnimations() {self.Animations = false} : self.CategoriesCollection.reloadData()
        
    UIView.animate(withDuration: 0.5) {
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
    self.ViewNoData.isHidden = true
    }else{
    self.CategoriesCollection.reloadData()
    }
    }
    self.IfNoData()
    }
    
    
    @objc func refresh() {
    skip = 0
    AllCategories(removeAll: true)
    }
    
    func IfNoData() {
    if self.DataCategories.count != 0 {
    ViewNoData.MessageDetails = "Something went wrong while processing your request, please try again later"
    }else{
    ViewNoData.MessageDetails = "Not Found"
    }
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewDots.endRefreshing(){}
    }
}

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  CategoriesId,for: indexPath) as! CategoriesCell
        cell.BackgroundHeight2?.isActive = true
        cell.BackgroundHeight1?.isActive = false
        cell.CategoriesLabel.addInterlineSpacing(spacingValue: ControlX(8))
        cell.TopBackground?.isActive = indexPath.item % 2 != 1 ? true:false
        cell.BottomBackground?.isActive = indexPath.item % 2 != 1 ? false:true
        cell.CategoriesLabel.text = DataCategories[indexPath.item].categoryName
        cell.ImageView.sd_setImage(with: URL(string: DataCategories[indexPath.item].photo ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - ControlWidth(5), height: ControlWidth(250))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let DetailsVC = CategoriesDetailsVC()
    DetailsVC.CategoryId = DataCategories[indexPath.item].id
    DetailsVC.ViewDismiss.TextLabel = DataCategories[indexPath.item].categoryName ?? ""
    Present(ViewController: self, ToViewController: DetailsVC)
    }
    
}


extension CategoriesVC: KRPullLoadViewDelegate {
    
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.AllCategories(removeAll: false, ShowDots: false)
        }
        default: break
        }
        return
        }

        switch state {
        case .none:
        pullLoadView.messageLabel.text = ""
        case .pulling(_, _):
        pullLoadView.messageLabel.text = "Pull more"
        case let .loading(completionHandler):
        pullLoadView.messageLabel.text = "Updating"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.refresh()
        }
        }
        return
        }
}

