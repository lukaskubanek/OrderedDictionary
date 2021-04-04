// https://github.com/realm/SwiftLint/pull/2965
// https://bugs.swift.org/browse/SR-11501
#if compiler(<5.1) || (SWIFT_PACKAGE && os(macOS))
internal enum UnwrapError: Error {
    case missingValue
}

internal func XCTUnwrap<T>(
    _ expression: @autoclosure () throws -> T?,
    _ message: @autoclosure () -> String = ""
) throws -> T {
    if let value = try expression() {
        return value
    } else {
        throw UnwrapError.missingValue
    }
}
#endif
