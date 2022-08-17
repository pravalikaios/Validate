//
//  Extensions.swift
//  SampleEmailApp
//
//  Created by Mallesh Kurva on 16/08/22.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlert(withTitle title:String = Constants.AlertTitles.KAppNameTitle, andMessage message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        present(alert, animated: true, completion: nil)
        
        
    }
}

func getTopMostViewController() -> UIViewController? {
    var topMostViewController = UIApplication.shared.windows.first?.rootViewController
    
    while let presentedViewController = topMostViewController?.presentedViewController {
        topMostViewController = presentedViewController
    }
    
    return topMostViewController
}

extension String {
    func containsSplCharacters() -> Bool {
        let arr = [" ", "," , "}", "{", "\\","+"]
        for obj in arr {
            if self.contains(obj)
            {
                return true
            }
        }
        return false
    }
}
