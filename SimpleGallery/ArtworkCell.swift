//
//  ArtworkCell.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import Foundation
import UIKit

class ArtworkCell: UICollectionViewCell {
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with artwork: Artwork) {
        guard let imageURL = URL(string: "https://www.artic.edu/iiif/2/\(artwork.imageId)/full/843,/0/default.jpg") else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
