//
//  UserLoginViewModel.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import UIKit

import Foundation

protocol LoginProtocol: AnyObject {
    var loginResponse: LoginResponse? { set get }
    var onLoginSuccess: (() -> Void)? { set get }
    var onLoginFailure: ((Error) -> Void)? { set get }
    func loginUser()
    func getBodyParams() -> [String : Any]
    func setCreds(userName: String, password: String)
}

final class LoginViewModel: LoginProtocol {
    
    private let apiKey: String = "1a873e8982fdd7835bd00c56d68e33db3f695403"
    
    private let networkService: NetworkService
    private(set) var userName: String?
    private(set) var password: String?
    
    var bodyParams: [String : Any]?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var loginResponse: LoginResponse?
    
    var onLoginSuccess: (() -> Void)?
    
    var onLoginFailure: ((Error) -> Void)?
    
    func setCreds(userName: String, password: String) {
        self.userName = userName
        self.password = password.data(using: .utf8)?.base64EncodedString()
    }
    
    /// make user login API call with valid data and request.
    func loginUser() {
        let request = LoginRequest(bodyParams: getBodyParams())
        
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let loginReponse):
                self.loginResponse = loginReponse
                self.onLoginSuccess?()
            case .failure(let error):
                self.onLoginFailure?(error)
            }
        }
    }
    
    /// Configure body params for login request
    /// - Returns: dictionary for body params
    func getBodyParams() -> [String : Any] {
        let jsonDict: [String: Any] = [
            "ms_request": [
                "user": [
                    "api_key": apiKey,
                    "username": userName,
                    "password": password
                ]
            ]
        ]
        return jsonDict
    }
}
