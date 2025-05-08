//
//  Node.swift
//  PoiGraph
//
//  Created by Ömer Faruk Gökce on 5.05.2025.
//

/// A node within a graph, uniquely identified by an ID.
public struct Node {
    /// The unique identifier for the node.
    public let id: String
    
    /// Outgoing edges from this node.
    /// The dictionary keys are the IDs of destination nodes,
    /// and values are the edge weights (e.g., distance or cost).
    public let edges: [String: Double]
    
    /// The type of point this node represents (e.g., wc or regular).
    public let pointType: PointType
}

extension Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

extension Node: Sendable {
    
}

extension Node: Codable {
    
    private struct Edge: Codable {
        let id: String
        let weight: Double
    }
    
    enum CodingKeys: CodingKey {
        case id
        case edges
        case pointType
    }
    
    public init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init(
            
            id: try container
                .decode(String.self, forKey: .id),
            
            edges: try container
                .decode([Edge].self, forKey: .edges)
                .reduce(into: [:]) {
                    $0[$1.id] = $1.weight
                },
            
            pointType: try container
                .decode(PointType.self, forKey: .pointType)
        )
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(edges.map({ Edge(id: $0.key, weight: $0.value) }), forKey: .edges)
        try container.encode(pointType, forKey: .pointType)
    }
}
