//
//  TVDetailView.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/29.
//

import UIKit

class TVDetailView: BaseView {
    
    lazy var tvDetailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configCollectionViewLayout())
        
        let tvDetailCollectionViewCellNib = UINib(nibName: TVDetailCollectionViewCell.identifier, bundle: nil)
        collectionView.register(tvDetailCollectionViewCellNib, forCellWithReuseIdentifier: TVDetailCollectionViewCell.identifier)
        
        let tvDetailCollectionReusableViewNib = UINib(nibName: TVDetailCollectionReusableView.identifier, bundle: nil)
        collectionView.register(tvDetailCollectionReusableViewNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVDetailCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    override func configViewComponents() {
        addSubview(tvDetailCollectionView)
    }
    
    override func configLayoutConstraints() {
        tvDetailCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func configCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let inset: CGFloat = 20
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.width - (spacing * 3) - (inset * 2)) / 3

        layout.itemSize = CGSize(width: width, height: width * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        layout.headerReferenceSize = CGSize(width: 300, height: 36)

        return layout
    }
}
