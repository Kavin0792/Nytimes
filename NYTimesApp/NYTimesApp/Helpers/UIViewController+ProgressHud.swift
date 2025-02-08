//
//  UIViewController+ProgressHud.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showHUD(on view: UIView? = nil, progressLabel: String){
        DispatchQueue.main.async{
            let _view = (view == nil) ? self.view : view!
            let progressHUD = MBProgressHUD.showAdded(to: _view!, animated: true)
            progressHUD.label.text = progressLabel
            progressHUD.isUserInteractionEnabled = false
        }
    }
    
    func dismissHUD(from view: UIView? = nil, isAnimated:Bool) {
        DispatchQueue.main.async{
            let _view = (view == nil) ? self.view : view!
            MBProgressHUD.hide(for: _view!, animated: isAnimated)
        }
    }
}


extension String {
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

extension Optional where Wrapped == String {
    var notNil: String {
        self ?? ""
    }
}
