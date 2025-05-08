//
//  Graph.swift
//  PoiGraph
//
//  Created by Ömer Faruk Gökce on 5.05.2025.
//

/// A graph consisting of interconnected nodes.
public struct Graph {
    
    /// A mapping of node IDs to nodes.
    public var nodes: [String: Node]
    
    /// Creates a new graph from a given set of nodes.
    public init(with nodes: Set<Node>) {
        self.nodes = nodes.reduce(into: .init()) { partialResult, node in
            partialResult[node.id] = node
        }
    }
    
    /// Finds the shortest path from a node with a given ID to the first node matching a specific `PointType`.
    ///
    /// - Parameters:
    ///   - startId: The ID of the node to start the search from.
    ///   - targetPointType: The desired type of point to find.
    /// - Returns: A `Path` if a route exists; otherwise `nil`.
    public func shortestPath(from startId: String, to targetPointType: PointType) -> Path? {
        guard let startNode = nodes[startId] else { return nil }
        return Dijkstra.shortestPath(in: self, from: startNode, to: targetPointType)
    }
}

extension Graph: Codable {
    
    public init(from decoder: any Decoder) throws {
        try self.init(with: Set<Node>(from: decoder))
    }
    
    public func encode(to encoder: any Encoder) throws {
        try nodes
            .map { $0.value }
            .encode(to: encoder)
    }
}
