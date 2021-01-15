//
//  TableViewCell.swift
//  IOS_Senin_2_Currency
//
//  Created by Jenya on 15.01.2021.
//

import UIKit

class CoursesCellController: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    
    func initCell(currency: Currency) {
        
        //print(currency.imageFlag)
        //print(currency.CharCode)
        imageFlag.image = currency.imageFlag;
        labelCurrencyName.text = currency.Name;
        labelCourse.text = currency.Value;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
