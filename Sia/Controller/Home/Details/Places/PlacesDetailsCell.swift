//
//  PlacesDetailsCell.swift
//  Sia
//
//  Created by Emojiios on 15/03/2023.
//

import UIKit
import SDWebImage

protocol PlacesDetailsDelegate {
    func ShowsPlace(_ id:Int)
    func SimilarPlaces(_ id:Int)
    func ActionReadMore(_ Cell:PlacesDetailsCell)
    func ActionReserve(_ Cell:PlacesDetailsCell)
    func ActionAddReview(_ Cell:PlacesDetailsCell)
}

class PlacesDetailsCell: UITableViewCell, CustomSegmentedControlDelegate {
        
    var PlacesDetails : PlacesDetailsVC?
    var Delegate : PlacesDetailsDelegate?
    var Place : PlaceDetails? {
        didSet {
            let style = NSMutableParagraphStyle()
            style.alignment = .justified
            
            let attributedString = NSMutableAttributedString(string: Place?.screenData?.screenElements.filter({$0.id == 77}).first?.lable ?? "Read more", attributes: [
                .font: UIFont(name: "Nexa-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
                .foregroundColor: #colorLiteral(red: 0.8692544103, green: 0.6030948162, blue: 0.2276273072, alpha: 1) ,
                .paragraphStyle:style,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
            
            ReadMore.attributedText = attributedString
                        
            Hotline.TextLabel = Place?.AllDetails?.hotline ?? ""
            PhoneNumber.TextLabel = Place?.AllDetails?.phoneNumber ?? ""
            PriceRange.TextLabel = Place?.AllDetails?.priceRange ?? ""
            DressCode.TextLabel = Place?.AllDetails?.dressCode ?? ""
            if let Hours = Place?.AllDetails?.waitingHours { WaitingHours.TextLabel = "\(Hours)"}
            
            let NormalOperation = Place?.screenData?.screenElements.filter({$0.id == 191}).first?.lable ?? ""
            let timingAmendments = Place?.screenData?.screenElements.filter({$0.id == 193}).first?.lable ?? ""
            Date.TextLabel = "\(NormalOperation) \(Place?.AllDetails?.from ?? "") - \(Place?.AllDetails?.to ?? "")"
            TimingAmendments.text = timingAmendments
            
            BranchesStack.isHidden = Place?.AllDetails?.branches == nil ? true : false
            Hotline.isHidden = Place?.AllDetails?.hotline == nil ? true : false
            PhoneNumber.isHidden = Place?.AllDetails?.phoneNumber == nil ? true : false
            PriceRange.isHidden = Place?.AllDetails?.priceRange == nil ? true : false
            DressCode.isHidden = Place?.AllDetails?.dressCode == nil ? true : false
            WaitingHours.isHidden = Place?.AllDetails?.waitingHours == nil ? true : false
            StackDate.isHidden = Place?.AllDetails?.from == nil ? true : false
            
            FacebookButton.isHidden = Place?.AllDetails?.facebook == nil || Place?.AllDetails?.facebook == ""  ? true : false
            InstagramButton.isHidden = Place?.AllDetails?.instagram == nil || Place?.AllDetails?.instagram == "" ? true : false
            YouTubeButton.isHidden = Place?.AllDetails?.youtube == nil || Place?.AllDetails?.youtube == "" ? true : false
            OfficialWebsiteButton.isHidden = Place?.AllDetails?.OfficialWebsite == nil || Place?.AllDetails?.OfficialWebsite == "" ? true : false

            
            LabelDetails.text = Place?.AllDetails?.description ?? ""
            LabelDetails.addInterlineSpacing(spacingValue: ControlWidth(8))
            
            Branches.text = Place?.AllDetails?.branches ?? ""
            Branches.addInterlineSpacing(spacingValue: ControlWidth(8))

            FacilitesLabel.text = Place?.screenData?.screenElements.filter({$0.id == 178}).first?.lable ?? "Facilites"
            Reserve.setTitle(Place?.screenData?.screenElements.filter({$0.id == 79}).first?.lable ?? "Reserve", for: .normal)
            AddReview.setTitle(Place?.screenData?.screenElements.filter({$0.id == 80}).first?.lable ?? "Add a review", for: .normal)
            
            let Similar = Place?.screenData?.screenElements.filter({$0.id == 81}).first?.lable ?? "Similar Places"
            let Reviews = Place?.screenData?.screenElements.filter({$0.id == 84}).first?.lable ?? "Reviews"
            let Shows = Place?.screenData?.screenElements.filter({$0.id == 83}).first?.lable ?? "Shows"
            
            if Place?.ShowsPlace.count == 0 {
            MenuTapCollection.setButtonTitles(buttonTitles: [Similar,Reviews])
            }else{
            MenuTapCollection.setButtonTitles(buttonTitles: [Similar,Shows,Reviews])
            }
            
            TableView.reloadData()
            PlacesCollection.reloadData()
        }
    }
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionReadMore)))
        return Label
    }()
        
    lazy var ReadMore : UILabel = {
        let Label = UILabel()
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionReadMore)))
        return Label
    }()
    
    @objc func ActionReadMore() {
    Delegate?.ActionReadMore(self)
    }
    
    lazy var FacilitesLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()

    lazy var Hotline : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconImage.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.Label.numberOfLines = 1
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.IconImage.setImage(UIImage(named: "Hotline"), for: .normal)
        return View
    }()
    
    lazy var Date : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconImage.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.Label.numberOfLines = 1
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        return View
    }()
    
    lazy var TimingAmendments : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.713092144, green: 0.713092144, blue: 0.713092144, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(14))
        return Label
    }()
    
    
    lazy var SpacingTimingAmendments : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return View
    }()
    
    lazy var StackTimingAmendments : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SpacingTimingAmendments,TimingAmendments])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        return Stack
    }()
    
    lazy var StackDate : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Date,StackTimingAmendments])
        Stack.spacing = 0
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    lazy var WaitingHours : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconImage.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.Label.numberOfLines = 1
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.IconImage.setImage(UIImage(named: "timer"), for: .normal)
        return View
    }()
    
    lazy var PhoneNumber : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconImage.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.Label.numberOfLines = 1
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.IconImage.setImage(UIImage(named: "PhoneNumber"), for: .normal)
        return View
    }()
    
    lazy var PriceRange : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconImage.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.Label.numberOfLines = 1
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.IconImage.setImage(UIImage(named: "PriceRange"), for: .normal)
        return View
    }()
    
    lazy var DressCode : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconImage.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.Label.numberOfLines = 1
        View.translatesAutoresizingMaskIntoConstraints = false
        View.Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        View.IconSize = CGSize(width: ControlWidth(20), height: ControlWidth(20))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.IconImage.setImage(UIImage(named: "DressCode"), for: .normal)
        return View
    }()
    

    lazy var Branches : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular", size:  ControlWidth(15))
        return Label
    }()
    
    lazy var BranchesImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "location")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(18)).isActive = true
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(18)).isActive = true
        return ImageView
    }()
    
    lazy var BranchesStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [BranchesImage,Branches])
        Stack.alignment = .top
        Stack.axis = .horizontal
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    lazy var FacebookButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "facebook"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionFacebook), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        Button.heightAnchor.constraint(equalTo: Button.widthAnchor).isActive = true
        return Button
    }()
    
    
    @objc func ActionFacebook() {
        guard let url = URL(string: Place?.AllDetails?.facebook ?? "https://de-de.facebook.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    
    lazy var InstagramButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "Instagram"), for: .normal)
        Button.addTarget(self, action: #selector(ActionInstagram), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        Button.heightAnchor.constraint(equalTo: Button.widthAnchor).isActive = true
        return Button
    }()
    
    
    @objc func ActionInstagram() {
        guard let url = URL(string: Place?.AllDetails?.instagram ?? "https://instagram.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var YouTubeButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "YouTube"), for: .normal)
        Button.addTarget(self, action: #selector(ActionYouTube), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        Button.heightAnchor.constraint(equalTo: Button.widthAnchor).isActive = true
        return Button
    }()
    
    
    @objc func ActionYouTube() {
        guard let url = URL(string: Place?.AllDetails?.youtube ?? "https://www.youtube.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var OfficialWebsiteButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "OfficialWebsite"), for: .normal)
        Button.addTarget(self, action: #selector(ActionOfficialWebsite), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        Button.heightAnchor.constraint(equalTo: Button.widthAnchor).isActive = true
        return Button
    }()
    
    
    @objc func ActionOfficialWebsite() {
        guard let url = URL(string: Place?.AllDetails?.OfficialWebsite ?? "https://www.google.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
        }
    }
    
    lazy var MediaButton : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [OfficialWebsiteButton,FacebookButton,InstagramButton,YouTubeButton])
        Stack.axis = .horizontal
        Stack.alignment = .trailing
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var StackMedia : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UIView(),MediaButton])
        Stack.axis = .horizontal
        Stack.alignment = .trailing
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Stack
    }()
    
    lazy var Reserve : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.7583009601, green: 0.3631356359, blue: 0.1871258616, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ReserveAction), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ReserveAction() {
        Delegate?.ActionReserve(self)
    }
    
    
    lazy var AddReview : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.layer.borderColor = #colorLiteral(red: 0.7583009601, green: 0.3631356359, blue: 0.1871258616, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.borderWidth = ControlWidth(2)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.addTarget(self, action: #selector(ActionAddReview), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        Button.setTitleColor(#colorLiteral(red: 0.7583009601, green: 0.3631356359, blue: 0.1871258616, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionAddReview() {
        Delegate?.ActionAddReview(self)
    }
    
    
    lazy var ViewSpacing : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        return View
    }()
    
    lazy var MenuTapCollection : CustomSegmentedControl = {
        let View = CustomSegmentedControl()
        View.delegate = self
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return View
    }()
    
    var SimilarPlacesID = "SimilarPlacesID"
    lazy var PlacesCollection: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.alpha = 1
        vc.dataSource = self
        vc.delegate = self
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(350)).isActive = true
        vc.register(PlaceSimilarCell.self, forCellWithReuseIdentifier: SimilarPlacesID)
        return vc
    }()
    
    let ReviewsCommentId = "CellComment"
    lazy var TableView : UITableView = {
        let tv = UITableView()
        tv.alpha = 0
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ReviewsCommentPlaceCell.self, forCellReuseIdentifier: ReviewsCommentId)
        tv.heightAnchor.constraint(equalToConstant: ControlWidth(350)).isActive = true
        tv.contentInset = UIEdgeInsets(top: ControlY(10), left: 0, bottom: ControlY(10), right: 0)
        return tv
    }()
        
    var SegmentSelected = 0
    func change(to index:Int) {
        
        if Place?.ShowsPlace.count == 0 {
            switch index {
            case 0:
                SegmentSelected = 0
                self.TableView.isHidden = true
                self.PlacesCollection.isHidden = false
                UIView.animate(withDuration: 0.4) {
                    self.TableView.alpha = 0
                    self.PlacesCollection.alpha =  1}
            case 1:
                SegmentSelected = 2
                self.TableView.isHidden = false
                self.PlacesCollection.isHidden = true
                UIView.animate(withDuration: 0.4) {
                    self.TableView.alpha = 1
                    self.PlacesCollection.alpha =  0}
            default:
                break
            }
        }else{
            switch index {
            case 0:
                SegmentSelected = 0
                self.TableView.isHidden = true
                self.PlacesCollection.isHidden = false
                UIView.animate(withDuration: 0.4) {
                    self.TableView.alpha = 0
                    self.PlacesCollection.alpha =  1}
            case 1:
                SegmentSelected = 1
                self.TableView.isHidden = true
                self.PlacesCollection.isHidden = false
                UIView.animate(withDuration: 0.4) {
                    self.TableView.alpha = 0
                    self.PlacesCollection.alpha =  1}
            case 2:
                SegmentSelected = 2
                self.TableView.isHidden = false
                self.PlacesCollection.isHidden = true
                UIView.animate(withDuration: 0.4) {
                    self.TableView.alpha = 1
                    self.PlacesCollection.alpha =  0}
            default:
                break
            }
        }
        
        TableView.reloadData()
        PlacesCollection.reloadData()
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelDetails,ReadMore,FacilitesLabel,PriceRange,Hotline,StackDate,PhoneNumber,DressCode,UIView(),BranchesStack,UIView(),StackMedia,UIView(),Reserve,UIView(),AddReview,ViewSpacing,UIView(),MenuTapCollection,PlacesCollection,TableView])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(12)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    lazy var SimilarPlacesBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "SimilarPlacesBackground")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.isHidden = true
        
        var bottomSafeArea = CGFloat()
        guard let root = UIApplication.shared.keyWindow?.rootViewController else {return}
        if #available(iOS 11.0, *) {bottomSafeArea = root.view.safeAreaInsets.bottom}
        
        addSubview(SimilarPlacesBackground)
        addSubview(StackItems)
        StackItems.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(15)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlY(15)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlY(-15)).isActive = true
        StackItems.bottomAnchor.constraint(equalTo: bottomAnchor,constant: bottomSafeArea + ControlX(-15)).isActive = true

        SimilarPlacesBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        SimilarPlacesBackground.bottomAnchor.constraint(equalTo: bottomAnchor,constant: bottomSafeArea).isActive = true
        SimilarPlacesBackground.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlY(-5)).isActive = true
        SimilarPlacesBackground.topAnchor.constraint(equalTo: AddReview.bottomAnchor,constant: ControlY(20)).isActive = true
                
        TableView.alpha = 0
        PlacesCollection.alpha =  1
        TableView.isHidden = true
        PlacesCollection.isHidden = false
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        StackDate.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        Hotline.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        PhoneNumber.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        BranchesStack.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        PriceRange.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        DressCode.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        WaitingHours.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(0.8), space: ControlY(8))
        
        if Place?.AllDetails?.description?.TextHeight(self.frame.width , font: UIFont.systemFont(ofSize: ControlWidth(16)), Spacing: ControlWidth(8)) ?? 0 >  ControlWidth(50) {
        ReadMore.isUserInteractionEnabled = true
        LabelDetails.isUserInteractionEnabled = true
        }else{
        ReadMore.isUserInteractionEnabled = false
        LabelDetails.isUserInteractionEnabled = false
        }
    }
    
}


extension PlacesDetailsCell : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , PlaceSimilarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SegmentSelected {
        case 0:
            return Place?.SimilarPlaces.count ?? 0
        case 1:
            return Place?.ShowsPlace.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarPlacesID, for: indexPath) as! PlaceSimilarCell
        cell.Delegate = self
        
        switch SegmentSelected {
        case 0:
            cell.SimilarName.text = Place?.SimilarPlaces[indexPath.item].placeName
            cell.SimilarDescription.text = "\(Place?.SimilarPlaces[indexPath.item].description ?? "")\n\(Place?.SimilarPlaces[indexPath.item].address ?? "")"
            cell.Reserve.setTitle(Place?.screenData?.screenElements.filter({$0.id == 79}).first?.lable ?? "Reserve", for: .normal)
            
            cell.RatingButton.isHidden = false
            cell.RatingButton.setTitle("\(Place?.SimilarPlaces[indexPath.item].rate ?? 1.0)", for: .normal)
            cell.FavoritesButton.setBackgroundImage(Place?.SimilarPlaces[indexPath.item].isFavorite ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
            cell.ImageView.sd_setImage(with: URL(string: Place?.SimilarPlaces[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        case 1:
            cell.RatingButton.isHidden = true
            cell.SimilarName.text = Place?.ShowsPlace[indexPath.item].showName
            cell.SimilarDescription.text = "\(Place?.SimilarPlaces[indexPath.item].description ?? "")\n\(Place?.SimilarPlaces[indexPath.item].address ?? "")"
            cell.Reserve.setTitle(Place?.screenData?.screenElements.filter({$0.id == 79}).first?.lable ?? "Reserve", for: .normal)
            cell.ImageView.sd_setImage(with: URL(string: Place?.ShowsPlace[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            cell.FavoritesButton.setBackgroundImage(Place?.ShowsPlace[indexPath.item].isFavorite ?? false ? UIImage(named: "InFavorites") : UIImage(named: "NotFavorites"), for: .normal)
        default:
        break
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - ControlWidth(80), height: collectionView.frame.height)
    }
    
    func PlaceCollectionAction(_ Cell:PlaceSimilarCell) {
        if let indexPath = PlacesCollection.indexPath(for: Cell) {
            if SegmentSelected == 0 {
            Delegate?.SimilarPlaces(Place?.SimilarPlaces[indexPath.item].id ?? 0)
            }
            if SegmentSelected == 1 {
            Delegate?.ShowsPlace(Place?.ShowsPlace[indexPath.item].id ?? 0)
            }
        }
    }
    
    func PlaceActionFavorites(_ Cell:PlaceSimilarCell) {
        if let indexPath = PlacesCollection.indexPath(for: Cell) {
            if SegmentSelected == 0 {
            AddAndDeleteFavorite(IsSimilarPlaces: true, indexPath: indexPath, PlaceId: Place?.SimilarPlaces[indexPath.item].id ?? 0)
            }
            if SegmentSelected == 1 {
            AddAndDeleteFavorite(IsSimilarPlaces: false, indexPath: indexPath, PlaceId: Place?.ShowsPlace[indexPath.item].id ?? 0)
            }
        }
    }
    
    
    func AddAndDeleteFavorite(IsSimilarPlaces:Bool,indexPath:IndexPath ,PlaceId:Int) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    PlacesDetails?.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
            
    let api = "\(url + AddOrDeleteFavorite)"
    let token = defaults.string(forKey: "jwt") ?? ""
            
    PlacesDetails?.ViewDots.beginRefreshing()
    let parameters = ["PlaceId":PlaceId,
                      "EventId":0,
                      "ShowId":0]
        
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.PlacesDetails?.ViewDots.endRefreshing {}
        
    if IsSimilarPlaces {
    self.Place?.SimilarPlaces[indexPath.item].isFavorite = !(self.Place?.SimilarPlaces[indexPath.item].isFavorite ?? false)
    self.PlacesCollection.reloadData()
    }else{
    self.Place?.ShowsPlace[indexPath.item].isFavorite = !(self.Place?.ShowsPlace[indexPath.item].isFavorite ?? false)
    self.PlacesCollection.reloadData()
    }
        
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.PlacesDetails?.ViewDots.endRefreshing(error,.error) {}
    }
    }

    
    func ActionReserve(_ Cell: PlaceSimilarCell) {
        if HomeScreenData?.userData?.emailConfirmed == true && HomeScreenData?.userData?.email != nil {
        let WhatsappMessage = "Please contact us to reserve".urlEncoded ?? ""
               
        let phone = HomeScreenData?.reserveNumber ?? "+201021111111"
        guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phone)&text=\(WhatsappMessage)") else {return}
        if UIApplication.shared.canOpenURL(whatsappURL) {
        if #available(iOS 10.0, *) {
        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        }else {
        UIApplication.shared.openURL(whatsappURL)
        }
        }
        }else{
        if HomeScreenData?.userData?.email == nil  {
        if let Places = PlacesDetails {
        ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        Present(ViewController: Places, ToViewController: MyAccountVC())
        },"Sign-Up")
        }
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
        self.PlacesDetails?.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
                
        let api = "\(url + ResendConfirmeationEmile)"
        let token = defaults.string(forKey: "jwt") ?? ""
                
        self.PlacesDetails?.ViewDots.beginRefreshing()
        PostAPI(timeout: 60 ,api: api, token: token, parameters: [:]) { _ in
        self.PlacesDetails?.ViewDots.endRefreshing("Success Resend Confirmeation Emile", .success) {}
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.PlacesDetails?.ViewDots.endRefreshing(error,.error) {}
        }
    }

}


extension PlacesDetailsCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Place?.ReviewsPlace.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: ReviewsCommentId, for: indexPath) as! ReviewsCommentPlaceCell
        Cell.selectionStyle = .none
        Cell.ViewRating.rating = Place?.ReviewsPlace[indexPath.row].rate ?? 1.0
        Cell.LabelName.text = Place?.ReviewsPlace[indexPath.row].userName ?? ""
        Cell.Comment.text = Place?.ReviewsPlace[indexPath.row].comment ?? ""
        Cell.LabelDate.text = Place?.ReviewsPlace[indexPath.row].ratedIn?.Formatter().Formatter("MMM d, yyyy")
        Cell.UserImage.sd_setImage(with: URL(string: Place?.ReviewsPlace[indexPath.row].userPhoto ?? ""), placeholderImage: UIImage(named: "Profile"))
        return Cell
    }
}
