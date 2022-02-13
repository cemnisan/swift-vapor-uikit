//
//  ListBuilder.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import UIKit

final class ListBuilder {

    static func make() -> ListViewController {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        viewController.viewModel = ListViewModel(service: app.service)
        return viewController
    }
}
