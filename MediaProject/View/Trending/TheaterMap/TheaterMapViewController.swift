//
//  TheaterMapViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class TheaterMapViewController: UIViewController {

    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    
    let buttonImageSize: CGFloat = 17
    
    let theaterList = TheaterList().mapAnnotations
    
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        self.configButton(button, image: "xmark", imageSize: buttonImageSize)
        
        return button
    }()
    
    lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        self.configButton(button, image: "location", imageSize: buttonImageSize)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        locationManager.delegate = self
        mapView.delegate = self
        
        configLayoutConstraints()
        
        checkDeviceLocationAuthorization()
        
        setRegion(center: defaultLocation)
    }
    
    // MARK: - Actions
    
    @objc func tappedCloseButton() {
        dismiss(animated: true)
    }
    
    @objc func tappedCurrentLocationButton() {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Helpers
    
    func setRegion(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
            
        mapView.setRegion(region, animated: true)
    }
    
    func convertTheaterToAnnotation(theater: Theater) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = theater.location
        annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
        
        return annotation
    }
    
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("사용자 기기 위치 서비스 꺼짐")
            }
        }
    }

    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("restricted")
            
        case .denied:
            print("denied")
            showLocationSettingAlert()
            
        case .authorizedAlways:
            print("authorizedAlways")
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
            
        case .authorized:
            print("authorized")
            
        @unknown default:
            print("unknown default")
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

extension TheaterMapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegion(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - MKMapViewDelegate

extension TheaterMapViewController: MKMapViewDelegate {
    
}

// MARK: - Layout

extension TheaterMapViewController {
    func configLayoutConstraints() {
        let viewList = [mapView, closeButton, currentLocationButton]
        for item in viewList {
            view.addSubview(item)
        }
        
        mapView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.leading.equalTo(mapView).offset(8)
        }
        
        currentLocationButton.addTarget(self, action: #selector(tappedCurrentLocationButton), for: .touchUpInside)
        currentLocationButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(mapView).inset(8)
        }
    }
    
    func configButton(_ button: UIButton, image: String, imageSize: CGFloat) {
        let inset: CGFloat = 10
        
        var config = UIButton.Configuration.plain()
            
        config.image = UIImage(systemName: image, withConfiguration: UIImage.SymbolConfiguration(pointSize: imageSize))
        
        config.baseForegroundColor = .black
        config.background.backgroundColor = .white
        config.cornerStyle = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        button.configuration = config
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
    }
}
