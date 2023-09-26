//
//  WatchProvidersView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 19/09/23.
//

import UIKit

class WatchProvidersView: UIView {
    
    // MARK: - UI Components
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.blackOne.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var cardSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var cardDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var justWatchStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: .zero, bottom: 16, right: .zero)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .leading
        view.distribution = .fill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var justWatchLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "just-watch")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var justWatchDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        label.text = "JustWatch helps you to find legally watch providers for your movies and tv series. Go to JustWatch.com to see more.".localized()
        return label
    }()
    
    // MARK: - Properties
    
    var title = String() {
        didSet {
            cardTitle.text = title
        }
    }
    
    var text = String() {
        didSet {
            cardDescription.text = text
        }
    }
    
    var backgroundTint = UIColor.clear {
        didSet {
            stackView.backgroundColor = backgroundTint
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        setupCardSubtitle()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(title: String, description: String, backgroundColor: UIColor) {
        cardTitle.text = title
        cardDescription.text = description
        stackView.backgroundColor = backgroundColor
    }
    
    // MARK: - Private Methods
    
    private func setupCardSubtitle() {
        let regionName = MovieApi.shared.getWatchRegion().title
        cardSubtitle.text = regionName
    }
    
    private func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openUrl))
        justWatchDescription.isUserInteractionEnabled = true
        justWatchDescription.addGestureRecognizer(gesture)
    }
}

// MARK: - Actions

extension WatchProvidersView {
    
    @objc
    private func openUrl() {
        guard let url = URL(string: "https://www.justwatch.com") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK: - View Coding

extension WatchProvidersView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
        addCustomSpacings()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(cardTitle)
        stackView.addArrangedSubview(cardSubtitle)
        stackView.addArrangedSubview(cardDescription)
        justWatchStackView.addArrangedSubview(justWatchLogo)
        justWatchStackView.addArrangedSubview(justWatchDescription)
        addSubview(stackView)
        addSubview(justWatchStackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // stack view
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            
            // just watch stack view
            
            justWatchStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            justWatchStackView.rightAnchor.constraint(equalTo: rightAnchor),
            justWatchStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            justWatchStackView.leftAnchor.constraint(equalTo: leftAnchor),
            justWatchStackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            // just watch logo
            
            justWatchLogo.widthAnchor.constraint(equalToConstant: 100),
            justWatchLogo.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func addCustomSpacings() {
        
        // card title
        
        stackView.setCustomSpacing(.zero, after: cardTitle)
    }
}
