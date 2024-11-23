//
//  ImageCollectionViewCell.swift
//  DownloadImages
//
//  Created by Максим Игоревич on 20.11.2024.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell{
    
    public var imageView = DownloadableImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
