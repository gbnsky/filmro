//
//  ResultCollectionViewCell.swift
//  Unroll
//
//  Created by Gabriel Garcia on 12/09/23.
//

import UIKit

// MARK: - Delegate

protocol ResultCollectionViewCellDelegate: AnyObject {
    func fetchResultDetails(from movie: Movie)
}

// MARK: - Class

class ResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier: String = "ResultCollectionViewCell"
    
    // MARK: - Constants
    
    enum Constants {
        // url
        static let baseImageUrl: String = "https://image.tmdb.org/t/p/original/"
    }
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var movieStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: UIApplication.safeAreaEdgeInsets.bottom + 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder-poster")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var movieReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var movieDescriptionStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        view.backgroundColor = Colors.green
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.blackOne.cgColor
        return view
    }()
    
    private lazy var moreDescriptionStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieDescriptionTitle, button])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var movieDescriptionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Overview".localized()
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See more".localized(), for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.backgroundColor = Colors.orange
        button.layer.borderColor = Colors.blackOne.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var movieOverview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Exposed Properties
    
    weak var delegate: ResultCollectionViewCellDelegate?
    
    // MARK: - Private Properties
    
    private var movie: Movie?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with movie: Movie) {
        self.movie = movie
        
        setupMovieTitle()
        setupMovieReleaseDate()
        setupMoviePoster()
        setupMovieOverview()
    }
    
    // MARK: - Private Methods

    private func setupMovieTitle() {
        guard let movie = movie, let title = movie.title else {
            return
        }
        movieTitle.text = title
        movieStackView.addArrangedSubview(movieTitle)
        movieStackView.setCustomSpacing(.zero, after: movieTitle)
    }
    
    private func setupMovieReleaseDate() {
        guard let movie = movie, let releaseDate = movie.releaseDate else {
            return
        }
        movieReleaseDate.text = getFormattedMovieReleaseDate(from: releaseDate)
        movieStackView.addArrangedSubview(movieReleaseDate)
    }
    
    private func setupMoviePoster() {
        guard let movie = movie,
              let moviePosterPath = movie.posterPath,
              let posterPath = URL(string: "\(Constants.baseImageUrl)\(moviePosterPath)") else {
            moviePoster.image = UIImage(named: "placeholder-poster")
            return
        }
        
        moviePoster.load(url: posterPath) { imageSize in
            self.updateMoviePosterConstraints(with: imageSize)
        }
        
        movieStackView.addArrangedSubview(moviePoster)
    }
    
    private func setupMovieOverview() {
        if movie == nil {
            return
        }
        
        movieStackView.addArrangedSubview(movieDescriptionStackView)
        movieDescriptionStackView.addArrangedSubview(moreDescriptionStackView)
        
        setupMovieOverviewData()
    }
    
    private func setupMovieOverviewData() {
        guard let movie = movie, let overview = movie.overview else {
            return
        }
        
        movieOverview.text = overview
        movieDescriptionStackView.addArrangedSubview(movieOverview)
    }
    
    private func getFormattedMovieReleaseDate(from releaseDate: String) -> String {
        let separator = String("-")
        let releaseDateArray = releaseDate.components(separatedBy: separator)
        return releaseDateArray.first ?? String()
    }
    
    private func updateMoviePosterConstraints(with imageSize: CGSize) {        
        NSLayoutConstraint.activate([
            moviePoster.heightAnchor.constraint(equalTo: moviePoster.widthAnchor, multiplier: moviePoster.fullWidthRatio()),
        ])
    }
}

// MARK: - Actions

extension ResultCollectionViewCell {
    
    @objc
    private func buttonAction() {
        guard let movie = movie else {
            return
        }
        delegate?.fetchResultDetails(from: movie)
    }
}

// MARK: - View Coding

extension ResultCollectionViewCell {
    
    private func loadView() {
        addSubviews()
        addConstraints()
        addAdditionalConstraints()
    }
    
    private func addSubviews() {
        scrollView.addSubview(movieStackView)
        addSubview(scrollView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // scroll view
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            
            // movie stack view
            
            movieStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            movieStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            movieStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func addAdditionalConstraints() {
        
        // movie stack view
        
        let stackViewHeight = movieStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        
        stackViewHeight.isActive = true
        stackViewHeight.priority = UILayoutPriority(50)
        
        // movie poster
        
        let moviePosterHeight = moviePoster.heightAnchor.constraint(equalTo: moviePoster.widthAnchor, multiplier: moviePoster.fullWidthRatio())
        
        moviePosterHeight.isActive = true
    }
}
