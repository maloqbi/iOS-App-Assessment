import XCTest
import Combine
@testable import iOS_Assessment_Elm

class UsersViewModelTests: XCTestCase {
    
    var viewModel: UsersViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    func testUserDecoding() {
        let mockUsers = """
        [
            {
                "user": {
                    "id": "1",
                    "name": "Mohammad",
                    "profile_image": {
                        "medium": "https://example.com/john.jpg"
                    }
                }
            },
            {
                "user": {
                    "id": "2",
                    "name": "Abdullah",
                    "profile_image": {
                        "medium": "https://example.com/jane.jpg"
                    }
                }
            }
        ]
        """.data(using: .utf8)!
        
        do {
            let decodedUsers = try JSONDecoder().decode([User].self, from: mockUsers)
            XCTAssertEqual(decodedUsers.count, 2)
            XCTAssertEqual(decodedUsers[0].name, "Mohammad")
        } catch {
            XCTFail("Failed to decode mock users: \(error)")
        }
    }
    // Test for successful fetching of users
    func testFetchUsersSuccess() {
        let mockUsers = """
        [
            {
                "user": {
                    "id": "1",
                    "name": "Mohammad",
                    "profile_image": {
                        "medium": "https://test.com/test.jpg"
                    }
                }
            },
            {
                "user": {
                    "id": "2",
                    "name": "Abdullah",
                    "profile_image": {
                        "medium": "https://test.com/test.jpg"
                    }
                }
            }
        ]
        """.data(using: .utf8)!
        
        let urlSessionMock = URLSessionMock(data: mockUsers, response: nil, error: nil) // No error for success
        viewModel = UsersViewModel(urlSession: urlSessionMock)
        
        let expectation = XCTestExpectation(description: "Wait for users to be fetched")
        
        viewModel.fetchUsers()
        
        viewModel.$users
            .dropFirst() 
            .sink(receiveValue: { users in
                XCTAssertFalse(users.isEmpty, "The users array is empty")
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].name, "Mohammad")
                XCTAssertEqual(users[1].name, "Abdullah")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
    
    
    func testFetchUsersFailure() {
        
        let urlSessionMock = URLSessionMock(data: nil, response: nil, error: URLError(.badServerResponse))
        viewModel = UsersViewModel(urlSession: urlSessionMock)
        
        
        let expectation = XCTestExpectation(description: "Wait for users to fail fetching")
        
        
        viewModel.fetchUsers()
        
        
        viewModel.$errorMessage
            .dropFirst()
            .sink(receiveValue: { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertEqual(errorMessage, "Failed to load users: The operation couldn’t be completed. (NSURLErrorDomain error -1011.)")
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        
        wait(for: [expectation], timeout: 2)
    }
}
