![image](https://github.com/user-attachments/assets/b2fb2d70-c75a-4fe5-ae4a-0efbc28b3e45)

# Aztec Sequencer Node Kurulumu

# [Kurulum Videosu](https://youtu.be/QIm5Jxg-TAk) 

## Sunucu Gereksinimleri

RAM : 16GB

CPU : 8 CORE (4-6'da olur fakat imkan varsa 8 olsun)

SSD : 100GB+

Ubuntu 22.04

# ÖNEMLİ ! Videodan sonra bazı değişiklikler oldu videodan farklı giden yerlerde lütfen rehberi okuyarak takip edin, ücretsiz RPC'ler bir süre sonra kota dolduğu için hata veriyor uzun süreli çalıştıracaksanız ücretli RPC şart.

## Kuruluma Başlamadan Önce Yapılacak Hazırlıklar


İlk önce bir [Metamask](https://metamask.io) cüzdanı oluşturalım ve sepolia test ağında ETH [Faucet](https://sepolia-faucet.pk910.de/) alalım.(ilk başta 0.1 ETH yeterli olur kurulumu yaptıktan sonra arada kazın 3-4 tane biriktirin lazım olabilir.)

Daha sonra [Alchemy](https://dashboard.alchemy.com/) , [Infura](http://infura.io/) ve [Quicknode](https://www.quicknode.com/) sitesine kayıt olup 3'ünden de Sepolia RPC alalım.

Ücretsiz Beacon RPC için [Chainstack](https://console.chainstack.com/) kullanabilirsiniz.

Ücretli RPC için [dRPC](https://drpc.org/) veya yukarıdaki siteleri kullanabilirsiniz fiyatlarına bakın hangisi uygunsa onu alırsınız, hem Sepolia hem Beacon için.

Sonrasında Aztec'in [Discord](https://discord.com/invite/aztec) kanalına girelim.

# Node Kurulum Adımları

Sunucuya bağlandıktan sonra aşağıdaki kodu yapıştırıp enterlayın

```
wget https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/script.sh && chmod +x script.sh && ./script.sh
```

Eğer karşınıza "[Y/n]" çıkarsa "y" yazıp enterlayın veya aşağıdaki görseldeki gibi birşey çıkarsa(çıkmayabilir) "TAB" tuşuna basarak "OK" yazısına gelin ve enterlayın, bu aşamada karşınıza çıkan hepsine "OK" diyin.

![image](https://github.com/user-attachments/assets/a1bb0941-4d66-4a8b-9bc7-308572310266)

Aşağıdaki yere geldiğinizde "y" tuşuna basın, sonrasında tekrar soracak tekrar "y" yazıp enterlayın

![image](https://github.com/user-attachments/assets/5c70d387-b725-4638-a8b1-385819dab1a4)

Bu adımda Sepolia RPC istemek yerine aşağıdaki gibi bir ekran veya herhangi bir hata gelirse sunucudan çıkıp tekar geri bağlanın ve bu kodu girin ; (eğer kuruluma devam ederse burayı atlayın )

```
bash ~/script.sh
```

![image](https://github.com/user-attachments/assets/87db0344-aa1e-43af-893b-b1dcf0786530)


Yükleme bittikten sonra sizden "Sepolia RPC" isteyecek, kayıt olduğumuz alchemy sitesine gidip endpointe tıklayalım.Diğer sitelerden de benzer şekilde Sepolia RPC'leri alın.("My Apps" kısmında birşey yoksa sağ tarafta "Create New App" yazıyor ona tıklayıp oluşturun)

![image](https://github.com/user-attachments/assets/c6dd0a5a-bc30-4d46-a208-7af771987a5b) 

Sepolia'yı seçip RPC'yi kopyalayın ve terminale dönüp yapıştırıp enterlayın

![image](https://github.com/user-attachments/assets/f1494a00-412a-4e67-8870-64e693f6921a)
![image](https://github.com/user-attachments/assets/a3fe3266-2b75-45c5-938a-235e3032e3f9)


Sonrasında metamask özel anahtarınızı isteyecek onu da yapıştırıp enterlayın

![image](https://github.com/user-attachments/assets/aa8e27e4-b691-4fb8-9b95-d06235fb529e)


Sonra metamask adresinizi isteyecek onu da yapıştırıp enterlayın

![image](https://github.com/user-attachments/assets/d10cfae8-e1a1-447a-a9e2-49dd14a8f083)

Son olarak sunucu ip adresinizi yazıp enterlayın

![image](https://github.com/user-attachments/assets/1a5f16cd-379b-4740-9d1b-9cef7a039d69)

Screen'e girelim

```
screen -r aztec
```

![image](https://github.com/user-attachments/assets/2a055eb6-53bd-46db-ba4c-9b63e59b2d1a)

Biraz bekleyin ve loglar akmaya başlayınca " CTRL + A + D " ile screen'den çıkın ve aşağıdaki kodu girin

```
bash ~/base64.sh
```
Size verdiği bu uzun kodu bir yere kaydedin şimdi discord işlemlerini yapacağız

![image](https://github.com/user-attachments/assets/ed506ed1-f136-43e2-9bc8-454502715e11)

Discord'da [operators|start-here](https://discord.com/channels/1144692727120937080/1367196595866828982) kanalına gidin ve "/operator start" yazın aşağıdaki görseldeki gibi doldurun.

Adress kısmına metamask cüzdan adresinizi.

Block-number yazan yere az önce yazdığınız kodun çıktısındaki son blok numarasını.

Proof yazan yere aldığınız uzun çıktıyı yazıp enterlayın.

![image](https://github.com/user-attachments/assets/a2adec9c-171a-4c25-a2dc-d3318ea40ed5)

Bu işlemi yaptıktan sonra "Apprentice" rolünü almış olmanız gerekiyor, isminizin üstüne tıklayarak kontrol edin

![image](https://github.com/user-attachments/assets/b14bd8c4-3991-488d-8e22-b885789361e8)


Son olarak da aşağıki kod ile validatör kaydı yapalım.

```
bash ~/validator.sh
```
Yine aynı şekilde sizden istediği bilgileri girin.

Günlük belirli bir kayıt limiti olduğu için her zaman kayıt etmiyor eğer günlük limit doluysa şu şekilde bir çıktı alırsınız, kayıt olana kadar gün aşırı denersiniz.(Kayıt olurken gaz ücreti hatası vererek 2.3 ETH istemişti attım fakat yine kota doldu dedi, kayıt için ETH miktarını yüksek istiyor, cüzdanda fazla tutun)

![image](https://github.com/user-attachments/assets/85281adf-b28e-4dab-a8af-d6e03aa3dfeb)

İşlemler bu kadar.

Eğer node durursa aşağıdaki kodu screen içerisindeyken çalıştırın


```
bash ~/run-node.sh
```

Eğerki güncelleme gelirse "screen -r aztec" ile screen içerisine girip "ctrl+c" ile durdurun daha sonra sırasıyla aşağıdaki kodları girip yine screen içerisindeyken çalıştırma kodunu girin.

```
rm -rf ~/.aztec/alpha-testnet/data
```
```
aztec-up alpha-testnet
```


Thanks to [0xmoei](https://github.com/0xmoei/aztec-network)





