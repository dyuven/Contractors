import SwiftUI

struct ContractorDetailView: View {
  
  let contractor: ContractorEntity
  @State private var name: String = ""
  @State private var contactNumber: String = ""
  @State private var email: String = ""
  @State private var image: String = ""

  
  @Environment(\.presentationMode) var presentation

  
  var body: some View {
    VStack{
      Image(contractor.image ?? "default").clipShape(Circle())
      
      Text("name: \(self.name)")
      Text("contactNumber: \(self.contactNumber)")
      Text("email: \(self.email)")


      VStack{
      Text("Edit name")
      TextField("edit name", text: $name)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Text("Edit number")
      TextField("edit number", text: $contactNumber)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      Text("Edit email")
      TextField("edit email", text: $email)
        .textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none)

        
      Text("Edit photo")
        TextField("edit photo", text: $image)
        .textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none)
      
      
      Button(action: {
        self.contractor.update(name: self.name, imageName: self.image, contactNumber: self.contactNumber, email: self.email)
        self.presentation.wrappedValue.dismiss()
      }, label: {
        Text("Save")
      })
      }.padding()
    .onAppear{
      self.name = self.contractor.name
      self.contactNumber = self.contractor.contactNumber
      self.email = self.contractor.email ?? ""
      self.image = self.contractor.image ?? "default"
    }
    }
  }
}

struct ContractorDetailView_Previews: PreviewProvider {
    static var previews: some View {
      ContractorDetailView(contractor: ContractorEntity())
    }
}
