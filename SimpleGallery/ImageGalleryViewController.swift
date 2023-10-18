//
//  ViewController.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    var artworks: [Artwork] = []
    var currentPage = 1
    let itemsPerPage = 15
    
    var searchBar: UISearchBar!
    var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchQuery: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupSearchController()
        
        setupSearchBar()
        setupCollectionView()
        
        loadArtworks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Artworks"
        view.addSubview(searchBar)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Artworks"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArtworkCell.self, forCellWithReuseIdentifier: "ArtworkCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    func searchArtworks() {
        URLSession.shared.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
        
        NetworkManager.searchArtworks(query: searchQuery) { [weak self] (artworks, error) in
            guard let artworks = artworks, error == nil else {
                // Handle error
                return
            }
            self?.artworks = artworks
            self?.collectionView.reloadData()
        }
    }
    
    func loadArtworks() {
        NetworkManager.fetchArtworks(page: currentPage, limit: itemsPerPage) { [weak self] (artworks, error) in
            guard let artworks = artworks else {
                // Handle error
                return
            }
            self?.artworks += artworks
            self?.currentPage += 1
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension ImageGalleryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
        searchArtworks()
    }
}

extension ImageGalleryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            searchQuery = searchText
            searchArtworks()
        }
    }
}

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
        let totalHeight: CGFloat = ((self.view.frame.height - self.searchBar.frame.height) / 6)
        let totalWidth: CGFloat = (self.view.frame.width / 3.2)

        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            currentPage += 1
            loadArtworks()
        }
    }
}
