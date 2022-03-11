//
//  WeatherTableHeaderView.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import UIKit

class WeatherTableHeaderView: UITableViewHeaderFooterView {

    static let identifier = "WeatherTableHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Subviews
    private func setupSubview() {
        self.contentView.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(cityLabel)
        stackViewContainer.addArrangedSubview(currentTempLabel)
        stackViewContainer.addArrangedSubview(descriptionLabel)
        stackViewContainer.addArrangedSubview(minMaxLabel)
        stackViewContainer.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private lazy var stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5.0
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(30)
        return label
    }()
    
    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minMaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - WeatherTableHeaderView Delegate
extension WeatherTableHeaderView: WeatherTableHeaderViewDelegate {
    func display(city: String, current: Int, description: String, max: Int, min: Int) {
        cityLabel.text = city
        currentTempLabel.text = "\(current)\u{00B0}"
        descriptionLabel.text = description
        minMaxLabel.text = "L: \(min)\u{00B0} H: \(max)\u{00B0}"
    }
}
