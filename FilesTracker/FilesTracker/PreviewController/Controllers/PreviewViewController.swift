//
//  PreviewViewController.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import UIKit
import WebKit
import UniformTypeIdentifiers

//MARK: ViewController Setup
class PreviewViewController: UIViewController {
    private var viewModel: PreviewViewModel
    private var webView: WKWebView?
    private var loadingView: LoadingIndicator!
    
    init(viewModel: PreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
        addSwipeGestures()
        addActivityIndicator()
        getFileAndStartDownload()
    }
    
    /// setup WKWebview
    private func setupWebview() {
        webView = WKWebView()
        guard let webviewcontroller = webView else { return }
        webviewcontroller.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webviewcontroller)
        
        let padding: CGFloat = .zero
        NSLayoutConstraint.activate([
            webviewcontroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            webviewcontroller.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            webviewcontroller.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            webviewcontroller.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}

//MARK: File Handler
private extension PreviewViewController {
    /// get the file and start downloading
    func getFileAndStartDownload() {
        guard let fileToLoad = viewModel.getFileAtCurrentIndex() else { return }
        downloadFile(at: fileToLoad)
    }
    
    /// File download
    /// - Parameter file: file object with url to download
    func downloadFile(at file: Files) {
        if let downloadURL = file.shortUrl, let fileName = file.filename {
            displayActivityIndicator(true)
            viewModel.downloadRemoteFile(at: downloadURL, fileName: fileName) { [weak self] success, destinationURL in
                guard let self else { return }
                displayActivityIndicator(false)
                if let localURL = destinationURL {
                    openFile(localURL)
                }
            }
        }
    }
    
    /// Load WKWeview with the file downloaded
    /// - Parameter documentUrl: document directory URL of the file downloaded.
    func openFile(_ documentUrl: URL) {
        let request = URLRequest(url: documentUrl)
        DispatchQueue.main.async {
            guard let webView = self.webView else { return }
            webView.load(request)
        }
    }
}

//MARK: Swipe to Load
private extension PreviewViewController {
    /// add swipe gestures to the view to load next and previous file
    func addSwipeGestures() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
    }
    
    /// swipe
    /// - Parameter gesture: gesture
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            showNextFile()
        case .right:
            showPreviousFile()
        default:
            break
        }
    }
    
    func showNextFile() {
        viewModel.increamentCurrentIndex()
        getFileAndStartDownload()
    }
    
    func showPreviousFile() {
        viewModel.decreamentCurrentIndex()
        getFileAndStartDownload()
    }
}

//MARK: Activity Indicator
extension PreviewViewController {
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

//MARK: MIME Type extension
extension URL {
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}

// @note: incase the files does not load in wkwebview then we can load it by specifying mimeType. Had added this first but files started loading.
//  if let myURL = URL(string:localURL.absoluteString) {
//      self.webView?.load(request)
//      if let data = try? Data(contentsOf: myURL) {
//      self.webView?.load(data, mimeType: myURL.mimeType(), characterEncodingName: "", baseURL: myURL)
//    }
//  }
