import Foundation

import FirebaseCore
import FirebaseDataConnect




















// MARK: Common Enums

public enum OrderDirection: String, Codable, Sendable {
  case ASC = "ASC"
  case DESC = "DESC"
  }

public enum SearchQueryFormat: String, Codable, Sendable {
  case QUERY = "QUERY"
  case PLAIN = "PLAIN"
  case PHRASE = "PHRASE"
  case ADVANCED = "ADVANCED"
  }


// MARK: Connector Enums

// End enum definitions









public class CreateItemMutation{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "CreateItem"

  public typealias Ref = MutationRef<CreateItemMutation.Data,CreateItemMutation.Variables>

  public struct Variables: OperationVariable {
  
        
        public var
name: String

  
        @OptionalVariable
        public var
description: String?

  
        
        public var
creationTime: Timestamp


    
    
    
    public init (
        
name: String
,
        
creationTime: Timestamp

        
        
        ,
        _ optionalVars: ((inout Variables)->())? = nil
        ) {
        self.name = name
        self.creationTime = creationTime
        

        
        if let optionalVars {
            optionalVars(&self)
        }
        
    }

    public static func == (lhs: Variables, rhs: Variables) -> Bool {
      
        return lhs.name == rhs.name && 
              lhs.description == rhs.description && 
              lhs.creationTime == rhs.creationTime
              
    }

    
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(name)
  
  hasher.combine(description)
  
  hasher.combine(creationTime)
  
}

    enum CodingKeys: String, CodingKey {
      
      case name
      
      case description
      
      case creationTime
      
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      let codecHelper = CodecHelper<CodingKeys>()
      
      
      try codecHelper.encode(name, forKey: .name, container: &container)
      
      
      if $description.isSet { 
      try codecHelper.encode(description, forKey: .description, container: &container)
      }
      
      
      try codecHelper.encode(creationTime, forKey: .creationTime, container: &container)
      
      
    }

  }

  public struct Data: Decodable, Sendable {



public var 
item_insert: ItemKey

  }

  public func ref(
        
name: String
,
creationTime: Timestamp

        
        ,
        _ optionalVars: ((inout CreateItemMutation.Variables)->())? = nil
        ) -> MutationRef<CreateItemMutation.Data,CreateItemMutation.Variables>  {
        var variables = CreateItemMutation.Variables(name:name,creationTime:creationTime)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        

        let ref = dataConnect.mutation(name: "CreateItem", variables: variables, resultsDataType:CreateItemMutation.Data.self)
        return ref as MutationRef<CreateItemMutation.Data,CreateItemMutation.Variables>
   }

  @MainActor
   public func execute(
        
name: String
,
creationTime: Timestamp

        
        ,
        _ optionalVars: (@MainActor (inout CreateItemMutation.Variables)->())? = nil
        ) async throws -> OperationResult<CreateItemMutation.Data> {
        var variables = CreateItemMutation.Variables(name:name,creationTime:creationTime)
        
        if let optionalVars {
            optionalVars(&variables)
        }
        
        
        let ref = dataConnect.mutation(name: "CreateItem", variables: variables, resultsDataType:CreateItemMutation.Data.self)
        
        return try await ref.execute()
        
   }
}






public class ListEverythingQuery{

  let dataConnect: DataConnect

  init(dataConnect: DataConnect) {
    self.dataConnect = dataConnect
  }

  public static let OperationName = "ListEverything"

  public typealias Ref = QueryRefObservation<ListEverythingQuery.Data,ListEverythingQuery.Variables>

  public struct Variables: OperationVariable {

    
    
  }

  public struct Data: Decodable, Sendable {




public struct Item: Decodable, Sendable ,Hashable, Equatable, Identifiable {
  


public var 
id: UUID



public var 
name: String



public var 
description: String?



public var 
creationTime: Timestamp


  
  public var itemKey: ItemKey {
    return ItemKey(
      
      id: id,creationTime: creationTime
    )
  }

  
public func hash(into hasher: inout Hasher) {
  
  hasher.combine(id)
  
  hasher.combine(creationTime)
  
}
public static func == (lhs: Item, rhs: Item) -> Bool {
    
    return lhs.id == rhs.id  && 
        lhs.creationTime == rhs.creationTime 
        
  }

  

  
  enum CodingKeys: String, CodingKey {
    
    case id
    
    case name
    
    case description
    
    case creationTime
    
  }

  public init(from decoder: any Decoder) throws {
    var container = try decoder.container(keyedBy: CodingKeys.self)
    let codecHelper = CodecHelper<CodingKeys>()

    
    
    self.id = try codecHelper.decode(UUID.self, forKey: .id, container: &container)
    
    
    
    self.name = try codecHelper.decode(String.self, forKey: .name, container: &container)
    
    
    
    self.description = try codecHelper.decode(String?.self, forKey: .description, container: &container)
    
    
    
    self.creationTime = try codecHelper.decode(Timestamp.self, forKey: .creationTime, container: &container)
    
    
  }
}
public var 
items: [Item]

  }

  public func ref(
        
        ) -> QueryRefObservation<ListEverythingQuery.Data,ListEverythingQuery.Variables>  {
        var variables = ListEverythingQuery.Variables()
        

        let ref = dataConnect.query(name: "ListEverything", variables: variables, resultsDataType:ListEverythingQuery.Data.self, publisher: .observableMacro)
        return ref as! QueryRefObservation<ListEverythingQuery.Data,ListEverythingQuery.Variables>
   }

  @MainActor
   public func execute(
        
        ) async throws -> OperationResult<ListEverythingQuery.Data> {
        var variables = ListEverythingQuery.Variables()
        
        
        let ref = dataConnect.query(name: "ListEverything", variables: variables, resultsDataType:ListEverythingQuery.Data.self, publisher: .observableMacro)
        
        let refCast = ref as! QueryRefObservation<ListEverythingQuery.Data,ListEverythingQuery.Variables>
        return try await refCast.execute()
        
   }
}


