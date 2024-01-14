//
//  SuccessfullyVC.swift
//  Sia
//
//  Created by Emojiios on 17/10/2022.
//

import UIKit

class SuccessfullyVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp =  false
        view.backgroundColor = .white
    }
    
    
  fileprivate func SetUpItems() {
    view.addSubview(BackgroundImage)
    BackgroundImage.frame = view.bounds
        
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlY(20), y: ControlY(40), width: view.frame.width - ControlY(40) , height: ControlWidth(40))
      
    view.addSubview(StackItems)
    StackItems.frame = CGRect(x: ControlX(20), y: ControlY(120), width: view.frame.width - ControlX(40), height:  view.frame.height - ControlY(150))
      
    SetDataSuccessfully()
 }
    
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconSize = CGSize(width: ControlWidth(25), height: ControlWidth(25))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var BackgroundImage:UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Successfully")
        return Image
    }()

    lazy var SuccessfullyLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(250)).isActive = true
        return Label
    }()
    

    lazy var BottomLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return Label
    }()
    
    lazy var Start : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionStart), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionStart() {
    FirstController(TabBarController())
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SuccessfullyLabel,UIView(),BottomLabel,Start,UIView()])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    func SetDataSuccessfully() {
        self.view.subviews.forEach { View in View.alpha = 0}
        UIView.animate(withDuration: 0.4) {
        DataGetScreen(self, 8) { data in
        self.SetData(data)
        } _: { IsError in
        self.view.subviews.forEach { View in
        View.alpha = IsError ? 0:1
        self.ViewNoData.isHidden = IsError ? false:true

        if IsError == true {
        self.SetUpIsError(true) {
        self.SetDataSuccessfully()
        }
        }
        }
        }
        }

    }
    
    func SetData(_ Data:ScreenData?) {
        
        // MARK: Setup TopLabel String
        
        let SuccessfullyStyle = NSMutableParagraphStyle()
        SuccessfullyStyle.lineSpacing = ControlWidth(15)
        SuccessfullyStyle.alignment = .justified
        
        let SuccessfullyString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 61}).first?.lable ?? "You Successfully Made An Account", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(40)) ?? UIFont.systemFont(ofSize: ControlWidth(40)),
            .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
            .paragraphStyle:SuccessfullyStyle,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        SuccessfullyLabel.attributedText = SuccessfullyString
        
        
        // MARK: Setup Bottom String
        let BottomStyle = NSMutableParagraphStyle()
        BottomStyle.lineSpacing = ControlWidth(15)
        BottomStyle.alignment = .center
        
        let BottomString = NSMutableAttributedString(string: Data?.screenElements.filter({$0.id == 64}).first?.lable ?? "Let’s Discover", attributes: [
            .font: UIFont(name: "Nexa-XBold", size: ControlWidth(35)) ?? UIFont.systemFont(ofSize: ControlWidth(35)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:BottomStyle
        ])
        BottomLabel.attributedText = BottomString
        
        Start.setTitle(Data?.screenElements.filter({$0.id == 65}).first?.lable ?? "Start", for: .normal)
    }
    
}
