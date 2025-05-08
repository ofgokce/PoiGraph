# PoiGraph

PoiGraph is a Swift library for working with directed, weighted graphs. It enables finding the shortest path between nodes based on point types using Dijkstra’s algorithm.

## Features

- Lightweight graph structure using `Node` and `Graph`
- Flexible support for edge weights
- Dijkstra's algorithm for shortest path discovery
- Codable support for easy persistence
- Extensible PointType enumeration

## Installation

To add `PoiGraph` to your Swift project, use Swift Package Manager:

```swift
.package(url: "https://github.com/ofgokce/PoiGraph.git", from: "1.0.0")
```

## Framework Usage

1. Create Nodes from JSON
Make sure your graph.json follows this structure:

```json
{
  "id": "A",
  "pointType": "point",
  "edges": [
    { "id": "B", "weight": 2.0 },
    { "id": "C", "weight": 5.0 }
  ]
}
```
2. Decode into a Graph

```swift
let graph = try decoder.decode(Graph.self, from: jsonData)
```

3. Find the Nearest WC (or other PointType)
```swift
let path = graph.shortestPath(from: "A", to: .wc)
print(path?.distance ?? "Not found")
```

## Architecture & Design Choices

Graph Representation: The graph is modelled with a dictionary of Nodes keyed by their ID for fast lookup. Nodes contain edges as ID-to-weight mappings.

Pathfinding: Dijkstra’s algorithm is implemented in Algorithm.swift using a min-heap priority queue for optimal performance.

Modularity: The graph core is fully reusable across iOS/macOS projects and can be easily unit tested.

Codable Support: Both Node and Graph conform to Codable for easy JSON decoding.

Thread-Safe & Sendable: All public entities conform to Sendable where applicable for safe concurrent access.


## Requirements Coverage

✅ Parses graph.json

✅ Identifies node types using PointType

✅ Finds the closest node of a specific type

✅ Fully modular Swift framework

✅ Well-documented and maintainable codebase

✅ [Example application](https://github.com/ofgokce/PoiGraphTester)
