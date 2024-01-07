import Foundation

public enum ApiRepoState {
    case getProfile
}

struct GithubRepositoryRequest: CodableAPIRequest {
    
    var apiRepo: ApiRepoState
    
    init(apiRepo: ApiRepoState) {
        self.apiRepo = apiRepo
    }
    
    // MARK: - Request
    
    /// set path url
    var path: String {
        switch apiRepo {
        case .getProfile:
            return "serdarbakirtas"
        }
    }
    
    /// set parameters
    var params: [URLQueryItem]? {
        switch apiRepo {
        case .getProfile:
            return nil
        }
    }
    
    /// get method
    var method: HTTPMethod {
        switch apiRepo {
        case .getProfile:
            return .get
        }
    }

    /// set query items (parameters)
    var body: [String: Any]? {
        switch apiRepo {
        case .getProfile:
            return nil
        }
    }
    
    // MARK: - Response
    
    typealias Response = GetAUser
}
