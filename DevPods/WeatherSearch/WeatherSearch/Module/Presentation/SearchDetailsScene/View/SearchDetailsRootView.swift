//
//  SearchDetailsRootView.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation
import SnapKit

class SearchDetailsRootView: View {
    
    let viewModel: SearchDetailsViewModel
    var hierarchyNotReady = true
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(cellType: CityWeatherViewCell.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = 178
        return tableView
    }()
    
    init(frame: CGRect = .zero, viewModel: SearchDetailsViewModel) {
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
        tableView.dataSource = self
        hierarchyNotReady = false
    }
    
    func configHierarchy(){
        addSubview(tableView)
    }
    
    func configConstraints(){
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}


extension SearchDetailsRootView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecast.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueResuableCell(withCellType: CityWeatherViewCell.self, forIndexPath: indexPath)
        if let forecast = viewModel.forecast.value?.forecasts[indexPath.row] {
            cell.bindWithForecast(forecast)
        }
        return cell
    }
    
    
}
