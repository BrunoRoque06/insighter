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

func readSpacesState(_ url: URL) -> SpacesState {
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
    let currentSpace = spacesPlist.spacesDisplayConfiguration.managementData.monitors[0].currentSpace?.uuid
    let spaces = spacesPlist.spacesDisplayConfiguration.spaceProperties.map { $0.name }
    let current = spaces.firstIndex(where: { $0 == currentSpace })
    let count = spacesPlist.spacesDisplayConfiguration.spaceProperties.count
    return SpacesState(current: current ?? 0, count: count)
}

func shell(_ command: String) throws -> String {
    let task = Process()
    task.launchPath = "/usr/local/bin/fish"
    task.arguments = ["-c", command]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
}

func shellToInt(_ command: String) throws -> Int {
    let result = try shell(command)
    let trimmedResult = result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    return Int(trimmedResult)!
}

func getSpacesStateThroughYabai() -> SpacesState {
    let current = (try? shellToInt("yabai -m query --spaces --space | jq '.index'")) ?? 0
    let count = (try? shellToInt("yabai -m query --spaces | jq '. | length'")) ?? 0
    return SpacesState(current: current, count: count)
}
