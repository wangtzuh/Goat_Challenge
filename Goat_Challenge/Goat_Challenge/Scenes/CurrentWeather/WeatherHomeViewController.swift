//
//  WeatherHomeViewController.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/9/22.
//

import UIKit

class WeatherHomeViewController: UIViewController {
        
    var configurator: WeatherHomeConfiguratorDelegate!
    var presenter: WeatherHomePresenterDelegate!
    
    // MARK: - ViewController Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        
        configurator.configure(self)
        presenter.viewDidLoad()
    }
    
    // MARK: - Subview
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var settingBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(displayPermissionAlert))
        return item
    }()
}

// MARK: - UITableViewDataSource
extension WeatherHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherForcastCell.identifier) as! DailyWeatherForcastCell
            presenter.configureDailyWeatherCell(cell: cell, for: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.configureSectionTitleFor(section: section)
    }
}

// MARK: - UITableViewDelegate
extension WeatherHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherTableHeaderView.identifier) as! WeatherTableHeaderView
            presenter.configureWeatherTableHeader(header: header)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter.heightForHeader(in: section)
    }
}

// MARK: - WeatherHomeView Delegate
extension WeatherHomeViewController: WeatherHomeView {
    func animateIndicatorView() {
        indicator.startAnimating()
    }
    
    func reloadTableView() {
        indicator.stopAnimating()
        tableView.reloadData()
    }
    
    func routeToDetailPage(with detail: DailyForcastData) {
        let configurator = DetailWeatherConfigurator(detail)
        let viewController = DetailWeatherViewController()
        viewController.configurator = configurator
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private Extension
private extension WeatherHomeViewController {
    func setupSubview() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.width.top.height.equalToSuperview()
        }
        
        tableView.register(DailyWeatherForcastCell.self, forCellReuseIdentifier: DailyWeatherForcastCell.identifier)
        tableView.register(WeatherTableHeaderView.self, forHeaderFooterViewReuseIdentifier: WeatherTableHeaderView.identifier)
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        navigationItem.rightBarButtonItem = settingBarButton
    }
    
    @objc func displayPermissionAlert() {
        let alert = UIAlertController(title: nil, message: "Allow Location Service", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { [self] _ in
            self.presenter.didSelectAllowForLocation()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

