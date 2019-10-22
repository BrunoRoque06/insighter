import Foundation

let spacesPlist = URL(fileURLWithPath: "/Users/brunoroque/Library/Preferences/com.apple.spaces.plist")

func _readSpacesPlist(url: URL) throws -> SpacesPlist {
    let content = try Data(contentsOf: url)
    return try PropertyListDecoder().decode(SpacesPlist.self, from: content)
}

struct SpacesPlist: Decodable {
    struct SpacesDisplayConfiguration: Decodable {
        struct ManagementData: Decodable {
            struct Monitor: Decodable {
                struct Space: Decodable {
                    let uuid: String
                }

                let currentSpace: Space?

                enum CodingKeys: String, CodingKey {
                    case currentSpace = "Current Space"
                }
            }

            let monitors: [Monitor]

            enum CodingKeys: String, CodingKey {
                case monitors = "Monitors"
            }
        }

        struct SpaceProperties: Decodable {
            let name: String
        }

        let managementData: ManagementData
        let spaceProperties: [SpaceProperties]

        enum CodingKeys: String, CodingKey {
            case managementData = "Management Data"
            case spaceProperties = "Space Properties"
        }
    }

    let spacesDisplayConfiguration: SpacesDisplayConfiguration

    enum CodingKeys: String, CodingKey {
        case spacesDisplayConfiguration = "SpacesDisplayConfiguration"
    }
}

func readSpacesState(url: URL) -> SpacesState {
    do {
        let content = try _readSpacesPlist(url: url)
        return try _convertToSpacesState(spacesPlist: content)
    } catch {
        return SpacesState(current: 0, count: 0)
    }
}

struct SpacesState {
    let current: Int
    let count: Int
}

func _convertToSpacesState(spacesPlist: SpacesPlist) throws -> SpacesState {
    let count = spacesPlist.spacesDisplayConfiguration.spaceProperties.count
    return SpacesState(current: 0, count: count)
}
