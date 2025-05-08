//
//  Path.swift
//  PoiGraph
//
//  Created by Ömer Faruk Gökce on 8.05.2025.
//

/// Represents a path through a graph.
public struct Path {
    /// The ordered sequence of nodes visited in the path.
    public let nodes: [Node]
    
    /// The total cost/distance of the path.
    public let distance: Double
}
