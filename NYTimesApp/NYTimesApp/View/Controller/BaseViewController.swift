//
//  BaseViewController.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import UIKit

class BaseViewController: UIViewController {
    private var backButtonItem: UIBarButtonItem {
        let image = "backIcon"
        let button =  UIBarButtonItem(image: UIImage(named: image),
                                      style: .plain,
                                      target: self,
                                      action: #selector(backBarButtonTapped))
        button.tintColor = .blue
        return button
    }
    
    override var title: String? {
        didSet {
            self.navigationController?.title = title
            self.navigationController?.accessibilityLabel = title
        }
    }
    
    @objc private func backBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.viewControllers.count ?? 0 > 1 {
            self.navigationItem.leftBarButtonItem = backButtonItem
        }
    }
}
