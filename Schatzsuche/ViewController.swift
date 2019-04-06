//
//  ViewController.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 12.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let mylocmgr = MyLocationManager.sharedInstance
    var poslist = Position.readArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.notifyNewLocation(_:)), name: Notification.Name("New Value"), object: nil)
        
    }
    
    
    @objc func notifyNewLocation(_ notification: Notification) {
        
        let coord = mylocmgr.location.coordinate
        let long = degressMinutes(coord.longitude)
        let lat = degressMinutes(coord.latitude)
        
        lblPosition.text = "Position Lat = \(lat) / Long = \(long)"
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // PopUp zum Speicherdialog
        if let dest = segue.destination as? SaveVC, let popPC = dest.popoverPresentationController {
            popPC.delegate = self
        }
        
        // Segue zur Detailansicht
        if let dest = segue.destination as? DetailVC, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            dest.row = indexPath.row
            dest.pos = poslist[indexPath.row]
        //    dest.delegate = self
            
        }
        
    }
    
    
    
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
        if let src = unwindSegue.source as? SaveVC {
            
            
            if !unwindSegue.source.isBeingDismissed {
                unwindSegue.source.dismiss(animated: true, completion: nil)
            }
            
            if let txt = src.posname.text {
                let posname = txt.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if posname != "", let loc = mylocmgr.location {
                    
                    
                    // Initialisieren des neuen Objekts nachdem man aus der SaveVC zurückgekehrt ist
                    let newpos = Position(posname, loc.timestamp, loc.coordinate.latitude, loc.coordinate.longitude)
                    
                    // am Beginnd er Liste einfügen
                    poslist.insert(newpos, at: 0)
                    
                    // Speichern mittels JSON-Exports
                    Position.saveArray(poslist)
                    
                    // Refreshen der TableView
                    tableView.reloadData()
                    
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dfmt = DateFormatter()
        dfmt.dateStyle = .medium
        dfmt.timeStyle = .short
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath)
        cell.textLabel?.text = poslist[indexPath.row].name
        cell.detailTextLabel?.text = dfmt.string(from: poslist[indexPath.row].time as Date)
        
        return cell
        
    }
}




// Popups
extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
        
    }
    
}


extension ViewController: DetailVCDelegate {
    
    
    func backFromDetailVC(_ sourceVC: DetailVC) {
        
        
        if sourceVC.deleteItem == true {
        
            // Listenelement löschen
            poslist.remove(at: sourceVC.row)
        
            tableView.reloadData()
        
            Position.saveArray(poslist)
        } else {
            
            let txt = sourceVC.txtPosition.text!
            
            let newname = txt.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            
            if newname != "" && newname != poslist[sourceVC.row].name {
                
                poslist[sourceVC.row].name = newname
                Position.saveArray(poslist)
                tableView.reloadData()
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
}
