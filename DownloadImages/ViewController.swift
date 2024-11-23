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
    
    private let urlsArray: [String] = [
    "https://i.pinimg.com/736x/14/64/f5/1464f5cbd3244c9d684c1e5c923cebea.jpg",
    "https://i.pinimg.com/736x/85/b8/b7/85b8b7d18a9453a2f42248bca5e5081b.jpg",
    "https://i.pinimg.com/736x/24/d5/09/24d509e66a111feca41405147ceefc65.jpg",
    "https://i.pinimg.com/originals/26/c8/03/26c8038be8ac9ac7594bb23a03c5c8be.jpg",
    "https://i.pinimg.com/736x/0d/63/4e/0d634e7812232c5da03bbb1732e41c82.jpg",
    "https://i.pinimg.com/736x/9f/1a/c0/9f1ac0e798f7f912514a5142d41428d3.jpg",
    "https://i.pinimg.com/control2/736x/72/61/fe/7261fe2d12b8861466ace16393bef4a4.jpg",
    "https://i.pinimg.com/control2/736x/ec/c0/cc/ecc0cc4b89715c829ebf5abd2cd175ad.jpg"
    ]
    
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
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "https://i.pinimg.com/736x/85/b8/b7/85b8b7d18a9453a2f42248bca5e5081b.jpg")!) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
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
        
        let randomNumber = Int.random(in: 0...7)
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: self.urlsArray[randomNumber])!) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    uiImageView.image = image
                }
            }
        }
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
