//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit

class TVDetailViewController: BaseViewController {
    
    let mainView = TVDetailView()
    
    var seriesId: Int?
    var numberOfSeasons: Int?
    
    var tvDetail: TVDetail?
    var tvSeason: [[Episode]] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callTVDetailRequest()
    }
    
    override func configViewComponents() {
        super.configViewComponents()
        
        mainView.tvDetailCollectionView.delegate = self
        mainView.tvDetailCollectionView.dataSource = self
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
                self.tvSeason.append(data.episodes)
                self.mainView.tvDetailCollectionView.reloadData()
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
            
            view.seasonLabel.text = "Season \(indexPath.section + 1)"
            
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
}
