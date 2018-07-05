//
//  ShowPostsViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 29.06.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit

class ShowPostsViewController: UICollectionViewController {
    
    //MARK: Properties
    var posts: [Post] = []
    
    private var largePostPosition = 1
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser = RSSParser(url: URL(string: "http://lenta.ru/rss")!)
        parser.parse()
        posts = parser.posts
        
        if let layout = collectionView?.collectionViewLayout as? PostsLayout {
            layout.delegate = self
        }
        
        
    }
    
    //MARK: Actions
    @IBAction func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        (navigationController?.parent as! ContainerViewController).toggleSideMenu()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.postCell, for: indexPath) as? PostCollectionViewCell else {
            fatalError("Current cell is not a instance of PostCollectionViewCell")
        }
        
        let post = posts[indexPath.item]
    
        if let imageURL = post.imageURL {
            cell.postImage.image = UIImage(url: imageURL)
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








