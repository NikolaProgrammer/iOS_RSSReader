//
//  OfferPostViewController.swift
//  RSSReader
//
//  Created by Nikolay Sereda on 10.07.2018.
//  Copyright © 2018 Nikolay Sereda. All rights reserved.
//

import UIKit
import MobileCoreServices

class OfferPostViewController: BaseViewController {
    
    //MARK: Properties
    private let sources: [MenuSections] = [.tut, .onliner, .lenta]
    private var selectedImage: UIImage? {
        didSet{
            if selectedImage == nil {
                choosedImageStackView.isHidden = true
            } else {
                (choosedImageStackView.arrangedSubviews[0] as! UIImageView).image = selectedImage
                choosedImageStackView.isHidden = false
            }
        }
    }
    
   
    @IBOutlet weak var choosedImageStackView: UIStackView!
    @IBOutlet weak var headerTabBar: UICollectionView!
    @IBOutlet weak var postTextView: UIView!
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title in navigation bar
        navigationItem.title = MenuSections.offerPost.rawValue
        
        // set cell's width
        let width = view.frame.width / 3
        let layout = headerTabBar.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: CGFloat(50))
        
        //set border for postText view
        let layer = postTextView.layer
        layer.borderWidth = 0.5
        
    }
    
    //MARK: Actions
    @IBAction func photoButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeImage as String]
            imagePickerController.delegate = self
            
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func attachButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func deselectImageButtonTapped(_ sender: UIButton) {
        selectedImage = nil
    }
    
}

extension OfferPostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerTabBar.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.sourceCell, for: indexPath) as! SourceCollectionViewCell
        
        let source = sources[indexPath.item]
        
        if source == .onliner {
            cell.isSelected = true
        }
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        
        cell.id = source
        cell.sourceLabel.text = source.rawValue

        return cell
    }
    
}

extension OfferPostViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let visibleCells = collectionView.visibleCells as! [SourceCollectionViewCell]
        for cell in visibleCells {
            cell.isSelected = false
        }
        
    }
}

extension OfferPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
}
