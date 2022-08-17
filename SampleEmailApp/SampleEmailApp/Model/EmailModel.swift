//
//  EmailModel.swift
//  SampleEmailApp
//
//  Created by Mallesh Kurva on 16/08/22.
//

import Foundation

//MARK: - Email Model
struct EmailModel : Codable {
    let status : String?
    let data : EmailData?
}

struct EmailData : Codable {
    let email_address : String?
    let domain : String?
    let valid_syntax : Bool?
    let disposable : Bool?
    let webmail : Bool?
    let deliverable : Bool?
    let catch_all : Bool?
    let gibberish : Bool?
    let spam : Bool?
}
