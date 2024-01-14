//
//  TripPurposeVC.swift
//  Sia
//
//  Created by Emojiios on 28/02/2023.
//

import UIKit

class TripPurposeVC: ViewController {
    
    var PurposeData : TripPurpose?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        ShowWhatsUp = true
        view.backgroundColor = .white
    }
    
  fileprivate func SetUpItems() {
      
    view.addSubview(TripPurposeBackground)
    TripPurposeBackground.frame = view.bounds
      
    view.addSubview(ViewDismiss)
    ViewDismiss.frame = CGRect(x: ControlX(20), y: ControlY(40), width: view.frame.width  - ControlX(40), height: ControlWidth(40))
      
    view.addSubview(StackItme)
    StackItme.frame = CGRect(x: ControlX(20), y: ViewDismiss.frame.maxY + ControlY(50), width: view.frame.width - ControlX(40), height: view.frame.height - ControlY(150))
      
    GetDataTripPurpose()
  }
       
    lazy var TripPurposeBackground : UIImageView = {
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

    let CellId = "CellId"
    var PurposeSelect = [TripPurposeSelect]()
    lazy var TripPurposeCV: UICollectionView = {
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = ControlX(25)
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isScrollEnabled = true
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(TripPurposeCell.self, forCellWithReuseIdentifier: CellId)
        return vc
    }()
    
    lazy var DoneButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionDone), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Nexa-Bold", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionDone() {
    SetDataTripPurpose()
    }
    
    lazy var StackItme : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TripPurposeCV,DoneButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.arrangedSubviews.first?.heightAnchor.constraint(equalTo: Stack.heightAnchor ,constant: ControlWidth(-70)).isActive = true
        return Stack
    }()
}

/// MARK: TripPurposeVC   Extension
extension TripPurposeVC : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , TripPurposeDelegate {
    
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
    self.PurposeData = TripPurpose(dictionary: dictionary)
    self.TripPurposeCV.reloadData()

    self.ViewDismiss.TextLabel = self.PurposeData?.screenData?.title ?? "Trip Purpose"
    self.DoneButton.setTitle(self.PurposeData?.screenData?.screenElements.filter({$0.id == 49}).first?.lable ?? "Done", for: .normal)
        
    self.PurposeData?.UserTrips.forEach({ Id in
    self.PurposeSelect.append(TripPurposeSelect(tripPurposeId: Id))
    self.TripPurposeCV.reloadData()
    })
        
    self.view.subviews.filter({$0 != self.ViewDots}).forEach{ View in View.alpha = 1}
    self.ViewNoData.isHidden = true
    self.ViewDots.endRefreshing {}
    } array: { array in
    } Err: { error in
    self.SetUpIsError(true) {
    self.GetDataTripPurpose()
    }
    }
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
        
    let parameters = ["currencyId": 0,
                      "cityId": 0,
                      "tripPurposes": DataAsAny(PurposeSelect)]
        
    self.ViewDots.beginRefreshing()
    PostAPI(timeout: 60,api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("Success Change Trip Purpose",.success) {}
    } dictionary: { _ in
    } array: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
}
