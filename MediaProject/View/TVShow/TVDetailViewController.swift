//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit

class TVDetailViewController: UIViewController {

    @IBOutlet var tvDetailCollectionView: UICollectionView!
    
    var seriesId: Int?
    var numberOfSeasons: Int?
    
    var tvDetail: TVDetail?
    var tvSeason: [[Episode]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configCollectionView()
        configCollectionViewLayout()
        
        callTVDetailRequest()
    }
    
    func callTVDetailRequest() {
        guard let seriesId else { return }
        
        TMDBManager.shared.callTVDetailRequest(seriesId: seriesId) { data in
            self.tvDetail = data
            self.callTVSeasonRequest(seriesId: data.id, numberOfSeasons: data.numberOfSeasons)
        }
    }

    func callTVSeasonRequest(seriesId: Int, numberOfSeasons: Int) {
        
        for seasonNo in 1...numberOfSeasons {
            TMDBManager.shared.callTVSeasonRequest(seriesId: seriesId, seasonNo: seasonNo) { data in
                print(seriesId, seasonNo)
//                guard let episodes = data.episodes else {
//                    print("no episodes")
//                    return
//                }
                
                self.tvSeason.append(data.episodes)
                self.tvDetailCollectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tvSeason.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSeason[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVDetailCollectionViewCell.identifier, for: indexPath) as? TVDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configData(row: tvSeason[indexPath.section][indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVDetailCollectionReusableView.identifier, for: indexPath) as? TVDetailCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.seasonLabel.text = "Season \(indexPath.section)"
            
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
}

// MARK: - CollectionView Layout

extension TVDetailViewController {
    func configCollectionView() {
        let tvDetailCollectionViewCellNib = UINib(nibName: TVDetailCollectionViewCell.identifier, bundle: nil)
        tvDetailCollectionView.register(tvDetailCollectionViewCellNib, forCellWithReuseIdentifier: TVDetailCollectionViewCell.identifier)
        
        let tvDetailCollectionReusableViewNib = UINib(nibName: TVDetailCollectionReusableView.identifier, bundle: nil)
        tvDetailCollectionView.register(tvDetailCollectionReusableViewNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVDetailCollectionReusableView.identifier)
        
        tvDetailCollectionView.delegate = self
        tvDetailCollectionView.dataSource = self
    }
    
    func configCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let inset: CGFloat = 20
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.width - (spacing * 3) - (inset * 2)) / 3

        layout.itemSize = CGSize(width: width, height: width * 1.6)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        tvDetailCollectionView.collectionViewLayout = layout
    }
}
