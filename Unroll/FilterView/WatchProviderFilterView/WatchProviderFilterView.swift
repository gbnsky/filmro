//
//  WatchProviderFilterView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 20/09/23.
//

import UIKit

class WatchProviderFilterView: UIView {
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 16)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Watch Providers".localized()
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .none
        collectionView.allowsMultipleSelection = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(WatchProviderFilterCollectionViewCell.self, forCellWithReuseIdentifier: WatchProviderFilterCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var loadedWatchProviders: [WatchProvider] = []
    private var selectedWatchProviders: [WatchProvider] = []
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with watchProviders: [WatchProvider]?) {
        guard let watchProviders = watchProviders else {
            return
        }
        let orderedWatchProviders = getWatchProvidersWithRegionPriority(from: watchProviders)
        self.loadedWatchProviders = orderedWatchProviders
        updateCollectionView()
    }
    
    func getSelectedWatchProviders() -> [WatchProvider] {
        return selectedWatchProviders
    }
    
    // MARK: - Private Methods
    
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
    
    private func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
}

// MARK: - Collection View

// delegate

extension WatchProviderFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let watchProviderCell = cell as? WatchProviderFilterCollectionViewCell else {
            return
        }
        
        if watchProviderCell.isSelected {
            watchProviderCell.select()
            return
        }
        
        watchProviderCell.deselect()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WatchProviderFilterCollectionViewCell else {
            return
        }
        
        let watchProvider = loadedWatchProviders[indexPath.item]
        
        cell.select()
        selectWatchProvider(watchProvider)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WatchProviderFilterCollectionViewCell else {
            return
        }
        
        let watchProvider = loadedWatchProviders[indexPath.item]
        
        cell.deselect()
        deselectWatchProvider(watchProvider)
    }
}

// data Source

extension WatchProviderFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedWatchProviders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchProviderFilterCollectionViewCell.identifier, for: indexPath) as? WatchProviderFilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(with: loadedWatchProviders[indexPath.item].providerName, and: Colors.green)
        
        return cell
    }
}

// delegate flow layout

extension WatchProviderFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - View Coding

extension WatchProviderFilterView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // title
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.rightAnchor.constraint(equalTo: rightAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // collection view
            
            collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
