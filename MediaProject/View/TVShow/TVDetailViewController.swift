//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/17.
//

import UIKit

class TVDetailViewController: BaseViewController {
    
    private let mainView = TVDetailView()
    
    var seriesId: Int?
    var numberOfSeasons: Int?
    
    var tvDetail: TVDetail?
    private var tvSeason: [[Episode]] = []
    
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
    
    private func callTVDetailRequest() {
        guard let seriesId else { return }
        let id = String(seriesId)
        
        guard let detailUrl = URL.PathType.tvDetail.makeUrl(id: id, season: nil, page: nil) else { return }
        
        TMDBManager.shared.callRequest(url: detailUrl, model: TVDetail.self) { value in
            guard let value else { return }
            self.tvDetail = value
            self.callTVSeasonRequest(seriesId: id, numberOfSeasons: value.numberOfSeasons)
        }
    }

    private func callTVSeasonRequest(seriesId: String, numberOfSeasons: Int) {
        
        for seasonNo in 1...numberOfSeasons {
            guard let url = URL.PathType.tvSeason.makeUrl(id: seriesId, season: seasonNo, page: nil) else { return }
            
            TMDBManager.shared.callRequest(url: url, model: TVSeason.self) { value in
                guard let value else { return }
                self.tvSeason.append(value.episodes)
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
