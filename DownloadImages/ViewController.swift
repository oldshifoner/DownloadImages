//
//  ViewController.swift
//  DownloadImages
//
//  Created by Максим Игоревич on 20.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    enum Constants {
        static let padding: CGFloat = 10
        static let number: CGFloat = 4
    }
    
    var image: UIImage?
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var itemCount = 64
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let number: CGFloat = Constants.number
        let padding: CGFloat = Constants.padding
        
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = .init(top: Constants.padding, left: Constants.padding, bottom: 0, right: Constants.padding)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "https://i.pinimg.com/736x/85/b8/b7/85b8b7d18a9453a2f42248bca5e5081b.jpg")!) {
                let image = UIImage(data: data)
//                DispatchQueue.main.async {
                    self.image = image
//                }
            }
//        }
        cacheImage(image!, forKey: "0")
        view = collectionView
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.contentView.layer.cornerRadius = 12
        let uiImageView = UIImageView()
        uiImageView.image = self.image
        uiImageView.contentMode = .scaleAspectFill
        cell.imageUIView = uiImageView
        return cell
    }
    
    func cacheImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    func getCachedImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - Constants.padding * (Constants.number + 1)) / Constants.number
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
