//
//  Alert.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation

public protocol UIAlert {}
public extension UIAlert where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
