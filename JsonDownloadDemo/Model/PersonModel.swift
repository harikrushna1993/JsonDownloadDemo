//
//  PersonModel.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 05/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import Foundation

struct PersonListModel: Codable {
    let items: [PersonDetail]
}

struct PersonDetail: Codable {
    let firstName: String
    let lastName: String
    let emailId: String
    let imageUrl: String
}
