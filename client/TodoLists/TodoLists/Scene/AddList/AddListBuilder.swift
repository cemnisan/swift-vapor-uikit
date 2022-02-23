//
//  AddListBuilder.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import UIKit

final class AddListBuilder {
    static func make(with viewModel: AddListViewModelProtocol) -> AddListViewController {
        let storyboard = UIStoryboard(name: "AddList", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AddList") as! AddListViewController
        
        viewController.viewModel = viewModel
        return viewController
    }
}
