//
//  LifeWatchWidget.swift
//  LifeWatchWidget
//
//  Created by Q on 2023/07/14.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LifeWatchWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(Calendar.current.date(byAdding: .year, value: Int(dataFromApp)!, to: Date())!, style: .timer)
                .multilineTextAlignment(.center)
                .font(.custom("Seven Segment", size: 20))
                .foregroundColor(Color.red)
        }
    }
    private var dataFromApp: String {
        if let userDefaults = UserDefaults(suiteName: "group.com.LifeWatch230628") {
            let a: String = userDefaults.string(forKey: "a")!
            return a
        }
        return ""
        
    }
}

struct LifeWatchWidget: Widget {
    let kind: String = "LifeWatchWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LifeWatchWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,

            // Add Support to Lock Screen widgets
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline,
        ])
    }
}

struct LifeWatchWidget_Previews: PreviewProvider {
    static var previews: some View {
        LifeWatchWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
