//
//  ConciergeVC.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

class ConciergeVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
 
        
    view.addSubview(ConciergeLabel)
    ConciergeLabel.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(40))
        

    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ConciergeLabel.frame.maxY , width: view.frame.width , height: view.frame.height)
        
    // MARK: Transportation View
        
    ViewScroll.addSubview(TransportationImage1)
    TransportationImage1.frame = CGRect(x: 0, y: ControlY(20), width: view.frame.width , height: ControlWidth(400))
        
    ViewScroll.addSubview(TransportationCenter)
    TransportationCenter.frame = CGRect(x: view.center.x - (view.frame.width / 3.4), y:  ControlWidth(105), width: view.frame.width / 1.8 , height: ControlWidth(190))
        
    ViewScroll.addSubview(TransportationImage2)
    TransportationImage2.frame = CGRect(x: 0, y: 0, width: view.frame.width + ControlX(10), height: TransportationImage1.frame.height)
        
    ViewScroll.addSubview(Transportation)
    Transportation.frame = CGRect(x: 0, y: TransportationImage1.frame.maxY - ControlWidth(55), width: view.frame.width , height: ControlWidth(50))
        
    // MARK: Booking Services View
    ViewScroll.addSubview(BookingServicesImage1)
    BookingServicesImage1.frame = CGRect(x: 0, y: TransportationImage1.frame.maxY + ControlY(25), width: view.frame.width , height: TransportationImage1.frame.height)
        
    ViewScroll.addSubview(BookingServicesCenter)
    BookingServicesCenter.frame = CGRect(x: view.center.x - (view.frame.width / 3.8), y: BookingServicesImage1.frame.minY + ControlWidth(100), width: view.frame.width / 1.7 , height: ControlWidth(200))
        
    ViewScroll.addSubview(BookingServicesImage2)
    BookingServicesImage2.frame = BookingServicesImage1.frame
            
    ViewScroll.addSubview(BookingServices)
    BookingServices.frame = CGRect(x: 0, y: BookingServicesImage1.frame.minY , width: view.frame.width , height: Transportation.frame.height)
        
    
    ViewScroll.updateContentViewSize(ControlY(60))
    }
    
    lazy var ConciergeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(22))
        return Label
    }()

    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        return Scroll
    }()
    
    // MARK: Transportation View
    
    lazy var TransportationImage1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "ConciergeTop1")
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTransportation)))
        return ImageView
    }()
    
    lazy var TransportationImage2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "ConciergeTop2")
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTransportation)))
        return ImageView
    }()

    lazy var TransportationCenter : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "Test1")
        ImageView.layer.cornerRadius = ControlWidth(25)
        ImageView.transform = CGAffineTransform(rotationAngle: -0.03)
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionTransportation)))
        return ImageView
    }()
    
    lazy var Transportation : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = #colorLiteral(red: 0.9684386849, green: 0.8215563297, blue: 0.5260710716, alpha: 1)
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.setImage(UIImage(named: "Concierge"), for: .normal)
        Button.setTitle("  " + "Transportation".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-XBold", size:  ControlWidth(18))
        Button.addTarget(self, action: #selector(ActionTransportation), for: .touchUpInside)
        return Button
    }()

    @objc func ActionTransportation() {
    Present(ViewController: self, ToViewController: TransportationVC())
    }
    
    
    // MARK: Booking Services View
    
    lazy var BookingServicesImage1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "ConciergeBottom1")
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBookingServices)))
        return ImageView
    }()
    
    lazy var BookingServicesImage2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "ConciergeBottom2")
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBookingServices)))
        return ImageView
    }()
    
    lazy var BookingServicesCenter : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Test2")
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(25)
        ImageView.transform = CGAffineTransform(rotationAngle: -0.03)
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBookingServices)))
        return ImageView
    }()
    
    lazy var BookingServices : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = #colorLiteral(red: 0.6254840493, green: 0.6941396594, blue: 0.5239480138, alpha: 1)
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.setImage(UIImage(named: "BookingServices"), for: .normal)
        Button.setTitle("  " + "Booking services".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Nexa-XBold", size:  ControlWidth(18))
        Button.addTarget(self, action: #selector(ActionBookingServices), for: .touchUpInside)
        return Button
    }()

    @objc func ActionBookingServices() {
    Present(ViewController: self, ToViewController: BookingVC())
    }

}
