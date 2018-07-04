//
//  ContainerViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 03.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    private var isSideMenuShown = false
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigationController = self.childViewControllers[1] as? UINavigationController else {
            fatalError()
        }
        let showPostsController = navigationController.topViewController as! ShowPostsViewController
        
        showPostsController.delegate = self
    }
    
    //MARK: Private Methods
    private func toggleSideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.sideMenuConstraint.constant = self.isSideMenuShown ? -200 : 0
            self.view.layoutIfNeeded()
        }
        isSideMenuShown = !isSideMenuShown
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension ContainerViewController: ShowPostsViewControllerDelegate {
    func showPostsViewControllerDidMenuButton(_ view: ShowPostsViewController) {
        toggleSideMenu()
    }
}
