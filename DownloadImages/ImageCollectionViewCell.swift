//
//  ImageCollectionViewCell.swift
//  DownloadImages
//
//  Created by Максим Игоревич on 20.11.2024.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell{
    public var imageUIView: UIImageView?{
        didSet{
            guard let imageUIView else {return}
            backgroundView = imageUIView
            backgroundView?.layer.cornerRadius = 12
        }
    }
}
