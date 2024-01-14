//
//  ShowDetailsCell.swift
//  Sia
//
//  Created by Emojiios on 16/03/2023.
//

import UIKit
import SDWebImage

protocol ShowDetailsDelegate {
    func ActionReadMore(_ Cell:ShowDetailsCell)
    func ActionReserve(_ Cell:ShowDetailsCell)
}

class ShowDetailsCell: UITableViewCell {
        
    var Delegate : ShowDetailsDelegate?
    var Show : ShowDetails? {
        didSet {
            let style = NSMutableParagraphStyle()
            style.alignment = .justified
            
            let attributedString = NSMutableAttributedString(string: Show?.screenData?.screenElements.filter({$0.id == 77}).first?.lable ?? "Read more", attributes: [
                .font: UIFont(name: "Nexa-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
                .foregroundColor: #colorLiteral(red: 0.8692544103, green: 0.6030948162, blue: 0.2276273072, alpha: 1) ,
                .paragraphStyle:style,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
            
            ReadMore.attributedText = attributedString

            Hotline.TextLabel = Show?.Details?.hotline ?? ""
            PhoneNumber.TextLabel = Show?.Details?.phoneNumber ?? ""
            PriceRange.TextLabel = Show?.Details?.priceRange ?? ""
            DressCode.TextLabel = Show?.Details?.dressCode ?? ""
            if let Hours = Show?.Details?.waitingHours { WaitingHours.TextLabel = "\(Hours)"}
            
            let NormalOperation = Show?.screenData?.screenElements.filter({$0.id == 191}).first?.lable ?? ""
            let timingAmendments = Show?.screenData?.screenElements.filter({$0.id == 193}).first?.lable ?? ""
            Date.TextLabel = "\(NormalOperation) \(Show?.Details?.from ?? "") - \(Show?.Details?.to ?? "")"
            TimingAmendments.text = timingAmendments
            
            BranchesStack.isHidden = Show?.Details?.branches == nil ? true : false
            Hotline.isHidden = Show?.Details?.hotline == nil ? true : false
            PhoneNumber.isHidden = Show?.Details?.phoneNumber == nil ? true : false
            PriceRange.isHidden = Show?.Details?.priceRange == nil ? true : false
            DressCode.isHidden = Show?.Details?.dressCode == nil ? true : false
            WaitingHours.isHidden = Show?.Details?.waitingHours == nil ? true : false
            StackDate.isHidden = Show?.Details?.from == nil ? true : false
            
            FacebookButton.isHidden = Show?.Details?.facebook == nil || Show?.Details?.facebook == "" ? true : false
            InstagramButton.isHidden = Show?.Details?.instagram == nil || Show?.Details?.instagram == "" ? true : false
            YouTubeButton.isHidden = Show?.Details?.youtube == nil || Show?.Details?.youtube == "" ? true : false
            OfficialWebsiteButton.isHidden = Show?.Details?.OfficialWebsite == nil || Show?.Details?.OfficialWebsite == "" ? true : false

            LabelDetails.text = Show?.Details?.description ?? ""
            LabelDetails.addInterlineSpacing(spacingValue: ControlWidth(8))
            
            Branches.text = Show?.Details?.branches ?? ""
            Branches.addInterlineSpacing(spacingValue: ControlWidth(8))
            
            Reserve.setTitle(Show?.screenData?.screenElements.filter({$0.id == 79}).first?.lable ?? "Reserve", for: .normal)
        }
    }
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(16))
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionReadMore)))
        return Label
    }()
        
    lazy var ReadMore : UILabel = {
        let Label = UILabel()
        Label.isUserInteractionEnabled = true
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
        Stack.axis = .vertical
        Stack.spacing = 0
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
        guard let url = URL(string: Show?.Details?.facebook ?? "https://de-de.facebook.com") else { return }
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
        guard let url = URL(string: Show?.Details?.instagram ?? "https://instagram.com") else { return }
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
        guard let url = URL(string: Show?.Details?.youtube ?? "https://www.youtube.com") else { return }
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
        guard let url = URL(string: Show?.Details?.OfficialWebsite ?? "https://www.google.com") else { return }
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
        Button.addTarget(self, action: #selector(ActionReserve), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionReserve() {
        Delegate?.ActionReserve(self)
    }
        

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelDetails,ReadMore,FacilitesLabel,PriceRange,Hotline,StackDate,UIView(),PhoneNumber,DressCode,UIView(),BranchesStack,UIView(),StackMedia,UIView(),Reserve,UIView()])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.isHidden = true
        
        addSubview(StackItems)
        StackItems.topAnchor.constraint(equalTo: topAnchor,constant: ControlY(10)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlY(15)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlY(-15)).isActive = true
        StackItems.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: ControlY(-20)).isActive = true
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
        
        if Show?.Details?.description?.TextHeight(self.frame.width , font: UIFont.systemFont(ofSize: ControlWidth(16)), Spacing: ControlWidth(8)) ?? 0 >  ControlWidth(50) {
        ReadMore.isUserInteractionEnabled = true
        LabelDetails.isUserInteractionEnabled = true
        }else{
        ReadMore.isUserInteractionEnabled = false
        LabelDetails.isUserInteractionEnabled = false
        }
    }
    
}


