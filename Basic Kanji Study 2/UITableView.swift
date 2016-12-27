//
//  UITableView.swift
//  Motor
//
//  Created by Xavier Serra Soteras on 25/5/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNib(nibName name: String, forCellReuseIdentifier identifier: String) {
        register(
            UINib(nibName: name, bundle: Bundle.main),
            forCellReuseIdentifier: identifier
        )
    }
    
}
