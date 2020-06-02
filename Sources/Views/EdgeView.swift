import SwiftUI
import Combine

struct EdgeView: View {
    @ObservedObject var viewModel: EdgeViewModel
    
    var body: some View {
        ZStack {
            Arrow(start: viewModel.start, end: viewModel.end, thickness: viewModel.value)
                .foregroundColor(.gray)
                .opacity(0.5)
            
            if viewModel.showValue {
                Text(viewModel.value.description)
                    .font(.caption)
                    .position(viewModel.middle)
            }
        }
    }
}
