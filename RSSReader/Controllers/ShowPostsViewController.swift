//
//  ShowPostsViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

protocol ShowPostsViewControllerDelegate: class {
    func showPostsViewControllerDidMenuButton(_ view: ShowPostsViewController)
}

class ShowPostsViewController: UICollectionViewController {
    
    //MARK: Properties
    var posts: [Post] = []
    var url: String!
    
    weak var delegate: ShowPostsViewControllerDelegate?
    
    @IBOutlet weak var inProgressIndicatorView: UIActivityIndicatorView!
    
    private var largePostPosition = 1
  
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView?.collectionViewLayout as? PostsLayout {
            layout.delegate = self
        }
        
        parse(with: url)
    }
    
    //MARK: Actions
    @IBAction func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.showPostsViewControllerDidMenuButton(self)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.postCell, for: indexPath) as? PostCollectionViewCell else {
            fatalError("Current cell is not a instance of PostCollectionViewCell")
        }
        
        let post = posts[indexPath.item]
        if let imageURL = post.imageURL {
            cell.postImage.setImage(by: imageURL)
        }
        cell.titleTextView.text = post.title
        
        return cell
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








