//
//  ViewController.swift
//  NTR-Task
//
//  Created by KriDan on 22.05.2021.
//

import UIKit

class ViewControllerMain: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataSet: EntityWithCustomObjects!
    
    let cellID = "ObjectCell"
    
    let descriptionControllerID = "description"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        Repository.shared.getEntity{response in
            guard response != nil else {return}
            self.dataSet = response
            self.title = self.dataSet.name
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
    }
    
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ObjectCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
    }
    
}

extension ViewControllerMain: UITableViewDelegate {
    
}

extension ViewControllerMain: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet?.objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ObjectCell
        cell.data = dataSet.objects![indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: descriptionControllerID) as! ViewControllerDescription
        vc.data = DescriptionData(lat: dataSet.location!.gps_lat!, lng: dataSet.location!.gps_lng!, entityName: dataSet.name!, objectName: dataSet.objects![indexPath.item].object.name!, objectTitle: dataSet.objects![indexPath.item].object.title!, objectStatusAmount: dataSet.objects![indexPath.item].statuses?.count ?? 0, objectID: dataSet.objects![indexPath.item].object.object_id!)
        navigationController?.pushViewController(vc, animated: true)
    }
}
