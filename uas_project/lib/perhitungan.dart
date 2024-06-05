class Perhitungan {
  static int hitungTotalHarga(List<int> hargaTiket) {
    return hargaTiket.fold(0, (prev, harga) => prev + harga);
  }
}
