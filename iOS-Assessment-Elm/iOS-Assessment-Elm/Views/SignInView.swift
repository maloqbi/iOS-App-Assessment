import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 20)
            
            if viewModel.isLoggingIn {
                ProgressView("Logging in...")
                    .padding(.top, 20)
            } else {
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(viewModel.isLoginButtonEnabled ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .disabled(!viewModel.isLoginButtonEnabled)
                .padding(.top, 30)
            }
            
            if let result = viewModel.loginResult {
                Text(result)
                    .padding()
                    .foregroundColor(result.lowercased().contains("failed") ? .red : .green)
                    .fontWeight(.semibold)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}
