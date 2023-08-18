//
//  SimilarTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/18.
//

import UIKit

class SimilarTableViewCell: UITableViewCell {

    @IBOutlet var similarCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCollectionView()
        configCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SimilarTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.identifier, for: indexPath) as? SimilarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - Layout

extension SimilarTableViewCell {
    func configCollectionView() {
        self.selectionStyle = .none
        
        let similarCollectionViewCellNib = UINib(nibName: SimilarCollectionViewCell.identifier, bundle: nil)
        similarCollectionView.register(similarCollectionViewCellNib, forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier)
        
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
    }
    
    func configCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let inset: CGFloat = 20
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (spacing * 2) - (inset * 2)) / 3
        
        layout.itemSize = CGSize(width: width, height: width * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        similarCollectionView.collectionViewLayout = layout
    }
}
