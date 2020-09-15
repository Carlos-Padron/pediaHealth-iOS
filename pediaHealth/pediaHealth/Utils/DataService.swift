//
//  DataService.swift
//  pediaHealth
//
//  Created by Carlos on 06/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import Foundation

class DataService {
    
    var medCatalog = [Medicina]()
    
    static let instance = DataService()
    
    private init() {}
    
    private func readFile()-> Data?{
        do{
            if let bundlePath   =   Bundle.main.path(forResource: "db", ofType: "json") {
                let data        =   try String(contentsOfFile: bundlePath).data(using: .utf8)
                
                return data
            }
        }catch{
            print("error : \(error)" )
        }
        fatalError("File Not Found")
    }
    
    
    
    func createMedList(completion: (Result<[Medicina],ParseErrors>) -> Void){
        let data   =   self.readFile()
        if data   !=    nil {
            do{
                let jsonString   =   try JSONSerialization.jsonObject(with: data!, options: [])
                if let catalog   =   jsonString as? [[String: Any]] {
                    
                    var medicina      =  [Medicina]()
                    var enfermeades   =  [Enfermedad]()
                    var aplicaciones  =  [Aplicacion]()
                    var dosis         =  [Dosis]()
                    
                    for medicine in catalog {
                        for illness in medicine["enfermedades"] as! [[String:Any]] {
                            for application in illness["aplicaciones"] as! [[String:Any]] {
                                for dose in application["dosis"] as! [[String: Any]]{
                                    let quantity = Dosis(edad: dose["edad"] as! String, cantidad: dose["cantidad"] as Any, peso: dose["peso"] as Any, mayorEdad: dose["mayorEdad"] as! Bool, mayorPeso: dose["mayorPeso"] as! Bool,  multiplicador: dose["multiplicador"] as! Bool, maxima: dose["maxima"] as Any, frecuencia: dose["frecuencia"] as! String, directa: dose["directa"] as! String)
                                    dosis.append(quantity)
                                }
                                let app = Aplicacion(metodo: application["metodo"] as! String, dosis: dosis)
                                aplicaciones.append(app)
                                
                                dosis = []
                            }
                            
                            let ill = Enfermedad(nEnfermedad: illness["nEnfermedad"] as! String, advertencia: illness["advertencia"] as? String ?? nil, aplicaciones: aplicaciones)
                            
                            enfermeades.append(ill)
                            
                            aplicaciones = []
                            
                        }

                        let med = Medicina(nombre: medicine["nombre"] as! String, nombreCorto: medicine["nombreCorto"] as! String, uso: medicine["uso"] as! String, enfermedad: enfermeades)
                        
                        medicina.append(med)
                        
                        print(med.nombre)
                        enfermeades = []
                        aplicaciones = []
                        dosis = []
                        
                        
                    }
                    self.medCatalog = medicina
                    completion(.success(self.medCatalog))
                }
            }catch{
                completion(.failure(.parseError))
            }
        }
    }
}
