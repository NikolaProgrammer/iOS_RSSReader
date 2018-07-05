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
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    var postsSection: MenuSections = .onliner {
        didSet {
            showPostsController()
            toggleSideMenu()
        }
    }
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        showPostsController()

    }
    
    //MARK: Private Methods
    func toggleSideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.sideMenuConstraint.constant = self.isSideMenuShown ? -200 : 0
            self.view.layoutIfNeeded()
        }
        isSideMenuShown = !isSideMenuShown
    }
    
    private func showPostsController() {
        
        let postsController = storyboard?.instantiateViewController(withIdentifier: "ShowPosts") as! ShowPostsViewController
        postsController.url = postsSection.url
        
        guard let navigationController = self.childViewControllers[1] as? UINavigationController else {
            fatalError("Navigation controller expected")
        }
       
        navigationController.setViewControllers([postsController], animated: true)
        postsController.navigationItem.title = postsSection.rawValue
       
    }
}

