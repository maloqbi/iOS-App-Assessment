import Combine
import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let urlSession: URLSessionProtocol
    
    
    init(urlSession: URLSessionProtocol = URLSessionWrapper()) {
        self.urlSession = urlSession
    }
    
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://pastebin.com/raw/wgkJgazE") else {
            errorMessage = "Invalid URL."
            isLoading = false
            return
        }
        
        urlSession.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error occurred: \(error.localizedDescription)")
                    self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { [weak self] data in
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    self?.users = users
                    print("Decoded users: \(users)")
                } catch {
                    print("Decoding error: \(error)")
                    self?.errorMessage = "Failed to decode users."
                }
            })
            .store(in: &cancellables)
    }
}
