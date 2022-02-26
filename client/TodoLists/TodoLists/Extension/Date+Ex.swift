//
//  Date+Ex.swift
//  TodoLists
//
//  Created by Cem Nisan on 25.02.2022.
//

import Foundation

extension Date {
    var isoString: String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(self), let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return "" }
        return json as! String
    }
}
