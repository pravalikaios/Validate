//
//  NetworkManager.swift
//  SampleEmailApp
//
//  Created by Mallesh Kurva on 16/08/22.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func callService<T: Decodable, U: Decodable>(isSpinner: Bool? = nil, serviceMethod:String, params:[String:Any]? ,isToken: Bool? = nil,method: HttpMethod, successModel:@escaping (_ genericData:T)->(),errorBlock:@escaping (_ erorData: U)->(),failure:@escaping(String) -> ()) {
        
      
        if !Reachability.isConnectedToNetwork(){
            
            DispatchQueue.main.async {
                getTopMostViewController()?.displayAlert(andMessage:Constants.AlertTitles.internetMsg )
            }
            return
        }
        
        if isSpinner ?? false  {
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.isUserInteractionEnabled = false
//                Loader.shared.showLoader()
            }
        }
        var urlStr = ""//getServerURL()
        
       /* if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let dict = NSDictionary(contentsOfFile: path)
            print(dict?.object(forKey: "SERVER_URL") ?? "")
            urlStr = dict?.object(forKey: "SERVER_URL") as? String ?? ""
        }*/
        
//        var methodStr = serviceMethod
         urlStr = urlStr + serviceMethod//methodStr
        
        if urlStr.contains(" ")  || urlStr.containsSplCharacters() {
            //  urlStr = urlStr.replacingOccurrences(of: " ", with: "%2d")
            urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlStr
            
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        request.setValue(Constants.header.applicationJson, forHTTPHeaderField: Constants.header.ContentType)
//        request.setValue(Constants.header.device, forHTTPHeaderField: Constants.header.deviceKey)
        
        
        print("Request URL: \(request)")
        print("Request Headers: \(String(describing: request.allHTTPHeaderFields))")
//        if  serviceMethod == Constants.method.changePasswordUrl {
//            let authKey = ConformPasswordViewModel.shared.conformModel?.data?.jwttoken ?? ""
//            let AuthValue = Constants.header.Bearer + authKey
//            request.addValue(AuthValue, forHTTPHeaderField: Constants.header.Authorization)
//            request.setValue(Constants.header.Customer, forHTTPHeaderField: Constants.header.RequestedPortal)
//        }
        
        
        if params != nil && params?.count ?? 0 > 0 {
                let  jsonData = try? JSONSerialization.data(withJSONObject: params!)
                request.httpBody = jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("data", try? JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments))
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.isUserInteractionEnabled = true
//                Loader.shared.hideLoader()
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    print("service methd", serviceMethod, try? JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments))
                    self.decodeErrorModel(responseData: data) { (errorModel) in
                        errorBlock(errorModel)
                    }
                    return
                }
            
            self.decodeSuccessModel(responseData: data) { (successDataModel) in
                successModel(successDataModel)
            }
            
        }
        
        task.resume()
    }
    
    
    
    //MARK: Decode success model
    func decodeSuccessModel<T: Decodable>(responseData: Data?,successModelBlock:@escaping (_ modelData:T)->()) {
        guard let data = responseData else {
            return
        }
        do{
            let jsonDecoder = JSONDecoder()
            let genericModalData = try jsonDecoder.decode(T.self, from: data)
            successModelBlock(genericModalData)
        }catch let jsonErr {
            print("Success decoding Error Json", jsonErr)
        }
    }


    //MARK: Decode Error model
    func decodeErrorModel<T: Decodable>(responseData: Data?,errorBlock:@escaping (_ erorData:T)->()) {
        guard let data = responseData else {
            return
        }
        
        do{
            let jsonDecoder = JSONDecoder()
            let errorModalData = try jsonDecoder.decode(T.self, from: data)
            
            errorBlock(errorModalData)
        }catch let jsonErr {
            let dict  = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                print("invalid token",dict)
            if let error = dict?["error"] as? [String:Any] {
                let errorDescription = error["errorDescription"] as? String
                if  errorDescription?.lowercased().contains("access token expired") ?? false{
                    DispatchQueue.main.async {
                       // need to navigate Login
                    }
                }else{
                    DispatchQueue.main.async {
    //
                    }
                    
                    
                }
            }
        }
    }
}

enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
}
