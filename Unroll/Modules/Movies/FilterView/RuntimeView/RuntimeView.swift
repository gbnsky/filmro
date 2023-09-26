//
//  RuntimeView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 13/09/23.
//

import UIKit

class RuntimeView: UIView {
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 16)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Runtime"
        return label
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 180
        slider.isContinuous = true
        slider.tintColor = Colors.orange
        slider.addTarget(self, action: #selector(sliderActionHandler), for: .valueChanged)
        return slider
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layoutMargins = UIEdgeInsets(top: 16, left: .zero, bottom: 16, right: .zero)
//        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupRuntimeNumbers() {
        let runtimeNumbers = ["0m", "30m", "60m", "90m", "120m", "150m", "+180m"]

        let labelNumberList = createLabelNumberList(with: runtimeNumbers)
        
        for label in labelNumberList {
            stackView.addArrangedSubview(label)
        }
    }
}

// MARK: - Actions

extension RuntimeView {
    
    @objc
    private func sliderActionHandler() {
        
        let step = Float(30)
        let roundedValue = round(slider.value / step) * step
        slider.value = roundedValue
        
        print("slider value: \(slider.value)")
    }
}

// MARK: - View Coding

extension RuntimeView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(slider)
        addSubview(stackView)
        setupRuntimeNumbers()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // title
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            title.heightAnchor.constraint(equalToConstant: 48),
            
            // slider
            
            slider.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            slider.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            slider.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // slider
            
            stackView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
