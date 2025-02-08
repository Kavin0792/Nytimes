//
//  NYTimesListingController.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import UIKit

final class NYTimesListingController: BaseViewController {
    
    @IBOutlet weak private var searchBar: UISearchBar!{
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak private var noContentToDisplay: UILabel!
    @IBOutlet weak private var tableView: UITableView!{
        didSet {
            registerTableViewCell()
            setUpTableView()
        }
    }
    
    var viewModel: NYTimesListingViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        viewModel.loadData { }
    }
    
    fileprivate func initialConfiguration() {
        viewModel.configureView(view: self)
        navigationItem.title = viewModel.screenTitle
    }
    
    init?(coder: NSCoder,
          viewModel: NYTimesListingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use 'init(coder:viewModel:)' to initialize a 'NYTimesListingController' instance.")
    }
    
    fileprivate func setUpTableView() {
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.00
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func registerTableViewCell() {
        let titleDescCell =  UINib(nibName: "ArticlesListTableViewCell", bundle: nil)
        self.tableView.register(titleDescCell, forCellReuseIdentifier: "ArticlesListTableViewCell")
    }
    
}

// MARK: - NYTimesListingViewProtocol
extension NYTimesListingController: NYTimesListingViewProtocol {
    
    func showLoader() {
        showHUD(progressLabel: viewModel.loaderMsg)
    }
    
    func dismissLoader() {
        dismissHUD(isAnimated: true)
    }
    
    func reloadView() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func showNoSearchText() {
        noContentToDisplay.isHidden = false
        tableView.isHidden = true
    }
    
    func hideNoSearchText() {
        noContentToDisplay.isHidden = true
        tableView.isHidden = false
    }
}

// MARK: - UISearchBarDelegate
extension NYTimesListingController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        viewModel.searchText(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension NYTimesListingController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesListTableViewCell", for: indexPath) as! ArticlesListTableViewCell
        viewModel.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(row: indexPath)
    }
}
