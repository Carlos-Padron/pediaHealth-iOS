//
//  ViewController.swift
//  pediaHealth
//
//  Created by Carlos on 05/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MainController: UIViewController {
   
    override func viewDidLoad() {
        DataService.instance.createMedList { (res) in
            switch res{
            case .failure(let error):
                print(error)
                break
            case .success(let med):
                print(med)
            }
        }
        // Do any additional setup after loading the view.
    }


}

