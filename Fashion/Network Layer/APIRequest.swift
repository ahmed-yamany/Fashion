//
//  APIRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
protocol APIRequest{
    associatedtype Response
    var host: String { get }
    var path: String {get}
    var parameters: [String:Any?] {get set}
}

extension APIRequest{
    var host: String {"student.valuxapps.com/api/"}
    
    var userToken: String? {
        guard let token = KeychainWrapper.standard.string(forKey: AuthData.userToken) else{return nil}
        return token
    }
}

extension APIRequest{
    var url: String{"https://\(host)\(path)"}
    var languageCode: String{Locale.current.languageCode ?? "en"}
    var headers: HTTPHeaders {
        var header = HTTPHeaders(["Content-Type": "application/json", "lang": languageCode])
        if let userToken = userToken{
            header["Authorization"] = userToken
        }
        return header
    }
}

extension APIRequest where Response: Decodable{
    func request(method: HTTPMethod, completion: @escaping (Result<Response?, NSError>)->Void ){
        AF.request(url, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response.self) { response in
            guard let response = response.value else { return }
            completion(.success(response))
        }
    }

    func send(completion: @escaping (Result<Response?, NSError>)->Void ) {
        request(method: .post, completion: completion)
    }
    
    func feach(completion: @escaping (Result<Response?, NSError>)->Void ){
        request(method: .get, completion: completion)
    }
    
}

