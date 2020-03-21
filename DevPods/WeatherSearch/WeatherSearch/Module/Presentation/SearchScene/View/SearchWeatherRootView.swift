//
//  SearchWeatherRootView.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation
import SnapKit

class SearchWeatherRootView: View {
    
    let viewModel: SearchWeatherViewModel
    var hierarchyNotReady = true
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    let labelHint: UILabel = {
        let label = UILabel()
        //TODO: use string file
        label.text = """
        *Type multiple city names sepereated by comma, e.g. Dubai, Paris, London.
        \nMinimum 3 cities, Maximum 7 cities
        """
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font =  UIFont(name: "Avenir-Light", size: 17)!
        label.numberOfLines = 0
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Search", for: .normal)
        button.backgroundColor = Style.Color.disabledButtonColor
        button.layer.cornerRadius = 8
        button.setBackgroundColor(color: Style.Color.disabledButtonColor, forState: .disabled)
        button.setBackgroundColor(color: Style.Color.buttonColor, forState: .normal)
        button.setTitleColor(.black, for: .disabled)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)!
        button.isEnabled = false
        return button
    }()
    
    init(frame: CGRect = .zero, viewModel: SearchWeatherViewModel) {
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
        
        searchButton.addTarget(self,
                               action: #selector(searchButtonSelector),
                               for: .touchUpInside)
        searchBar.delegate = self
        hierarchyNotReady = false
    }
    
    func configHierarchy(){
        addSubview(searchBar)
        addSubview(labelHint)
        addSubview(searchButton)
    }
    
    func configConstraints(){
        
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        labelHint.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(searchBar.snp.bottom).offset(30)
        }
        
        searchButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(60)
        }
    }
}

extension SearchWeatherRootView{
    @objc func searchButtonSelector(){
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        viewModel.didSearch(query: searchText)
    }
}


extension SearchWeatherRootView: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        changeButtonState()
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        changeButtonState()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchButtonSelector()
    }
    
    func changeButtonState(){
        guard let query = searchBar.text else {return}
        searchButton.isEnabled = !query.isEmpty
    }
    
}
