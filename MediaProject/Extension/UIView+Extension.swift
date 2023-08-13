//
//  UIView+Extension.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit

extension UIView {
    func configShadow(cornerRadius corner: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = corner
    }
}
