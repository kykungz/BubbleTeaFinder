//
//  ViewController.swift
//  BubbleTeaFinder
//
//  Created by Kongpon Charanwattanakit on 14/2/2562 BE.
//  Copyright © 2562 Kongpon Charanwattanakit. All rights reserved.
//

import Alamofire
import GoogleMaps
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        print(mapView)
        mapView.delegate = self
    }
    
    @IBAction func findBubbleTea(_ sender: Any) {
        print("TAPPP")
        mapView.clear()
        let parameters: Parameters = [
            "client_id": "WO2I23NESB0GYI15UECV4LRVE1MTLFPAYTG50PTXH13VQ5KY",
            "client_secret": "E3KN30HT4PZYNJCQFPSKKM4D1EALAEPCFJJRTEUBKNPRMLDF",
            "query": "ชานมไข่มุก",
            "limit": 10,
            "v": "20180323",
            "ll": "\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)"
        ]
        
        Alamofire
            .request("https://api.foursquare.com/v2/venues/search", parameters: parameters)
            .responseJSON(completionHandler: { res in
                guard let data = res.data else { return }
                let response = (try? JSONDecoder().decode(SearchResponse.self, from: data))?.response

                response?.venues?.forEach { venue in
                    let position = CLLocationCoordinate2D(
                        latitude: venue.location?.lat ?? 0.0,
                        longitude: venue.location?.lng ?? 0.0
                    )
                    let marker = GMSMarker(position: position)
                    marker.map = self.mapView
                    marker.title = venue.name
                    marker.userData = venue
                }
            })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showVenueDetail") {
            let venueDetailView = segue.destination as? VenueDetailViewController
            let venue = sender as? Venue
            venueDetailView?.venue = venue
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            manager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.camera = GMSCameraPosition(latitude: manager.location!.coordinate.latitude, longitude: manager.location!.coordinate.longitude, zoom: 15)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print(location)
        
    }
    
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker)
        performSegue(withIdentifier: "showVenueDetail", sender: marker.userData)
//        performSegue(withIdentifier: "showVenueDetail", sender: marker.title)
        return true
    }
}
