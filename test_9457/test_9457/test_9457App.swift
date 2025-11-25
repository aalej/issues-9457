import SwiftUI
import FirebaseCore
import FirebaseDataConnect
import DataConnectGenerated

struct Item: Identifiable, Hashable {
    var id: UUID
    var name: String
    var description: String?
    var creationTime: Timestamp
    
    init(id: UUID = UUID(),
         name: String,
         creationTime: Timestamp,
         description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.creationTime = creationTime
    }
}

@main
struct test_9457App: App {
    @State var itemName: String = ""
    @State var itemDescription: String = ""
    @State var isShowingItemAddedAlert: Bool = false
    @State var itemList: [Item] = []
    
    init() {
        let firebaseOptions = FirebaseOptions(
            googleAppID: "1:123456789000:ios:1f55a973bd5705274278d8",
            gcmSenderID: "123456789000"
        )
        firebaseOptions.apiKey = "fake-api-key"
        firebaseOptions.projectID = "demo-project"
        firebaseOptions.bundleID = "org.test-9457"
        firebaseOptions.clientID = "123456789000-4599bdk728aaathoa40tk1o6cjuhvedi.apps.googleusercontent.com"
        firebaseOptions.appGroupID = nil
        
        FirebaseApp.configure(options: firebaseOptions)
        DataConnect.defaultConnector.useEmulator()
    }
    
    var body: some Scene {
        WindowGroup {
            List {
                Section(header: Text("Add Item").textCase(.none)) {
                    TextField("Enter Item Name", text: $itemName)
                    TextField("Enter Item Description", text: $itemDescription)
                }
                
                Section {
                    Button(action: {
                        Task {
                            _ = try await DataConnect.defaultConnector
                                .createItemMutation.execute(name: itemName, creationTime: Timestamp(date: Date())
                                ) { variables in
                                    variables.description = itemDescription
                                }
                            isShowingItemAddedAlert = true
                        }
                    }, label: {
                        Text("Add Item")
                            .frame( maxWidth: .infinity, alignment: .center)
                    })
                }
                
                Section {
                    Button(action: {
                        Task {
                            let queryResult = try await DataConnect.defaultConnector.listEverythingQuery.execute()
                            itemList = queryResult.data.items.compactMap({$0}).compactMap { item -> Item? in
                                let id: UUID = item.id
                                let name = item.name
                                let description = item.description
                                let creationTime = item.creationTime
                                return Item(id: id, name: name, creationTime: creationTime, description: description)
                            }
                        }
                    }, label: {
                        Text("Get Items")
                            .frame( maxWidth: .infinity, alignment: .center)
                    })
                }
                
                Section(header: Text("Item List").textCase(.none)) {
                    ForEach(itemList) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            if let description = item.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Text(formatTimestamp(item.creationTime))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                
            }.alert("Item Added!", isPresented: $isShowingItemAddedAlert) {
                Button("OK", role: .cancel) { }
            }
            
            
        }
        
    }
    
    func formatTimestamp(_ timestamp: Timestamp) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateformatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp.seconds)))
    }
}
