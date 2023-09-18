//
//  FolderListViewModel.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

protocol FolderListViewModelProtocol: AnyObject, ErrorHanler {
    var folders: [Folders] { set get }
    func fetchFolders()
}

protocol ErrorHanler {
    var completion: ((_ success: Bool, _ error: Error?) -> Void)? { set get }
}

final class FolderListViewModel: FolderListViewModelProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var foldersResponse: FilesAndFolderResponse?
    var folders: [Folders] = []
    var completion: ((Bool, Error?) -> Void)?
    
    var myDriveFolderResponse: FilesAndFolderResponse?
    var files: [Files] = []
    
    /// make API call to fetch root folders
    func fetchFolders() {
        let request = RootFolderRequest(bodyParams: [:])
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let folderResponse):
                // success to get folders
                guard let mResponse = folderResponse.msResponse  else {
                    self.completion?(false, nil)
                    return
                }
                self.foldersResponse = folderResponse
                self.folders = folderResponse.msResponse?.folders ?? []
                self.completion?(true, nil)
            case .failure(let error):
                // error to get folders
                self.completion?(false, error)
            }
        }
    }
    
    ///  API call for getting details of my drive folder.
    func fetchMyDriveFolderDetails() {
        let myDriveFolder = foldersResponse?.msResponse?.folders?.filter { $0.name == Constants.myDrive }
        let request = MyDriveFolderRequest(folderID: myDriveFolder?.first?.id ?? GlobalConstants.emptyString, bodyParams: [:])
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let folderResponse):
                self.myDriveFolderResponse = folderResponse
                self.files = folderResponse.msResponse?.files ?? []
                self.completion?(true, nil)
            case .failure(let error):
                self.completion?(false, error)
            }
        }
    }
}

extension FolderListViewModel {
    enum Constants {
        static let myDrive = "My Drive"
    }
}
