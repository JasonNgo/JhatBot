//
//  File.swift
//  Main
//
//  Created by Jason Ngo on 2025-05-19.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        if index >= 0 && index < count {
            return self[index]
        } else if index < 0 && abs(index) <= count {
            return self[count + index]
        } else {
            return nil
        }
    }
}
