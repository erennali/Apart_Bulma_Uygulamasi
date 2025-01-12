# 🏠 Apart Bulma Uygulaması

Apart Bulma Uygulaması, apart ilanlarını kolayca oluşturabileceğiniz, diğer kullanıcıların ilanlarını görüntüleyebileceğiniz bir mobil uygulamadır. **Flutter** ile geliştirilmiş ve **Firebase** altyapısını kullanmaktadır.

---

## 📋 Özellikler

### 🔑 Kullanıcı Girişi ve Çıkışı
- Firebase Authentication ile kullanıcılar:
  - E-posta ve şifre kullanarak giriş yapabilir.
  - Yeni hesap oluşturabilir.
  - Çıkış işlemi gerçekleştirebilir.

### 🏠 Apart İlanı Verme
- Kullanıcılar yeni apart ilanları oluşturabilir.
- İlan detayları:
  - Başlık
  - Açıklama
  - Fiyat
  - Konum
  - M2
  - Kiralık/Satılık

### 🔍 Apart Arama ve Filtreleme
- İlanlar ücret kriterine göre filtrelenebilir.
- Detaylı apart bilgilerini görüntüleme özelliği.

### 📁 Tutulan Apartlar
- Kullanıcılar, tuttukları apartların listesini ayrı bir menüde görüntüleyebilir.
- Kullanıcılar, tutulan apartlarının listesini ayrı bir menüde görüntüleyebilir.

### 👤 Profil Menüsü
- Kullanıcılar:
  - Kendi bilgilerini (e-posta, kullanıcı adı vb.) görüntüleyebilir.
  - Profil menüsünden erişebilir.

### 🔒 Şifre Sıfırlama
- Kullanıcılar, şifrelerini unutursa Firebase sayesinde e-postalarına şifre sıfırlama bağlantıları gönderebilir.


---

## 🛠️ Teknolojiler ve Araçlar
- **Flutter**: Mobil uygulama geliştirme.
- **Firebase**: 
  - Authentication: Kullanıcı oturum yönetimi.
  - Firestore: Apart ilanlarının saklanması ve yönetimi.
- **Dart**: Flutter uygulaması için programlama dili.

---

## 📦 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK
- Dart SDK
- Firebase Projesi (Authentication ve Firestore yapılandırılmış)

### Adımlar
1. **Proje Depolarını Klonlayın**:
   ```bash
   git clone https://github.com/erennali/Apart_Bulma_Uygulamasi.git
