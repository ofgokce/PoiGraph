import Testing
import Foundation
@testable import PoiGraph

private class Test { }

@Test func example() async throws {
    let url = Bundle.module.url(forResource: "PoiGraphTest", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let graph = try JSONDecoder().decode(Graph.self, from: data)
    
    for node in graph.nodes.keys {
        let path = graph.shortestPath(from: node, to: .wc)
        #expect(path?.distance != nil)
        print(path?.distance ?? -1)
    }
}
