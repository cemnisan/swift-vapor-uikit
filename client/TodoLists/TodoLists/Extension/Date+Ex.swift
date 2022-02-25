//
//  Date+Ex.swift
//  TodoLists
//
//  Created by Cem Nisan on 25.02.2022.
//

import Foundation

extension Date {
    func dateFormatter(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
