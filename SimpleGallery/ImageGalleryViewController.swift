//
//  ViewController.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    // MARK: - Variable(s)
    private var artworks: [Artwork] = []
    private var currentPage = 1
    private let itemsPerPage = 15
    private var searchQuery: String = ""
    
    private lazy var searchBarHeader: UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search Artwork"
        s.delegate = self
        s.backgroundColor = .white
        s.backgroundImage = UIImage()
        s.tintColor = .black
        s.barTintColor = .black
        s.barStyle = .default
        s.sizeToFit()
        return s
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ArtworkCell.self, forCellWithReuseIdentifier: "ArtworkCell")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCell")
        
        return collectionView
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Override Function(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Artworks Gallery"
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupData() {
        loadArtworks()
    }
    
    // MARK: - Fetch Data
    private func searchArtworks() {
        URLSession.shared.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
        
        NetworkManager.searchArtworks(query: searchQuery) { [weak self] (artworks, error) in
            guard let artworks = artworks, error == nil else {
                print("Error Searching Artworks: \(error)")
                return
            }
            self?.artworks = artworks
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func loadArtworks() {
        loadingIndicator.startAnimating()
        
        NetworkManager.fetchArtworks(page: currentPage, limit: itemsPerPage) { [weak self] (artworks, error) in
            guard let artworks = artworks else {
                print("Error Fetching Artworks: \(error)")
                self?.loadingIndicator.stopAnimating()
                return
            }
            self?.artworks += artworks
            
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func fetchArtworkDetail(_ artworkId: Int) {
        NetworkManager.fetchArtworkDetail(id: artworkId) { [weak self] (artworkDetail, error) in
            guard let artworkDetail = artworkDetail else {
                print("Error Fetching Artwork Detail: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                let imageGalleryDetailViewController = ImageGalleryDetailViewController()
                imageGalleryDetailViewController.artworkDetail = artworkDetail
                
                self?.navigationController?.pushViewController(imageGalleryDetailViewController, animated: true)
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension ImageGalleryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            artworks = []
            loadArtworks()
            
            return
        }
        
        searchQuery = searchText
        searchArtworks()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ImageGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artworks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtworkCell", for: indexPath) as! ArtworkCell
        let artwork = artworks[indexPath.item]
        cell.configure(with: artwork)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHeight: CGFloat = ((self.view.frame.height - self.searchBarHeader.frame.height) / 6)
        let totalWidth: CGFloat = (self.view.frame.width / 3.2)

        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath)
        header.addSubview(searchBarHeader)
        searchBarHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBarHeader.leftAnchor.constraint(equalTo: header.leftAnchor),
            searchBarHeader.rightAnchor.constraint(equalTo: header.rightAnchor),
            searchBarHeader.topAnchor.constraint(equalTo: header.topAnchor),
            searchBarHeader.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20)
        ])
        return header
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            currentPage += 1
            loadArtworks()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard artworks[indexPath.item].id != 0 else {
            return
        }
        
        fetchArtworkDetail(artworks[indexPath.item].id)
    }
}
