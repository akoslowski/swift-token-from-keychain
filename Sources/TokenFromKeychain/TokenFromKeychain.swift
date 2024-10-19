import Foundation
import Security

/// Fetches a token for the given name from the keychain
/// - Parameter token: Name of the token
public func tokenFromKeychain(_ tokenName: String) throws(TokenFromKeychainError) -> String {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: tokenName,
        kSecAttrAccount as String: tokenName,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne,
    ]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    guard status == errSecSuccess
    else {
        throw .tokenNotFound(tokenName)
    }
    guard let data = item as? Data, let password = String(data: data, encoding: .utf8)
    else {
        throw .convertingTokenToStringFailed
    }
    return password
}

public enum TokenFromKeychainError: Error, CustomStringConvertible {
    case tokenNotFound(String)
    case convertingTokenToStringFailed

    public var description: String {
        switch self {
        case .tokenNotFound(let token):
            """
            ⚠️ Token not found.
            ⚠️
            ⚠️ Make sure to store '\(token)' in your keychain!
            ⚠️ Example: security -v add-generic-password -a "\(token)" -s "\(token)" -w "your-access-token..."
            """
        case .convertingTokenToStringFailed:
            "Failed to convert token to string."
        }
    }
}
