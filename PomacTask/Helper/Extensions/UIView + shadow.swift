//
//  UIView + shadow.swift
//  PomacTask
//
//  Created by ahlam on 11/10/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
    }
}
