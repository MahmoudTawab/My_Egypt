//
//  CategoriesDetailsVC.swift
//  Sia
//
//  Created by Emojiios on 20/10/2022.
//

import UIKit
import SDWebImage

class CategoriesDetailsVC: ViewController {

    var CategoryId : Int?
    var DataCatrgories = [Categories]()
    var DataPlacesAndEvents = [PlacesAndEvents]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        DataCategoryPlaces()
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
      
    view.addSubview(CategoriesBackground1)
    CategoriesBackground1.frame = view.bounds
      
    view.addSubview(PlacesNoData)
    view.addSubview(CollectionPlaces)
    view.addSubview(MoreCategoriesStack)
    view.addSubview(CategoriesBackground2)
    view.addSubview(ViewDismiss)
      
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(35), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
    CategoriesBackground2.frame = view.bounds
      
    CollectionPlaces.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    CollectionPlaces.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    CollectionPlaces.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2.1).isActive = true
    CollectionPlaces.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlX(20)).isActive = true
      
    PlacesNoData.topAnchor.constraint(equalTo: CollectionPlaces.topAnchor).isActive = true
    PlacesNoData.heightAnchor.constraint(equalTo: CollectionPlaces.heightAnchor).isActive = true
    PlacesNoData.leadingAnchor.constraint(equalTo: CollectionPlaces.leadingAnchor, constant: ControlX(40)).isActive = true
    PlacesNoData.trailingAnchor.constraint(equalTo: CollectionPlaces.trailingAnchor, constant: ControlX(-40)).isActive = true
    
    MoreCategoriesStack.heightAnchor.constraint(equalToConstant: ControlWidth(195)).isActive = true
    MoreCategoriesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    MoreCategoriesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
    MoreCategoriesStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ControlX(-25)).isActive = true
      

    self.view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
  }
          
    
    lazy var CategoriesBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "CategoriesBackground1")
        return ImageView
    }()
    
    
    lazy var CategoriesBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "CategoriesBackground2")
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

    let CollectionPlacesId = "CollectionPlaces"
    lazy var CollectionPlaces: FSPagerView = {
        let View = FSPagerView()
        View.delegate = self
        View.dataSource = self
        View.isInfinite = false
        View.isScrollEnabled = true
        View.backgroundColor = .clear
        View.collectionView.ContentInsetLeft = 0
        View.interitemSpacing = ControlWidth(10)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.transformer = FSPagerViewTransformer(type: .linear)
        View.register(DetailsCell.self, forCellWithReuseIdentifier: CollectionPlacesId)
        View.itemSize = CGSize(width: view.frame.width - ControlWidth(80), height: view.frame.height / 2.1)
        return View
    }()
    
    lazy var PlacesNoData : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(26))
        return Label
    }()

    // MARK: Set up More Categories
    lazy var MoreCategoriesLabel : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    
    var CategoriesID = "Categories"
    lazy var CollectionCategories: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(HomeCategories.self, forCellWithReuseIdentifier: CategoriesID)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(-4), bottom: 0, right: 0)
        return vc
    }()
    
    lazy var MoreCategoriesStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [MoreCategoriesLabel,CollectionCategories])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.arrangedSubviews[1].heightAnchor.constraint(equalTo: Stack.heightAnchor, constant: ControlWidth(-50)).isActive = true
        return Stack
    }()
    
    
    var skip = 0
    var fetchingMore = false
    @objc func DataCategoryPlaces(removeAll:Bool = false,ShowDots:Bool = true) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }

    let api = "\(url + GetCategoryPlaces)"
    guard let Id = CategoryId else { return }
    let token = defaults.string(forKey: "jwt") ?? ""
    let parameters:[String:Any] = ["CategoryId": Id,
                                   "Take": 10,
                                   "Skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    } dictionary: { dictionary in
    self.ViewDots.endRefreshing(){}
    if removeAll {
    self.DataPlacesAndEvents.removeAll()
    self.CollectionPlaces.reloadData()
    }
    self.IfNoData()
    self.AddData(CategoryPlaces(dictionary: dictionary))
    } array: { _ in
    } Err: { error in
    if self.DataPlacesAndEvents.count != 0 {
    return
    }else{
    self.IfNoData()
    self.SetUpIsError(true) {self.DataCategoryPlaces()}
    }
    }
    }
    
    func AddData(_ dictionary : CategoryPlaces) {
        
    for item in dictionary.placesAndEvents {
    self.DataPlacesAndEvents.append(item)
    self.skip += 1
    self.fetchingMore = false
    self.CollectionPlaces.reloadData()
    }
        
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
    self.PlacesNoData.isHidden = self.DataPlacesAndEvents.count == 0 ? false : true
    self.CollectionPlaces.isHidden = self.DataPlacesAndEvents.count != 0 ? false : true
    }
        
    if DataCatrgories.count != dictionary.categories.count {
    self.DataCatrgories.removeAll()
        
    for item in dictionary.categories.sorted(by: {$0.id ?? 1 < $1.id ?? 2}) {
    self.DataCatrgories.append(item)
    self.CollectionCategories.reloadData()
    }
    }

    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlWidth(15)
    style.alignment = .center
        
    let attributedString = NSMutableAttributedString(string: "  ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:style
    ])
        
    if let Image = UIImage(named: "MoreCategories")?.toAttributedString(with: ControlWidth(30), tint: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) {
    attributedString.append(Image)
    }
        
    attributedString.append(NSAttributedString(string: dictionary.screenData?.screenElements.filter({$0.id == 90}).first?.lable ?? "Category Places", attributes: [
    .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
    .paragraphStyle:style
    ]))
        
    if let Image = UIImage(named: "MoreCategories")?.toAttributedString(with: ControlWidth(30), tint: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) {
    attributedString.append(Image)
    }
        
    MoreCategoriesLabel.attributedText = attributedString
      
        
    PlacesNoData.text = dictionary.screenData?.screenElements.filter({$0.id == 190}).first?.lable ?? "There are no places to display it"
    PlacesNoData.addInterlineSpacing(spacingValue: ControlWidth(10))
    self.IfNoData()
    }
    
    func IfNoData() {
    if self.DataPlacesAndEvents.count == 0 && DataCatrgories.count == 0 {
    self.view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    self.ViewDots.endRefreshing(){}
    }else{
    UIView.animate(withDuration: 0.5) {
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}}
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing(){}
    }
        
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(DataCategoryPlaces), for: .touchUpInside)
    }
    
}

extension CategoriesDetailsVC : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout ,HomeCategoriesDelegate  {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataCatrgories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesID, for: indexPath) as! HomeCategories
        cell.Delegate = self
        cell.backgroundColor = .clear
        cell.Label.textColor = .black
        cell.Label.numberOfLines = 2
        cell.Label.text = DataCatrgories[indexPath.item].categoryName
        cell.Image.sd_setImage(with: URL(string: DataCatrgories[indexPath.item].photo ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }
    
    func HomeCategoriesAction(_ Cell:HomeCategories) {
    if let indexPath = CollectionCategories.indexPath(for: Cell) {
    if CategoryId != DataCatrgories[indexPath.item].id {
    skip = 0
    CategoryId = DataCatrgories[indexPath.item].id
    ViewDismiss.TextLabel = DataCatrgories[indexPath.item].categoryName ?? ""
    DataCategoryPlaces(removeAll: true,ShowDots:true)
    }
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height - ControlWidth(30), height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    cell.alpha = 0
    UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
    cell.alpha = 1
    }, completion: nil)
    }
}


extension CategoriesDetailsVC : FSPagerViewDelegate, FSPagerViewDataSource  {
        
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return DataPlacesAndEvents.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CollectionPlacesId, at: index) as! DetailsCell
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = ControlX(10)
        cell.DetailsLabel.text = DataPlacesAndEvents[index].name
        cell.DetailsLabel.addInterlineSpacing(spacingValue: 5)
        cell.ImageView.sd_setImage(with: URL(string: DataPlacesAndEvents[index].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if DataPlacesAndEvents[index].placeId != nil {
            let DetailsVC = PlacesDetailsVC()
            DetailsVC.PlaceId = DataPlacesAndEvents[index].placeId
            DetailsVC.GetDataPlaceDetails()
            Present(ViewController: self, ToViewController: DetailsVC)
        }else{
            let DetailsVC = EventsDetailsVC()
            DetailsVC.EventId = DataPlacesAndEvents[index].eventId
            DetailsVC.GetDataEventDetails()
            Present(ViewController: self, ToViewController: DetailsVC)
        }
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let contentOffsetX = pagerView.collectionView.contentOffset.x
        if contentOffsetX >= (pagerView.collectionView.contentSize.width - pagerView.bounds.width) - 20 /* Needed offset */ {
        guard !self.fetchingMore else { return }
        self.fetchingMore = true
        
        self.DataCategoryPlaces(ShowDots: true)
        }
    }
}

