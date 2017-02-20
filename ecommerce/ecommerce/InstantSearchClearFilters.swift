//
//  InstantSearchClearFilters.swift
//  ecommerce
//
//  Created by Guy Daher on 17/02/2017.
//  Copyright © 2017 Guy Daher. All rights reserved.
//

import Foundation
import UIKit

extension InstantSearch {
    func addWidget(clearFilter: UIControl, for controlEvent: UIControlEvents) {
        clearFilters.append(clearFilter)
        clearFilter.addTarget(self, action: #selector(self.clearFilter), for: controlEvent)
        reloadAllWidgets()
    }
    
    internal func clearFilter() {
        searcher.params.clearRefinements()
        searcher.search()
        reloadAllWidgets()
    }
}