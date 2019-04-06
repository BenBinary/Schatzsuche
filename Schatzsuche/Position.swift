//
//  Position.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 18.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import Foundation


struct Position: Codable, CustomStringConvertible {
    
    var description: String {
        return name + "\(time) \(lat) \(long)"
    }
    
    
    var name: String
    var time: Date
    var lat: Double
    var long: Double
    
    init (_ name: String, _ time: Date, _ lat: Double, _ long: Double) {
        
        self.name = name
        self.time = time
        self.lat = lat
        self.long = long
        
    }
    
    
    static func saveArray(_ data: [Position]) {
        
        if data.count == 0 { return }
        
        let enc = JSONEncoder()
        if let url = docURL(for: "positions.json")
        {
            do {
                let jsondata = try enc.encode(data)
                try jsondata.write(to: url)
                
            } catch {
                print(error)
            }
        }
        
    }
    
    static func readArray() -> [Position] {
        
        let dec = JSONDecoder()
        
        if let url = docURL(for: "positions.json") {
            do {
                let jsondata = try Data(contentsOf: url)
                
                return try dec.decode([Position].self, from: jsondata)
            }
            catch {
                print(error)
            }
        }
        
        return [Position]()
    }
    
    private static func docURL(for filename: String) -> URL? {
        
        //sollte immer genau ein Ergebnis liefern
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let docDir = urls.first {
            return docDir.appendingPathComponent(filename)
        }
        return nil
    }
    
    
    
}
