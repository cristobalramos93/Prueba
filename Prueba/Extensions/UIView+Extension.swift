//
//  UIView+Extension.swift
//  openBank
//
//  Created by Cristobal Ramos on 5/3/22.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
