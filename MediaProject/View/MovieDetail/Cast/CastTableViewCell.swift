//
//  CastTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    @IBOutlet var castCollectionView: UICollectionView!
    
    var castList: [Cast]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCollectionView()
        configCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let cast = castList?[indexPath.item] else { return UICollectionViewCell() }
        cell.configData(cast: cast)
        
        return cell
    }
}

// MARK: - Layout

extension CastTableViewCell {
    func configCollectionView() {
        self.selectionStyle = .none
        
        let castCollectionViewCellNib = UINib(nibName: CastCollectionViewCell.identifier, bundle: nil)
        castCollectionView.register(castCollectionViewCellNib, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
    }
    
    func configCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let inset: CGFloat = 20
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (spacing * 3) - (inset * 2)) / 4

        layout.itemSize = CGSize(width: width, height: width * 2.1)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        castCollectionView.collectionViewLayout = layout
    }
}
