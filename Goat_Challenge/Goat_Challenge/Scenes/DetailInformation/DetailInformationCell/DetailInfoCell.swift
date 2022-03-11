//
//  DetailInfoCell.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import UIKit

class DetailInfoCell: UITableViewCell {
    
    static let identifier: String = "DetailInfoCell"
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private func setupSubview() {
        contentView.addSubview(stackContainerView)
        stackContainerView.addArrangedSubview(titleLabel)
        stackContainerView.addArrangedSubview(descriptionLabel)
        stackContainerView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    private lazy var stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}

// MARK: - DetailInfoCell Delegate
extension DetailInfoCell: DetailInfoCellDelegate {
    func display(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
