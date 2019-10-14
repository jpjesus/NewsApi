//
//  UINavigationControllerExtension.swift
//  TheNews
//
//  Created by Jesus Parada on 10/14/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController {
    
    func pushFadeAnimation(viewController: UIViewController) {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
        view.layer.removeAllAnimations()
    }
    
    func popFadeAnimation() {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
        view.layer.removeAllAnimations()
    }
    
    static func showOfflineAlert(with navigation: UINavigationController?) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Error fetching the news", comment: "Error fetching the news"), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        if let navigation = navigation?.visibleViewController {
            if !(navigation.isKind(of: UIAlertController.self)) {
                OperationQueue.main.addOperation {
                    navigation.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
