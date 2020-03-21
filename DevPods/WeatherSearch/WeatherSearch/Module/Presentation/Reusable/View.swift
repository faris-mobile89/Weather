//
//  View.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation

class View: UIView {
    
    // MARK: - Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Unsupported")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Nib is not supported")
    }
}
