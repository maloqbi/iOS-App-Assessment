# iOS-App-Assessment

This is an iOS application built as part of an assessment for demonstrating my skills in iOS development using Swift, MVVM architecture, and Combine for handling asynchronous tasks. The project showcases authentication using secure token storage via Keychain, network handling using URLSession, and modern Swift practices.

Table of Contents

	•	Features
	•	Technologies Used
	•	Key Functionality
	•	Known Issues
	•	Future Enhancements

 Features

	•	User Authentication: Users can log in with a username and password. The login request is securely handled with Combine, and tokens are stored in Keychain.
	•	Secure Token Storage: Tokens are stored and managed securely using Apple’s Keychain services.
	•	Networking: The app interacts with external APIs using URLSession and Combine, ensuring error handling and secure communication.
	•	MVVM Architecture: Follows the Model-View-ViewModel (MVVM) pattern to maintain a clean separation of concerns.

Technologies Used

	•	Swift: Programming language for iOS development.
	•	Combine: Framework used for handling asynchronous events by combining data over time.
	•	MVVM Architecture: Ensures clean code organization and separation of concerns.
	•	Keychain: Secure storage of authentication tokens.
	•	URLSession: Network requests and responses handling.

Key Functionality

	1.	Login Flow:
	•	Users can log in by providing a username and password.
	•	On successful login, a token is retrieved and securely stored in Keychain using the KeychainService.
	•	The app handles errors like invalid credentials or network failures gracefully.
	2.	Token Management:
	•	Tokens are stored securely using Apple’s Keychain. The app retrieves the token for any authenticated requests.
	•	The KeychainService class manages saving, retrieving, and deleting tokens.
	3.	Network Handling:
	•	APIService handles all network requests, using Combine to manage asynchronous requests and response validation.

 Known Issues

	•	Error handling in token refresh logic could be improved, especially when the token expires.
	•	UI/UX is minimal and focuses on functionality.

 Future Enhancements

	•	Unit Testing: Adding more comprehensive unit tests for APIService and LoginViewModel.
	•	Token Expiry Handling: Implementing a refresh token mechanism to ensure the user session is valid throughout usage.
	•	UI Enhancements: Improve the visual interface and add more responsive UI elements.
