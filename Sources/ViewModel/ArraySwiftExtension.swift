//
//  ArraySwiftExtension.swift
//  Note
//
//  Created by etudiant on 10/06/2023.
//

import Foundation

extension Array where Element: Equatable {
    func compare(to other: [Element]) -> Bool {
        self.count == other.count && self.allSatisfy({ elt in
            other.contains { otherElt in
                otherElt == elt
            }
        })
    }
}
