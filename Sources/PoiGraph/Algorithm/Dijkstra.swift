//
//  Dijkstra.swift
//  PoiGraph
//
//  Created by Ömer Faruk Gökce on 8.05.2025.
//

enum Dijkstra {
    
    /// A wrapper for nodes used in the priority queue, with comparison based on cost.
    private struct HeapElement: Comparable {
        
        let node: Node
        let cost: Double
        
        static func < (lhs: Dijkstra.HeapElement, rhs: Dijkstra.HeapElement) -> Bool {
            lhs.cost < rhs.cost
        }
    }
    
    /// Finds the shortest path in a graph from a starting node to the nearest node with a given `PointType`.
    ///
    /// - Parameters:
    ///   - graph: The graph in which the path is to be found.
    ///   - startNode: The node to start the search from.
    ///   - targetPointType: The desired `PointType` (e.g., `.wc`) to find.
    /// - Returns: A `Path` object containing the nodes and total distance, or `nil` if unreachable.
    ///
    /// - Complexity:
    ///   - Time: `O((V + E) * log V)`
    ///   - Space: `O(V)`
    ///   - V = number of nodes, E = number of edges
    static func shortestPath(in graph: Graph, from startNode: Node, to targetPointType: PointType) -> Path? {
        var distances: [Node: Double] = [startNode: 0]
        var previous: [Node: Node] = [:]
        var visited: Set<Node> = []
        var queue = Heap<HeapElement>()
        
        queue.enqueue(HeapElement(node: startNode, cost: 0))
        
        while let current = queue.dequeue() {
            // Skip already visited nodes
            guard !visited.contains(current.node) else { continue }
            visited.insert(current.node)
            
            // If we reached the desired point type, reconstruct the path
            if current.node.pointType == targetPointType {
                
                var path: [Node] = []
                var node: Node? = current.node
                while let n = node {
                    path.insert(n, at: 0)
                    node = previous[n]
                }
                return Path(nodes: path, distance: current.cost)
            }
            
            // Explore neighbors
            for edge in current.node.edges {
                let neighbor = graph.nodes[edge.key]
                let newCost = current.cost + edge.value
                
                guard let neighbor else { continue }
                
                // Update the distance and previous node if a shorter path is found
                if newCost < (distances[neighbor] ?? .infinity) {
                    distances[neighbor] = newCost
                    previous[neighbor] = current.node
                    queue.enqueue(HeapElement(node: neighbor, cost: newCost))
                }
            }
        }
        
        // No path found
        return nil
    }
}
