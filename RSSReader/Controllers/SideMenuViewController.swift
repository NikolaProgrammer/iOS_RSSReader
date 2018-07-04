//
//  SideMenuViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 03.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var headerTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    let menuTitles: [String] = ["Onliner.by", "TUT.by", "Lenta.ru"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        // Shadow for headerTextView
        headerTextView.clipsToBounds = false
        let layer = headerTextView.layer
        layer.shadowRadius = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        
        //tableView header
        let header = UIView(frame: CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: 40))
        tableView.tableHeaderView = header
        
    }

}

extension SideMenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.menuCell) as! MenuTableViewCell
        
        cell.titleLabel.text = menuTitles[indexPath.row]
        
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        UIView.transition(with: cell,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            cell.titleLabel.textColor = #colorLiteral(red: 0.7465571385, green: 0.7465571385, blue: 0.7465571385, alpha: 1)
                            cell.pointersView.isActive = false
                          },
                          completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        UIView.transition(with: cell,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            cell.titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                            cell.pointersView.isActive = true
                          },
                          completion: nil)
    
    }
}










