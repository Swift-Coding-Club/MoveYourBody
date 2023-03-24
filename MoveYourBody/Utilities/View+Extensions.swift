//
//  View+Extensions.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/24.
//

import SwiftUI

extension View {
    func sync(_ published: Binding<Int>, with binding: Binding<Int>) -> some View {
        self
            .onChange(of: published.wrappedValue) { published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { binding in
                published.wrappedValue = binding
            }
    }
}
