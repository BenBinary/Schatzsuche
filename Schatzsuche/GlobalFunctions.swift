//
//  GlobalFunctions.swift
//  Schatzsuche
//
//  Created by Benedikt Kurz on 18.03.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import Foundation


func degressMinutes(_ x:Double) -> String {
    
    
    let remainder = x.truncatingRemainder(dividingBy: 1)
    let minutes = abs(remainder * 60)
    return String(format: "%d° %.2f", locale: Locale.current, arguments: [minutes])
    
    
    
    
}
