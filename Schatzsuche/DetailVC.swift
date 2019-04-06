//
//  DetailVC.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 19.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit
import CoreLocation

protocol DetailVCDelegate {
    
    func backFromDetailVC(_ sourceVC: DetailVC)
    
}

class DetailVC: UIViewController {
    
    var pos:Position!
    var row:Int!
    let mylocmgr = MyLocationManager.sharedInstance
    var deleteItem = false
    var delegate:DetailVCDelegate?
    var heading = 0.0
    
    
    @IBOutlet weak var arrowview: ArrowView!
    @IBOutlet weak var txtPosition: UITextField!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLatLong: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if pos == nil { return }
        
        
        // Steuerelemente mit Daten aus pos initialisieren
        let dfmt = DateFormatter()
        dfmt.dateStyle = .medium
        dfmt.timeStyle = .short
        txtPosition.text = pos.name
        lblTime.text = "Zeit: " + dfmt.string(from: pos.time as Date)
        let long = degressMinutes(pos.long)
        let lat = degressMinutes(pos.lat)
        lblLatLong.text = "Ort: Lat = \(lat) / Long = \(long)"
        
        // TT verarbeiten
        txtPosition.delegate = self
        
        // neue Position verarbetien
        // NotificationCenter.default.addObserver(self, selector: #selector(DetailVC.), name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
        
        
    }
    

    @IBAction func deleteButton(_ sender: UIButton) {
        
        
    }
    
    
    // Berechnung akutelle Position und Zeilpunkt
    // - Richtung wird bestimmt
    // - Abstandsermittlung mithilfe von distanceFromLocaiton
    @objc func notifyNewLocation(_ notification: Notification) {
        
        // Entfernung zwischen 'pos' und aktuellem Standpunkt errechnen
        let loc = CLLocation(latitude: pos.lat, longitude: pos.long)
        let dist = mylocmgr.location.distance(from: loc)
        lblDistance.text = "-->" + String(format: "%.0f", dist)
        
        // Richtung vom Standort zum Ziel berechnen
        let toLat = pos.lat / 180 * .pi
        let toLong = pos.long / 180 * .pi
        let fromLat = mylocmgr.location.coordinate.latitude / 180 * .pi
        let fromLong = mylocmgr.location.coordinate.longitude / 180 * .pi
        
        //let rad = atan2
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
