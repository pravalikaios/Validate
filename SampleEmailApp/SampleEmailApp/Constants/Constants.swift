//
//  Constants.swift
//  SampleEmailApp
//
//  Created by Mallesh Kurva on 16/08/22.
//

import Foundation

struct Constants {
    struct APIUrls {
        static let validate_emailAPI = "https://api.eva.pingutil.com/email"
    }
    
    struct VaidMessages {
        static let inValidEmail = "Please Enter a Valid Email Address"
        static let validEmail   = "Email Address is Valid"
    }
    
    struct AlertTitles {
        static let KAppNameTitle = "Sample Email App"
        static let internetMsg = "Looks like we are having an issue with your Internet, please retry again"
        
    }
    
    //Mark: API Headers
    struct header {
        // Default
        static let RefererValue     = "http://mobile/"
        static let Referer          = "Referer"
        static let enUS             = "en-US"
        static let AcceptLanguage   = "Accept-Language"
        static let XREQUESTID       = "X-REQUESTID"
        static let Accept           = "Accept"
        static let ContentType      = "Content-Type"
        static let applicationJson  = "application/json"
        static let Token            = "Token"
        static let Bearer           = "Bearer "
        static var jwtToken         = String()
    }
}
