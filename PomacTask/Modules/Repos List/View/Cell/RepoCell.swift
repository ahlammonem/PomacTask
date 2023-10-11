//
//  RepoCell.swift
//  PomacTask
//
//  Created by ahlam on 09/10/2023.
//

import UIKit

class RepoCell: UITableViewCell {

    //MARK: - Outletes
    @IBOutlet var repoNameLbl: UILabel!
    @IBOutlet var ownerNameLbl: UILabel!
    @IBOutlet var createdAtLbl: UILabel!
    @IBOutlet var repoImageView: UIImageView!
    @IBOutlet var contentBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
      
    }
    
    func setUpView(){
        //add corners
        repoImageView.layer.cornerRadius = 16
        contentBackgroundView.layer.cornerRadius = 16
        
        //add shadow
        contentBackgroundView.addShadow()
    }

  
    
}
