//
//  LoginManager.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

// this class manages session of user (Login/Logout). As logout is not implemented the logout scenario is not there.
class LoginManager {
    static let shared = LoginManager()
    
    private init() {}
    
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: GlobalConstants.isLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.isLoggedIn)
        }
    }
    
    /// save the _felix_session_id
    /// - Parameter token: token from login response.
    func setToken(_ token: String) {
        UserDefaults.standard.set("\(GlobalConstants._felix_session_id)=\(token)", forKey: GlobalConstants._felix_session_id)
    }
    
    /// method to get _felix_session_id
    /// - Returns: _felix_session_id
    func getToken() -> String {
        guard let token = UserDefaults.standard.value(forKey: GlobalConstants._felix_session_id) as? String else {
            return GlobalConstants.emptyString
        }
        return token
    }
}
