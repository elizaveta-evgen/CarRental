//
//  FiltersView.swift
//  CarRental
//
//  Created by Elizaveta Evgenia on 09.07.2026.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss

    private let onApply: (CarFilter) -> Void

    @State private var brand: CarBrand?
    @State private var bodyType: BodyType?
    @State private var transmission: Transmission?
    @State private var steering: Steering?
    @State private var color: CarColor?
    @State private var minPriceText: String
    @State private var maxPriceText: String

    init(initialFilter: CarFilter, onApply: @escaping (CarFilter) -> Void) {
        self.onApply = onApply
        self._brand = State(initialValue: initialFilter.brand)
        self._bodyType = State(initialValue: initialFilter.bodyType)
        self._transmission = State(initialValue: initialFilter.transmission)
        self._steering = State(initialValue: initialFilter.steering)
        self._color = State(initialValue: initialFilter.color)
        self._minPriceText = State(initialValue: initialFilter.minPrice.map(String.init) ?? "")
        self._maxPriceText = State(initialValue: initialFilter.maxPrice.map(String.init) ?? "")
    }

    var body: some View {
        self.content
    }
}

private extension FiltersView
{
    var content: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    self.brandSection
                    self.bodyTypeSection
                    self.steeringSection
                    self.transmissionSection
                    self.priceSection
                    self.colorSection
                }
                .padding()
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Фильтры")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                self.actions
            }
        }
    }

    var brandSection: some View {
        self.section(title: "Марка") {
            Menu {
                Button("Любая") { self.brand = nil }
                ForEach(CarBrand.allCases, id: \.self) { item in
                    Button(item.title) { self.brand = item }
                }
            } label: {
                self.dropdownLabel(self.brand?.title ?? "Выберите марку")
            }
        }
    }

    var bodyTypeSection: some View {
        self.section(title: "Тип кузова") {
            Menu {
                Button("Любой") { self.bodyType = nil }
                ForEach(BodyType.allCases, id: \.self) { item in
                    Button(item.title) { self.bodyType = item }
                }
            } label: {
                self.dropdownLabel(self.bodyType?.title ?? "Выберите тип кузова")
            }
        }
    }

    var steeringSection: some View {
        self.section(title: "Руль") {
            Picker("Руль", selection: self.$steering) {
                Text("Любой").tag(Steering?.none)
                ForEach(Steering.allCases, id: \.self) { item in
                    Text(item.title).tag(Steering?.some(item))
                }
            }
            .pickerStyle(.segmented)
        }
    }

    var transmissionSection: some View {
        self.section(title: "Коробка передач") {
            Picker("Коробка передач", selection: self.$transmission) {
                Text("Любая").tag(Transmission?.none)
                ForEach(Transmission.allCases, id: \.self) { item in
                    Text(item.title).tag(Transmission?.some(item))
                }
            }
            .pickerStyle(.segmented)
        }
    }

    var priceSection: some View {
        self.section(title: "Стоимость, ₽") {
            HStack(spacing: 12) {
                self.priceField(placeholder: "От", text: self.$minPriceText)
                self.priceField(placeholder: "До", text: self.$maxPriceText)
            }
        }
    }

    var colorSection: some View {
        self.section(title: "Цвет") {
            HStack(spacing: 12) {
                ForEach(CarColor.allCases, id: \.self) { item in
                    self.colorSwatch(item)
                }
            }
        }
    }

    var actions: some View {
        VStack(spacing: 12) {
            Button {
                self.onApply(CarFilter())
                self.dismiss()
            } label: {
                Text("Сбросить фильтры")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            Button {
                self.onApply(self.buildFilter())
                self.dismiss()
            } label: {
                Text("Найти")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding()
        .background(.regularMaterial)
    }

    func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            content()
        }
    }

    func dropdownLabel(_ text: String) -> some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    func priceField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .keyboardType(.numberPad)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    func colorSwatch(_ item: CarColor) -> some View {
        Circle()
            .fill(self.swatchColor(item))
            .frame(width: 34, height: 34)
            .overlay {
                Circle().stroke(Color(.systemGray4), lineWidth: 1)
            }
            .overlay {
                if self.color == item {
                    Circle().stroke(Color.blue, lineWidth: 3)
                }
            }
            .onTapGesture {
                self.color = self.color == item ? nil : item
            }
    }

    func swatchColor(_ item: CarColor) -> Color {
        switch item {
        case .black: .black
        case .white: .white
        case .red: .red
        case .silver: Color(.systemGray3)
        case .blue: .blue
        case .grey: .gray
        case .orange: .orange
        }
    }

    func buildFilter() -> CarFilter {
        CarFilter(
            search: "",
            brand: self.brand,
            bodyType: self.bodyType,
            transmission: self.transmission,
            steering: self.steering,
            color: self.color,
            minPrice: Int(self.minPriceText),
            maxPrice: Int(self.maxPriceText)
        )
    }
}
