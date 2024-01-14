//
//  DropDownList.swift
//  Sia
//
//  Created by Emojiios on 16/10/2022.
//

import UIKit

protocol DropDownListDelegate {
    func DropDownSelect(_ Index: String)
}

class DropDownList: UITableViewController {
    
    var SelectRow : IndexPath?
    var DropDownData : [String]?
    var Delegate : DropDownListDelegate?

    var TextColor : UIColor = .black {
        didSet {
        tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.backgroundColor = .clear
        tableView.rowHeight = ControlWidth(40)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.backgroundView = BackgroundImage
        
        UIView.animate(views: self.view.subviews,
        animations: AnimationsView,duration: 0.5, options: [.curveEaseInOut],completion: {})
    }

    lazy var BackgroundImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.contentMode = .scaleAspectFill
        Image.image = UIImage(named: "Group 57578")
        return Image
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DropDownData?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    cell.textLabel?.textColor = TextColor
    cell.textLabel?.text = DropDownData?[indexPath.row] ?? ""
    cell.accessoryType = self.SelectRow == indexPath ? .checkmark : .none
    cell.textLabel?.font = UIFont.systemFont(ofSize: ControlWidth(15), weight: .medium)
    return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let Data = DropDownData?[indexPath.row] {
    Delegate?.DropDownSelect(Data)
    self.SelectRow = indexPath
    self.tableView.reloadData()
    self.dismiss(animated: true)
    }
    }
}
