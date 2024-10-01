struct User: Identifiable, Decodable,Hashable {
    let id: String
    let name: String
    let profileImageUrl: String

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        let profileImageContainer = try userContainer.nestedContainer(keyedBy: ProfileImageKeys.self, forKey: .profileImage)

        id = try userContainer.decode(String.self, forKey: .id)
        name = try userContainer.decode(String.self, forKey: .name)
        profileImageUrl = try profileImageContainer.decode(String.self, forKey: .medium)
    }

    
    enum CodingKeys: String, CodingKey {
        case user
    }

    enum UserKeys: String, CodingKey {
        case id, name, profileImage = "profile_image"
    }

    enum ProfileImageKeys: String, CodingKey {
        case medium
    }
}
