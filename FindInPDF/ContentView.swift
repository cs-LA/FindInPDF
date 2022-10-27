import Foundation
import SwiftUI


struct ContentView: View {
  
  @ObservedObject var vModel: ContentViewModel
  
  var body: some View {
    
    VStack {
      HStack {
        Spacer()
        Text("HTML")
          .foregroundColor(.blue)
          .onTapGesture { vModel.loadHTML() }
        Spacer()
        Text("PDF")
          .foregroundColor(.blue)
          .onTapGesture { vModel.loadPDF() }
        Spacer()
      }
      
      searchInPageView()
      
      if vModel.pdfDoc == nil { Browser() }
      else { vModel.pdfViewer }

    }
    .padding()
    .onAppear() { vModel.loadPDF() }
  }
  
  
  @ViewBuilder
  private func searchInPageView() -> some View {
    HStack {
      Image(systemName: "doc.text.magnifyingglass")
      
      Button(action: { vModel.searchInPage(forward: false) })
      {
        if vModel.searchIsAtTop { Image(systemName: "arrow.triangle.capsulepath").rotationEffect(.radians(.pi)) }
        else { Image(systemName: "lessthan") }
      }
      
      TextField("", text: $vModel.searchString)
        .onChange(of: vModel.searchString) { _ in
          vModel.searchIsAtTop = false
          vModel.searchIsAtEnd = false
          vModel.pdfSelectionIndex = -1
        }
        .background(Color(.systemGray6))
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color(.systemGray), lineWidth: 1)
        )
      
      Button(action: { vModel.searchInPage(forward: true) })
      {
        if vModel.searchIsAtEnd { Image(systemName: "arrow.triangle.capsulepath") }
        else { Image(systemName: "greaterthan") }
      }
    }
    .padding()
    .background(Color(.systemGray3))
    .overlay(
      RoundedRectangle(cornerRadius: 4)
        .stroke(Color(.systemGray), lineWidth: 1)
    )
  }
  
}
