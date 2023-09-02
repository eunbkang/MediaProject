//
//  VideoCollectionViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/18.
//

import UIKit
import WebKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var videoWebView: WKWebView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        videoWebView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 2
        titleLabel.contentMode = .top
        titleLabel.textAlignment = .left
    }
    
    func configData(video: Video) {
        titleLabel.text = video.name
        
        guard let url = URL.PathType.youTube.makeUrl(id: video.key, season: nil, page: nil) else { return }
        
        print(url)
//        guard let url = URL(string: URL.makeYouTubeUrl(with: video.key)) else { return }
        videoWebView.load(URLRequest(url: url))
    }

}
