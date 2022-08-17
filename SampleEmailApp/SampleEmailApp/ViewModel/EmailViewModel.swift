//
//  EmailViewModel.swift
//  SampleEmailApp
//
//  Created by Mallesh Kurva on 16/08/22.
//

import Foundation
import UIKit

class EmailViewModel {
    static let shared = EmailViewModel()
    var emailData : EmailData?
    
    //MARK: - Post login information
    func validateEmailAddress(vc : ViewController) {
        let path = "\(Constants.APIUrls.validate_emailAPI)" + "?email=\(vc.emailTF.text ?? "")"
        NetworkManager.shared.callService(isSpinner: false, serviceMethod: path, params: [:], isToken: false, method: .get) { (info: EmailModel) in
            if info.status == "success" {
                DispatchQueue.main.async {
                    self.emailData = info.data
                    vc.displayAlert(andMessage: Constants.VaidMessages.validEmail)
                }
            }
            else {
                DispatchQueue.main.async {
                    vc.displayAlert(andMessage: Constants.VaidMessages.inValidEmail)
                }
            }
        }
        errorBlock: { (errorData:EmailModel) in
            DispatchQueue.main.async {
                vc.displayAlert(andMessage: Constants.VaidMessages.inValidEmail)
            }
        } failure: { message in
            DispatchQueue.main.async {
                vc.displayAlert(andMessage: message)
            }
        }
    }
}
