//
//  SelectSegmenTitle.swift
//  TodoLists
//
//  Created by Cem Nisan on 15.02.2022.
//

import Foundation

enum SelectSegmentTitle {
    case completed
    case notCompleted
    
    static func getTitle(with segmentTitle: String) -> SelectSegmentTitle {
        switch segmentTitle {
        case Constant.SegmentTitle.completed:
            return .completed
        case Constant.SegmentTitle.notCompleted:
            return .notCompleted
        default:
            return .notCompleted
        }
    }
}
