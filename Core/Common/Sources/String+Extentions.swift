import Foundation

public extension String {
    func localized(_ bundle: Bundle) -> String {
        bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
