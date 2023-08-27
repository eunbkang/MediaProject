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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configDesign()
        configLayoutConstraints()
    }
    
    // MARK: - Helpers
    
    func configDesign() {
        view.addSubview(imageShadowView)
        imageShadowView.addSubview(introImageView)
        view.addSubview(introLabel)
    }

    func configLayoutConstraints() {
        introImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-24)
            make.width.equalTo(250)
            make.height.equalTo(introImageView.snp.width).multipliedBy(1.7)
        }
        
        imageShadowView.snp.makeConstraints { make in
            make.size.equalTo(introImageView)
            make.horizontalEdges.verticalEdges.equalTo(introImageView)
        }
        
        introLabel.snp.makeConstraints { make in
            make.bottom.equalTo(introImageView.snp.bottom).offset(100)
            make.centerX.equalTo(view)
        }
    }
}
