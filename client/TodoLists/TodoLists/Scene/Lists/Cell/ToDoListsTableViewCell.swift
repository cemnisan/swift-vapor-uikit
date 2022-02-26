//
//  ToDoListsTableViewCell.swift
//  TodoLists
//
//  Created by Cem Nisan on 13.02.2022.
//

import UIKit

final class ToDoListsTableViewCell: UITableViewCell {

    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var listDetailLabel: UILabel!
    @IBOutlet weak var listDateLabel: UILabel!
    @IBOutlet weak var listEndDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Configure Cell
extension ToDoListsTableViewCell {
    func configureCell(with todoList: ToDoListPresentation,
                       segmentTitle: SelectSegmentTitle)
    {
        listNameLabel.text = todoList.title
        listDetailLabel.text = todoList.content
        configureDate(on: segmentTitle,
                        updatedDate: todoList.updatedAt,
                        createdDate: todoList.createdAt,
                        endDate: todoList.endDate)
    }
    
    private func configureDate(on segment: SelectSegmentTitle,
                                 updatedDate: Date,
                                 createdDate: Date,
                                 endDate: Date)
    {
        switch segment {
        case .completed:
            listDateLabel.text = DateFormatter.dateOnly.string(from: updatedDate)
            listEndDateLabel.text = ""
        case .notCompleted:
            listDateLabel.text = DateFormatter.dateOnly.string(from: createdDate)
            listEndDateLabel.text = DateFormatter.dateOnly.string(from: endDate)
        }
    }
}
