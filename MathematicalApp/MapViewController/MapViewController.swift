//
//  GoogleMapViewController.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//


import UIKit
import GoogleMaps
import GooglePlaces

protocol GoogleMapViewControllerDelegate {
    func didConfirm(with location: CLLocationCoordinate2D, address: String, governorate: String)
}

class GoogleMapViewController: mainViewController{
    func didFailAutocompleteWithError(_ error: Error) {
        
    }
    

    var delegate: GoogleMapViewControllerDelegate?
    var gmsFetcher: GMSAutocompleteFetcher!
    @IBOutlet weak var mapView: GMSMapView!

    @IBOutlet weak var currentLocationLabel: UILabel!


    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var zoomLevel: Float = 15.0
    var governorate: String?
    var placesClient = GMSPlacesClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        gmsFetcher = GMSAutocompleteFetcher()
        initMap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    
    func initMap() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self


        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.myLocationButton = true
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true;
    }

    var marker = GMSMarker()
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async { () -> Void in
            self.mapView.clear()
            let position = CLLocationCoordinate2DMake(lat, lon)
            self.marker = GMSMarker(position: position)

            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.mapView.camera = camera

            self.marker.title = "Address : \(title)"
            self.currentLocationLabel.text = title
            self.marker.map = self.mapView
        }
    }
}


extension GoogleMapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {

    func moveMarkerToLocation(location: CLLocationCoordinate2D) {
        mapView.clear()

        let mapMarker = GMSMarker(position: location)
        mapMarker.map = mapView


        getAddressFor(location: location) { (obtainedAddress, governorate) in
            self.currentLocationLabel.text = obtainedAddress
            self.governorate = governorate
            mapMarker.title = "Address : \(obtainedAddress)"

        }
        self.currentLocation = location
        
        
    }

    func getAddressFor(location: CLLocationCoordinate2D,
                       completionHandler: @escaping (_ address: String, _ governorate: String) -> ()) {

        let geocoder = GMSGeocoder()


        var obtainedAddress = ""
        var governorate = ""
        geocoder.reverseGeocodeCoordinate(location) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]

                obtainedAddress = lines.joined(separator: "\n")
                governorate = address.lines?.last ?? ""
                completionHandler(obtainedAddress, governorate)
            }
        }


        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                              longitude: location.longitude,
                                              zoom: zoomLevel)

        mapView.animate(to: camera)

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        moveMarkerToLocation(location: location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            break
        case .denied:
            break
        case .notDetermined:
            break
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            break
        }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {

        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                              longitude: coordinate.longitude,
                                              zoom: zoomLevel)

        mapView.animate(to: camera)

        moveMarkerToLocation(location: coordinate)


    }

    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {

        if mapView.myLocation?.coordinate != nil {
            moveMarkerToLocation(location: (mapView.myLocation?.coordinate)!)
        }

        return true
    }


}
