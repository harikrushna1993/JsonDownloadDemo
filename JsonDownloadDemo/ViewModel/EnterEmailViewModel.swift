//
//  EnterEmailViewModel.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 05/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import UIKit

protocol PersonDetailStoringDelegate: AnyObject {
    func successfullySaved()
    func errorInSaving(errMsg: String)
}

class EnterEmailViewModel: NSObject {
    
    let databaseWrapper = DataBaseWrapper.sharedInstance
    weak var delegate: PersonDetailStoringDelegate?
    
    func isValidEmail(text: String) -> Bool {
        let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegExp)
        return emailTest.evaluate(with: text)
    }
    
    func storeEmailId(email: String) {
        let param = ["emailId": email] as [String: Any]
        
        NetworkWrapper.makePostRequest(url: ApiConstant.listUrl, params: param, sucess: { (response) in
            print(response)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(PersonListModel.self, from: response)
                self.storeDataInLocal(list: result.items)
            } catch {
                self.delegate?.errorInSaving(errMsg: "Something went wrong")
                print("parsing error")
            }
        }) { (errmsg) in
            self.delegate?.errorInSaving(errMsg: errmsg)
            print(errmsg)
        }
        
    }
    
    func storeDataInLocal(list: [PersonDetail]) {
        for detail in list {
            if !databaseWrapper.savePersonDetails(personDetail: detail) {
                delegate?.errorInSaving(errMsg: "Something went wrong")
                break
            }
        }
        delegate?.successfullySaved()
    }
}
