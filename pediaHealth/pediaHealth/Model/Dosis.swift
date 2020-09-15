//
//  Dosis.swift
//  pediaHealth
//
//  Created by Carlos on 06/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import Foundation

class Dosis {
    let edad: String
    let cantidad: Any?
    let peso: Any?
    let mayorEdad: Bool
    let mayorPeso: Bool
    let multiplicador: Bool
    let maxima: Any?
    let frecuencia: String
    let directa: String
    
    init(edad: String, cantidad: Any, peso: Any, mayorEdad: Bool, mayorPeso: Bool, multiplicador: Bool, maxima: Any, frecuencia: String, directa: String) {
        
        self.edad          =  edad
        self.cantidad      =  cantidad
        self.peso          =  peso
        self.mayorEdad     =  mayorEdad
        self.mayorPeso     =  mayorPeso
        self.multiplicador =  multiplicador
        self.maxima        =  maxima
        self.frecuencia    =  frecuencia
        self.directa       =  directa
    }
}


