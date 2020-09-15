//
//  Enfermedad.swift
//  pediaHealth
//
//  Created by Carlos on 06/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import Foundation
class Enfermedad {
    let nEnfermedad: String
    let advertencia: String?
    let aplicaciones: [Aplicacion]
    
    init(nEnfermedad: String, advertencia: String?, aplicaciones: [Aplicacion]) {
        self.nEnfermedad   =  nEnfermedad
        self.advertencia   =  advertencia
        self.aplicaciones  =  aplicaciones
    }
}
