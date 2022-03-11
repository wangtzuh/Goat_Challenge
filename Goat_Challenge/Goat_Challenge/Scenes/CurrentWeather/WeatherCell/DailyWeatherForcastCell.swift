//
//  DailyWeatherCell.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import UIKit
import AlamofireImage

class DailyWeatherForcastCell: UITableViewCell {
    
    static let identifier = "DailyWeatherForcastCel"

    // MARK: - UITableView lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private func setupSubview() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(dateLabel)
        containerStackView.addArrangedSubview(dateLabel)
        containerStackView.addArrangedSubview(icon)
        containerStackView.addArrangedSubview(maxTempLabel)
        containerStackView.addArrangedSubview(minTempLabel)
        containerStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - DailyWeatherForcastCell Delegate
extension DailyWeatherForcastCell: DailyWeatherForcastCellDelegate {
    func display(date: String, iconUrl: String, minTemp: Int, maxTemp: Int) {
        dateLabel.text = date
        minTempLabel.text = "L: \(minTemp)\u{00B0}"
        maxTempLabel.text = "M: \(maxTemp)\u{00B0}"
        
        guard let url = URL(string: iconUrl) else {
            return
        }
        icon.af.setImage(withURL: url)
    }
}
