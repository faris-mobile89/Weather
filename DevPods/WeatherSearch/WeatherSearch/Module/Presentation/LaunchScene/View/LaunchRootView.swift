//
//  LaunchRootView.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation
import SnapKit

class LaunchRootView: View {
    
    let viewModel: LaunchViewModel
    var hierarchyNotReady = true
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = LiteralBundleImage(imageLiteralResourceName: "header").image
        return imageView
    }()
    
    let searchByCityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Search By City", for: .normal)
        button.backgroundColor = Style.Color.buttonColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)!
        return button
    }()
    
    let currentCityWeatherButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Current City Weather", for: .normal)
        button.backgroundColor = Style.Color.buttonColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)!
        return button
    }()
    
    init(frame: CGRect = .zero, viewModel: LaunchViewModel) {
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
        
        searchByCityButton.addTarget(viewModel,
                               action: #selector(LaunchViewModel.showSearchWeatherView),
                               for: .touchUpInside)
        currentCityWeatherButton.addTarget(viewModel,
                               action: #selector(LaunchViewModel.showCurrentCityView),
                               for: .touchUpInside)
        hierarchyNotReady = false
    }
    
    func configHierarchy(){
        addSubview(headerImageView)
        addSubview(searchByCityButton)
        addSubview(currentCityWeatherButton)
    }
    
    func configConstraints(){
        
        headerImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(296)
        }
        
        searchByCityButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.center.equalToSuperview()
            make.height.equalTo(60)
        }
        
        currentCityWeatherButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(searchByCityButton.snp.bottom).offset(25)
            make.height.equalTo(60)
        }
    }
}
