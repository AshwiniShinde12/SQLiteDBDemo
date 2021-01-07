//
//  ViewController.swift
//  SQLLiteDemo
//
//  Created by Ashwini on 06/01/21.
//  Copyright © 2021 Ashwini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var db : DBHelper = DBHelper()
    var student : [Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db.insert(id: 0, name: "Ashwini", dob: "12 march 1996", standard: "BE")
        db.insert(id: 0, name: "Komal", dob: "14 August 1996", standard: "BE")
        student = db.read()
        tableview.reloadData()
        tableview.tableFooterView = UIView()
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.name.text = student[indexPath.row].name
        cell.dob.text = student[indexPath.row].dob
        cell.standard.text = student[indexPath.row].standard
        return cell
    }
}

