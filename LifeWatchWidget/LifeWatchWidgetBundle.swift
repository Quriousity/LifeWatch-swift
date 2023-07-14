//
//  LifeWatchWidgetBundle.swift
//  LifeWatchWidget
//
//  Created by Q on 2023/07/14.
//

import WidgetKit
import SwiftUI

@main
struct LifeWatchWidgetBundle: WidgetBundle {
    var body: some Widget {
        LifeWatchWidget()
        LifeWatchWidgetLiveActivity()
    }
}
