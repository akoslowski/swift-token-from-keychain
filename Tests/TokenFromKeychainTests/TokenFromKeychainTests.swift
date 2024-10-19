import Testing
@testable import TokenFromKeychain

@Test func throwsErrorOnTokenNotFoundInKeychain() async throws {
    #expect(
        throws: TokenFromKeychainError.self,
        performing: {
            try tokenFromKeychain("not-in-keychain")
        }
    )
}
