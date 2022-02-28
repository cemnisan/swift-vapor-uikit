//
//  AlertManager.swift
//  TodoLists
//
//  Created by Cem Nisan on 26.02.2022.
//

import Foundation
import UIKit

final class AlertHelper
{
    func alertForDeleteList(
        on vc: UIViewController,
        deleteList: @escaping () -> Void
    ) {
        let alert = UIAlertController(
            title: "Delete List",
            message: "Are u sure??",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in deleteList() }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func alertForUserErrors(
        on vc: UIViewController,
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
}
