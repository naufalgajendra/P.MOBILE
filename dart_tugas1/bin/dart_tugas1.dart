import 'dart:io';

void main() {
  print('=== KALKULATOR BMI (Body Mass Index) ===');
  print('');
  
  // Input berat badan
  double? beratBadan;
  while (beratBadan == null) {
    stdout.write('Masukkan berat badan Anda (kg): ');
    String? inputBerat = stdin.readLineSync();
    beratBadan = double.tryParse(inputBerat ?? '');
    
    if (beratBadan == null || beratBadan <= 0) {
      print('❌ Input tidak valid! Masukkan angka yang benar.');
      beratBadan = null;
    }
  }
  
  // Input tinggi badan
  double? tinggiBadan;
  while (tinggiBadan == null) {
    stdout.write('Masukkan tinggi badan Anda (cm): ');
    String? inputTinggi = stdin.readLineSync();
    tinggiBadan = double.tryParse(inputTinggi ?? '');
    
    if (tinggiBadan == null || tinggiBadan <= 0) {
      print('❌ Input tidak valid! Masukkan angka yang benar.');
      tinggiBadan = null;
    }
  }
  
  // Konversi tinggi dari cm ke meter
  double tinggiMeter = tinggiBadan / 100;
  
  // Hitung BMI
  double bmi = hitungBMI(beratBadan, tinggiMeter);
  
  // Tampilkan hasil
  tampilkanHasil(beratBadan, tinggiBadan, bmi);
}

// Fungsi untuk menghitung BMI
double hitungBMI(double berat, double tinggiMeter) {
  return berat / (tinggiMeter * tinggiMeter);
}

// Fungsi untuk menentukan kategori BMI
String kategoriBMI(double bmi) {
  if (bmi < 18.5) {
    return 'Kurus (Underweight)';
  } else if (bmi >= 18.5 && bmi < 25.0) {
    return 'Normal';
  } else if (bmi >= 25.0 && bmi < 30.0) {
    return 'Gemuk (Overweight)';
  } else {
    return 'Obesitas';
  }
}

// Fungsi untuk memberikan saran berdasarkan BMI
String saranKesehatan(double bmi) {
  if (bmi < 18.5) {
    return '🍽️ Pertimbangkan untuk menambah asupan kalori dan konsultasi dengan ahli gizi.';
  } else if (bmi >= 18.5 && bmi < 25.0) {
    return '✅ BMI Anda normal! Pertahankan pola hidup sehat.';
  } else if (bmi >= 25.0 && bmi < 30.0) {
    return '⚖️ Pertimbangkan untuk mengatur pola makan dan olahraga teratur.';
  } else {
    return '⚠️ Disarankan konsultasi dengan dokter untuk program penurunan berat badan.';
  }
}

// Fungsi untuk menampilkan hasil lengkap
void tampilkanHasil(double berat, double tinggi, double bmi) {
  print('');
  print('=' * 50);
  print('              HASIL PERHITUNGAN BMI');
  print('=' * 50);
  print('Berat Badan    : ${berat.toStringAsFixed(1)} kg');
  print('Tinggi Badan   : ${tinggi.toStringAsFixed(1)} cm');
  print('BMI Anda       : ${bmi.toStringAsFixed(2)}');
  print('Kategori       : ${kategoriBMI(bmi)}');
  print('');
  print('💡 SARAN:');
  print(saranKesehatan(bmi));
  print('');
  print('📊 REFERENSI KATEGORI BMI:');
  print('• Kurus       : BMI < 18.5');
  print('• Normal      : BMI 18.5 - 24.9');
  print('• Gemuk       : BMI 25.0 - 29.9');
  print('• Obesitas    : BMI ≥ 30.0');
  print('=' * 50);
}