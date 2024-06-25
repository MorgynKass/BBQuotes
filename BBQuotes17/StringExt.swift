//
//  StringExt.swift
//  BBQuotes17
//
//  Created by Morgyn Peay on 6/24/24.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpace() -> String {
        self.removeSpaces().lowercased()
    }
}
