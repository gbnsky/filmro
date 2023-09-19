//
//  HomeView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 06/09/23.
//

import UIKit

// MARK: - Delegate

protocol HomeViewDelegate: AnyObject {
    func continueButtonAction()
    func aboutButtonAction()
}

// MARK: - Class

class HomeView: UIView {
    
    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "unroll")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "A shortcut to the next streaming".localized()
        return label
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "We'll try to spare your time before countless scrolling time to find something to watch.".localized()
        return label
    }()
    
    private lazy var mascot: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rolly")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var regionTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.inputView = regionPicker
        field.text = "Choose your country".localized()
        field.textColor = Colors.blackOne
        field.font = UIFont(name: Fonts.kanitRegular, size: 16)
        field.textAlignment = .center
        field.backgroundColor = Colors.orange
        field.layer.borderColor = Colors.blackOne.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 24
        return field
    }()
    
    private lazy var regionPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let’s find a movie together".localized(), for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.backgroundColor = Colors.yellow
        button.layer.borderColor = Colors.blackOne.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var aboutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Or tap here to know more about the app.".localized(), for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.addTarget(self, action: #selector(aboutButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Picker

extension HomeView: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let region = Location.allCases[row]
        
        MovieApi.shared.setWatchRegion(to: region)
        
        regionTextField.text = region.title
        regionTextField.resignFirstResponder()
    }
}

extension HomeView: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Location.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Location.allCases[row].title
    }
}

// MARK: - Actions

extension HomeView {
    
    @objc
    private func continueButtonAction() {
        delegate?.continueButtonAction()
    }
    
    @objc
    private func aboutButtonAction() {
        delegate?.aboutButtonAction()
    }
}

// MARK: - View Coding

extension HomeView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
        addAdditionalConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(mascot)
        stackView.addArrangedSubview(regionTextField)
        stackView.addArrangedSubview(continueButton)
        stackView.addArrangedSubview(aboutButton)
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
        ])
    }
    
    private func addAdditionalConstraints() {
        NSLayoutConstraint.activate([
            
            // logo
            
            logo.heightAnchor.constraint(equalToConstant: 48),
            
            // mascot

            mascot.heightAnchor.constraint(equalTo: mascot.widthAnchor, multiplier: mascot.fullHeightRatio()),

            // region text field

            regionTextField.heightAnchor.constraint(equalToConstant: 48),

            // continue button

            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
