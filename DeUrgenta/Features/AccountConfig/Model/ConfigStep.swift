import Foundation

enum ConfigStepType {
    case address
    case group
    case backpack
    case firstAid
}

struct ConfigStep: Identifiable {
    let id = UUID()
    let name: String
    var type: ConfigStepType
    let logo: String
    let enabled: Bool
}
