//
//  DetailWeatherViewController.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/10/22.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    var configurator: DetailWeatherConfiguratorDelegate!
    var presenter: DetailWeatherPresenterDelegate!
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(self)
        presenter.viewDidLoad()
        setupSubview()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

// MARK: - UITableView DataSource
extension DetailWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCell.identifier) as! DetailInfoCell
        presenter.configureDetailWeatherCell(cell: cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
}

// MARK: - UITableView Delegate
extension DetailWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}


// MARK: - DetailWeatherView
extension DetailWeatherViewController: DetailWeatherView {
    func reloadTableView() {
        tableView.reloadData()
    }
}


// MARK: - Private Extension
private extension DetailWeatherViewController {
    func setupSubview() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        tableView.register(DetailInfoCell.self, forCellReuseIdentifier: DetailInfoCell.identifier)
    }
}
