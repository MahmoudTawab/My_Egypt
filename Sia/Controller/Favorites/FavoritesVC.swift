//
//  FavoritesVC.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

class FavoritesVC: ViewController {
    

    var PlaceId = Int()
    var EventId = Int()
    var ShowId = Int()
    var DataMyFavorite: MyFavorite?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        
    view.addSubview(FavoritesBackground1)
    FavoritesBackground1.frame = view.bounds
        
    view.addSubview(FavoritesCollection)
    view.addSubview(FavoritesBackground2)
    view.addSubview(FavoritesLabel)
        
    FavoritesLabel.frame = CGRect(x: ControlX(15), y: ControlY(45), width: view.frame.width - ControlX(30), height: ControlWidth(40))
    FavoritesBackground2.frame = view.bounds
        
    FavoritesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    FavoritesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
    FavoritesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
    FavoritesCollection.topAnchor.constraint(equalTo: FavoritesLabel.bottomAnchor, constant: ControlY(40)).isActive = true
    GetDataMyFavorite()
        
    AddRefreshControl(Scroll: FavoritesCollection, color: #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)) {
    self.GetDataMyFavorite()
    }
    }
    
    lazy var FavoritesBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "FavoritesBackground1")
        return ImageView
    }()
    
    lazy var FavoritesBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "FavoritesBackground2")
        return ImageView
    }()
    
    lazy var FavoritesLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(22))
        return Label
    }()

    let ShowsId = "ShowsId"
    let PlacesId = "PlacesId"
    let EventsId = "EventsId"
    lazy var FavoritesCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(25)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.isHidden = false
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(FavoritesCell.self, forCellWithReuseIdentifier: PlacesId)
        vc.register(FavoritesCell.self, forCellWithReuseIdentifier: EventsId)
        vc.register(FavoritesCell.self, forCellWithReuseIdentifier: ShowsId)
        vc.contentInset = UIEdgeInsets(top: ControlY(5), left: 0, bottom: ControlX(15), right: 0)
        vc.register(FavoriteHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FavoriteResaultHeaderId")
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FavoriteResaultFooterId")
        return vc
    }()

}

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , FavoritesDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DataMyFavorite?.places.count ?? 0
        case 1:
            return DataMyFavorite?.Events.count ?? 0
        case 2:
            return DataMyFavorite?.Shows.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  PlacesId,for: indexPath) as! FavoritesCell
            cell.Delegate = self
            cell.clipsToBounds = true
            cell.layer.cornerRadius = ControlWidth(12)
            cell.TitleLabel.text = DataMyFavorite?.places[indexPath.item].plaseName
            cell.FavoritesButton.setBackgroundImage(UIImage(named: "FavoritesVC"), for: .normal)
            cell.ImageView.sd_setImage(with: URL(string: DataMyFavorite?.places[indexPath.item].plaseImage ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  EventsId,for: indexPath) as! FavoritesCell
            cell.Delegate = self
            cell.clipsToBounds = true
            cell.layer.cornerRadius = ControlWidth(12)
            cell.TitleLabel.text = DataMyFavorite?.Events[indexPath.item].eventName
            cell.FavoritesButton.setBackgroundImage(UIImage(named: "FavoritesVC"), for: .normal)
            cell.ImageView.sd_setImage(with: URL(string: DataMyFavorite?.Events[indexPath.item].eventImage ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowsId, for: indexPath) as! FavoritesCell
            cell.Delegate = self
            cell.clipsToBounds = true
            cell.layer.cornerRadius = ControlWidth(12)
            cell.TitleLabel.text = DataMyFavorite?.Shows[indexPath.item].showName
            cell.FavoritesButton.setBackgroundImage(UIImage(named: "FavoritesVC"), for: .normal)
            cell.ImageView.sd_setImage(with: URL(string: DataMyFavorite?.Shows[indexPath.item].showImage ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: ControlWidth(220))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
        let Cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavoriteResaultHeaderId", for: indexPath) as! FavoriteHeader
        Cell.backgroundColor = .clear
        Cell.Label.text = DataMyFavorite?.screenData?.screenElements[indexPath.section].lable
        return Cell
        }else {
        let Cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FavoriteResaultFooterId", for: indexPath)
        Cell.backgroundColor = .clear
        return Cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width , height: DataMyFavorite?.places.count == 0 ? 0 : ControlWidth(50))
            
        case 1:
            return CGSize(width: collectionView.frame.width , height: DataMyFavorite?.Events.count == 0 ? 0 : ControlWidth(50))

        case 2:
            return CGSize(width: collectionView.frame.width, height: DataMyFavorite?.Shows.count == 0 ? 0 : ControlWidth(50))

        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width , height: ControlWidth(20))
    }
    

    func FavoritesAction(_ Cell:FavoritesCell) {
        if let indexPath = FavoritesCollection.indexPath(for: Cell) {
            switch indexPath.section {
            case 0:
                let DetailsVC = PlacesDetailsVC()
                DetailsVC.PlaceId = DataMyFavorite?.places[indexPath.item].plaseId ?? 0
                DetailsVC.GetDataPlaceDetails()
                Present(ViewController: self, ToViewController: DetailsVC)
            case 1:
                let DetailsVC = EventsDetailsVC()
                DetailsVC.EventId = DataMyFavorite?.Events[indexPath.item].eventId ?? 0
                DetailsVC.GetDataEventDetails()
                Present(ViewController: self, ToViewController: DetailsVC)
            case 2:
                let DetailsVC = ShowDetailsVC()
                DetailsVC.ShowId = DataMyFavorite?.Shows[indexPath.item].showId ?? 0
                Present(ViewController: self, ToViewController: DetailsVC)
            default:
                break
            }
        }
    }
    
    
    func FavoritesButtonAction(_ Cell:FavoritesCell) {

    if let indexPath = FavoritesCollection.indexPath(for: Cell) {

        switch indexPath.section {
        case 0:
            PlaceId = DataMyFavorite?.places[indexPath.item].plaseId ?? 0
            EventId = 0
            ShowId = 0
            DeleteFavorite(indexPath)
        case 1:
            EventId = DataMyFavorite?.Events[indexPath.item].eventId ?? 0
            PlaceId = 0
            ShowId = 0
            DeleteFavorite(indexPath)
        case 2:
            ShowId = DataMyFavorite?.Shows[indexPath.item].showId ?? 0
            PlaceId = 0
            EventId = 0
            DeleteFavorite(indexPath)
        default:
            break
        }
    }
    }
    
    
    func DeleteFavorite(_ indexPath:IndexPath) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
            
    let api = "\(url + AddOrDeleteFavorite)"
    let token = defaults.string(forKey: "jwt") ?? ""
            
    self.ViewDots.beginRefreshing()
    let parameters = ["PlaceId":PlaceId,
                      "EventId":EventId,
                      "ShowId":ShowId]
        
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing {}
        
    switch indexPath.section {
    case 0:
    self.DataMyFavorite?.places.removeAll(where: {$0.plaseId == self.PlaceId})
    self.FavoritesCollection.deleteItems(at: [indexPath])
    self.FavoritesCollection.reloadData()
    case 1:
    self.DataMyFavorite?.Events.removeAll(where: {$0.eventId == self.EventId})
    self.FavoritesCollection.deleteItems(at: [indexPath])
    self.FavoritesCollection.reloadData()
    case 2:
    self.DataMyFavorite?.Shows.removeAll(where: {$0.showId == self.ShowId})
    self.FavoritesCollection.deleteItems(at: [indexPath])
    self.FavoritesCollection.reloadData()
    default:
    break
    }
        
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error,.error) {}
    }
    }
    
    func GetDataMyFavorite() {
    self.view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetDataMyFavorite()}
    return
    }

    let api = "\(url + GetMyFavorite)"
    let token = defaults.string(forKey: "jwt") ?? ""
            
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: [:]) { _ in
    } dictionary: { dictionary in
    self.DataMyFavorite = MyFavorite(dictionary: dictionary)
    self.FavoritesLabel.text = self.DataMyFavorite?.screenData?.title ?? "My Favorites"
    
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.ViewDots.endRefreshing {}
    self.ViewNoData.isHidden = true
    self.FavoritesCollection.reloadData()

    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
    self.FavoritesCollection.scrollRectToVisible(CGRect(x: 0, y: ControlWidth(30), width: self.FavoritesCollection.frame.width, height: self.FavoritesCollection.frame.height)
                                                    , animated: true)}
        
    } array: { _ in
    } Err: { _ in
    self.SetUpIsError(true) {
    self.GetDataMyFavorite()
    }
    }
    }
    
    
    
}


