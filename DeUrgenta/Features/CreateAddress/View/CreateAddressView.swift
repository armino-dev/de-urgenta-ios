import MapKit
import SwiftUI

protocol CreateAddressViewDelegate {
    func createAddressViewDidTapAddAddress(_ view: CreateAddressView)
    func createAddressViewDidTapNoAddAddress(_ view: CreateAddressView)
}

struct CreateAddressView: View {
    private var title: String = "Adauga-ti adresa de domiciliu"
    @State private var searchText = ""
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)) // Default map region
    @State private var mapItems: [MKMapItem] = []

    // Autocomplete suggestions
    @State private var searchCompleter = MKLocalSearchCompleter()
    @State private var searchResults: [MKLocalSearchCompletion] = []

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "xmark")
                    Text(title)
                        .bold()
                        .frame(height: 24)
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.horizontal, 20)
                TextField("Cauta o adresa", text: $searchText)
                    .frame(height: 42)
                    .textFieldStyle(SearchTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .overlay(
                        HStack {
                            Spacer()
                            if searchText.isEmpty {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 30)
                            }
                        }
                    )
            }
            .background(Color(hex: "#ec1a3a"))

            if searchText != "" {
                List(searchResults, id: \.self) { completion in
                    Text(completion.title)
                        .onTapGesture {
                            // Handle selection of autocomplete suggestion
                            // For example, update map region or perform search
                            searchSelected(completion)
                        }
                }
                .frame(maxHeight: .infinity)
            }

            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Map(coordinateRegion: $mapRegion, showsUserLocation: true, userTrackingMode: .constant(.follow))

                Button(action: {
                    getUserLocation()
                }) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .frame(width: 20, height: 20)
                    Text("Localizeaza-ma")
                        .multilineTextAlignment(.leading)
                        .padding(10)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity)
                }
                .background(Color(hex: "#ec1a3a"))
                .frame(width: UIScreen.main.bounds.width / 2 - 20)
                .cornerRadius(5)
                .padding(20)
            }
            .frame(maxHeight: .infinity)
        }
        .onChange(of: searchText) { newValue in
            // Update autocomplete suggestions when text changes
            searchCompleter.queryFragment = newValue
        }
        .onChange(of: searchCompleter.results) { newResults in
            // Update search results when autocomplete suggestions change
            searchResults = newResults.map { $0 }
        }
    }

    func getUserLocation() {
        // Your implementation for getting user location
        print("get user location")
    }

    // Handle selection of autocomplete suggestion
    func searchSelected(_ completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)

        search.start { response, _ in
            guard let mapItem = response?.mapItems.first else {
                // Handle error or no results
                return
            }

            // Set the map location to the selected location
            mapRegion = MKCoordinateRegion(center: mapItem.placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

            // searchText = "";
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct AddressPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAddressView()
    }
}

extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

struct SearchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.leading, 10)
            .padding(.vertical, 10)
            .background(.white)
            .cornerRadius(5)
            .font(Font.system(size: 18))
    }
}
