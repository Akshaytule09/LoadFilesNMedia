//
//  PreviewViewModel.swift
//  FilesTracker
//
//  Created by Akshay Tule on 22/08/23.
//

import Foundation

//MARK: Preview model
class PreviewViewModel {
    
    private(set) var files: [Files]
    private(set) var currentIndex: Int
    
    init(files: [Files], currentIndex: Int) {
        self.files = files
        self.currentIndex = currentIndex
    }
    
    /// increament the index to show the next resource
    func increamentCurrentIndex() {
        currentIndex = (currentIndex + Constant.one) % files.count
    }
    
    /// decreament in index to show previous resource
    func decreamentCurrentIndex() {
        currentIndex = (currentIndex - Constant.one + files.count) % files.count
    }
    
    /// get file at current index to be displayed
    /// - Returns: file object
    func getFileAtCurrentIndex() -> Files? {
        guard files.count > currentIndex else { return nil }
        return files[currentIndex]
    }
}

//MARK: Download resource to documents directory
extension PreviewViewModel {
    func downloadRemoteFile(at remoteURL: String, fileName: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
        let itemUrl = URL(string: remoteURL)
        
        // create document folder url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileName)
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            debugPrint("The file already exists at path")
            completion(true, destinationUrl)
            
            // if the file doesn't exist
        } else {
            
            URLSession.shared.downloadTask(with: itemUrl!, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    // after downloading file move it to destination url
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    print("File moved to documents folder")
                    completion(true, destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            }).resume()
        }
    }
}

extension PreviewViewModel {
    enum Constant {
        static let one = 1
    }
}
