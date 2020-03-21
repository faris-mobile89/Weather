//
//  CurrentCityWeatherRootView.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation
import SnapKit

class CurrentCityWeatherRootView: View {
    
    let viewModel: CurrentCityWeatherViewModel
    var hierarchyNotReady = true
    
    let header:UIView = {
        return UIView()
    }()
    
    let labelCityName: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font =  UIFont(name: "Avenir-Light", size: 45)!
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(cellType: CityDayWeatherViewCell.self)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 87
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    init(frame: CGRect = .zero, viewModel: CurrentCityWeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard hierarchyNotReady else {
            return
        }
        backgroundColor = .white
        configHierarchy()
        configConstraints()
        activityIndicatorView.startAnimating()
        tableView.dataSource = self
        viewModel.forecast.observe(on: self) { [weak self] forecast in
            guard forecast != nil else {return}
            self?.activityIndicatorView.stopAnimating()
            self?.labelCityName.text = forecast?.cityName
            self?.tableView.reloadData()
        }
        hierarchyNotReady = false
    }
    
    func configHierarchy(){
        addSubview(tableView)
        header.addSubview(labelCityName)
        tableView.tableHeaderView = header
        tableView.backgroundView = activityIndicatorView
    }
    
    func configConstraints(){
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        header.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalToSuperview()
        }
        
        labelCityName.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension CurrentCityWeatherRootView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecast.value?.daysForecast.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withCellType: CityDayWeatherViewCell.self, forIndexPath: indexPath)
        if let forecast = viewModel.forecast.value?.daysForecast[indexPath.row] {
            cell.bindWith(Forecast: forecast)
        }
        return cell
    }
    
    
}
