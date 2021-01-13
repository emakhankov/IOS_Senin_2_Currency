//
//  ConverterController.swift
//  IOS_Senin_2_Currency
//
//  Created by Jenya on 13.01.2021.
//

import UIKit

class ConverterController: UIViewController {

    @IBOutlet weak var labelCourserForDate: UILabel!
    
    @IBOutlet weak var buttonFrom: UIButton!
    
    @IBOutlet weak var buttonTo: UIButton!
    
    
    @IBAction func pushFromAction(_ sender: Any) {
    }

    @IBAction func pushToAction(_ sender: Any) {
    }

    
    @IBOutlet weak var textFrom: UITextField!
    
    @IBOutlet weak var textTo: UITextField!
    
    
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        
        let amount = Double(textFrom.text!)
        //if amount != nil {
            textTo.text = Model.shared.convert(amount: amount)
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons();
    }
    func refreshButtons() {
        buttonFrom.setTitle(Model.shared.fromCurrency.CharCode, for: UIControl.State.normal)
        buttonTo.setTitle(Model.shared.toCurrency.CharCode, for: UIControl.State.normal)
    }

    
}
