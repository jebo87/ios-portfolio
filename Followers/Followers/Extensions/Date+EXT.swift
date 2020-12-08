//
//  Date+EXT.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-07.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
