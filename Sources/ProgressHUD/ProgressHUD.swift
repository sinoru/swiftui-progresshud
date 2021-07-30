//
//  ProgressHUD.swift
//  
//
//  Created by Jaehong Kang on 2021/07/30.
//

import SwiftUI

struct ProgressHUD<Label, CurrentValueLabel>: ViewModifier where Label : View, CurrentValueLabel : View {
    @Binding private var isPresented: Bool
    private let progressView: ProgressView<Label, CurrentValueLabel>

    func body(content: Content) -> some View {
        if isPresented {
            ZStack {
                content
                    .disabled(true)

                Rectangle()
                    .fill(Color.systemFill)
                    .ignoresSafeArea()
                    .overlay(
                        VStack() {
                            progressView
                        }
                        .padding()
                        .background(Color.systemBackground)
                        .cornerRadius(10)
                        .shadow(radius: 10),
                        alignment: .center
                    )
            }
        } else {
            content
        }
    }

    init(isPresented: Binding<Bool>, progressView: ProgressView<Label, CurrentValueLabel>) {
        self._isPresented = isPresented
        self.progressView = progressView
    }
}

extension View {
    public func progressHUD<V, Label, CurrentValueLabel>(isPresented: Binding<Bool>, value: V? = nil, total: V = 1.0, @ViewBuilder label: () -> Label, @ViewBuilder currentValueLabel: () -> CurrentValueLabel) -> some View where V: BinaryFloatingPoint, Label: View, CurrentValueLabel: View {
        modifier(
            ProgressHUD(
                isPresented: isPresented,
                progressView: ProgressView(value: value, total: total, label: label, currentValueLabel: currentValueLabel)
            )
        )
    }

    public func progressHUD<V, Label>(isPresented: Binding<Bool>, value: V? = nil, total: V = 1.0, @ViewBuilder label: () -> Label) -> some View where V: BinaryFloatingPoint, Label: View {
        modifier(
            ProgressHUD(
                isPresented: isPresented,
                progressView: ProgressView(value: value, total: total, label: label)
            )
        )
    }

    public func progressHUD<V>(isPresented: Binding<Bool>, value: V? = nil, total: V = 1.0) -> some View where V: BinaryFloatingPoint {
        modifier(
            ProgressHUD(
                isPresented: isPresented,
                progressView: ProgressView(value: value, total: total)
            )
        )
    }

    public func progressHUD<Label>(isPresented: Binding<Bool>, @ViewBuilder label: () -> Label) -> some View where Label: View {
        modifier(
            ProgressHUD(
                isPresented: isPresented,
                progressView: ProgressView(label: label)
            )
        )
    }

    public func progressHUD(isPresented: Binding<Bool>) -> some View {
        modifier(
            ProgressHUD(
                isPresented: isPresented,
                progressView: ProgressView()
            )
        )
    }
}

#if DEBUG
struct ProgressHUD_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .foregroundColor(.blue)
            .overlay(
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 250, height: 250)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                            .progressHUD(isPresented: .constant(true))
                    )
            )

        Rectangle()
            .foregroundColor(.blue)
            .overlay(
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: 250, height: 250)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                            .progressHUD(isPresented: .constant(true)) {
                                Text("Loading...")
                            }
                    )
            )
    }
}
#endif
