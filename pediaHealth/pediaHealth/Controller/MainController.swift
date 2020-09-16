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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medCatalog.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === MainTable{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MedName", for: indexPath) as? MedCell{
                cell.setMedName(name: self.medCatalog[indexPath.row].nombre)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}


