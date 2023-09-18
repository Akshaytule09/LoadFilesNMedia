//
//  FolderDetailsViewController.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import UIKit
import QuickLook

//MARK: class implementation
class FolderDetailsViewController: UIViewController {
    
    @IBOutlet weak var folderDetailsTableview: UITableView!
    
    private let viewModel: FolderDetailstViewModel
    private var loadingView: LoadingIndicator!
    
    init(viewModel: FolderDetailstViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        addActivityIndicator()
        viewModel.fetchFoldersDetails()
        bindViewModelEvent()
        displayActivityIndicator(true)
    }
    
    /// configure navigation bar attributes
    private func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        title = Constants.screenTitle
    }
    
    /// configure view and tableview
    private func configureView() {
        view.backgroundColor = .white
        
        folderDetailsTableview.separatorStyle = .none
        folderDetailsTableview.tableFooterView = UIView()
        folderDetailsTableview.rowHeight = Constants.rowHeight
        setTableViewDelegateDataSource()
        folderDetailsTableview.register(
            FilesAndFolderCell.self,
            forCellReuseIdentifier: FilesAndFolderCell.cellIdentifier
        )
    }
    
    /// set delegate and data source for tableview
    private func setTableViewDelegateDataSource() {
        folderDetailsTableview.delegate = self
        folderDetailsTableview.dataSource = self
    }
    
    /// completion handlers for success and failure
    func bindViewModelEvent() {
        viewModel.onFetchFolderSuccess = { [weak self] in
            guard let self else { return }
            displayActivityIndicator(false)
            if self.viewModel.foldersDetailsResponse?.msResponse == nil {
                print("failed to fetch folder details")
            } else {
                print("success to fetch folder details")
                DispatchQueue.main.async {
                    self.folderDetailsTableview.reloadData()
                }
            }
        }
        
        viewModel.onFetchFolderFailure = { [weak self] error in
            guard let self else { return }
            displayActivityIndicator(false)
            print(error)
            print("failed to fetch folder details")
        }
    }
}

//MARK: tableview delegate, datasource implementaion
extension FolderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.files.count
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
        navigateToFoldersDetailListVC(currentIndex: indexPath, withFiles: viewModel.files)
    }
    
    /// navigate to folder details to view resources
    /// - Parameters:
    ///   - currentIndex: current selected index to view
    ///   - withFiles: files array to load next or previous file on swipe action
    private func navigateToFoldersDetailListVC(currentIndex: IndexPath, withFiles: [Files]) {
        DispatchQueue.main.async {
            let viewModel = PreviewViewModel(files: withFiles, currentIndex: currentIndex.row)
            let folerListVC = PreviewViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(folerListVC, animated: true)
        }
    }
}

//MARK: activity indicator
extension FolderDetailsViewController {
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

//MARK: file constants
extension FolderDetailsViewController {
    enum Constants {
        static let screenTitle = "Folder Detail"
        static let rowHeight = 120.0
    }
}
