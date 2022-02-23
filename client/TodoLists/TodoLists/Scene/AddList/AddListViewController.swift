//
//  AddListViewController.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import UIKit

final class AddListViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var viewModel: AddListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        viewModel.add(with: titleTextField.text!, contentTextField.text!)
    }
}

extension AddListViewController: AddListViewModelDelegate {
    func handleOutput(_ output: AddListViewModelOutput) {
        switch output {
        case .showSuccessAdded(let isAdded):
            configureCheckMark(with: isAdded)
        case .setLoading(let isLoading):
            configureIndicatorView(with: isLoading)
        case .isEmptyError:
            print("error.")
        }
    }
}

// MARK: - Configure UI
extension AddListViewController {
    private func configureIndicatorView(with isLoading: Bool) {
        if (isLoading) {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        } else {
            indicatorView.isHidden = true
        }
    }
    
    private func configureCheckMark(with isAdded: Bool) {
        if (isAdded) {
            checkMarkView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func configureUI() {
        indicatorView.isHidden = true
        checkMarkView.isHidden = true
        
        checkMarkView.layer.cornerRadius = 6
    }
}
