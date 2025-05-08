//
//  Heap.swift
//  PoiGraph
//
//  Created by Ömer Faruk Gökce on 8.05.2025.
//

/// A min-heap implementation for Comparable elements.
struct Heap<Element> where Element: Comparable {
    
    private var storage: [Element] = []
    
    init() { }

    /// Inserts an element into the heap and maintains the heap property.
    ///
    /// - Complexity: Time `O(log n)`, Space `O(1)`
    mutating func enqueue(_ element: Element) {
        storage.append(element)
        siftUp(from: storage.count - 1)
    }

    /// Removes and returns the smallest element from the heap.
    ///
    /// - Complexity: Time `O(log n)`, Space `O(1)`
    mutating func dequeue() -> Element? {
        guard !storage.isEmpty else { return nil }
        if storage.count == 1 { return storage.removeFirst() }
        let top = storage[0]
        storage[0] = storage.removeLast()
        siftDown(from: 0)
        return top
    }

    /// Restores the heap property by shifting the element at `index` upwards.
    ///
    /// - Parameter index: Index of the element to sift up.
    /// - Complexity: Time `O(log n)`, Space `O(1)`
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0, storage[child] < storage[parent] {
            storage.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    /// Restores the heap property by shifting the element at `index` downwards.
    ///
    /// - Parameter index: Index of the element to sift down.
    /// - Complexity: Time `O(log n)`, Space `O(1)` 
    private mutating func siftDown(from index: Int) {
        var parent = index
        var candidate = parent
        let bound = storage.count
        
        repeat {
            let left = 2 * parent + 1
            let right = 2 * parent + 2

            if left < bound, storage[left] < storage[candidate] {
                candidate = left
            }
            
            if right < bound, storage[right] < storage[candidate] {
                candidate = right
            }
            
            storage.swapAt(parent, candidate)
            parent = candidate
        } while candidate != parent
    }
}
