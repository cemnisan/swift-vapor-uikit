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
    
    private let date = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension ToDoListsTableViewCell {
    func configureCell(with todoList: ToDoListPresentation) {
        listNameLabel.text = todoList.title
        listDetailLabel.text = todoList.content
        listDateLabel.text = date.dateFormatter(format: todoList.createdAt)
    }
}
