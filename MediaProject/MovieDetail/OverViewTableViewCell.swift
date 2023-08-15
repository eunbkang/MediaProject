//
//  OverViewTableViewCell.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/13.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {

    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    
    var isShowingMore: Bool? {
        didSet {
            configMoreButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        moreButton.tintColor = .black
        
        configMoreButton()
    }
    
    func configData(row: Result) {
        overViewLabel.text = row.overview
    }
    
    func configMoreButton() {
        guard let isShowingMore else { return }
        
        if isShowingMore {
            overViewLabel.numberOfLines = 0
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            
        } else {
            overViewLabel.numberOfLines = 2
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            
        }
    }
}
