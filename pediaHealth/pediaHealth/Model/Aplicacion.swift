//
//  Aplicacion.swift
//  pediaHealth
//
//  Created by Carlos on 06/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import Foundation

class Aplicacion {
    let metodo: String
    let dosis: [Dosis]
    
    init(metodo:String, dosis: [Dosis]) {
        self.metodo  =  metodo
        self.dosis   =  dosis
    }
}
