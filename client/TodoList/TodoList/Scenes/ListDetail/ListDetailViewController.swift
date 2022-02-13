//
//  ListDetailViewController.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import UIKit

class ListDetailViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: ListDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.load()
    }
}

extension ListDetailViewController: ListDetailViewModelDelegate {
    func showDetail(_ presentation: ListPresentation) {
        titleLabel.text = presentation.title
        contentLabel.text = presentation.content
        print(presentation.title)
    }
}
