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
    
    
    @IBOutlet var backgroundCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        repoImageView.layer.cornerRadius = 16
        // Initialization code
    }

  
    
}
