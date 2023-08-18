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
        
        self.backgroundColor = .systemTeal
        
        videoWebView.contentMode = .scaleAspectFit
    }

}
