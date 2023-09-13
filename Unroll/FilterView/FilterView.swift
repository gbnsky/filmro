//
//  FilterView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 07/09/23.
//

import UIKit

// MARK: - Delegate

protocol FilterViewDelegate: AnyObject {
    func fetchResults(with filters: Filters)
}

// MARK: - Class

class FilterView: UIView {
        
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Just like Subway,\nchoose the ingredients."
        return label
    }()
    
    private lazy var genreView: GenreView = {
        let view = GenreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var runtimeView: RuntimeView = {
        let view = RuntimeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.backgroundColor = Colors.orange
        button.layer.borderColor = Colors.blackOne.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Exposed Properties
    
    weak var delegate: FilterViewDelegate?
    
    // MARK: - Private Properties
    
    private var filters: Filters?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setupGenreView(with genres: [Genre]?) {
        genreView.setup(with: genres)
    }
    
    // MARK: - Private Methods
    
    private func setupFilters() {
        let filters = Filters(page: "1", genres: genreView.getSelectedGenres())
        self.filters = filters
    }
}

// MARK: - Actions

extension FilterView {
    
    @objc
    private func buttonAction() {
        setupFilters()
        
        if let filters = filters {
            delegate?.fetchResults(with: filters)
        }
    }
}

// MARK: - View Coding

extension FilterView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(genreView)
        addSubview(runtimeView)
        addSubview(button)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // title
            
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // genre collection view
            
            genreView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            genreView.widthAnchor.constraint(equalTo: widthAnchor),
            genreView.heightAnchor.constraint(equalToConstant: 160),
            
            // runtime slider view
            
            runtimeView.topAnchor.constraint(equalTo: genreView.bottomAnchor, constant: 16),
            runtimeView.rightAnchor.constraint(equalTo: rightAnchor),
            runtimeView.leftAnchor.constraint(equalTo: leftAnchor),
            runtimeView.heightAnchor.constraint(equalToConstant: 80),
            
            // button
            
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
