//
//  ViewController.swift
//  NTR-Task
//
//  Created by KriDan on 22.05.2021.
//

import UIKit

class ViewControllerMain: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Entity"
        // Do any additional setup after loading the view.
    }

    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ViewControllerMain: UITableViewDelegate {
    
}

extension ViewControllerMain: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
