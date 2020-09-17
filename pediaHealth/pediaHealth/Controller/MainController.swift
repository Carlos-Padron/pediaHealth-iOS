//
//  ViewController.swift
//  pediaHealth
//
//  Created by Carlos on 05/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    //Outlets
    @IBOutlet weak var MainTable: UITableView!
    
    //Variables
    let cellSpacingHeight: CGFloat = 20
    
    
    var medCatalog = [Medicina](){
        didSet{
            DispatchQueue.main.async {
                 self.MainTable.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        setInitialConfig()
    }

    
    //Initial SetUp
    func setInitialConfig(){
        mainTableViewSetUp()

        DataService.instance.createMedList { (res) in
            switch res {
            case .success(let medArray):
                self.medCatalog = medArray
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mainTableViewSetUp(){
        self.MainTable.delegate = self
        self.MainTable.dataSource = self
        
        self.MainTable.rowHeight = UITableView.automaticDimension
        self.MainTable.estimatedRowHeight = UITableView.automaticDimension
    }
    
    
    
    

    
    
    //MARK: - TableView Config 
    
    //# Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medCatalog.count
    }
    
    //Sets Medicine's name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === MainTable{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MedName", for: indexPath) as? MedCell{
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
                cell.selectedBackgroundView = backgroundView
                
                let index = indexPath.row
                cell.setMedName(name: self.medCatalog[index].nombre,
                                uso: self.medCatalog[index].uso )
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    //Sets dynamic height
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let index = IndexPath()
        //let cell = tableView.cellForRow(at: indexPath.row) as! MedCell
        
        let cell = tableView.cellForRow(at: index) as! MedCell

        print(cell.medText.bounds.height)
        
        return cell.medText.bounds.height
        
      //  return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedMed = indexPath.row
        //print(self.medCatalog[selectedMed].nombre)
        let cell = tableView.cellForRow(at: indexPath) as! MedCell
        print(cell.medText.bounds.height)
        
        
//        let height = cell.bounds.height
//        tableView.beginUpdates()
//        tableView.endUpdates()
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//         if indexPath.row == 1 {  //assign the selected row when touched
//               let thisCell = tableView.cellForRow(at: indexPath)
//
//               if let thisHeight = thisCell?.bounds.height {
//
//                   return thisHeight + 50
//
//               }
//           }
//           return 60
//    }

}


