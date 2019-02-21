import Foundation

struct SearchResponse: Decodable {
    let response: Response?
}

struct Response: Decodable {
    let venues: [Venue]?
}

struct Venue: Decodable {
    let id: String?
    let name: String?
    let location: Location?
}

struct Location: Decodable {
    let lat: Double?
    let lng: Double?
    let labeledLatLngs: [LabeledCoordinate]?
    let distance: Int?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
    let categories: [String]?
    let verified: Bool?
    let stats: Stats?
    let referralId: String?
    let hasPerk: Bool?
}

struct LabeledCoordinate: Decodable {
    let label: String?
    let lat: Double?
    let lng: Double?
}

struct Stats: Decodable {
    let tipCount: Int?
    let usersCount: Int?
    let checkinsCount: Int?
    let visitsCount: Int?
}
