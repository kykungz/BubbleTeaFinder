//
//  VenueViewController.swift
//  BubbleTeaFinder
//
//  Created by Kongpon Charanwattanakit on 21/2/2562 BE.
//  Copyright © 2562 Kongpon Charanwattanakit. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class VenueDetailViewController: UIViewController {

    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueDistance: UILabel!
    
    var venue: Venue?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = venue?.id {
            print("https://api.foursquare.com/v2/venues/\(id)/photos")
            let parameters: Parameters = [
                "client_id": "WO2I23NESB0GYI15UECV4LRVE1MTLFPAYTG50PTXH13VQ5KY",
                "client_secret": "E3KN30HT4PZYNJCQFPSKKM4D1EALAEPCFJJRTEUBKNPRMLDF",
                "limit": 1,
                "v": "20180323"
            ]
            venueName.text = venue?.name
            venueDistance.text = "\(venue?.location?.distance ?? 0) m."
            Alamofire
                .request("https://api.foursquare.com/v2/venues/\(id)/photos", parameters: parameters)
                .responseJSON { res in
                    debugPrint(res)
                    guard let json = res.result.value as? [String: Any] else { return }
                    guard let response = json["response"] as? [String: Any] else { return }
                    guard let photos = response["photos"] as? [String: Any] else { return }
                    guard let count = photos["count"] as? Int else { return }
                    
                    if (count < 1) {
                        Alamofire
                            .request("https://omnivorescookbook.com/wp-content/uploads/2017/06/1705_Bubble-Tea_550.jpg")
                            .responseImage { res in
                                self.venueImage.image = res.result.value
                            }
                    } else {
                        guard let items = photos["items"] as? [[String: Any]] else { return }
                        let prefix = items[0]["prefix"] as? String ?? ""
                        let suffix = items[0]["suffix"] as? String ?? ""
                        let size = "300x500"
                        let url = prefix + size + suffix
                        Alamofire
                            .request(url, parameters: parameters)
                            .responseImage { res in
                                self.venueImage.image = res.result.value
                        }

                    }
                }

        }
    }
}
