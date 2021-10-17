//
//  ContentView.swift
//  IphoneStore
//
//  Created by Edi Sunardi on 03/02/21.
//

import SwiftUI

struct ProductModel: Identifiable {
    let id: Int
    let namaProduk: String
    let fotoProduk: String
    let hargaProduk: Int
    let lokasi: String
    let ratingCount: Int
    let jumlahRating: Int
    
    init(id: Int, namaproduk: String, fotoproduk: String, hargaproduk: Int, lokasi: String, ratingcount: Int, jumlahrating: Int){
        
        self.id = id
        self.namaProduk = namaproduk
        self.fotoProduk = fotoproduk
        self.hargaProduk = hargaproduk
        self.lokasi = lokasi
        self.ratingCount = ratingcount
        self.jumlahRating = jumlahrating
        
    }
    
}

struct ContentView: View {
    
    private var gridItem = [GridItem(.flexible()),GridItem(.flexible())]
    
    let data : [ProductModel] = [
        ProductModel(id: 0, namaproduk: "iPhone 12 Pro Max", fotoproduk: "iphone0", hargaproduk: 22999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 1, namaproduk: "iPhone 12 mini", fotoproduk: "iphone1", hargaproduk: 12999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 2, namaproduk: "iPhone SE 2nd Gen", fotoproduk: "iphone2", hargaproduk: 7499000, lokasi: "Jakarta", ratingcount: 5, jumlahrating: 56),
        ProductModel(id: 3, namaproduk: "iPhone 11 Pro", fotoproduk: "iphone3", hargaproduk: 20999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 4, namaproduk: "iPhone 11", fotoproduk: "iphone4", hargaproduk: 22999000, lokasi: "Jakarta", ratingcount: 3, jumlahrating: 56),
        ProductModel(id: 5, namaproduk: "iPhone XR", fotoproduk: "iphone5", hargaproduk: 9299000, lokasi: "Jakarta", ratingcount: 5, jumlahrating: 56),
        ProductModel(id: 6, namaproduk: "iPhone XS Max", fotoproduk: "iphone6", hargaproduk: 17999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 7, namaproduk: "iPhone X ", fotoproduk: "iphone7", hargaproduk: 14999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 8, namaproduk: "iPhone 8", fotoproduk: "iphone8", hargaproduk: 8499000, lokasi: "Jakarta", ratingcount: 5, jumlahrating: 56),
        ProductModel(id: 9, namaproduk: "iPhone 7", fotoproduk: "iphone9", hargaproduk: 7999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 56),
        ProductModel(id: 10, namaproduk: "iPhone X", fotoproduk: "iphone9", hargaproduk: 7999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 60),
        ProductModel(id: 11, namaproduk: "iPhone XR", fotoproduk: "iphone9", hargaproduk: 7999000, lokasi: "Jakarta", ratingcount: 4, jumlahrating: 60),
        
    ]
    
    @State var jumlahkeranjang: Int = 0
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: gridItem){
                    ForEach(data){ row in
                        VStack{
                            Product(data: row,  jumlahproduk: self.$jumlahkeranjang)
                        }
                        .padding()
                        .frame(height: 400)
                    }
                }
            }
            .navigationBarTitle("IBox")
            .navigationBarItems(
                    trailing:
                        HStack{
                            Button(action: {print()}){
                                Image(systemName: "heart")
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                            }
                            
                            keranjangView(jumlah: $jumlahkeranjang)
                        }
            )
        }
    }
}

struct keranjangView : View {
    @Binding var jumlah: Int
    
    var body : some View {
        ZStack{
            Button(action: {print("Oke")}){
                Image(systemName: "bag")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width:20, height:20)
                
            }
            
            Text("\(jumlah)")
                .foregroundColor(Color.white)
                .frame(width:10, height:10)
                .font(.body)
                .padding(5)
                .background(Color.red)
                .clipShape(Circle())
                .offset(x:10,y:-10)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Product: View {
    
    let data: ProductModel
    
    @Binding var jumlahproduk: Int
    
    var body: some View {
        
            VStack{
                //Foto
                VStack{
                    ZStack(alignment:.topTrailing){
                        Image(self.data.fotoProduk)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .cornerRadius(15)
                            .clipped()
                        Button(action: {print("OK")}){
                            Image(systemName: "heart")
                                .padding()
                                .foregroundColor(Color.black)
                        }
                        
                        
                    }
                    
                    VStack(alignment:.leading){
                        //Text
                        Text(self.data.namaProduk)
                            .font(.title3)
                            .bold()
                            .padding(.leading)
                            .padding(.trailing)
                        Text("Rp.\(self.data.hargaProduk)")
                            .font(.title3)
                            .foregroundColor(.orange)
                            .bold()
                            .padding(.leading)
                            .padding(.trailing)
                        
                        HStack{
                            Image(systemName: "mappin.circle")
                            Text(self.data.lokasi)
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        
                        HStack{
                            HStack{
                                //Menghitung Bintang
                                ForEach(0..<self.data.ratingCount){
                                    items in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.leading)
                            .padding(.trailing)
                            
                        }
                    }
                    
                    //buat komponen baru jumlah
                    //ambil data binding dari komponen tambahkeranjang
                    tambahKeranjang(jumlah: $jumlahproduk)
                   
                    
                }
                .background(Color("AccentColor"))
                .cornerRadius(15)
                
            }
            .padding()
    }
}

//button tambah keranjang
struct tambahKeranjang : View {
    //buat binding data
    @Binding var jumlah: Int
    
    var body : some View {
        Button(action: {self.jumlah += 1}){
            HStack{
                Spacer()
                HStack{
                    Image(systemName: "cart")
                    Text("Keranjang")
                        .font(.callout)
                        .padding()
                }
                Spacer()
                
            }
        }
        .background(Color.black)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding(10)
    }
}
