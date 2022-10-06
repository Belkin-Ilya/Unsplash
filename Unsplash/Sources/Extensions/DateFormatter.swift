//
//  DateFormatter.swift
//  Unsplash
//
//  Created by Илья Белкин on 30.09.2022.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
