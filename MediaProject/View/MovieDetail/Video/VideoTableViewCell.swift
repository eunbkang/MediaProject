//
//  VideoTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/18.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var videoCollectionView: UICollectionView!
    
    var videoList: [Video]?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configCollectionView()
        configCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension VideoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let video = videoList?[indexPath.item] else { return UICollectionViewCell() }
        cell.configData(video: video)
        
        return cell
    }
}

// MARK: - Layout

extension VideoTableViewCell {
    func configCollectionView() {
        self.selectionStyle = .none
        
        let videoCollectionViewCellNib = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
        videoCollectionView.register(videoCollectionViewCellNib, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
    }
    
    func configCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let inset: CGFloat = 20
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - spacing - (inset * 2)) * 3/4

        layout.itemSize = CGSize(width: width, height: width * 3/4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        videoCollectionView.collectionViewLayout = layout
    }
}
