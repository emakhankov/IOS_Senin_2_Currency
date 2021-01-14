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
        
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen; // Чтобы набрасывался на весьб экран иначе ViewWillAppear не проявится
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .from;
        present(nc, animated: true, completion: nil)
    }

    @IBAction func pushToAction(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        nc.modalPresentationStyle = .fullScreen; // Чтобы набрасывался на весьб экран иначе ViewWillAppear не проявится
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .to;
        present(nc, animated: true, completion: nil)
    }

    
    @IBOutlet weak var textFrom: UITextField!
    
    @IBOutlet weak var textTo: UITextField!
    
    
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    
    @IBAction func pushButtonDone(_ sender: Any) {
        
        textFrom.resignFirstResponder(); // Убрать клавиатуру
        navigationItem.rightBarButtonItem = nil;
    }
    
    
    @IBAction func textFromEditingChange(_ sender: Any) {
        
        let amount = Double(textFrom.text!)
        //if amount != nil {
            textTo.text = Model.shared.convert(amount: amount)
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFrom.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons();
        textFromEditingChange(self);
        navigationItem.rightBarButtonItem = nil;
    }
    func refreshButtons() {
        buttonFrom.setTitle(Model.shared.fromCurrency.CharCode, for: UIControl.State.normal)
        buttonTo.setTitle(Model.shared.toCurrency.CharCode, for: UIControl.State.normal)
    }

    
}

extension ConverterController: UITextFieldDelegate
{
 
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone;
        return true; // Если вернем false то редактирование не начнется
    }
  
}

