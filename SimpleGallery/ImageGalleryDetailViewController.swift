//
//  ImageGalleryDetailViewController.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 19/10/23.
//

import UIKit

class ImageGalleryDetailViewController: UIViewController {
    var artworkDetail: ArtworkDetail?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .blue
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        title = "Artwork Detail"
        view.backgroundColor = .systemBackground
        
        guard let artworkDetail = artworkDetail else {
            return
        }
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            categoryLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        guard let imageURL = URL(string: "https://www.artic.edu/iiif/2/\(artworkDetail.imageID)/full/843,/0/default.jpg") else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
        
        titleLabel.text = artworkDetail.title
        subtitleLabel.text = artworkDetail.artistDisplay
        categoryLabel.text = "Categories:\n\(artworkDetail.categoryTitles.joined(separator: " - "))"
    }
}
