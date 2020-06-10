import SwiftUI
import DirectedGraph

struct ContentView: View {
    static private let graph = try? SimpleGraph.load(filename: "graph")
    private let viewModel = GraphViewModel(Self.graph!)
    
    var body: some View {
        VStack {
            GraphView(viewModel)
            
            HStack {
                Button("Release Nodes") {
                    self.viewModel.releaseNodes()
                }
                
                Spacer()
                
                Button("Toggle Edge Values") {
                    self.viewModel.toggleEdgeValues()
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
