//
//  WatchProviderViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 25/09/23.
//

import UIKit

class WatchProviderViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var watchProvidersView: WatchProviderView = {
        let view = WatchProviderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var loadedWatchProviders: [WatchProvider] = []
    var selectedWatchProviders: [WatchProvider] = []
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = watchProvidersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWatchProviders()
    }
    
    // MARK: - Private Methods
    
    private func fetchWatchProviders() {
        MovieApi.shared.getWatchProviderList { watchProviders in
            self.setFetchedWatchProviders(with: watchProviders)
        }
    }
    
    private func selectWatchProvider(_ watchProvider: WatchProvider) {
        selectedWatchProviders.append(watchProvider)
    }
    
    private func deselectWatchProvider(_ watchProvider: WatchProvider) {
        
        for (index, value) in selectedWatchProviders.enumerated() {
            if value.providerId == watchProvider.providerId {
                selectedWatchProviders.remove(at: index)
            }
        }
    }
    
    private func getWatchProvidersWithRegionPriority(from watchProviders: [WatchProvider]) -> [WatchProvider] {
        let region = MovieApi.shared.getWatchRegion()
        var orderedWatchProviders: [WatchProvider] = []
        
        for watchProvider in watchProviders {
            
            switch region {
                
            case .usa:
                if watchProvider.displayPriorities.us != nil {
                    orderedWatchProviders.append(watchProvider)
                }
                
            case .brazil:
                if watchProvider.displayPriorities.br != nil {
                    orderedWatchProviders.append(watchProvider)
                }
            }
        }
        
        orderedWatchProviders.sort { $0.displayPriority < $1.displayPriority }
        
        return orderedWatchProviders
    }
    
    private func setFetchedWatchProviders(with watchProviders: [WatchProvider]?) {
        guard let watchProviders = watchProviders else {
            return
        }
        let orderedWatchProviders = getWatchProvidersWithRegionPriority(from: watchProviders)
        self.loadedWatchProviders = orderedWatchProviders
        
        watchProvidersView.reloadCollectionViewData()
    }
}

// MARK: - Collection View DataSource

extension WatchProviderViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedWatchProviders.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchProviderCollectionViewCell.identifier, for: indexPath) as! WatchProviderCollectionViewCell
        
        cell.setup(with: loadedWatchProviders[indexPath.item].providerName, and: Colors.green)
        
        return cell
    }
}

// MARK: - Collection View Delegate

extension WatchProviderViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let watchProvider = loadedWatchProviders[indexPath.item]
        selectWatchProvider(watchProvider)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let watchProvider = loadedWatchProviders[indexPath.item]
        deselectWatchProvider(watchProvider)
    }
}

// MARK: - Collection View Delegate Flow Layout

extension WatchProviderViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
