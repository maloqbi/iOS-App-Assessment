import Combine
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var loginResult: String? = nil
    @Published var isLoggedIn: Bool = false
    @Published var isLoggingIn: Bool = false
    @Published var isLoginButtonEnabled: Bool = false
    @Published var username: String = "" {
        didSet {
            validateForm()  
        }
    }

    @Published var password: String = "" {
        didSet {
            validateForm()
        }
    }
    

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIService
    private let keychainService: KeychainService
    
    init(apiService: APIService = APIService.shared, keychainService: KeychainService = KeychainService.shared) {
            self.apiService = apiService
            self.keychainService = keychainService
        }
    
    
    func login() {
        guard !username.isEmpty && !password.isEmpty else {
            loginResult = "Username or Password is empty"
            return
        }

        isLoggingIn = true
        loginResult = nil

        apiService.login(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failure in login: \(error.localizedDescription)")
                    self.loginResult = "Login failed: \(error.localizedDescription)"
                case .finished:
                    break
                }
                self.isLoggingIn = false
            }, receiveValue: { response in
                self.isLoggedIn = true
                self.loginResult = "Login Successful. Token: \(response.token)"
                self.keychainService.saveToken(response.token)
            })
            .store(in: &cancellables)
    }
    
    private func validateForm() {
        
        isLoginButtonEnabled = !username.isEmpty && !password.isEmpty && password.count >= 6
    }
}
