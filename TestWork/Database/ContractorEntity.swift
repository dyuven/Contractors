import Foundation
import RealmSwift

final class ContractorEntity: Object, ObjectKeyIdentifiable{

  @objc dynamic var id = 0
  @objc dynamic var name: String = ""
  @objc dynamic var contactNumber: String = ""
  @objc dynamic var image: String? = "default"
  @objc dynamic var email: String? = nil
  
  var group = LinkingObjects(fromType: Group.self, property: "contractors")
    
  func IncrementaID() -> Int{
  let realm = try! Realm()
  if let retNext = realm.objects(ContractorEntity.self).sorted(byKeyPath: "id").last?.id {
    return retNext + 1
  }else{
    return 0
    }
  }
  
  func update(name: String, imageName: String, contactNumber: String, email: String){
    if let realm = self.realm{
      try? realm.write({
        self.name = name
        self.contactNumber = contactNumber
        self.email = email
        self.image = imageName
      })
    } else {
      self.name = name
      self.contactNumber = contactNumber
      self.email = email
      self.image = imageName
    }
  }
  
}
