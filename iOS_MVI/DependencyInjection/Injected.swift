import SwiftUI

@propertyWrapper
struct Dependency<T> {
    private let keyPath: WritableKeyPath<DependencyValues, T>
    var wrappedValue: T {
        get { DependencyValues[keyPath] }
        set { DependencyValues[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<DependencyValues, T>) {
        self.keyPath = keyPath
    }
}
