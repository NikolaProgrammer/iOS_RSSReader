//
//  BaseViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 10.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(sideMenuButtonTapped))
        menuButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationItem.leftBarButtonItem = menuButton
        
        
    }
    
    //MARK: Private Methods
    @objc private func sideMenuButtonTapped() {
        (navigationController?.parent as? ContainerViewController)?.toggleSideMenu()
    }

}
