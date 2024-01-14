//
//  SearchResaultVC.swift
//  Sia
//
//  Created by Emojiios on 09/02/2023.
//

import UIKit

class SearchResaultVC: ViewController {
   
    var SearchData : Search?
    var ScreenData = [ScreenElements]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        
    view.addSubview(SearchResaultBackground)
    SearchResaultBackground.frame = view.bounds
        
    view.addSubview(SearchResault1)
    SearchResault1.frame = view.bounds
        
    view.addSubview(SearchResaultCollection)
    view.addSubview(SearchResault2)
    view.addSubview(TopStack)
    view.addSubview(SearchTF)
        
    TopStack.frame = CGRect(x: ControlX(15), y: ControlY(45), width: view.frame.width - ControlX(30), height: ControlWidth(40))
        
    SearchTF.frame = CGRect(x: ControlX(15), y: TopStack.frame.maxY + ControlY(20), width:  view.frame.width - ControlX(30), height: ControlWidth(48))

    SearchResault2.frame = view.bounds
        
    view.addSubview(NoResault)
    NoResault.frame = CGRect(x: ControlX(50), y: view.center.y , width:  view.frame.width - ControlX(100), height: ControlWidth(120))
        
    SearchResaultCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    SearchResaultCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
    SearchResaultCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
    SearchResaultCollection.topAnchor.constraint(equalTo: SearchTF.bottomAnchor, constant: ControlY(15)).isActive = true
        
    SetDataSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,object: nil, queue: OperationQueue.main,using: keyboardWillShowNotification)
        
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,object: nil, queue: OperationQueue.main,
        using: keyboardWillHideNotification)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShowNotification(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        EdgeInsets(top: 0, bottom: keyboardSize.height + 10)
    }
    
    func keyboardWillHideNotification(notification: Notification) {
    EdgeInsets(top: 0, bottom: 10)
    }
    
    func EdgeInsets(top:CGFloat,bottom:CGFloat) {
        let contentInsets = UIEdgeInsets(top: top, left: 0.0, bottom: bottom, right: 0.0)
        SearchResaultCollection.contentInset = contentInsets
        SearchResaultCollection.scrollIndicatorInsets = contentInsets
    }
    
    lazy var SearchResaultBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.7776824832, green: 0.9091050029, blue: 1, alpha: 1)
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EmergencyContactsBackground")
        return ImageView
    }()
    
    lazy var SearchResault1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "SearchResault1")
        return ImageView
    }()
    
    lazy var SearchResault2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "SearchResault2")
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
    
    
    let ActivityIndicator : UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .white)
    aiv.hidesWhenStopped = true
    aiv.color = .white
    aiv.translatesAutoresizingMaskIntoConstraints = false
    aiv.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
    return aiv
    }()
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ViewDismiss,ActivityIndicator])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        return Stack
    }()
    
    lazy var SearchTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        tf.clearButtonMode = .never
        tf.Icon.tintColor = .black
        tf.IconImage = UIImage(named: "Search")
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.SetUpIcon(LeftOrRight: false, Width: 35, Height: 35)
        tf.addTarget(self, action: #selector(ActionSearch(_:)), for: .editingChanged)
        tf.Icon.addTarget(self, action: #selector(ActionSearchIcon), for: .touchUpInside)
        return tf
    }()
    
    @objc func ActionSearchIcon() {
    SearchTF.becomeFirstResponder()
    }
    
    @objc func ActionSearch(_ TF:FloatingTF) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.4) {
            if self.SearchTF.NoEmptyError() {
            guard let url = defaults.string(forKey: "API") else {
            LodBaseUrl()
            self.ViewDots.endRefreshing {}
            ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
            return
            }
            
            let api = "\(url + ApiSearch)"
            let token = defaults.string(forKey: "jwt") ?? ""
            guard let TextSearch = self.SearchTF.text else { return}
                
            let parameters = ["Word": TextSearch]
                
            self.ActivityIndicator.startAnimating()
            PostAPI(timeout: 60, api: api, token: token, parameters: parameters) { _ in
            } dictionary: { dictionary in
            self.ActivityIndicator.stopAnimating()
            self.SearchData = Search(dictionary: dictionary)
                
            if self.SearchData?.places.count == 0 && self.SearchData?.events.count == 0 && self.SearchData?.shows.count == 0 && self.SearchData?.categories.count == 0 {
            self.NoResault.isHidden = false
            self.SearchResaultCollection.isHidden = true
            self.SearchResaultCollection.reloadData()
            }else{
            self.NoResault.isHidden = true
            self.SearchResaultCollection.isHidden = false
            self.SearchResaultCollection.reloadData()
            }
            } array: { _ in
            } Err: { _ in
            self.NoResault.isHidden = false
            self.ActivityIndicator.stopAnimating()
            self.SearchResaultCollection.isHidden = true
            self.SearchResaultCollection.reloadData()
            }
            }else{
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
            self.NoResault.isHidden = false
            self.ActivityIndicator.stopAnimating()
            self.SearchResaultCollection.isHidden = true
            self.SearchResaultCollection.reloadData()
            }
            }
        }
    }
    
    lazy var NoResault : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(20))
        return Label
    }()
    
    
    let CategoriesId = "CategoriesId"
    let EventsPlacesId = "EventsPlacesId"
    lazy var SearchResaultCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(25)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.isHidden = true
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.keyboardDismissMode = .interactive
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(FavoritesCell.self, forCellWithReuseIdentifier: EventsPlacesId)
        vc.register(SearchResaultCategoriesCell.self, forCellWithReuseIdentifier: CategoriesId)

        vc.contentInset = UIEdgeInsets(top: ControlY(5), left: 0, bottom: ControlX(15), right: 0)
        vc.register(SearchResaultHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchResaultHeaderId")
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchResaultFooterId")
        return vc
    }()

    
    func SetDataSearch() {
    self.view.subviews.forEach { View in View.alpha = 0}
    UIView.animate(withDuration: 0.4) {
    DataGetScreen(self,  22) { data in
    
    self.ScreenData = data.screenElements
    self.ViewDismiss.TextLabel = data.title ?? "Search Resault"
    self.NoResault.text = data.screenElements.filter({$0.id == 150}).first?.lable ?? ""
    self.SearchTF.attributedPlaceholder = NSAttributedString(string: data.screenElements.filter({$0.id == 149}).first?.placeholder ?? "Search", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    self.SearchResaultCollection.reloadData()
        
    } _: { IsError in
    self.view.subviews.forEach { View in
    View.alpha = IsError ? 0:1
    self.ViewNoData.isHidden = IsError ? false:true
                    
    if IsError == true {
    self.SetUpIsError(true) {
    self.SetDataSearch()
    }
    }
    }
    }
    }
    }
}

extension SearchResaultVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , FavoritesDelegate ,SearchCategoriesDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return SearchData?.places.count ?? 0
        case 1:
            return SearchData?.events.count ?? 0
        case 2:
            return SearchData?.shows.count ?? 0
        case 3:
            return 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  EventsPlacesId,for: indexPath) as! FavoritesCell
            cell.Delegate = self
            cell.clipsToBounds = true
            cell.layer.cornerRadius = ControlWidth(12)
            cell.TitleLabel.text = SearchData?.places[indexPath.item].name
            cell.ImageView.sd_setImage(with: URL(string: SearchData?.places[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            cell.FavoritesButton.setBackgroundImage(SearchData?.places[indexPath.item].fav ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)

            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  EventsPlacesId,for: indexPath) as! FavoritesCell
            cell.Delegate = self
            cell.clipsToBounds = true
            cell.layer.cornerRadius = ControlWidth(12)
            cell.TitleLabel.text = SearchData?.events[indexPath.item].name
            cell.ImageView.sd_setImage(with: URL(string: SearchData?.events[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            cell.FavoritesButton.setBackgroundImage(SearchData?.events[indexPath.item].fav ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)

            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsPlacesId, for: indexPath) as! FavoritesCell
            cell.Delegate = self
            cell.clipsToBounds = true
            cell.layer.cornerRadius = ControlWidth(12)
            cell.TitleLabel.text = SearchData?.shows[indexPath.item].name
            cell.ImageView.sd_setImage(with: URL(string: SearchData?.shows[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            cell.FavoritesButton.setBackgroundImage(SearchData?.shows[indexPath.item].fav ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)

            return cell
            
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesId, for: indexPath) as! SearchResaultCategoriesCell
            cell.Delegate = self
            cell.SearchCategories = SearchData
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 3 {
            return CGSize(width: collectionView.frame.width, height: ControlWidth(120))
        }else{
            return CGSize(width: collectionView.frame.width , height: ControlWidth(220))
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
        let Cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchResaultHeaderId", for: indexPath) as! SearchResaultHeader
        Cell.backgroundColor = .clear
        switch indexPath.section {
        case 0:
        Cell.Label.text = self.ScreenData.filter({$0.id == 154}).first?.lable ?? ""
        case 1:
        Cell.Label.text = self.ScreenData.filter({$0.id == 155}).first?.lable ?? ""
        case 2:
        Cell.Label.text = self.ScreenData.filter({$0.id == 156}).first?.lable ?? ""
        case 3:
        Cell.Label.text = self.ScreenData.filter({$0.id == 157}).first?.lable ?? ""
        default:
        break
        }
        return Cell
        }else {
        let Cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchResaultFooterId", for: indexPath)
        Cell.backgroundColor = .clear
        return Cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width , height: SearchData?.places.count == 0 ? 0 : ControlWidth(50))
            
        case 1:
            return CGSize(width: collectionView.frame.width , height: SearchData?.events.count == 0 ? 0 : ControlWidth(50))

        case 2:
            return CGSize(width: collectionView.frame.width, height: SearchData?.shows.count == 0 ? 0 : ControlWidth(50))
            
        case 3:
            return CGSize(width: collectionView.frame.width, height: SearchData?.categories.count == 0 ? 0 : ControlWidth(50))

        default:
            return .zero
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//    return CGSize(width: collectionView.frame.width , height: ControlWidth(5))
//    }
    
    func FavoritesAction(_ Cell:FavoritesCell) {
        if let indexPath = SearchResaultCollection.indexPath(for: Cell) {
            switch indexPath.section {
            case 0:
                let DetailsVC = PlacesDetailsVC()
                DetailsVC.PlaceId = SearchData?.places[indexPath.item].id 
                DetailsVC.GetDataPlaceDetails()
                Present(ViewController: self, ToViewController: DetailsVC)
            case 1:
                let DetailsVC = EventsDetailsVC()
                DetailsVC.EventId = SearchData?.events[indexPath.item].id 
                DetailsVC.GetDataEventDetails()
                Present(ViewController: self, ToViewController: DetailsVC)
            case 2:
                let ShowDetails = ShowDetailsVC()
                ShowDetails.ShowId = SearchData?.shows[indexPath.item].id 
                Present(ViewController: self, ToViewController: ShowDetails)
            default:
                break
            }
        }
    }
    
    func FavoritesButtonAction(_ Cell:FavoritesCell) {
        if let indexPath = SearchResaultCollection.indexPath(for: Cell) {
            switch indexPath.section {
            case 0:
                AddAndDeleteFavorite(indexPath: indexPath, PlaceId: SearchData?.places[indexPath.item].id ?? 0, EventId: 0, ShowId: 0)
            case 1:
                AddAndDeleteFavorite(indexPath: indexPath, PlaceId: 0, EventId: SearchData?.events[indexPath.item].id ?? 0, ShowId: 0)
            case 2:
                AddAndDeleteFavorite(indexPath: indexPath, PlaceId: 0, EventId: 0, ShowId: SearchData?.shows[indexPath.item].id ?? 0)
            default:
                break
            }
        }
    }
    
    
    func AddAndDeleteFavorite(indexPath:IndexPath ,PlaceId:Int ,EventId:Int,ShowId:Int) {
        if HomeScreenData?.userData?.emailConfirmed == true && HomeScreenData?.userData?.email != nil {
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
            
        if PlaceId != 0 {
        self.SearchData?.places[indexPath.item].fav = !(self.SearchData?.places[indexPath.item].fav ?? false)
        self.SearchResaultCollection.reloadData()
        }else if EventId != 0 {
        self.SearchData?.events[indexPath.item].fav = !(self.SearchData?.events[indexPath.item].fav ?? false)
        self.SearchResaultCollection.reloadData()
        }else if ShowId != 0 {
        self.SearchData?.shows[indexPath.item].fav = !(self.SearchData?.shows[indexPath.item].fav ?? false)
        self.SearchResaultCollection.reloadData()
        }

        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error,.error) {}
        }
        }else{
        if HomeScreenData?.userData?.email == nil {
        ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        Present(ViewController: self, ToViewController: MyAccountVC())
        },"Sign-Up")
        }else{
        ShowMessageAlert("ErrorIcon", "Please Confirm your Email",
                                                "If you not confirmed your account you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        self.ResendConfirmeation()
        },"Re-send")
        }
        }
    }
    
    func ResendConfirmeation() {
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
                
        let api = "\(url + ResendConfirmeationEmile)"
        let token = defaults.string(forKey: "jwt") ?? ""
                
        self.ViewDots.beginRefreshing()
        PostAPI(timeout: 60 ,api: api, token: token, parameters: [:]) { _ in
        self.ViewDots.endRefreshing("Success Resend Confirmeation Emile", .success) {}
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error,.error) {}
        }
    }
    
    func CategoriesAction(_ indexPath:IndexPath) {
        if SearchData?.categories[indexPath.item].id != nil && SearchData?.categories[indexPath.item].id != 0 {
            let DetailsVC = CategoriesDetailsVC()
            DetailsVC.CategoryId = SearchData?.categories[indexPath.item].id
            DetailsVC.ViewDismiss.TextLabel = SearchData?.categories[indexPath.item].categoryName ?? ""
            Present(ViewController: self, ToViewController: DetailsVC)
        }
    }
    
}



