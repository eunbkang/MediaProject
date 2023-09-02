//
//  UIView+Extension.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit

extension UIView {
    func configShadow(cornerRadius corner: CGFloat, opacity: Float = 0.3, radius: CGFloat = 8) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = corner
    }
}
