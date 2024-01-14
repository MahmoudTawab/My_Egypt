//
//  SubmitComplainVC.swift
//  Sia
//
//  Created by Emojiios on 19/10/2022.
//

import UIKit

class SubmitComplainVC: ViewController ,DropDownListDelegate ,UIPopoverPresentationControllerDelegate {
    
    var DataSubmitComplain : SubmitComplain?
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
      
    ViewScroll.addSubview(TopicTF)
    TopicTF.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
    TopicTF.topAnchor.constraint(equalTo: ViewScroll.topAnchor, constant: ControlX(50)).isActive = true
    TopicTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    TopicTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
      
    ViewScroll.addSubview(TextView)
    TextView.heightAnchor.constraint(equalToConstant: ControlWidth(250)).isActive = true
    TextView.topAnchor.constraint(equalTo: TopicTF.bottomAnchor, constant: ControlX(80)).isActive = true
    TextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    TextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
      
    ViewScroll.addSubview(SendButton)
    SendButton.frame = CGRect(x: ControlX(15), y: ViewScroll.frame.height - ControlWidth(70), width: ViewScroll.frame.width - ControlX(30), height: ControlWidth(48))
      
    ViewScroll.updateContentViewSize(0)
    SetSubmitComplain()
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
        return Scroll
    }()
    
    lazy var TopicTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = false
        tf.Icon.tintColor = #colorLiteral(red: 0.8692544103, green: 0.6030948162, blue: 0.2276273072, alpha: 1)
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.layer.borderWidth = ControlWidth(1)
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.addTarget(self, action: #selector(TopicAction), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(TopicAction), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TopicAction)))
        return tf
    }()
    
    var Topicsid = Int()
    var Topics = [String]()
    @objc func TopicAction() {
        let DropDown = DropDownList()
        DropDown.DropDownData = Topics
        DropDown.Delegate = self
        DropDown.TextColor = .black
        DropDown.BackgroundImage.image = UIImage()
        if let Select = Topics.firstIndex(where: {$0 == TopicTF.text}) {
        DropDown.SelectRow = IndexPath(row: Select , section: 0)
        }
                    
        DropDown.modalPresentationStyle = .popover
        DropDown.preferredContentSize = CGSize(width: ControlWidth(380), height: CGFloat(Topics.count) * ControlWidth(40))

        let popController: UIPopoverPresentationController? = DropDown.popoverPresentationController
        popController?.permittedArrowDirections = [.unknown]
        popController?.delegate = self
        popController?.sourceView = TopicTF
        popController?.sourceRect = CGRect(
            x: TopicTF.frame.size.width/2,
            y: TopicTF.frame.size.height/2,
            width: 1,
            height: 1)
                
        popController?.backgroundColor = .white
        if Topics.count != 0 {
        self.present(DropDown, animated: true, completion: { })
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func DropDownSelect(_ Index: String) {
    TopicTF.text = Index
    Topicsid = DataSubmitComplain?.Topics.filter({$0.topicName == Index}).first?.id ?? 0
    }

    lazy var TextView : GrowingTextView = {
    let TV = GrowingTextView()
    TV.minHeight = ControlWidth(48)
    TV.maxHeight = ControlWidth(250)
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
        Button.addTarget(self, action: #selector(ActionSend), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        return Button
    }()

    @objc func ActionSend() {
        if TopicTF.NoEmptyError() {
        guard let url = defaults.string(forKey: "API") else{
        LodBaseUrl()
        self.ViewDots.endRefreshing {}
        ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
        return
        }
            
        let api = "\(url + AddComplain)"
        let token = defaults.string(forKey: "jwt") ?? ""
            
        self.ViewDots.beginRefreshing()
        let parameters: [String:Any] = ["TopicId": Topicsid,
                                        "Message": TextView.text ?? ""]
            
        PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
        self.ViewDots.endRefreshing("Success Add Complain",.success) {
        self.TopicTF.text = ""
        self.TextView.text = ""
        }
        } dictionary: { _ in
        } array: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error,.error) {}
        }
        }
    }


    func SetSubmitComplain() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}

    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.SetSubmitComplain()
    }
    return
    }
            
    let api = "\(url + GetSubmitComplain)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { dictionary in
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.SetData(SubmitComplain(dictionary: dictionary))
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.SetSubmitComplain()
    }
    }
    }
    
    
    func SetData(_ data:SubmitComplain) {
    DataSubmitComplain = data
    data.Topics.forEach({ topics in
    if let topicName = topics.topicName {
    Topics.append(topicName)
    }
    })
        
    ViewDismiss.TextLabel = data.screenData?.title ?? "Submit a complain"
    TopicTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 108}).first?.lable ?? "Topic", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
    TextView.placeholder = data.screenData?.screenElements.filter({$0.id == 109}).first?.lable ?? "Enter your message"
    SendButton.setTitle(data.screenData?.screenElements.filter({$0.id == 110}).first?.lable ?? "Send", for: .normal)
    }
}
