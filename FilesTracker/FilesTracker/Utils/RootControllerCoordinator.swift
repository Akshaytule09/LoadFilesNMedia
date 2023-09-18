//
//  RootControllerCoordinator.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import UIKit

protocol RootViewControllerProvider {
    var rootViewController: UIViewController { get }
}

//MARK: decide the rootview controller to be loaded as per login status
class RootControllerCoordinator: RootViewControllerProvider {
    var rootViewController: UIViewController {
        if LoginManager.shared.isLoggedIn {
            // user is logged in
            let viewModel: FolderListViewModel = FolderListViewModel (
                networkService: DefaultNetworkService()
            )
            return FilesListViewController(viewModel: viewModel)
        } else {
            // user is logged out
            let viewModel: LoginViewModel = LoginViewModel(
                networkService: DefaultNetworkService()
            )
            return LoginViewController(viewModel: viewModel)
        }
    }
}
