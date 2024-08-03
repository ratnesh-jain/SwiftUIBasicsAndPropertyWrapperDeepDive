//
//  HomeView.swift
//  SwiftUIPropertyWrapperStudy
//
//  Created by Ratnesh Jain on 03/08/24.
//

import Foundation
import SwiftUI

enum PathDestination: Hashable {
    case itemDetails(Int)
    case settings
}

extension PathDestination: EnvironmentKey {
    static var defaultValue: PathNavigation = .init()
}

@Observable
class PathNavigation {
    var path: [PathDestination] = []
    func append(destination: PathDestination) {
        path.append(destination)
    }
}

extension EnvironmentValues {
    var navigationManager: PathNavigation {
        get {
            self[PathDestination.self]
        }
        set {
            self[PathDestination.self] = newValue
        }
    }
}

struct HomeView: View {
    
    @Bindable var path = PathNavigation()
    
    var body: some View {
        NavigationStack(path: $path.path) {
            List {
                ForEach(1...10, id: \.self) { item in
                    ItemView(item: item)
                }
            }
            .navigationDestination(for: PathDestination.self) { destination in
                switch destination {
                case .itemDetails(let item):
                    VStack {
                        Image(systemName: "gear")
                            .font(.largeTitle)
                        Text("Item Details: \(item)")
                    }
                case .settings:
                    Text("Settings")
                }
            }
            .environment(\.navigationManager, path)
        }
    }
}

struct ItemView: View {
    let item: Int
    @Environment(\.navigationManager) var manager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            manager.append(destination: .itemDetails(item))
        } label: {
            Text("Item: \(item)")
        }
    }
}

#Preview {
    HomeView()
}
