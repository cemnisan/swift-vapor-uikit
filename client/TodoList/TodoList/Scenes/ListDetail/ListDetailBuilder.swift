//
//  ListDetailBuilder.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import UIKit

final class ListDetailBuilder {
    
    static func make(with viewModel: ListDetailViewModelProtocol) -> ListDetailViewController {
        let storyboard = UIStoryboard(name: "ListDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
