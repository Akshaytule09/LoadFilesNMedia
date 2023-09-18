//
//  FilesAndFolderCell.swift
//  FilesTracker
//
//  Created by Akshay Tule on 20/08/23.
//

import UIKit

//MARK: class implementation
final class FilesAndFolderCell: UITableViewCell {
    
    static let cellIdentifier = Constants.cellIdentifier
    
    private let container = UIView()
    private let fileImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        addContainerView()
        setupImageView()
        addTitleLabel()
        addSubTitleLabel()
        addStackViewAndSetConstraints()
    }
    
    ///  add main container view
    private func addContainerView() {
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        contentView.addSubview(fileImageView)
    }
    
    /// add image view
    private func setupImageView() {
        fileImageView.clipsToBounds = true
        fileImageView.layer.cornerRadius = Constants.imageCornerRadius
        fileImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// add title label
    private func addTitleLabel() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = .zero
    }
    
    /// add subtitle label
    private func addSubTitleLabel() {
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// add stackview and add constraints to all UI elements
    private func addStackViewAndSetConstraints() {
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            fileImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.constantTen),
            fileImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.constantTen),
            fileImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constants.constantTen),
            fileImageView.widthAnchor.constraint(equalToConstant: Constants.constantNinty),
            
            labelStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.constantTen),
            labelStackView.leadingAnchor.constraint(equalTo: fileImageView.trailingAnchor, constant: Constants.constantTen),
            labelStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.constantTen),
            labelStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constants.constantTen)
        ])
    }
    
    /// bind cell with data on cell load
    /// - Parameter file: file to be loaded
    func bindViewWith(file: Files) {
        titleLabel.text = file.filename
        if let isFolder = file.isFolder, isFolder == true {
            descriptionLabel.text = GlobalConstants.emptyString
        } else {
            descriptionLabel.text = Constants.sizeKey + String(describing: file.size ?? .zero)
        }
        
        ImageClient.shared.setImage(from: file.previewUrl2 ?? GlobalConstants.emptyString, placeholderImage: nil) { [weak self] image in
            guard let self else { return }
            fileImageView.image = image
        }
    }
}

//MARK: File constants
extension FilesAndFolderCell {
    enum Constants {
        static let sizeKey = "Size: "
        static let imageCornerRadius: CGFloat = 4
        static let constantTen: CGFloat = 10
        static let constantNinty: CGFloat = 90
        static let cellIdentifier = "FilesAndFolderCellIdentifier"
    }
}

