//
//  DateConverter.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation
class DateConverter {
    
    // get year from formate YYYY-MM-DD
    static func getYear(dateStr: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-DD"
        if let showDate = inputFormatter.date(from: dateStr) {
            inputFormatter.dateFormat = "YYYY"
            return inputFormatter.string(from: showDate)
        }
        return nil
    }
}
