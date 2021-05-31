import Foundation
import Combine
import RealmSwift

class ContractorsModel: ObservableObject{
  
  @Published var contractors = List<ContractorEntity>()
  @Published var selectedGroup: Group? = nil
  var token: NotificationToken? = nil
  var realm: Realm?


  init() {
    let realm = try? Realm()
    self.realm = realm
    if let group = realm?.objects(Group.self).first{
      self.selectedGroup = group
      self.contractors = group.contractors
      } else {
      try? realm?.write({
        let group = Group()
        realm?.add(group)
        self.selectedGroup = group
        self.contractors = group.contractors
      })
    }
    
//    token = selectedGroup?.observe({ [unowned self] (changes) in
//      switch changes {
//      case .error(_): break
//      case.change(_, _): self.objectWillChange.send()
//      case .deleted: self.selectedGroup = nil
//      }
//    })
    
    token = selectedGroup?.contractors.observe({ changes in
      switch changes {
      case .error(_): break
      case .initial(_): break
      case .update(_, deletions: _, insertions: _, modifications: _):
        self.objectWillChange.send()
      }
    })
  }
  
  
  func addNewContractor(name: String, number: String, image: String?, email: String?){
    let newConrtactor = ContractorEntity()
    newConrtactor.name = name
    newConrtactor.contactNumber = number
    newConrtactor.image = image == "" ? "default" : image
    newConrtactor.email = email
    if let realm = selectedGroup?.realm {
      try? realm.write{
        selectedGroup?.contractors.append(newConrtactor)
        self.contractors.sort{ $0.name < $1.name }
      }
    }
  }
  
  func deleteContractor(at indexSet: IndexSet){
    if let index = indexSet.first,
      let realm = contractors[index].realm{
      try? realm.write({
        realm.delete(contractors[index])
      })
    }
  }
  

}
