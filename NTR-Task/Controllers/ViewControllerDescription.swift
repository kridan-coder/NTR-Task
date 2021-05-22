//
//  ViewControllerDescription.swift
//  NTR-Task
//
//  Created by KriDan on 23.05.2021.
//

import UIKit



class ViewControllerDescription: UIViewController {
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelLat: UILabel!
    @IBOutlet weak var labelLng: UILabel!
    
    @IBOutlet weak var labelObjectName: UILabel!
    @IBOutlet weak var labelObjectTitle: UILabel!
    @IBOutlet weak var labelObjectStatusAmount: UILabel!
    @IBOutlet weak var labelObjectID: UILabel!
    
    var data: DescriptionData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        setData()
    }
        private func setData(){
            labelName.text = data.entityName
    
            labelLat.text = String(data.lat)
            labelLng.text = String(data.lng)
    
            labelObjectName.text = data.objectName
            labelObjectTitle.text = data.objectTitle
            labelObjectStatusAmount.text = String(data.objectStatusAmount)
            labelObjectID.text = String(data.objectID)
        }


}
