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
    
    // MARK: - Properties
    
    let mainView = ProfileView()
    
    private var observedName: String? {
        didSet {
            mainView.profileTableView.reloadData()
        }
    }
    
    private var receivedNickname: String? {
        didSet {
            mainView.profileTableView.reloadData()
        }
    }
    
    private var escapedIntroduction: String? {
        didSet {
            mainView.profileTableView.reloadData()
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(observedProfileNameNotification),
            name: .name,
            object: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .name, object: nil)
    }
    
    // MARK: - BaseViewController
    
    override func loadView() {
        view = mainView
    }
    
    override func configViewComponents() {
        super.configViewComponents()
        
        title = "Profile"
        
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
    }
    
    // MARK: - Action
    
    @objc func observedProfileNameNotification(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            observedName = name
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

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
            if let receivedNickname {
                cell.itemContentLabel.text = receivedNickname
            } else {
                cell.itemContentLabel.text = profileItem.text
            }
            
        case .introduction:
            if let escapedIntroduction {
                cell.itemContentLabel.text = escapedIntroduction
            } else {
                cell.itemContentLabel.text = profileItem.text
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return }
        
        let profileItem = ProfileItem.allCases[indexPath.row]
        
        let vc = ProfileEditViewController()
        vc.configDataToView(profileItem: ProfileItem.allCases[indexPath.row], content: cell.itemContentLabel.text ?? "")
        vc.profileItem = ProfileItem.allCases[indexPath.row]
        
        if profileItem == .nickname {
            vc.delegate = self
        } else if profileItem == .introduction {
            vc.completionHandler = { text in
                self.escapedIntroduction = text
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - PassNicknameDelegate

extension ProfileViewController: PassNicknameDelegate {
    func receiveNickname(nickname: String) {
        receivedNickname = nickname
    }
}
