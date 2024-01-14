//
//  ReportLostVC.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

class ReportLostVC: ViewController {

    var DataScreen : ScreenData?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
      
    view.addSubview(ReportLostBackground)
    ReportLostBackground.frame = view.bounds
      
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: ControlY(80), width: view.frame.width, height: view.frame.height - ControlY(100))
      
    ViewScroll.addSubview(StackTF)
    StackTF.frame = CGRect(x: ControlX(20), y: ControlY(50), width: ViewScroll.frame.width - ControlX(40), height: ViewScroll.frame.height - ControlY(70))
      
    ViewScroll.addSubview(TextView)
    TextView.heightAnchor.constraint(equalToConstant: ControlWidth(220)).isActive = true
    TextView.topAnchor.constraint(equalTo: LocationButton.bottomAnchor, constant: ControlX(80)).isActive = true
    TextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    TextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true

    ViewScroll.updateContentViewSize(0)
    SetReportLost()
  }
    
    lazy var ReportLostBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Help")
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
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()

    lazy var ItemTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        return tf
    }()
    
    var Latitude : Double?
    var Longitude : Double?
    lazy var LocationButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = .clear
        Button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Button.contentVerticalAlignment = .center
        Button.layer.borderWidth = ControlWidth(1)
        Button.contentHorizontalAlignment = .leading
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.titleLabel?.font = UIFont(name: "Nexa-Regular", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionLocation), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(10), bottom: 0, right: ControlWidth(10))
        Button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        return Button
    }()
    
    
    @objc func ActionLocation() {
    let Map = MapKitSearchViewController()
    Map.ReportLost = self
    Map.modalPresentationStyle = .fullScreen
    present(Map, animated: true, completion: nil)
    }
    
    lazy var TextView : GrowingTextView = {
    let TV = GrowingTextView()
    TV.minHeight = ControlWidth(48)
    TV.maxHeight = ControlWidth(220)
    TV.placeholderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    TV.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    TV.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    TV.clipsToBounds = true
    TV.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    TV.autocorrectionType = .no
    TV.backgroundColor = .clear
    TV.layer.borderWidth = ControlWidth(1)
    TV.translatesAutoresizingMaskIntoConstraints = false
    TV.font = UIFont(name: "Nexa-Regular", size: ControlWidth(15))
    return TV
    }()

    lazy var SendButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSend), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSend() {
        if LocationButton.titleLabel?.text?.TextNull() == false {
        LocationButton.Shake()
        UIView.animate(withDuration: 0.8) {
        self.LocationButton.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.LocationButton.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.8) {
        self.LocationButton.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.LocationButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        self.ActionLocation()
        }
        }

        return
        }else{
        if ItemTF.NoEmptyError() {
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
                
        let api = "\(url + AddReportLostItem)"
        let token = defaults.string(forKey: "jwt") ?? ""
                
        self.ViewDots.beginRefreshing()
        guard let Item = ItemTF.text else { return }
        guard let Latitude = Latitude else { return }
        guard let Longitude = Longitude else { return }
        let parameters: [String:Any] = ["ItemName": Item,
                                        "Message": TextView.text ?? "",
                                        "Latitude": Latitude,
                                        "Longitude": Longitude]
                
        PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
        self.ViewDots.endRefreshing("Success Add Report Lost Item",.success) {
        self.ItemTF.text = ""
        self.TextView.text = ""
        self.LocationButton.setTitle(self.DataScreen?.screenElements.filter({$0.id == 106}).first?.placeholder ?? "Enter the location", for: .normal)
        }
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error,.error) {}
        }
        }
        }
    }
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ItemTF,LocationButton,UIView(),UIView(),UIView(),UIView(),SendButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    
    func SetReportLost() {
    self.view.subviews.forEach { View in View.alpha = 0}
    UIView.animate(withDuration: 0.4) {
    DataGetScreen(self, 18) { data in
    self.SetData(data)
    } _: { IsError in
    self.view.subviews.forEach { View in
    View.alpha = IsError ? 0:1
    self.ViewNoData.isHidden = IsError ? false:true
    if IsError == true {
    self.SetUpIsError(true) {
    self.SetReportLost()
    }
    }
    }
    }
    }
    }
    
    func SetData(_ data:ScreenData) {
    DataScreen = data
    ViewDismiss.TextLabel = data.title ?? "Report lost item"
    SendButton.setTitle(data.screenElements.filter({$0.id == 107}).first?.lable ?? "Send", for: .normal)
    TextView.placeholder = data.screenElements.filter({$0.id == 143}).first?.placeholder ?? "Enter your message"
    ItemTF.attributedPlaceholder = NSAttributedString(string: data.screenElements.filter({$0.id == 105}).first?.placeholder ?? "Item", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
    LocationButton.setTitle(data.screenElements.filter({$0.id == 106}).first?.placeholder ?? "Enter the location", for: .normal)
    }
}
