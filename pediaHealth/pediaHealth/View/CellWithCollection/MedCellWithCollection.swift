//
//  MedCellWithCollection.swift
//  pediaHealth
//
//  Created by Carlos on 28/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MedCellWithCollection: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var medText: UILabel!
    @IBOutlet weak var uso: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    //Variables
    var dosesType:[Aplicacion]?
    
    let textTopAnchor: CGFloat               =  12.0
    let TextBottomAnchor: CGFloat            =  10.0
    let cardBottomAnchor: CGFloat            =  9.0
    let cardTopAnchor: CGFloat               =  2.0

    


    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewSetUp()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setMedName(name: String, uso: String, array: [Aplicacion], index: Int){
        self.medText.text = name
        self.uso.text     = uso
        self.uso.isHidden = true
        
        self.dosesType = array
        
        self.CollectionView.reloadData()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()

    }
    
    func collapsedCellHeight()-> CGFloat{
        let cellTextHeight: CGFloat       =  self.medText.bounds.height
        let collapsedHeight: CGFloat      =  cellTextHeight          +  self.textTopAnchor      +  self.TextBottomAnchor +                                                                            self.cardBottomAnchor   +  self.cardTopAnchor      +  5
        
        return collapsedHeight
    }
    
    func expandedCellHeight()->CGFloat{
        let cellTextHeight: CGFloat       =  self.medText.bounds.height
        let cellUsageTextHeight: CGFloat  =  self.uso.bounds.height
        let collectionHeight: CGFloat           =  self.CollectionView.bounds.height
        
        //10 es la constante por deault
        let expandedHeight: CGFloat       =  cellTextHeight         +  self.textTopAnchor      + self.TextBottomAnchor +                                                                              self.cardBottomAnchor  +  self.cardTopAnchor      + cellUsageTextHeight   +
                                             10  + collectionHeight
        return expandedHeight
    }
    
    func rotateIcon(open: Bool){
        let angle: CGFloat = open == true ? CGFloat((Double.pi) / (2)) : CGFloat((Double.pi) * (2))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.uso.isHidden = false
            self.arrowIcon.tintColor = open == true ? UIColor(named: "Text") :  UIColor(named: "DarkGrey")
            self.arrowIcon.transform = CGAffineTransform(rotationAngle: angle)
            
        }) { (finished: Bool) in
            if !open {
                self.uso.isHidden = true
            }
        }
    }

}
extension MedCellWithCollection: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionViewSetUp(){
        self.CollectionView.delegate    =  self
        self.CollectionView.dataSource  =  self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dosesType?.count ?? 0
        //return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doseColletion", for: indexPath as IndexPath) as? DoseCollection {
            
                
            cell.setButtonConfig(doseType: self.dosesType![indexPath.row].metodo , index: indexPath.row)
                
                return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    
}
