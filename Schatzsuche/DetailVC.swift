//
//  DetailVC.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 19.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit

protocol DetailVCDelegate {
    
    func backFromDetailVC(_ sourceVC: DetailVC)
    
}

class DetailVC: UIViewController {
    
    var pos:Position!
    var row:Int!
    var delegate:DetailVCDelegate?
    var deleteItem = false
    
    @IBOutlet weak var arrowview: ArrowView!
    @IBOutlet weak var txtPosition: UITextField!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLatLong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func deleteButton(_ sender: UIButton) {
        
        
    }
    
}


extension DetailVC : UITextFieldDelegate {
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Eingabe beenden und TT ausblenden
        view.endEditing(true)
        
        // Popup schließen
        _ = navigationController?.popViewController(animated: true)
        
        // Return nicht als Eingabe weitergeben
        return false
        
    }
    
    
}
