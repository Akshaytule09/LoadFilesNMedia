//
//  FilesListViewController.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import UIKit

//MARK: class implemenation
class FilesListViewController: UIViewController {
    
    @IBOutlet weak var foldersTableView: UITableView!
    
    private let viewModel: FolderListViewModel
    private var loadingView: LoadingIndicator!
    
    init(viewModel: FolderListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureView()
        addActivityIndicator()
        fetchResourses()
    }
    
    /// Navigation controller attributes
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = false
        title = Constants.screenTitle
    }
    
    /// View configuration
    private func configureView() {
        view.backgroundColor = .white
        
        foldersTableView.separatorStyle = .none
        foldersTableView.tableFooterView = UIView()
        foldersTableView.rowHeight = Constants.rowHeight
        setTableViewDelegateDataSource()
        foldersTableView.register(
            FilesAndFolderCell.self,
            forCellReuseIdentifier: FilesAndFolderCell.cellIdentifier
        )
    }
    
    private func setTableViewDelegateDataSource() {
        foldersTableView.delegate = self
        foldersTableView.dataSource = self
    }
}

//MARK: UITableview datasource and delegate methods
extension FilesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.myDriveFolderResponse?.msResponse?.files?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilesAndFolderCell.cellIdentifier, for: indexPath) as? FilesAndFolderCell else {
            return UITableViewCell()
        }
        
        let files = viewModel.files[indexPath.row]
        cell.bindViewWith(file: files)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = viewModel.files[indexPath.row]
        guard let fileID = file.id else { return }
        navigateToFoldersDetailListVC(folderID: fileID)
    }
    
    /// navigation to folder details list
    /// - Parameter folderID: folder ID
    private func navigateToFoldersDetailListVC(folderID: Int) {
        DispatchQueue.main.async {
            let viewModel: FolderDetailstViewModel = FolderDetailstViewModel (
                networkService: DefaultNetworkService(),
                folderID: folderID
            )
            let folerListVC = FolderDetailsViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(folerListVC, animated: true)
        }
    }
}

//MARK: API sequence
extension FilesListViewController {
    /// API call in sequence to getch
    func fetchResourses() {
        let group = DispatchGroup()
        
        // Root Folder block operation
        let rootFolderOperation = BlockOperation()
        rootFolderOperation.addExecutionBlock {
            group.enter()
            self.displayActivityIndicator(true)
            self.viewModel.fetchFolders()
            rootFolderOperationEventLister()
            group.wait()
        }
        
        // My Drive Files block operation
        let mydriveFoldersOperation = BlockOperation()
        mydriveFoldersOperation.addExecutionBlock {
            self.displayActivityIndicator(true)
            self.viewModel.fetchMyDriveFolderDetails()
            mydriveFoldersOperationEventListener()
        }
        
        // adding dependency on rootFolder structure API
        mydriveFoldersOperation.addDependency(rootFolderOperation)
        
        // creating the operation queue
        let operationQueue = OperationQueue()
        operationQueue.addOperation(mydriveFoldersOperation)
        operationQueue.addOperation(rootFolderOperation)
        
        func rootFolderOperationEventLister() {
            viewModel.completion = { [weak self] (success, error) in
                guard let self else { return }
                self.displayActivityIndicator(false)
                if success {
                    print("success to fetch root folder")
                } else {
                    print("failure to fetch root folder")
                }
                group.leave()
            }
        }
        
        func mydriveFoldersOperationEventListener() {
            viewModel.completion = { [weak self] (success, error) in
                guard let self else { return }
                self.displayActivityIndicator(false)
                if success {
                    print("success to fetch my drive folder")
                    DispatchQueue.main.async {
                        self.foldersTableView.reloadData()
                    }
                } else {
                    print("failed to fetch my drive folder")
                }
            }
        }
    }
}

//MARK: activity indicator
extension FilesListViewController {
    func addActivityIndicator() {
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

//MARK: File constants
extension FilesListViewController {
    enum Constants {
        static let screenTitle = "File and Folder"
        static let rowHeight = 120.0
    }
}
