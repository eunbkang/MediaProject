//
//  ProfileEditViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import UIKit

class ProfileEditViewController: BaseViewController {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        
        return textField
    }()
    
    var profileItem: ProfileItem?
    
    var delegate: PassNicknameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        switch profileItem {
        case .name:
            print("name")
            NotificationCenter.default.post(
                name: .name,
                object: nil,
                userInfo: ["name": textField.text ?? ""]
            )
            
        case .nickname:
            print("nickname")
            delegate?.receiveNickname(nickname: textField.text ?? "")
            
        case .introduction:
            print("introduction")
            
        case .none:
            print("unexpected case")
        }
    }
    
    override func configViewComponents() {
        super.configViewComponents()
        
        view.addSubview(textField)
    }
    
    override func configLayoutConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
    }
    
    func configDataToView(profileItem: ProfileItem, content: String) {
        title = profileItem.text
        textField.placeholder = profileItem.text
        textField.text = content
    }
}
