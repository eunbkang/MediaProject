//
//  UIViewController+Extension.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/30.
//

import UIKit

extension UIViewController {
    enum TransitionType {
        case push
        case present
        case windowRoot
    }

    func transitView<T: UIViewController>(vc: T, type: TransitionType) {
        switch type {
        case .push:
            navigationController?.pushViewController(vc, animated: true)
            
        case .present:
            present(vc, animated: true)
            
        case .windowRoot:
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
        }
    }
}
