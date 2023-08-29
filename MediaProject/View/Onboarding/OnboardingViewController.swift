//
//  OnboardingViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/27.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    // MARK: - Properties
    
    var introNumber: IntroScene? {
        didSet {
            guard let introNumber else { return }
            introLabel.text = introNumber.introText
            introImageView.image = UIImage(named: introNumber.imageName)
        }
    }
    
    lazy var introImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    lazy var imageShadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init("시작하기")
        titleAttr.font = .preferredFont(forTextStyle: .headline)
        config.attributedTitle = titleAttr
            
        config.baseForegroundColor = .white
        config.background.backgroundColor = .black
        config.cornerStyle = .fixed
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        
        button.configuration = config
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configDesign()
        configLayoutConstraints()
    }
    
    // MARK: - Action
    
    @objc func tappedStartButton() {
        UserDefaultsManager.shared.isOnboardingCompleted = true
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = MainTabBarController()

        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    
    // MARK: - Helpers
    
    func configDesign() {
        view.addSubview(imageShadowView)
        imageShadowView.addSubview(introImageView)
        view.addSubview(introLabel)
        
        if introNumber?.rawValue == IntroScene.allCases.count - 1 {
            view.addSubview(startButton)
            startButton.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        }
    }

    func configLayoutConstraints() {
        introImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-36)
            make.width.equalTo(250)
            make.height.equalTo(introImageView.snp.width).multipliedBy(1.7)
        }
        
        imageShadowView.snp.makeConstraints { make in
            make.size.equalTo(introImageView)
            make.horizontalEdges.verticalEdges.equalTo(introImageView)
        }
        
        introLabel.snp.makeConstraints { make in
            make.bottom.equalTo(introImageView.snp.bottom).offset(90)
            make.centerX.equalTo(view)
        }
        
        if introNumber?.rawValue == IntroScene.allCases.count - 1 {
            startButton.snp.makeConstraints { make in
                make.centerX.equalTo(view)
                make.top.equalTo(introLabel.snp.bottom).offset(36)
            }
        }
    }
}
