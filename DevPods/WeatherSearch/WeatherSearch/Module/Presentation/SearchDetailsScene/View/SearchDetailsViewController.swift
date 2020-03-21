//
//  SearchDetailsViewController.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import UIKit

class SearchDetailsViewController: ViewController {
    
    let searchDetailsViewModel: SearchDetailsViewModel
    
    init(viewModel:SearchDetailsViewModel){
        self.searchDetailsViewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        view = SearchDetailsRootView(viewModel: searchDetailsViewModel)
    }
    
}
