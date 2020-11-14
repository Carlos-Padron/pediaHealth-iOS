//
//  IllCell.swift
//  pediaHealth
//
//  Created by Carlos on 21/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class IllCell: UITableViewCell {
    
    //Varables
    var dosesType:[Aplicacion]?
    
    let topBottomAnchor: CGFloat = 16.0
    
    //Outlets
    @IBOutlet weak var enfermedadText: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSetUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    func setUpCell(enfermedad: String, array: [Aplicacion]){
        self.enfermedadText.text = enfermedad
        self.dosesType = array
        
        self.collectionView.reloadData()
    }
    
    func collapsedCellHeight()->CGFloat{
        let cellTextHeight: CGFloat       =  self.enfermedadText.bounds.height
        
        return cellTextHeight + self.topBottomAnchor
    }
    
    func expandedCellHeight()->CGFloat{
        let cellTextHeight: CGFloat       =  self.enfermedadText.bounds.height
        let collectionHeight: CGFloat           =  self.collectionView.bounds.height
        
        //10 es la constante por deault
        let expandedHeight: CGFloat       =  cellTextHeight  + 10  + collectionHeight
        
        
        return expandedHeight
    }

    
    
    func rotateIcon(open: Bool){
        let angle: CGFloat = open == true ? CGFloat((Double.pi) / (2)) : CGFloat((Double.pi) * (2))
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.arrowIcon.tintColor = open == true ? UIColor(named: "Text") :  UIColor(named: "DarkGrey")
            self.arrowIcon.transform = CGAffineTransform(rotationAngle: angle)
            
        }) 
    }
    
}
extension IllCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionViewSetUp(){
        self.collectionView.delegate     =  self
        self.collectionView.dataSource   =  self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dosesType?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doseColletion", for: indexPath) as? DoseCollection{
            
            cell.setButtonConfig(doseType: self.dosesType![indexPath.row].metodo, index: indexPath.row)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
}
