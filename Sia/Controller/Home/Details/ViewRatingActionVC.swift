//
//  ViewRatingActionVC.swift
//  Sia
//
//  Created by Emojiios on 30/05/2023.
//

import UIKit

class ViewRatingDetails: PopUpDownView {
    
    let ViewRating = ViewRatingAction()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        View.addSubview(TopView)
        TopView.frame = CGRect(x: view.center.x - ControlWidth(60), y: ControlY(20), width: ControlWidth(120), height: ControlWidth(5))
        
        View.addSubview(LabelTitle)
        LabelTitle.frame = CGRect(x: ControlX(15), y: TopView.frame.maxY + ControlY(15), width: view.frame.width - ControlX(30), height: ControlWidth(30))
        
        Scroll.frame = CGRect(x: 0, y: LabelTitle.frame.maxY + ControlY(15), width: view.frame.width , height: view.frame.height / 1.3)
        View.addSubview(Scroll)
        
        Scroll.addSubview(LabelRate)
        LabelRate.frame = CGRect(x: ControlX(15), y: 0, width: Scroll.frame.width - ControlX(30), height: ControlWidth(25))
        
        ViewRating.backgroundColor = .clear
        Scroll.addSubview(ViewRating)
        ViewRating.frame = CGRect(x: ControlX(15), y: LabelRate.frame.maxY + ControlY(20), width: Scroll.frame.width - ControlX(30), height: ControlWidth(50))
        
        Scroll.addSubview(LabelComment)
        LabelComment.frame = CGRect(x: ControlX(15), y: ViewRating.frame.maxY + ControlY(20), width: Scroll.frame.width - ControlX(30), height: ControlWidth(25))
        
        Scroll.addSubview(CommentTV)
        CommentTV.frame = CGRect(x: ControlX(15), y: LabelComment.frame.maxY + ControlY(20), width: Scroll.frame.width - ControlX(30), height: Scroll.frame.height / 3.5)
        
        Scroll.addSubview(Button)
        Button.frame = CGRect(x: ControlX(15), y: CommentTV.frame.maxY + ControlY(30), width: Scroll.frame.width - ControlX(30), height: ControlWidth(48))
            
        Scroll.updateContentViewSize(0)
    }
    
    lazy var TopView : UIView = {
    let View = UIView()
    View.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    View.clipsToBounds = true
    View.layer.cornerRadius = ControlWidth(2.5)
    return View
    }()
    
    lazy var LabelTitle : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(20))
    return Label
    }()
    
        
    lazy var Scroll : UIScrollView = {
    let Scroll = UIScrollView()
    Scroll.backgroundColor = .clear
    Scroll.keyboardDismissMode = .interactive
    return Scroll
    }()
        
    lazy var LabelRate : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(18))
    return Label
    }()
        
    lazy var LabelComment : UILabel = {
    let Label = UILabel()
    Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    Label.backgroundColor = .clear
    Label.font = UIFont(name: "Nexa-Regular" ,size: ControlWidth(18))
    return Label
    }()
    
    lazy var CommentTV : UITextView = {
    let CommentTV = UITextView()
    CommentTV.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    CommentTV.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    CommentTV.clipsToBounds = true
    CommentTV.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    CommentTV.autocorrectionType = .no
    CommentTV.backgroundColor = .clear
    CommentTV.layer.borderWidth = ControlWidth(1)
    CommentTV.layer.cornerRadius = ControlWidth(12)
    CommentTV.font = UIFont(name: "Nexa-Regular", size: ControlWidth(15))
    return CommentTV
    }()

    lazy var Button : ButtonNotEnabled = {
    let Button = ButtonNotEnabled(type: .system)
    Button.Radius = false
    Button.backgroundColor = #colorLiteral(red: 0.7583009601, green: 0.3631356359, blue: 0.1871258616, alpha: 1)
    Button.setTitleColor(.white, for: .normal)
    Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
    return Button
    }()
    
}
