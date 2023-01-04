//
//  ViewController.swift
//  WeatherAppSwift
//
//  Created by Emre ÖZKÖK on 3.01.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let rootStackView = UIStackView()
    //search
    let searchStackView = UIStackView()
    var backgroundImage = UIImageView()
    var locationButton = UIButton()
    var searchButton = UIButton()
    var searchTextField = UITextField()
    
    //root
    var conditionImage = UIImageView()
    var temperatureLbl = UILabel()
    var cityLbl = UILabel()
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        weatherManager.delegate = self
        style()
        layout()
        searchButton.addTarget(self, action: #selector(makeSearch), for: .touchUpInside)
        
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @objc func makeSearch(){
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            print("no item...")
            textField.placeholder = "Type City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather (_: WeatherManager ,weather: WeatherModel){
        cityLbl.text = weather.cityName
        conditionImage.image = UIImage(systemName: weather.conditionName)
        temperatureLbl.text = weather.tempString
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - layoutSection
extension WeatherViewController{
    
    func style(){
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "day")
        backgroundImage.contentMode = .scaleAspectFill
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10
        //searh
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .right
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        searchTextField.autocapitalizationType = .words
        searchTextField.delegate = self
        
        //Root
        conditionImage.translatesAutoresizingMaskIntoConstraints = false
        conditionImage.image = UIImage(systemName: "sun.max")
        conditionImage.tintColor = .label
        
        temperatureLbl.translatesAutoresizingMaskIntoConstraints = false
        temperatureLbl.font = UIFont.systemFont(ofSize: 80)
        temperatureLbl.attributedText = makeTemperatureText(with: "21")
        
        
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.text = "Ankara"
        cityLbl.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    private func makeTemperatureText(with temperature: String) -> NSAttributedString{
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 100)
        
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.systemFont(ofSize: 80)
        
        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "°C", attributes: plainTextAttributes))
        return text
    }
    
    func layout(){
        view.addSubview(backgroundImage)
        view.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(searchStackView)
        rootStackView.addArrangedSubview(conditionImage)
        rootStackView.addArrangedSubview(temperatureLbl)
        rootStackView.addArrangedSubview(cityLbl)
        
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
      
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1),
            
            searchStackView.widthAnchor.constraint(equalTo: rootStackView.widthAnchor),
            
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            conditionImage.widthAnchor.constraint(equalToConstant: 120),
            conditionImage.heightAnchor.constraint(equalToConstant: 120),
            
        ])
    }
}
