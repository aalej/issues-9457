import Foundation

import FirebaseDataConnect



public struct ItemKey {
  
  public private(set) var id: UUID
  
  public private(set) var creationTime: Timestamp
  

  enum CodingKeys: String, CodingKey {
    
    case  id
    
    case  creationTime
    
  }
}

extension ItemKey : Codable {
  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    self.creationTime = try codecHelper.decode(Timestamp.self, forKey: .creationTime, container: &container)
    
  }

  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(id, forKey: .id, container: &container)
      
      
      
      try codecHelper.encode(creationTime, forKey: .creationTime, container: &container)
      
      
    }
}

extension ItemKey : Equatable {
  public static func == (lhs: ItemKey, rhs: ItemKey) -> Bool {
    
    if lhs.id != rhs.id {
      return false
    }
    
    if lhs.creationTime != rhs.creationTime {
      return false
    }
    
    return true
  }
}

extension ItemKey : Hashable {
  public func hash(into hasher: inout Hasher) {
    
    hasher.combine(self.id)
    
    hasher.combine(self.creationTime)
    
  }
}

extension ItemKey : Sendable {}


