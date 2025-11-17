
import Foundation

import FirebaseCore
import FirebaseDataConnect
public extension DataConnect {

  static let defaultConnector: DefaultConnector = {
    let dc = DataConnect.dataConnect(connectorConfig: DefaultConnector.connectorConfig, callerSDKType: .generated)
    return DefaultConnector(dataConnect: dc)
  }()

}

public class DefaultConnector {

  let dataConnect: DataConnect

  public static let connectorConfig = ConnectorConfig(serviceId: "test-dc-2", location: "us-central1", connector: "default")

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect

    // init operations 
    self.createItemMutation = CreateItemMutation(dataConnect: dataConnect)
    self.listEverythingQuery = ListEverythingQuery(dataConnect: dataConnect)
    
  }

  public func useEmulator(host: String = DataConnect.EmulatorDefaults.host, port: Int = DataConnect.EmulatorDefaults.port) {
    self.dataConnect.useEmulator(host: host, port: port)
  }

  // MARK: Operations
public let createItemMutation: CreateItemMutation
public let listEverythingQuery: ListEverythingQuery


}
