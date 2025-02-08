//
//  NYTimesListingViewModelProtocol.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import UIKit

protocol  NYTimesListingViewModelProtocol {
    
    var screenTitle: String { get }
    var loaderMsg: String { get }
    var view: NYTimesListingViewProtocol? { get set }
    var coordinatorDelegate: NYMostPopularListingCoordinatorDelegateProtocol? { get set }
    
    func configureView(view: NYTimesListingViewProtocol)
    func loadData(completionHandler: @escaping (() -> Void))
    func numberOfRowsInSection() -> Int
    func configure(cell: NYTimesListingCellViewProtocol, forRow row: Int)
    func didSelect(row: IndexPath)
    func searchText(_ text: String)
}

protocol NYTimesListingViewProtocol: AnyObject where Self: UIViewController {
    func showLoader()
    func dismissLoader()
    func reloadView()
    func showNoSearchText()
    func hideNoSearchText()
    var viewModel: NYTimesListingViewModelProtocol { get set }
}
