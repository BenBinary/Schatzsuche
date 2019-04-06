//
//  SaveVC.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 19.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit

class SaveVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var posname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        posname.delegate = self
        
        // Fokus in den Fokus setzen
        posname.becomeFirstResponder()
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        
        performSegue(withIdentifier: "SegueUnwindToMain", sender: self)
        
        
        
        return false
        
    }


}
