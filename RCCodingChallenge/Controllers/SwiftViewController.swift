//
//  SwiftViewController.swift
//  RCCodingChallenge
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {
    
    // MARK: - Instance Vars
    
    lazy var sharedManager: RCManager? = {
        guard let sharedManager = RCManager.sharedManager() as? RCManager else {
            return nil
        }
        
        return sharedManager;
    }()
    
    // MARK: - Subviews
    
    @IBOutlet var displayLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func getLocationButtonTapped(_ sender: UIButton) {
        // use capture list to prevent retain cycles on escaping closure
        sharedManager?.currentLocation(handler: { [weak self] (location, error) in
            if let error = error {
                self?.displayLabel.text = error.localizedDescription
                return print(error.localizedDescription)
            }
            
            guard let location = location else { return }
            
            self?.displayLabel.text = "Lng: \(location.coordinate.longitude), Lat: \(location.coordinate.latitude)"
        })
    }
    
    @IBAction func getBatteryInfoButtonTapped(_ sender: UIButton) {
        // technically doesn't need capture list because closure never escapes
        // but usually we wouldn't know implementation details of framework
        sharedManager?.batteryInfo(handler: { [weak self] (isPluggedIn, batteryLevel, error) in
            if let error = error {
                self?.displayLabel.text = error.localizedDescription
                return print(error.localizedDescription)
            }
            
            self?.displayLabel.text = "Is Plugged In: \(isPluggedIn ? "Yes" : "No") Battery Level: \(batteryLevel)"
        })
    }
    
    @IBAction func getWeatherButtonTapped(_ sender: UIButton) {
        // technically doesn't need capture list because closure never escapes
        // but usually we wouldn't know implementation details of framework
        sharedManager?.weatherForCurrentLocation(handler: { [weak self] (weatherInfo, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.displayLabel.text = error.localizedDescription
                }
                return print(error.localizedDescription)
            }
            
            guard let weatherInfo = weatherInfo else { return }
            
            DispatchQueue.main.async {
                self?.displayLabel.text = "\(weatherInfo.cityName) has a current forecast of \(weatherInfo.currentWeather) with a temperature of \(weatherInfo.temperature)"
            }
        })
    }
}
