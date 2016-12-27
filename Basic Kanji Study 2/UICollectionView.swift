//
//  UICollectionView.swift
//  Motor
//
//  Created by Davide Mendolia on 01/12/15.
//  Copyright © 2015 Schibsted. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerNib(nibName name: String, forCellReuseIdentifier identifier: String) {
        register(
            UINib(nibName: name, bundle: Bundle.main),
            forCellWithReuseIdentifier: identifier
        )
    }

    func registerNib(nibName name: String, forHeaderWithReuseIdentifier identifier: String) {
        register(
            UINib(nibName: name, bundle: Bundle.main),
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: identifier
        )
    }

    func registerNib(nibName name: String, forFooterWithReuseIdentifier identifier: String) {
        register(
            UINib(nibName: name, bundle: Bundle.main),
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: identifier
        )
    }
}
