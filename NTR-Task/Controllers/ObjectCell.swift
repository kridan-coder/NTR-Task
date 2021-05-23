//
//  ObjectCell.swift
//  NTR-Task
//
//  Created by KriDan on 22.05.2021.
//

import UIKit

class ObjectCell: UITableViewCell {
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var wrapperView: UIView!
    
    @IBOutlet weak var labelTag: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    var data: ObjectWithStatuses! {
        didSet{
            if let statuses = data.statuses, data.statuses?.count != 0 {
                if statuses.count == 1 {
                    icon1.isHidden = false
                    icon2.isHidden = true
                }
                else if statuses.count >= 2 {
                    icon1.isHidden = false
                    icon2.isHidden = false
                }
                labelTag.text = String((data.statuses!.min{t1, t2 in
                    return t1.status!.tag! < t2.status!.tag!
                }!.status?.tag)!)
            }
            else {
                labelTag.text = "No Tag"
                icon1.isHidden = true
                icon2.isHidden = true
            }

            labelName.text = data.object.name
            labelTitle.text = data.object.title
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
