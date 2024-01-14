//
//  WelcomeVC.swift
//  Sia
//
//  Created by Emojiios on 17/10/2022.
//

import UIKit

struct TripPurposeSelect: Codable {
    var tripPurposeId : Int
}

class WelcomeVC: ViewController  ,DropDownListDelegate {
    
    var tutorialPageViewController: ScreenPageView? {
    didSet {
    tutorialPageViewController?.tutorialDelegate = self
    }
    }
    
    var currentPage = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowWhatsUp =  false
        view.backgroundColor = .white
        SetUpItems()
    }
    
    
  fileprivate func SetUpItems() {
    view.addSubview(Welcome2)
    Welcome2.frame = view.bounds
        
    view.addSubview(Welcome1)

    view.addSubview(StackItems)
    StackItems.frame = CGRect(x: ControlX(40), y: ControlY(100), width: view.frame.width - ControlX(80), height:  view.frame.height - ControlY(150))
      
    Welcome1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    Welcome1.topAnchor.constraint(equalTo: TopLabel.bottomAnchor).isActive = true
    Welcome1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    Welcome1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PageControl.set(progress: currentPage, animated: false)
        SetUpEnum()
    }

    lazy var Welcome1 : UIImageView = {
        let Image = UIImageView()
        Image.isHidden = false
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Welcome")
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var Welcome2 : UIImageView = {
        let Image = UIImageView()
        Image.isHidden = true
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Welcome2")
        return Image
    }()

    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return Label
    }()

    lazy var LabelNumber : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
  
    lazy var PageControl : WOPageControl = {
        let Page = WOPageControl()
        Page.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Page.numberOfPages = 2
        Page.padding = ControlX(15)
        Page.enableTouchEvents = true
        Page.radius = ControlWidth(2.5)
        Page.currentPageTintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Page.translatesAutoresizingMaskIntoConstraints = false
        Page.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        Page.transform = "lang".localizable == "ar" ? CGAffineTransform(rotationAngle: .pi) : .identity
        return Page
    }()
    
    lazy var StackPage : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelNumber,PageControl])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Stack
    }()
    
    
    /// MARK: Set Up Page First TF
    var IsCurrencyDropDown = Bool()
    var SelectCurrency = Int()
    var SelectVisitingCity = Int()
    var DataCurrenciesAndCities : CurrenciesAndCities?
    lazy var CurrencyTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.TitleHidden = false
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.addTarget(self, action: #selector(CurrencyAction), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(CurrencyAction), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CurrencyAction)))
        return tf
    }()
    
    var CurrencyList = [String]()
    @objc func CurrencyAction() {
        IsCurrencyDropDown = true
        let DropDown = DropDownList()
        DropDown.DropDownData = CurrencyList
        DropDown.Delegate = self
        if let Select = CurrencyList.firstIndex(where: {$0 == CurrencyTF.text}) {
        DropDown.SelectRow = IndexPath(row: Select , section: 0)
        }
        
        DropDown.modalPresentationStyle = .popover
        DropDown.preferredContentSize = CGSize(width: ControlWidth(380), height: CGFloat(CurrencyList.count) * ControlWidth(40))

        let popController: UIPopoverPresentationController? = DropDown.popoverPresentationController
        popController?.permittedArrowDirections = [.unknown]
        popController?.delegate = self
        popController?.sourceView = CurrencyTF
        popController?.sourceRect = CGRect(
            x: CurrencyTF.frame.size.width/2,
            y: CurrencyTF.frame.size.height/2,
            width: 1,
            height: 1)
                
        popController?.backgroundColor = .white
        if CurrencyList.count != 0 {
            self.present(DropDown, animated: true, completion: { })
        }
    }
    
    lazy var VisitingCityTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.TitleHidden = false
        tf.tintColor = .clear
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.IconImage = UIImage(named: "arrow-back")
        tf.SetUpIcon(LeftOrRight: false, Width: 20, Height: 20)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.addTarget(self, action: #selector(VisitingCityAction), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(VisitingCityAction), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(VisitingCityAction)))
        return tf
    }()
    
    var CityList = [String]()
    @objc func VisitingCityAction() {
        IsCurrencyDropDown = false
        let DropDown = DropDownList()
        DropDown.DropDownData = CityList
        DropDown.Delegate = self
        if let Select = CityList.firstIndex(where: {$0 == VisitingCityTF.text}) {
        DropDown.SelectRow = IndexPath(row: Select , section: 0)
        }
                    
        DropDown.modalPresentationStyle = .popover
        DropDown.preferredContentSize = CGSize(width: ControlWidth(380), height: CGFloat(CityList.count) * ControlWidth(40))

        let popController: UIPopoverPresentationController? = DropDown.popoverPresentationController
        popController?.permittedArrowDirections = [.unknown]
        popController?.delegate = self
        popController?.sourceView = VisitingCityTF
        popController?.sourceRect = CGRect(
            x: VisitingCityTF.frame.size.width/2,
            y: VisitingCityTF.frame.size.height/2,
            width: 1,
            height: 1)
                
        popController?.backgroundColor = .white
        if CityList.count != 0 {
        self.present(DropDown, animated: true, completion: { })
        }
    }

    func DropDownSelect(_ Index: String) {
    if IsCurrencyDropDown {
    CurrencyTF.text = Index
    SelectCurrency = DataCurrenciesAndCities?.currencies.filter({$0.currencyName == Index}).first?.id ?? 0
    }else{
    VisitingCityTF.text = Index
    SelectVisitingCity = DataCurrenciesAndCities?.cities.filter({$0.cityName == Index}).first?.id ?? 0
    }
    }
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [CurrencyTF,VisitingCityTF])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(160)).isActive = true
        return Stack
    }()
    
    /// MARK: Set Up Page last Trip purpose
    lazy var TripPurposeLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Nexa-Bold" ,size: ControlWidth(20))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    let CellId = "CellId"
    var PurposeData : TripPurpose?
    var PurposeSelect = [TripPurposeSelect]()
    lazy var TripPurposeCV: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isScrollEnabled = true
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(TripPurposeCell.self, forCellWithReuseIdentifier: CellId)
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
        return vc
    }()
    
    
    lazy var StackTripPurpose : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TripPurposeLabel,TripPurposeCV])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(170)).isActive = true
        return Stack
    }()

    lazy var NextButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        return Button
    }()

    @objc func ActionNext() {
    if currentPage == 0 {
    tutorialPageViewController?.scrollToViewController(index: 1)
    }else{
    SetDataTripPurpose()
    }
    }
    
    lazy var ButtonBack : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Button.backgroundColor = .clear
        Button.layer.borderWidth = ControlWidth(2)
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.addTarget(self, action: #selector(ActionBack), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        return Button
    }()
    
    @objc func ActionBack() {
        SetDataTripPurpose()
    }
    
    lazy var StackButton : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ButtonBack,NextButton])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Stack
    }()

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,StackPage,StackTF,StackTripPurpose,UIView(),UIView(),UIView(),StackButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    func SetUpEnum()  {
    switch self.currentPage {
    case 0:
        Welcome1.isHidden = false
        Welcome2.isHidden = true
        
        StackTF.alpha = 1
        StackTripPurpose.alpha = 0
        GetDataCurrenciesAndCities()
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [], animations: {
        self.StackTF.isHidden = false
        self.StackTripPurpose.isHidden = true
        })
        
    case 1:

        Welcome1.isHidden = true
        Welcome2.isHidden = false
        
        StackTF.alpha = 0
        GetDataTripPurpose()
        StackTripPurpose.alpha = 1
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [], animations: {
        self.StackTF.isHidden = true
        self.StackTripPurpose.isHidden = false
        })
    default:
    break
    }
        
    }
}


/// MARK: WelcomeVC   Extension
extension WelcomeVC : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , TripPurposeDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PurposeData?.listTrip.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! TripPurposeCell
        cell.Delegate = self
        cell.clipsToBounds = true
        cell.Label.unpauseLabel()
        cell.Label.speed = .rate(60)
        cell.Label.speed = .duration(20)
        cell.layer.borderWidth = ControlX(2)
        cell.layer.cornerRadius = cell.frame.height / 2.2
        cell.Label.text = PurposeData?.listTrip[indexPath.item].purposeName
        
        let Id = PurposeData?.listTrip[indexPath.item].id ?? 0
        if self.PurposeSelect.contains(where: {$0.tripPurposeId == Id}) {
        cell.Label.textColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        cell.backgroundColor = .clear
        }else{
        cell.backgroundColor = .clear
        cell.Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 3) - ControlWidth(8), height: ControlWidth(40))
    }
    
    func TripPurposeAction(_ Cell:TripPurposeCell) {
        if let indexPath = TripPurposeCV.indexPath(for: Cell) {
        let Id = PurposeData?.listTrip[indexPath.item].id ?? 0
        if self.PurposeSelect.contains(where: {$0.tripPurposeId == Id}) {
        if let index = self.PurposeSelect.firstIndex(where: {$0.tripPurposeId == Id}) {
        PurposeSelect.remove(at: index)
        TripPurposeCV.reloadItems(at: [indexPath])
        }
        }else{
        PurposeSelect.append(TripPurposeSelect(tripPurposeId: Id))
        TripPurposeCV.reloadItems(at: [indexPath])
        }

        UIView.animate(withDuration: 0.3, animations: {
        Cell.transform = Cell.transform.scaledBy(x: 0.8, y: 0.8)
        }, completion: { _ in
        UIView.animate(withDuration: 0.3, animations: {
        Cell.transform = .identity
        })
        })
        }
    }
    
    func GetDataCurrenciesAndCities() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetDataCurrenciesAndCities()
    }
    return
    }
        
    let api = "\(url + GetCurrenciesAndCities)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { dictionary in
    self.SetDataPage1(CurrenciesAndCities(dictionary: dictionary))
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetDataCurrenciesAndCities()
    }
    }
    }
    
    func SetDataPage1(_ data:CurrenciesAndCities) {
    DataCurrenciesAndCities = data
        
    // MARK: Setup TopLabel String
    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlWidth(15)
    style.alignment = .center
        
    let TopLabelString = NSMutableAttributedString(string: data.screenData?.screenElements.filter({$0.id == 32}).first?.lable ?? "Welcome", attributes: [
        .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
        .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
        .paragraphStyle:style
    ])
        
    TopLabelString.append(NSAttributedString(string: " \n ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:style
    ]))
        
    TopLabelString.append(NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 33}).first?.lable ?? "Please answer this question for a better experience", attributes: [
        .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style
    ]))
    TopLabel.attributedText = TopLabelString
       
    LabelNumber.text = data.screenData?.screenElements.filter({$0.id == 38}).first?.lable ?? "1 of 2"
    CurrencyTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 34}).first?.lable ?? "Select currency", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
    VisitingCityTF.attributedPlaceholder = NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 35}).first?.lable ?? "Select city", attributes:[.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        
    NextButton.setTitle(data.screenData?.screenElements.filter({$0.id == 37}).first?.lable ?? "Next", for: .normal)
    ButtonBack.setTitle(data.screenData?.screenElements.filter({$0.id == 36}).first?.lable ?? "Skip", for: .normal)

    data.cities.forEach { Cities in
    if let Cities = Cities.cityName {
    self.CityList.append(Cities)
    }
    }

    data.currencies.forEach { Currencies in
    if let Currencies = Currencies.currencyName {
    self.CurrencyList.append(Currencies)
    }
    }
    }
    
    func GetDataTripPurpose() {
    view.subviews.filter({$0 != ViewIsError()}).forEach{ View in View.alpha = 0}
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.SetUpIsError(true) {
    self.GetDataTripPurpose()
    }
    return
    }
        
    let api = "\(url + GetTripPurpose)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: []) { _ in
    } dictionary: { dictionary in
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.SetDataPage2(TripPurpose(dictionary: dictionary))
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetDataTripPurpose()
    }
    }
    }
    
    
    func SetDataPage2(_ data:TripPurpose) {

    // MARK: Setup TopLabel String
    let style = NSMutableParagraphStyle()
    style.lineSpacing = ControlWidth(15)
    style.alignment = .center
        
    let TopLabelString = NSMutableAttributedString(string: data.screenData?.screenElements.filter({$0.id == 44}).first?.lable ?? "Welcome", attributes: [
        .font: UIFont(name: "Nexa-XBold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
        .foregroundColor: #colorLiteral(red: 0.950833261, green: 0.7497702241, blue: 0.3252720237, alpha: 1) ,
        .paragraphStyle:style
    ])
        
    TopLabelString.append(NSAttributedString(string: " \n ", attributes: [
        .foregroundColor: UIColor.clear ,
        .paragraphStyle:style
    ]))
        
    TopLabelString.append(NSAttributedString(string: data.screenData?.screenElements.filter({$0.id == 45}).first?.lable ?? "Please answer this question for a better experience", attributes: [
        .font: UIFont(name: "Nexa-Bold", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
        .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
        .paragraphStyle:style
    ]))
    TopLabel.attributedText = TopLabelString
       
    PurposeData = data
    TripPurposeCV.reloadData()
        
    LabelNumber.text = data.screenData?.screenElements.filter({$0.id == 46}).first?.lable ?? "1 of 2"
    TripPurposeLabel.text = data.screenData?.screenElements.filter({$0.id == 47}).first?.lable ?? "Trip purpose"

    NextButton.setTitle(data.screenData?.screenElements.filter({$0.id == 49}).first?.lable ?? "Done", for: .normal)
    ButtonBack.setTitle(data.screenData?.screenElements.filter({$0.id == 48}).first?.lable ?? "Skip", for: .normal)
    }
    

    func SetDataTripPurpose() {
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error", "Something went wrong while processing your request, please try again later", true, {})
    return
    }
    
    let api = "\(url + SetTripPurpose)"
    let token = defaults.string(forKey: "jwt") ?? ""
        
    let parameters = ["currencyId": SelectCurrency,
                      "cityId": SelectVisitingCity,
                      "tripPurposes": DataAsAny(PurposeSelect)]
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing {}
    Present(ViewController: self, ToViewController: SuccessfullyVC())
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
    
}


extension WelcomeVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}


extension WelcomeVC : TutorialPageViewControllerDelegate {
    
    func didTapNextButton(_ sender: Any) {
        tutorialPageViewController?.scrollToNextViewController()
    }
    
    func tutorialPageViewController(tutorialPageViewController: ScreenPageView,
            didUpdatePageCount count: Int) {
            PageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: ScreenPageView, didUpdatePageIndex index: Int) {
        PageControl.set(progress: index, animated: false)
    }
}
