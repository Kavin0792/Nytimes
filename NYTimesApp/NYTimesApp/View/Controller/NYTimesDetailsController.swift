//
//  NYTimesDetailsController.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import UIKit
import SDWebImage

final class NYTimesDetailsController: BaseViewController {
    
    @IBOutlet weak private var articleSection: UILabel!
    @IBOutlet weak private var articleLastUpdatedOn: UILabel!
    @IBOutlet weak private var articleDate: UILabel!
    @IBOutlet weak private var articleTitle: UILabel!
    @IBOutlet weak private var articleSubTitle: UILabel!
    @IBOutlet weak private var articleImageView: UIImageView!
    
    let viewModel: NYArticlesDetailsViewModelProtocol
    
    init?(coder: NSCoder,
          viewModel: NYArticlesDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use 'init(coder:viewModel:)' to initialize a 'NYTimesDetailsController' instance.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        articleSection.text = viewModel.articleSource
        articleLastUpdatedOn.text = viewModel.articleUpdatedOn
        articleDate.text = viewModel.articlePublishedOn
        articleTitle.text = viewModel.articleTitle
        articleSubTitle.text = viewModel.articleSubTitle
        articleImageView.sd_setImage(with: viewModel.articleImageURL,
                                     placeholderImage: UIImage(named: "fav_placeHolder"))
    }
}
