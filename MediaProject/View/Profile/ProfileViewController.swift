//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import UIKit

protocol PassNicknameDelegate {
    func receiveNickname(nickname: String)
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    var observedName: String? {
        didSet {
            mainView.profileTableView.reloadData()
        }
    }
    
    var receivedNickname: String? {
        didSet {
            mainView.profileTableView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(observedProfileNameNotification), name: .name, object: nil)
    }
    
    override func configViewComponents() {
        super.configViewComponents()
        
        title = "Profile"
        
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
    }
    
    @objc func observedProfileNameNotification(notification: NSNotification) {
        print(#function)
        
        if let name = notification.userInfo?["name"] as? String {
            observedName = name
        }
        
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        
        let profileItem = ProfileItem.allCases[indexPath.row]
        
        cell.itemNameLabel.text = profileItem.text
        
        switch profileItem {
        case .name:
            if let observedName {
                cell.itemContentLabel.text = observedName
            } else {
                cell.itemContentLabel.text = profileItem.text
            }
        case .nickname:
            print("cellForRowAt nickname")
            if let receivedNickname {
                cell.itemContentLabel.text = receivedNickname
            } else {
                cell.itemContentLabel.text = profileItem.text
            }
            
        case .introduction:
            print("cellForRowAt introduction")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return }
        
        let vc = ProfileEditViewController()
        vc.configDataToView(profileItem: ProfileItem.allCases[indexPath.row], content: cell.itemContentLabel.text ?? "")
        vc.profileItem = ProfileItem.allCases[indexPath.row]
        
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: PassNicknameDelegate {
    func receiveNickname(nickname: String) {
        receivedNickname = nickname
    }
}
