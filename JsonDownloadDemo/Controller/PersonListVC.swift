//
//  PersonListVC.swift
//  JsonDownloadDemo
//
//  Created by Kaha on 05/12/18.
//  Copyright © 2018 Hari Krushna. All rights reserved.
//

import UIKit

class PersonListVC: UIViewController {
    @IBOutlet weak var tableviewPersonList: UITableView!
    
    var personList = [Person]()
    let databaseWrapperObject = DataBaseWrapper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        loadDataFromDB()
    }
    
    private func customizeUI() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        tableviewPersonList.estimatedRowHeight = 10
        tableviewPersonList.rowHeight = UITableView.automaticDimension
    }
    
    private func loadDataFromDB() {
        if let details = databaseWrapperObject.getAllPersonDetails(), details.count > 0 {
            personList = details
            tableviewPersonList.reloadData()
        }
    }
}

extension PersonListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wikiDataCell = tableView.dequeueReusableCell(withIdentifier: "PersonDetailTableViewCell", for: indexPath) as? PersonDetailTableViewCell else {
            return UITableViewCell()
        }
        wikiDataCell.loadCellData(personDetail: personList[indexPath.row])
        return wikiDataCell
    }
}
