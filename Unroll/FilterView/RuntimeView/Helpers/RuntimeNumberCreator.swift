//
//  RuntimeNumberCreator.swift
//  Unroll
//
//  Created by Gabriel Garcia on 14/09/23.
//

import UIKit

extension RuntimeView {
    
    internal func createLabelNumberList(with numbers: [String]) -> [UILabel] {
        var labelNumberList = [UILabel]()
        
        for number in numbers {
            let createdLabel = createLabelNumber(with: number)
            labelNumberList.append(createdLabel)
        }
        
        return labelNumberList
    }
    
    private func createLabelNumber(with text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = text
        return label
    }
}
