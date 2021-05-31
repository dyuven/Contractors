import SwiftUI
import RealmSwift


struct ContentView: View {
  
  @ObservedObject var contractorsModel = ContractorsModel()
  @State var showingAddView: Bool = false
  
  var body: some View {
    NavigationView{
      VStack{
      Button(action: {
      self.showingAddView.toggle()
        }, label: {Image(systemName: "plus")})
        .sheet(isPresented: self.$showingAddView, content: { AddView(isPresented: self.$showingAddView)})
      List{

        ForEach(self.contractorsModel.contractors.freeze(), id: \.self) { contractor in
          NavigationLink(
            destination: ContractorDetailView(contractor: self.contractorsModel.realm!.resolve(ThreadSafeReference(to: contractor))!),
           label: {
            HStack{
              Image(contractor.image ?? "default").cornerRadius(40)
              Text(contractor.name).fontWeight(Font.Weight.heavy)
            }
          })
        }
        .onDelete { indexSet in
          self.contractorsModel.deleteContractor(at: indexSet)
        }
      }.textFieldStyle(RoundedBorderTextFieldStyle())
    .navigationBarTitle("Contractors")
      }
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
