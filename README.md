# Repro for issue 9457

## Versions

firebase-tools: 14.25.0<br>
Firebase Data Connect for VSCode: v1.10.1

## Steps to reproduce

1. Run `firebase dataconnect:sdk:generate`
2. Run `firebase emulators:start --project demo-project`
3. Open the application in Xcode
4. Run the app
   - No errors raised during compilation
5. Add an item
   - Enter a name
   - Eneter a description
   - Click `Add Item`
6. Click `Get Items`
   - Query raises no errors
   - Items are displayed on screen

## Notes

Code seems to compile and run even without the `FirebaseCore` import in `test_9457/dataconnect-generated/swift/DataConnectGenerated/Sources/DefaultKeys.swift`

```swift
import Foundation

import FirebaseDataConnect



public struct ItemKey {

  public private(set) var id: UUID


  enum CodingKeys: String, CodingKey {

    case  id

  }
}

extension ItemKey : Codable {
  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()


    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)

  }

  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()


      try codecHelper.encode(id, forKey: .id, container: &container)


    }
}

extension ItemKey : Equatable {
  public static func == (lhs: ItemKey, rhs: ItemKey) -> Bool {

    if lhs.id != rhs.id {
      return false
    }

    return true
  }
}

extension ItemKey : Hashable {
  public func hash(into hasher: inout Hasher) {

    hasher.combine(self.id)

  }
}

extension ItemKey : Sendable {}
```
