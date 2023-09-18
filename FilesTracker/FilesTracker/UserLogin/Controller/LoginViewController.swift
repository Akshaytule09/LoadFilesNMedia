//
//  LoginViewController.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import UIKit

//MARK: protocol to add methods required in authentication process
protocol AuthManager: AnyObject {
    func validateAuthParameters(userName: String, password: String) -> Bool
}

//MARK: Login
/// Can have optional a domain url textfield to as for server URL to use which can be saved in a shared class and used with every request. If emply can go with toke server url as default.
final class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    private let viewModel: LoginViewModel
    private var loadingView: LoadingIndicator!
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldPadding()
        addActivityIndicator()
    }
    
    /// set up all textfields padding
    private func setupTextFieldPadding() {
        userEmailTextField.setLeftPaddingPoints(Constants.textPadding)
        userPasswordTextField.setLeftPaddingPoints(Constants.textPadding)
        userEmailTextField.setRightPaddingPoints(Constants.textPadding)
        userPasswordTextField.setRightPaddingPoints(Constants.textPadding)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        // check if username/password field is empty. For better experience we can also add regex to check email format
        let isLoginFieldsValid = validateAuthParameters(userName: userEmailTextField.text ?? GlobalConstants.emptyString, password: userPasswordTextField.text ?? GlobalConstants.emptyString)
        // if valid then continue
        if isLoginFieldsValid {
            viewModel.loginUser()
            bindViewModelEvent()
            displayActivityIndicator(true)
        }
    }
    
    ///  handling login success or failure cases.
    private func bindViewModelEvent() {
        viewModel.onLoginSuccess = { [weak self] in
            guard let self else { return }
            
            if self.viewModel.loginResponse?.msResponse == nil {
                print("login failure")
            } else {
                print("login success")
                saveTokenToUserDefault()
                navigateToFoldersListVC()
            }
            displayActivityIndicator(false)
        }
        
        viewModel.onLoginFailure = { [weak self] error in
            guard let self else { return }
            print(error)
            print("login failure")
            displayActivityIndicator(false)
        }
    }
    
    /// Save login related information after successful login to use later. For demo used userdefaults but to secure the content we can use keychain storage to save token
    private func saveTokenToUserDefault() {
        guard let loginResponse = viewModel.loginResponse, let mResponse = loginResponse.msResponse, let token = mResponse.user?.token else {
            return
        }
        LoginManager.shared.setToken(token)
        LoginManager.shared.isLoggedIn = true
    }
    
    /// Navigation to folder list
    private func navigateToFoldersListVC() {
        // calling UI changes on main thread
        DispatchQueue.main.async {
            let viewModel: FolderListViewModel = FolderListViewModel (
                networkService: DefaultNetworkService()
            )
            let folerListVC = FilesListViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(folerListVC, animated: true)
        }
    }
}

//MARK: activity indicator
private extension LoginViewController {
    func addActivityIndicator() {
        // Create the activity indicator
        loadingView = LoadingIndicator()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// decide activity indicator display status
    /// - Parameter status: boolean
    func displayActivityIndicator(_ status: Bool) {
        DispatchQueue.main.async {
            if status {
                self.loadingView.startLoading()
            } else {
                self.loadingView.stopLoading()
            }
        }
    }
}

//MARK: AuthManager implementation
extension LoginViewController: AuthManager {
    func validateAuthParameters(userName: String, password: String) -> Bool {
        guard !userName.isEmpty, !password.isEmpty else { return false}
        viewModel.setCreds(userName: userName, password: password)
        return true
    }
}

//MARK: constants
private extension LoginViewController {
    enum Constants {
        static let textPadding: CGFloat = 10.0
    }
}
