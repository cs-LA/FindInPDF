import Foundation
import SwiftUI


let webView = WebView.shared

@main
struct FindInPDFApp: App {
  
  @StateObject var cvModel = ContentViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView(vModel: cvModel)
    }
  }
}
