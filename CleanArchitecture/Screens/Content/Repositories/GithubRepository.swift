import Foundation

public enum GithubRepository {
    case getProfile
}

struct StandartGithubRepository: CodableAPIRequest {
    
    typealias Response = GetAUser
    
    var apiRepo: GithubRepository
    
    init(apiRepo: GithubRepository) {
        self.apiRepo = apiRepo
    }

    /// set path url
    var path: String {
        switch apiRepo {
        case .getProfile:
            return "serdarbakirtas"
        }
    }

    /// get method
    var method: HTTPMethod {
        switch apiRepo {
        case .getProfile:
            return .get
        }
    }

    /// set parameters
    var params: [URLQueryItem]? {
        switch apiRepo {
        case .getProfile:
            return nil
        }
    }
    
    /// set query items (parameters)
    var body: [String: Any]? {
        switch apiRepo {
        case .getProfile:
            return nil
        }
    }
}
