//
//  AddListViewController.swift
//  TodoLists
//
//  Created by Cem Nisan on 23.02.2022.
//

import UIKit

final class AddListViewController: UIViewController
{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var viewModel: AddListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private let datePicker = UIDatePicker()
    private lazy var alertHelper = AlertHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDatePicker()
    }
}

//MARK: - Button Pressed
extension AddListViewController
{
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem)
    {
        let title = titleTextField.text!
        let content = contentTextView.text!
        let expectedDate = endDateTextField.text!
        let selectedDate = datePicker.date.isoString
        
        viewModel.add(with: title,
                      content: content,
                      expectedDate: expectedDate,
                      selectedDate: selectedDate)
    }

    @objc private func donePressed() {
        endDateTextField.text = "\(DateFormatter.dateOnly.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
}

// MARK: - View Model Delegate
extension AddListViewController: AddListViewModelDelegate
{
    func handleOutput(_ output: AddListViewModelOutput)
    {
        switch output {
        case .setLoading(let isLoading):
            configureIndicatorView(with: isLoading)
        case .showSuccessAdded(let isAdded):
            configureCheckMark(with: isAdded)
        case .showError(let error):
            alertHelper.alertForUserErrors(on: self,
                                                   title: "Error",
                                                   message: error.localizedDescription)
        }
    }
}

// MARK: - Configure UI
extension AddListViewController
{
    private func configureUI()
    {
        contentTextField.isEnabled = false
        contentTextField.backgroundColor = .white
        
        indicatorView.isHidden = true
        checkMarkView.isHidden = true
        
        checkMarkView.layer.cornerRadius = 6
    }
    
    private func configureIndicatorView(with isLoading: Bool)
    {
        if (isLoading) {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        } else {
            indicatorView.isHidden = true
        }
    }
    
    private func configureCheckMark(with isAdded: Bool)
    {
        if (isAdded) {
            checkMarkView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func configureDatePicker()
    {
        // create toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // create bar button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        // assign toolbar
        endDateTextField.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        // assign date picker to the text field
        endDateTextField.inputView = datePicker
    }
}
