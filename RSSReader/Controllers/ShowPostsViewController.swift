//
//  ShowPostsViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class ShowPostsViewController: UIViewController {
    
    //MARK: Properties
    var posts: [Post] = []
    private var filteredPosts: [Post] = []
    var url: String!
    

    @IBOutlet weak var categoryBar: CategoryBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inProgressIndicatorView: UIActivityIndicatorView!
    
    private var largePostPosition = 1
  
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? PostsLayout {
            layout.delegate = self
        }
        categoryBar.delegate = self
        
        parse(with: url)
    }
    
    //MARK: Actions
    @IBAction func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        (navigationController?.parent as! ContainerViewController).toggleSideMenu()
    }

    //MARK: Private Methods
    private func parse(with url: String) {
        inProgressIndicatorView.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let parser = RSSParser(url: URL(string: url)!)
            parser.parse()
            
            self?.posts = parser.posts
            DispatchQueue.main.async {
                self?.inProgressIndicatorView.stopAnimating()
                self?.collectionView?.reloadData()
            }
            
        }
    }
}

extension ShowPostsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPosts.isEmpty ? posts.count : filteredPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.postCell, for: indexPath) as? PostCollectionViewCell else {
            fatalError("Current cell is not a instance of PostCollectionViewCell")
        }
        
        let post = filteredPosts.isEmpty ? posts[indexPath.item] : filteredPosts[indexPath.item]
        if let imageURL = post.imageURL {
            cell.postImage.setImage(by: imageURL)
        }
        cell.titleTextView.text = post.title
        
        return cell
    }
}

extension ShowPostsViewController: PostsLayoutDelegate {
    
    func collectionview(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        var size: CGFloat
        
        if indexPath.item == largePostPosition {
            size = collectionView.frame.height / 2.3
            largePostPosition += 3
        } else {
            size = collectionView.frame.height / 3.5
        }

        return size

    }
}

extension ShowPostsViewController: CategoryBarDelegate {
    func categoryBarButtonDidChangeState(_ view: CategoryBar, button: CategoryButton) {
        filteredPosts = posts.filter{ (post) -> Bool in
            return post.category == button.category
        }
        navigationItem.title = button.category?.categoryName
        
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}


