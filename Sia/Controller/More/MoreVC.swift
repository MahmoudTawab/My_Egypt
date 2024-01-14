//
//  MoreVC.swift
//  Sia
//
//  Created by Emojiios on 18/10/2022.
//

import UIKit

class MoreVC: ViewController {
    
    var MoreData = [ScreenElements]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        SetDataMore()
        ShowWhatsUp = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        
    view.addSubview(MoreBackground1)
    MoreBackground1.frame = view.bounds
        
    view.addSubview(ViewBackground)
    ViewBackground.frame = CGRect(x: ControlX(60), y: 0, width: view.frame.width - ControlX(120), height: view.frame.height)
        
    view.addSubview(MoreTable)
    view.addSubview(MoreBackground2)
    MoreBackground2.frame = view.bounds
        
    view.addSubview(MoreLabel)
    MoreLabel.frame = CGRect(x: ControlX(15), y: ControlY(60), width: view.frame.width - ControlX(30), height: ControlWidth(40))

    MoreTable.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor).isActive = true
    MoreTable.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor).isActive = true
    MoreTable.topAnchor.constraint(equalTo: MoreLabel.bottomAnchor, constant: ControlY(10)).isActive = true
    MoreTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ControlY(-60)).isActive = true
        
    }

    lazy var MoreBackground1 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "MoreBackground1")
        return ImageView
    }()
    
    lazy var MoreBackground2 : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "MoreBackground2")
        return ImageView
    }()
    
    
    lazy var ViewBackground : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9432628751, green: 0.8789214492, blue: 0.7612995505, alpha: 1)
        return View
    }()
    
    lazy var MoreLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Nexa-XBold" ,size: ControlWidth(33))
        return Label
    }()

    let MoreId = "More"
    lazy var MoreTable: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.bounces = false
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 80
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MoreCell.self, forCellReuseIdentifier: MoreId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlY(20), right: 0)
        return tv
    }()

}

extension MoreVC: UITableViewDelegate, UITableViewDataSource ,MoreDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  MoreId,for: indexPath) as! MoreCell
        cell.Delegate = self
        cell.selectionStyle = .none
        cell.MoreLabel.text  = MoreData[indexPath.item].lable
        return cell
    }
    
    func MoreAction(_ Cell:MoreCell) {
        if let indexPath = MoreTable.indexPath(for: Cell) {
        switch MoreData[indexPath.item].id {
        case 137:
        Present(ViewController: self, ToViewController: HelpVC())
            
        case 138:
        Present(ViewController: self, ToViewController: ExchangeCurrencyVC())

        case 140:
        Present(ViewController: self, ToViewController: EmergencyContactsVC())

        case 141:
        let Map = MapKitSearchViewController()
        Map.modalPresentationStyle = .fullScreen
        present(Map, animated: true, completion: nil)
            
        case 142:
        if HomeScreenData?.userData?.email != nil {
        Present(ViewController: self, ToViewController: TripPurposeVC())
        }else{
        ShowMessageAlert("ErrorIcon", "Sorry, you are not a user", "…you won’t be able to leave comments, rate, favorite or even reserve places and events.", false, {
        Present(ViewController: self, ToViewController: MyAccountVC())
        },"Sign-Up")
        }
            
        default:
        break
        }
        }
    }
    
    func SetDataMore() {
    self.view.subviews.forEach { View in View.alpha = 0}
    UIView.animate(withDuration: 0.4) {
    DataGetScreen(self, 20) { data in
    self.MoreData = data.screenElements
    self.MoreLabel.text = data.title ?? "More"

    self.MoreTable.reloadData()
    } _: { IsError in
    self.view.subviews.forEach { View in
    View.alpha = IsError ? 0:1
    self.ViewNoData.isHidden = IsError ? false:true
                    
    if IsError == true {
    self.SetUpIsError(true) {
    self.SetDataMore()
    }
    }
    }
    }
    }
    }

}

