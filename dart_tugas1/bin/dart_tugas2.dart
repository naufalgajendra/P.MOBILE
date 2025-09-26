import 'dart:io';

class CurrencyConverter {
  // Kurs mata uang terhadap USD (sebagai base currency)
  final Map<String, double> exchangeRates = {
    'USD': 1.0,      // US Dollar (base)
    'IDR': 15420.0,  // Indonesian Rupiah
    'EUR': 0.92,     // Euro
    'GBP': 0.79,     // British Pound
    'JPY': 149.5,    // Japanese Yen
    'SGD': 1.35,     // Singapore Dollar
    'MYR': 4.68,     // Malaysian Ringgit
    'AUD': 1.53,     // Australian Dollar
  };

  final Map<String, String> currencyNames = {
    'USD': 'US Dollar',
    'IDR': 'Indonesian Rupiah',
    'EUR': 'Euro',
    'GBP': 'British Pound',
    'JPY': 'Japanese Yen',
    'SGD': 'Singapore Dollar',
    'MYR': 'Malaysian Ringgit',
    'AUD': 'Australian Dollar',
  };

  // Konversi dari satu mata uang ke mata uang lain
  double convert(double amount, String fromCurrency, String toCurrency) {
    if (!exchangeRates.containsKey(fromCurrency)) {
      throw ArgumentError('Mata uang $fromCurrency tidak tersedia');
    }
    if (!exchangeRates.containsKey(toCurrency)) {
      throw ArgumentError('Mata uang $toCurrency tidak tersedia');
    }

    // Konversi ke USD terlebih dahulu, kemudian ke target currency
    double usdAmount = amount / exchangeRates[fromCurrency]!;
    double result = usdAmount * exchangeRates[toCurrency]!;
    
    return result;
  }

  // Menampilkan daftar mata uang yang tersedia
  void showAvailableCurrencies() {
    print('\n=== MATA UANG YANG TERSEDIA ===');
    exchangeRates.forEach((code, rate) {
      print('$code - ${currencyNames[code]} (Rate: $rate USD)');
    });
    print('================================\n');
  }

  // Format angka dengan pemisah ribuan
  String formatCurrency(double amount, String currency) {
    String formattedAmount;
    
    if (currency == 'IDR' || currency == 'JPY') {
      // Untuk IDR dan JPY, tampilkan tanpa desimal
      formattedAmount = amount.toStringAsFixed(0);
    } else {
      // Untuk mata uang lain, tampilkan 2 desimal
      formattedAmount = amount.toStringAsFixed(2);
    }
    
    // Tambahkan pemisah ribuan (sederhana)
    List<String> parts = formattedAmount.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
    
    // Tambahkan koma sebagai pemisah ribuan
    String formatted = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formatted += ',';
      }
      formatted += integerPart[i];
    }
    
    return '$formatted$decimalPart $currency';
  }

  // Method utama untuk menjalankan kalkulator
  void run() {
    print('🌍 KALKULATOR KONVERSI MATA UANG 🌍');
    print('====================================');
    
    while (true) {
      try {
        // Tampilkan menu
        print('\nPilihan:');
        print('1. Konversi mata uang');
        print('2. Lihat daftar mata uang');
        print('3. Keluar');
        stdout.write('Pilih opsi (1-3): ');
        
        String? choice = stdin.readLineSync();
        
        switch (choice) {
          case '1':
            performConversion();
            break;
          case '2':
            showAvailableCurrencies();
            break;
          case '3':
            print('Terima kasih telah menggunakan kalkulator mata uang!');
            return;
          default:
            print('Pilihan tidak valid. Silakan pilih 1, 2, atau 3.');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void performConversion() {
    print('\n--- KONVERSI MATA UANG ---');
    
    // Input jumlah
    stdout.write('Masukkan jumlah: ');
    String? amountInput = stdin.readLineSync();
    if (amountInput == null || amountInput.isEmpty) {
      print('Jumlah tidak valid!');
      return;
    }
    
    double amount = double.tryParse(amountInput) ?? 0;
    if (amount <= 0) {
      print('Jumlah harus lebih besar dari 0!');
      return;
    }

    // Input mata uang asal
    stdout.write('Dari mata uang (contoh: USD, IDR, EUR): ');
    String? fromCurrency = stdin.readLineSync()?.toUpperCase();
    if (fromCurrency == null || !exchangeRates.containsKey(fromCurrency)) {
      print('Mata uang asal tidak valid!');
      return;
    }

    // Input mata uang tujuan
    stdout.write('Ke mata uang (contoh: USD, IDR, EUR): ');
    String? toCurrency = stdin.readLineSync()?.toUpperCase();
    if (toCurrency == null || !exchangeRates.containsKey(toCurrency)) {
      print('Mata uang tujuan tidak valid!');
      return;
    }

    // Lakukan konversi
    double result = convert(amount, fromCurrency, toCurrency);
    
    // Tampilkan hasil
    print('\n=== HASIL KONVERSI ===');
    print('${formatCurrency(amount, fromCurrency)}');
    print('= ${formatCurrency(result, toCurrency)}');
    
    // Tampilkan informasi rate
    double rate = result / amount;
    print('\nRate: 1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency');
    print('======================');
  }
}

// Class untuk demonstrasi penggunaan
class CurrencyConverterDemo {
  static void runDemo() {
    print('🔧 DEMO KONVERSI MATA UANG 🔧');
    print('==============================');
    
    CurrencyConverter converter = CurrencyConverter();
    
    // Demo konversi beberapa mata uang
    List<Map<String, dynamic>> demoConversions = [
      {'amount': 100.0, 'from': 'USD', 'to': 'IDR'},
      {'amount': 1000000.0, 'from': 'IDR', 'to': 'USD'},
      {'amount': 50.0, 'from': 'EUR', 'to': 'SGD'},
      {'amount': 200.0, 'from': 'GBP', 'to': 'JPY'},
      {'amount': 75.0, 'from': 'AUD', 'to': 'MYR'},
    ];
    
    for (var demo in demoConversions) {
      double amount = (demo['amount'] as num).toDouble();
      String from = demo['from'];
      String to = demo['to'];
      
      double result = converter.convert(amount, from, to);
      
      print('${converter.formatCurrency(amount, from)} = ${converter.formatCurrency(result, to)}');
    }
    
    print('\n==============================');
  }
}

void main() {
  print('Pilih mode:');
  print('1. Mode Interaktif');
  print('2. Mode Demo');
  stdout.write('Pilihan (1/2): ');
  
  String? choice = stdin.readLineSync();
  
  if (choice == '2') {
    CurrencyConverterDemo.runDemo();
  } else {
    CurrencyConverter converter = CurrencyConverter();
    converter.run();
  }
}