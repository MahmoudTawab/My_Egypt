//
//  ExchangeCurrencyVC.swift
//  Sia
//
//  Created by Emojiios on 14/02/2023.
//

import UIKit

struct ExchangeRates: Codable {
    let rates: [String: Double]
}

class ExchangeCurrencyVC : ViewController, DropDownListDelegate , UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
      
    view.addSubview(ExchangeCurrencyBackground)
    ExchangeCurrencyBackground.frame = view.bounds
      
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(StackTF)
    StackTF.frame = CGRect(x: ControlX(20), y: ViewDismiss.frame.maxY + ControlY(50), width: view.frame.width - ControlX(40), height: ControlWidth(170))
      
    view.addSubview(StackDropDownCurrency1)
    StackDropDownCurrency1.widthAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
    StackDropDownCurrency1.centerYAnchor.constraint(equalTo: Currency1TF.centerYAnchor).isActive = true
    StackDropDownCurrency1.trailingAnchor.constraint(equalTo: Currency1TF.trailingAnchor,constant: ControlWidth(-5)).isActive = true
    StackDropDownCurrency1.heightAnchor.constraint(equalTo: Currency1TF.heightAnchor,constant:  ControlWidth(-15)).isActive = true
      
    view.addSubview(StackDropDownCurrency2)
    StackDropDownCurrency2.centerYAnchor.constraint(equalTo: Currency2TF.centerYAnchor).isActive = true
    StackDropDownCurrency2.widthAnchor.constraint(equalTo: StackDropDownCurrency1.widthAnchor).isActive = true
    StackDropDownCurrency2.heightAnchor.constraint(equalTo: StackDropDownCurrency1.heightAnchor).isActive = true
    StackDropDownCurrency2.trailingAnchor.constraint(equalTo: StackDropDownCurrency1.trailingAnchor).isActive = true
      
    self.fetchJson { rates in
    if let value = rates.rates.firstIndex(where: {$0.key == "EGP"})  {
    self.Currency2TF.text = "\(rates.rates[value].value * 1.0)"
    }
    }
     
    SetExchangeCurrencyVC()
  }
       
    lazy var ExchangeCurrencyBackground : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = #colorLiteral(red: 0.9432628751, green: 0.8789214492, blue: 0.7612995505, alpha: 1)
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "EmergencyContactsBackground")
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

    var IsDropDownCurrency1 = Bool()
    lazy var Currency1TF : FloatingTF = {
        let tf = FloatingTF()
        tf.tag = 1
        tf.text = "1.0"
        tf.ShowError = false
        tf.TitleHidden = true
        tf.tintColor = .clear
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.keyboardType = .numberPad
        tf.layer.borderWidth = ControlWidth(1)
        tf.addTarget(self, action: #selector(CurrencyTarget(_:)), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(120) , height: tf.frame.height))
        tf.rightViewMode = .always
        return tf
    }()
    
    @objc func CurrencyTarget(_ TF:FloatingTF) {
    if TF.tag == 1 {
        
    if let text = DropDownCurrency1.text {
    self.fetchJson(text) { rates in
    if let value = rates.rates.firstIndex(where: {$0.key == self.DropDownCurrency2.text})  {
    self.Currency2TF.text = "\(rates.rates[value].value * (self.Currency1TF.text?.toDouble() ?? 1.0))"
    }
    }
    }
        
    }else{
     
    if let text = DropDownCurrency2.text {
    self.fetchJson(text) { rates in
    if let value = rates.rates.firstIndex(where: {$0.key == self.DropDownCurrency1.text})  {
    self.Currency1TF.text = "\(rates.rates[value].value * (self.Currency2TF.text?.toDouble() ?? 1.0))"
    }
    }
    }
        
    }
    }
    
    lazy var SpacingCurrency1 : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.widthAnchor.constraint(equalToConstant: ControlWidth(3)).isActive = true
        return View
    }()
    
    lazy var DropDownCurrency1 : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        tf.text = "USD"
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = true
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.tintColor = .clear
        tf.layer.borderWidth = 0
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 18, Height: 18)
        tf.widthAnchor.constraint(equalToConstant: ControlWidth(95)).isActive = true
        tf.addTarget(self, action: #selector(DropDownCurrency1Action), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(DropDownCurrency1Action), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DropDownCurrency1Action)))
        return tf
    }()
    
    @objc func DropDownCurrency1Action() {
        IsDropDownCurrency1 = true
        let DropDown = DropDownList()
        DropDown.DropDownData = currencyData
        DropDown.Delegate = self
        if let Select = currencyData.firstIndex(where: {$0 == DropDownCurrency1.text}) {
        DropDown.SelectRow = IndexPath(row: Select , section: 0)
        }
                    
        DropDown.modalPresentationStyle = .popover
        DropDown.preferredContentSize = CGSize(width: ControlWidth(380), height: CGFloat(currencyData.count) * ControlWidth(40))

        let popController: UIPopoverPresentationController? = DropDown.popoverPresentationController
        popController?.permittedArrowDirections = [.unknown]
        popController?.delegate = self
        popController?.sourceView = DropDownCurrency1
        popController?.sourceRect = CGRect(
            x: DropDownCurrency1.frame.size.width/2,
            y: DropDownCurrency1.frame.size.height/2,
            width: 1,
            height: 1)
                
        popController?.backgroundColor = .white
        if currencyData.count != 0 {
        self.present(DropDown, animated: true, completion: { })
        }else{
        DropDownCurrency1Action()
        }
    }
    
    lazy var StackDropDownCurrency1 : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SpacingCurrency1,DropDownCurrency1])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(12)
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    lazy var ExchangeCurrencyIcon : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.contentVerticalAlignment = .center
        Button.contentHorizontalAlignment = .center
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setImage(UIImage(named: "ExchangeCurrencyIcon"), for: .normal)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Button.addTarget(self, action: #selector(ActionExchangeCurrency), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionExchangeCurrency() {
        Currency1TF.text = ""
        Currency2TF.text = ""
    }

    lazy var Currency2TF : FloatingTF = {
        let tf = FloatingTF()
        tf.tag = 2
        tf.ShowError = false
        tf.TitleHidden = true
        tf.tintColor = .clear
        tf.backgroundColor = .clear
        tf.titleActiveTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.keyboardType = .numberPad
        tf.layer.borderWidth = ControlWidth(1)
        tf.addTarget(self, action: #selector(CurrencyTarget(_:)), for: .editingChanged)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: ControlWidth(120) , height: tf.frame.height))
        tf.rightViewMode = .always
        return tf
    }()
    
    
    lazy var SpacingCurrency2 : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.widthAnchor.constraint(equalToConstant: ControlWidth(3)).isActive = true
        return View
    }()
    
    lazy var DropDownCurrency2 : FloatingTF = {
        let tf = FloatingTF()
        tf.text = "EGP"
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = true
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.tintColor = .clear
        tf.layer.borderWidth = 0
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 18, Height: 18)
        tf.widthAnchor.constraint(equalToConstant: ControlWidth(95)).isActive = true
        tf.addTarget(self, action: #selector(DropDownCurrency2Action), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(DropDownCurrency2Action), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DropDownCurrency2Action)))
        return tf
    }()
    
    @objc func DropDownCurrency2Action() {
        IsDropDownCurrency1 = false
        let DropDown = DropDownList()
        DropDown.DropDownData = currencyData
        DropDown.Delegate = self
        if let Select = currencyData.firstIndex(where: {$0 == DropDownCurrency2.text}) {
        DropDown.SelectRow = IndexPath(row: Select, section: 0)
        }
                    
        DropDown.modalPresentationStyle = .popover
        DropDown.preferredContentSize = CGSize(width: ControlWidth(380), height: CGFloat(currencyData.count) * ControlWidth(40))

        let popController: UIPopoverPresentationController? = DropDown.popoverPresentationController
        popController?.permittedArrowDirections = [.unknown]
        popController?.delegate = self
        popController?.sourceView = DropDownCurrency2
        popController?.sourceRect = CGRect(
            x: DropDownCurrency2.frame.size.width/2,
            y: DropDownCurrency2.frame.size.height/2,
            width: 1,
            height: 1)
                
        popController?.backgroundColor = .white
        
        if currencyData.count != 0 {
        self.present(DropDown, animated: true, completion: { })
        }else{
        DropDownCurrency2Action()
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func DropDownSelect(_ Index: String) {
        if IsDropDownCurrency1 {
        DropDownCurrency1.text = Index
        }else{
        DropDownCurrency2.text = Index
        }
    }
    
    
    lazy var StackDropDownCurrency2 : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SpacingCurrency2,DropDownCurrency2])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(12)
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    private var currencyData: [String] = []
    func fetchJson(_ key: String = "USD", completion: @escaping (ExchangeRates) -> ()) {
       guard let url = URL(string: "https://open.er-api.com/v6/latest/\(String(describing: key))") else {return}
       URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
        print(error)
        return
        }
        guard let safeData = data else {return}
        
        do {
        let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
        DispatchQueue.main.async {
        completion(results)
        for Data in results.rates {
        self.currencyData.append(Data.key)
        }
        }
        } catch {
        print(error)
        }
       }.resume()
   }
    
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Currency1TF,ExchangeCurrencyIcon,Currency2TF])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    func SetExchangeCurrencyVC() {
        self.view.subviews.forEach { View in View.alpha = 0}
        UIView.animate(withDuration: 0.4) {
        DataGetScreen(self, 25) { data in
        self.SetData(data)
        } _: { IsError in
        self.view.subviews.forEach { View in
        View.alpha = IsError ? 0:1
        self.ViewNoData.isHidden = IsError ? false:true

        if IsError == true {
        self.SetUpIsError(true) {
        self.SetExchangeCurrencyVC()
        }
        }
        }
        }
        }
    }
    
    func SetData(_ Data:ScreenData?) {
        ViewDismiss.TextLabel = Data?.title ?? "Exchange Currency"
        Currency1TF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 187}).first?.lable ?? "Number", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        DropDownCurrency1.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 187}).first?.lable ?? "Item", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
        Currency2TF.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 187}).first?.lable ?? "Number", attributes:[.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        DropDownCurrency2.attributedPlaceholder = NSAttributedString(string: Data?.screenElements.filter({$0.id == 187}).first?.lable ?? "Item", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    }
}
