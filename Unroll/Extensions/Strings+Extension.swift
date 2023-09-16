//
//  Strings+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 16/09/23.
//

import UIKit

extension String {
    
    func localized() -> String {
        
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
