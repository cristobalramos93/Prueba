//
//  UIViewController+Extension.swift
//  openBank
//
//  Created by Cristobal Ramos on 5/3/22.
//

import Foundation
import UIKit

extension UIViewController {
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }
}
