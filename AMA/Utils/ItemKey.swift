//
//  ItemKey.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/28.
//

import NMapsMap

class ItemKey: NSObject, NMCClusteringKey {
    let identifier: Int
    let position: NMGLatLng

    init(identifier: Int, position: NMGLatLng) {
        self.identifier = identifier
        self.position = position
    }

    static func markerKey(withIdentifier identifier: Int, position: NMGLatLng) -> ItemKey {
        return ItemKey(identifier: identifier, position: position)
    }

    override func isEqual(_ o: Any?) -> Bool {
        guard let o = o as? ItemKey else {
            return false
        }
        if self === o {
            return true
        }

        return o.identifier == self.identifier
    }

    override var hash: Int {
        return self.identifier
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return ItemKey(identifier: self.identifier, position: self.position)
    }
}
