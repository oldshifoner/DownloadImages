//
//  ViewModel.swift
//  DownloadImages
//
//  Created by Максим Игоревич on 23.11.2024.
//

import Foundation

class ViewModel {
    
    public var stringURLs: [URL] = []
    
    private let imageURLs: [String] = [
        "https://i.pinimg.com/736x/14/64/f5/1464f5cbd3244c9d684c1e5c923cebea.jpg",
        "https://i.pinimg.com/736x/85/b8/b7/85b8b7d18a9453a2f42248bca5e5081b.jpg",
        "https://i.pinimg.com/736x/24/d5/09/24d509e66a111feca41405147ceefc65.jpg",
        "https://i.pinimg.com/originals/26/c8/03/26c8038be8ac9ac7594bb23a03c5c8be.jpg",
        "https://i.pinimg.com/736x/0d/63/4e/0d634e7812232c5da03bbb1732e41c82.jpg",
        "https://i.pinimg.com/736x/9f/1a/c0/9f1ac0e798f7f912514a5142d41428d3.jpg",
        "https://i.pinimg.com/control2/736x/72/61/fe/7261fe2d12b8861466ace16393bef4a4.jpg",
        "https://i.pinimg.com/control2/736x/ec/c0/cc/ecc0cc4b89715c829ebf5abd2cd175ad.jpg"
    ]
    
    public func generateArrayURLs(count: Int){
        
        stringURLs = []
        
        for _index in 0..<count {
            stringURLs.append(URL(string: imageURLs[Int.random(in: 0..<imageURLs.count)])!)
        }
    }
    
}
