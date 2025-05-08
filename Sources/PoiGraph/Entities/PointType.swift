//
//  PointType.swift
//  PoiGraph
//
//  Created by Ömer Faruk Gökce on 5.05.2025.
//

/// Represents the type of a node in the graph.
public enum PointType: String, Codable, Sendable, CaseIterable {
    /// A regular point of interest.
    case point
    /// A point representing a WC.
    case wc
}
