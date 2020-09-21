//
//  Medicina.swift
//  pediaHealth
//
//  Created by Carlos on 06/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import Foundation
struct Medicina {
     let nombre: String
     let nombreCorto: String
     let uso: String
     let enfermedades: [Enfermedad]
    
    init(nombre: String, nombreCorto: String, uso: String, enfermedad:  [Enfermedad]) {
        self.nombre         =  nombre
        self.nombreCorto    =  nombreCorto
        self.uso            =  uso
        self.enfermedades   =  enfermedad
    }
}
