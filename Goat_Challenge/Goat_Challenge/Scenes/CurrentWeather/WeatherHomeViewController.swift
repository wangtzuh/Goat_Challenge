//
//  WeatherHomeViewController.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import UIKit

class WeatherHomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
    }
    
    // MARK: - private methods
    private func configureSubview() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.width.top.height.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension WeatherHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
