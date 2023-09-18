//
//  LoadingIndicator.swift
//  FilesTracker
//
//  Created by Akshay Tule on 21/08/23.
//

import UIKit

class LoadingIndicator: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        isHidden = true

        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func startLoading() {
        isHidden = false
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
