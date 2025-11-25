This Swift package contains the generated Swift code for the connector `default`.

You can use this package by adding it as a local Swift package dependency in your project.

# Accessing the connector

Add the necessary imports

```
import FirebaseDataConnect
import DataConnectGenerated

```

The connector can be accessed using the following code:

```
let connector = DataConnect.defaultConnector

```


## Connecting to the local Emulator
By default, the connector will connect to the production service.

To connect to the emulator, you can use the following code, which can be called from the `init` function of your SwiftUI app

```
connector.useEmulator()
```

# Queries

## ListEverythingQuery


### Using the Query Reference
```
struct MyView: View {
   var listEverythingQueryRef = DataConnect.defaultConnector.listEverythingQuery.ref(...)

  var body: some View {
    VStack {
      if let data = listEverythingQueryRef.data {
        // use data in View
      }
      else {
        Text("Loading...")
      }
    }
    .task {
        do {
          let _ = try await listEverythingQueryRef.execute()
        } catch {
        }
      }
  }
}
```

### One-shot execute
```
DataConnect.defaultConnector.listEverythingQuery.execute(...)
```


# Mutations
## CreateItemMutation

### Variables

#### Required
```swift

let name: String = ...
let creationTime: Timestamp = ...
```
 

#### Optional
```swift

let description: String = ...
```

### One-shot execute
```
DataConnect.defaultConnector.createItemMutation.execute(...)
```

