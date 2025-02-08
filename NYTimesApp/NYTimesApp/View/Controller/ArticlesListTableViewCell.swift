//
//  ArticlesListTableViewCell.swift
//  NYTimesApp
//
//  Created by Kavin on 01/05/23.
//

import UIKit
import SDWebImage

protocol NYTimesListingCellViewProtocol {
    func display(title: String)
    func display(imageURL:URL?)
    func display(subTitle: String)
    func display(date: String)
}

final class ArticlesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var articleImageView: UIImageView!
    @IBOutlet weak private var articleTitle: UILabel!
    @IBOutlet weak private var articleSubTitle: UILabel!
    @IBOutlet weak private var articleDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension ArticlesListTableViewCell: NYTimesListingCellViewProtocol {
    
    func display(imageURL: URL?) {
        articleImageView.sd_setImage(with: imageURL,
                                       placeholderImage: UIImage(named: "fav_placeHolder"))
    }
    
    func display(title: String) {
        articleTitle.text = title
    }
    
    func display(subTitle: String) {
        articleSubTitle.text = subTitle
    }
    
    func display(date: String) {
        articleDate.text = date
    }
}

