import Foundation
import RealmSwift

final class Group: Object, ObjectKeyIdentifiable{
  
  @objc dynamic var name: String = "new"

  
  var contractors = RealmSwift.List<ContractorEntity>()
  
}
