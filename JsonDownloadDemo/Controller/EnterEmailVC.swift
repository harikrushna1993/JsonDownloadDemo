//
//  EnterEmailVC.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 05/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import UIKit

class EnterEmailVC: UIViewController {
    
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnEnter: UIButton!
    
    let enterEmailVM = EnterEmailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterEmailVM.delegate = self
        customizeUI()
        addGesture()
    }
    
    // MARK: - Custom Methods
    
    func customizeUI() {
        activityIndicator.isHidden = true
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController , animated: true, completion: nil)
    }
    
    private func showActivityIndicator(status: Bool) {
        if status {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    private func controlUserInteraction(status: Bool) {
        textfieldEmail.isUserInteractionEnabled = status
        btnEnter.isUserInteractionEnabled = status
    }
    
    private func moveToNextVC() {
        UserDefaults.standard.set(true, forKey: Constants.DownloadedOrNotKey)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PersonListVC") as? PersonListVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: - UIBtn
    @IBAction func enterBtnAction(_ sender: Any) {
        if enterEmailVM.isValidEmail(text: textfieldEmail.text!) {
            showActivityIndicator(status: true)
            controlUserInteraction(status: false)
            enterEmailVM.storeEmailId(email: textfieldEmail.text!)
        } else {
            showAlert(message: "Please enter valid email")
        }
    }
}

extension EnterEmailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension EnterEmailVC: PersonDetailStoringDelegate {
    func successfullySaved() {
        DispatchQueue.main.async {
            self.moveToNextVC()
            self.controlUserInteraction(status: true)
            self.showActivityIndicator(status: false)
        }
    }
    
    func errorInSaving(errMsg: String) {
        DispatchQueue.main.async {
            self.showAlert(message: errMsg)
            self.controlUserInteraction(status: true)
            self.showActivityIndicator(status: false)
        }
    }
    
}
