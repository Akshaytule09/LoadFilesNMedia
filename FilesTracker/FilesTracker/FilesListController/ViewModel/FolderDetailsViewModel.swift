//
//  FolderDetailsViewModel.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import Foundation

protocol FolderDetailsViewModelProtocol: AnyObject {
    var files: [Files] { set get }
    var onFetchFolderSuccess: (() -> Void)? { set get }
    var onFetchFolderFailure: ((Error) -> Void)? { set get }
    func fetchFoldersDetails()
}

final class FolderDetailstViewModel: FolderDetailsViewModelProtocol {
    
    private let networkService: NetworkService
    private let folderID: Int
    
    init(networkService: NetworkService, folderID: Int) {
        self.networkService = networkService
        self.folderID = folderID
    }
    
    var foldersDetailsResponse: FilesAndFolderResponse?
    var onFetchFolderSuccess: (() -> Void)?
    var onFetchFolderFailure: ((Error) -> Void)?
    
    var files: [Files] = []
    
    /// API call  to fetch folder details for folders present inside the my drive
    func fetchFoldersDetails() {
        let request = FolderDetailsRequest(folderID: folderID, bodyParams: [:])
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let folderResponse):
                // success
                self.foldersDetailsResponse = folderResponse
                self.files = folderResponse.msResponse?.files ?? []
                self.onFetchFolderSuccess?()
            case .failure(let error):
                // failure
                self.onFetchFolderFailure?(error)
            }
        }
    }
}
