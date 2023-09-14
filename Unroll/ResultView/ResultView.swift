//
//  ResultView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 11/09/23.
//

import UIKit

// MARK: - Class

class ResultView: UIView {
    
    // MARK: - Constants

    enum Constants {
        static let titleMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: .zero, bottom: 16, right: .zero)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Is this your movie?"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .none
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var page: Int = .zero
    private var movies: [Movie] = []
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with movies: Movies?) {
        guard let movies = movies else {
            return
        }
        self.page = movies.page
        self.movies = movies.results
    }
}

// MARK: - Collection View

// delegate

extension ResultView: UICollectionViewDelegate {

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? ResultCollectionViewCell else {
//            return
//        }
//    }
}

// data Source

extension ResultView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(with: movies[indexPath.item])
        
        return cell
    }
}

// delegate flow layout

extension ResultView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - View Coding

extension ResultView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(title, withMargins: Constants.titleMargins)
        stackView.addArrangedSubview(collectionView)
        scrollView.addSubview(stackView)
        addSubview(scrollView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // scroll view
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            
            // stack view
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
