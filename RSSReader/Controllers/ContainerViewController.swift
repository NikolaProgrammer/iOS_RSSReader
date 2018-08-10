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
    
    var menuSection: MenuSections = .onliner {
        didSet {
            showController()
            toggleSideMenu()
        }
    }
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        showController()

    }
    
    //MARK: Private Methods
    func toggleSideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.sideMenuConstraint.constant = self.isSideMenuShown ? -200 : 0
            self.view.layoutIfNeeded()
        }
        isSideMenuShown = !isSideMenuShown
    }
    
    private func showController() {
        
        guard let navigationController = self.childViewControllers[1] as? UINavigationController else {
            fatalError("Navigation controller expected")
        }
        
        if menuSection == .offerPost {
            let offerPostController = storyboard?.instantiateViewController(withIdentifier: StoryBoardIds.offerPost) as! OfferPostViewController
            navigationController.setViewControllers([offerPostController], animated: true)
            offerPostController.navigationItem.title = menuSection.rawValue
        } else {
            let postsController = storyboard?.instantiateViewController(withIdentifier: StoryBoardIds.posts) as! ShowPostsViewController
            postsController.url = menuSection.url

            navigationController.setViewControllers([postsController], animated: true)
        }

    }
}

