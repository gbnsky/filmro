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
        view.layoutMargins = UIEdgeInsets(top: 16, left: .zero, bottom: 32, right: .zero)
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
        label.text = "Just like Subway,\nchoose the ingredients".localized()
        return label
    }()
    
    private lazy var genreView: GenreView = {
        let view = GenreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sortByView: SortByView = {
        let view = SortByView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue".localized(), for: .normal)
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
        let filters = Filters(page: "1",
                              sortBy: sortByView.getSelectedSortBy(),
                              genres: genreView.getSelectedGenres())
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
        stackView.addArrangedSubview(title, withMargins: Constants.titleMargins)
        stackView.addArrangedSubview(genreView)
        stackView.addArrangedSubview(sortByView)
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        addSubview(button)
    }
    
    private func addConstraints() {
        
        let stackViewHeight = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        
        stackViewHeight.isActive = true
        stackViewHeight.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            
            // scroll view
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -32),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            
            // stack view

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // genre view

            genreView.heightAnchor.constraint(equalToConstant: 160),
            
            // sort by view
            
            sortByView.heightAnchor.constraint(equalToConstant: 160),

            // button

            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
