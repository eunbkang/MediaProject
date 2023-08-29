//
//  BaseViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViewComponents()
        configLayoutConstraints()
    }

    func configViewComponents() {
        view.backgroundColor = .white
    }
    
    func configLayoutConstraints() { }
}
