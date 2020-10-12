//
//  ViewController.swift
//  pediaHealth
//
//  Created by Carlos on 05/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MainController: UIViewController{
    
    //Variables
    var selectedMainIndex: IndexPath?
    var previousSelectedMainIndex: IndexPath?
    var collapsedCellHeight: [Int: CGFloat]  = [:]
    var expandedCellHeight: [Int: CGFloat]   = [:]
    var isCellActive: [Int: Bool]            = [:]
    var cellBool: [Int: Bool]                = [:]
    
    var medCatalog = [Medicina](){ didSet{ DispatchQueue.main.async {self.MainTable.reloadData() } } }
    
    //Outlets
    @IBOutlet weak var MainTable: UITableView!

    

    override func viewDidLoad() {
        mainTableViewSetUp()
        getMedCatalog()
    }
     
    //Initial SetUp
    func getMedCatalog(){
        DataService.instance.createMedList { (res) in
            switch res {
            case .success(let medArray):
               
                self.medCatalog = self.sortCatalog(medArray: medArray)
               
                for (index, _) in medArray.enumerated() {
                    self.isCellActive[index] = false
                }
                
            
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortCatalog(medArray: [Medicina]) -> [Medicina]{
        let sortedArray:[Medicina] = medArray.sorted { (a: Medicina, b: Medicina) -> Bool in
            return    a.nombre.folding(options: .diacriticInsensitive, locale: .none)
                   <  b.nombre.folding(options: .diacriticInsensitive, locale: .none)
        }
        return sortedArray
    }
   
    
    
}

//MARK: - TableView Config 
extension MainController:  UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    func mainTableViewSetUp(){
        self.MainTable.delegate = self
        self.MainTable.dataSource = self
    }
    
    //# Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medCatalog.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Sets Medicine's name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === MainTable{
           
            if self.medCatalog[indexPath.row].enfermedades.count > 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MedCellWithTable") as? MedCellWithTable{
                    
                    let backgroundView              =  UIView()
                    backgroundView.backgroundColor  =  UIColor.white.withAlphaComponent(0.0)
                    cell.selectedBackgroundView     =  backgroundView
                                    
                    cell.setMedName(name: self.medCatalog[indexPath.row].nombre, uso: self.medCatalog[indexPath.row].uso , array: self.medCatalog[indexPath.row].enfermedades, index: indexPath.row)
        
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    cell.setNeedsUpdateConstraints()
                    cell.updateConstraintsIfNeeded()
                    
                    if  self.isCellActive[indexPath.row] == true {
                        cell.rotateIcon(open: true)
                    }else{
                        cell.rotateIcon(open: false)
                    }

                    
                    self.cellBool[indexPath.row]             =  true
                    self.collapsedCellHeight[indexPath.row]  =  cell.collapsedCellHeight()
                    self.expandedCellHeight[indexPath.row]   =  cell.expandedCellHeight()
                    
                    //cell.updateSecondTableView()
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MedCellWithCollection") as? MedCellWithCollection{
                    
                    let backgroundView              =  UIView()
                    backgroundView.backgroundColor  =  UIColor.white.withAlphaComponent(0.0)
                    cell.selectedBackgroundView     =  backgroundView
                                    
                    cell.setMedName(name: self.medCatalog[indexPath.row].nombre, uso: self.medCatalog[indexPath.row].uso , array: self.medCatalog[indexPath.row].enfermedades[0].aplicaciones  , index: indexPath.row)
        
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    cell.setNeedsUpdateConstraints()
                    cell.updateConstraintsIfNeeded()
                    
                    if  self.isCellActive[indexPath.row] == true {
                        cell.rotateIcon(open: true)
                    }else{
                        cell.rotateIcon(open: false)
                    }

                    
                    self.cellBool[indexPath.row]             =  true
                    self.collapsedCellHeight[indexPath.row]  =  cell.collapsedCellHeight()
                    self.expandedCellHeight[indexPath.row]   =  cell.expandedCellHeight()
                    
                    //cell.updateSecondTableView()
                    return cell
                }
            }
            
        }
        self.cellBool[indexPath.row]             =   false
        self.collapsedCellHeight[indexPath.row]  =   0.0
        self.expandedCellHeight[indexPath.row]   =   0.0
        return UITableViewCell()
    }
    
    
    //Sets dynamic height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if self.cellBool[indexPath.row] != nil {
            if self.cellBool[indexPath.row]!{
                if self.isCellActive[indexPath.row] == true {
                    return self.expandedCellHeight[indexPath.row]!
                }else{
                    
                    return self.collapsedCellHeight[indexPath.row]!
                }
            }
        }
        return 85
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.previousSelectedMainIndex = self.selectedMainIndex
        self.selectedMainIndex         = indexPath
        
        
        if let cell = tableView.cellForRow(at: self.selectedMainIndex!) as? MedCellWithTable {
            cell.rotateIcon(open: true)
            self.isCellActive[self.selectedMainIndex!.row] = true
            
            if let indexP = self.previousSelectedMainIndex{
                if indexP.row == self.selectedMainIndex!.row {

                    if let cell = tableView.cellForRow(at: indexP) as? MedCellWithTable{
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                        self.selectedMainIndex        =  nil
                    }else{
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                        self.selectedMainIndex        =  nil
                    }
                    
                }else{
                    
                    if let cell = tableView.cellForRow(at: indexP) as? MedCellWithTable {
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                    }
                    if let cell = tableView.cellForRow(at: indexP) as? MedCellWithCollection {
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                    }
                    else{
                        self.isCellActive[indexP.row] = false
                    }
                    
                }
                
            }
        }else{
            let cell = tableView.cellForRow(at: self.selectedMainIndex!) as! MedCellWithCollection
            cell.rotateIcon(open: true)
            self.isCellActive[self.selectedMainIndex!.row] = true
            
            if let indexP = self.previousSelectedMainIndex{
                if indexP.row == self.selectedMainIndex!.row {

                    if let cell = tableView.cellForRow(at: indexP) as? MedCellWithTable{
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                        self.selectedMainIndex        =  nil
                    }else{
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                        self.selectedMainIndex        =  nil
                    }
                    
                }else{
                    
                    if let cell = tableView.cellForRow(at: indexP) as? MedCellWithTable {
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                    }
                    if let cell = tableView.cellForRow(at: indexP) as? MedCellWithCollection {
                        cell.rotateIcon(open: false)
                        self.isCellActive[indexP.row] = false
                    }
                    else{
                        self.isCellActive[indexP.row] = false
                    }
                    
                }
                
            }
            
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}


