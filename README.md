![image](https://github.com/user-attachments/assets/b2fb2d70-c75a-4fe5-ae4a-0efbc28b3e45)

# Aztec Sequencer Node Kurulumu

# [Kurulum Videosu]() 

## Sunucu Gereksinimleri

RAM : 16GB

CPU : 8 CORE (4'de oluyor fakat imkan varsa 8 olsun)

SSD : 100GB+

Ubuntu 22.04


# Kuruluma Başlamadan Önce Yapılacak Hazırlıklar

İlk önce bir [Metamask](metamask.io) cüzdanı oluşturalım ve sepolia test ağında ETH [Faucet](https://sepolia-faucet.pk910.de/) alalım, 0.1 ETH kazsanız yeterli olur.

Daha sonra [Alchemy](https://dashboard.alchemy.com/) sitesine kayıt olalım.

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

Yükleme bittikten sonra "exit" yazıp enterlayın ve sonra tekrar "exit" yazıp tekrar enterlayın sunucudan çıkın ve "ssh root@ip" ile sunucuya tekrar bağlanın.(sunucudan çıkıp tekrar geri giriyoruz)

![image](https://github.com/user-attachments/assets/ea430ff9-f8c7-4e74-a45a-c4176dd7605f)

Sunucuya tekrar bağlandıktan sonra aşağıdaki kodu yazıp enterlayın

```
wget https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/script2.sh && chmod +x script2.sh && ./script2.sh
```

Yükleme bittikten sonra sizden "Sepolia RPC" isteyecek, kayıt olduğumuz alchemy sitesine gidip endpointe tıklayalım.("My Apps" kısmında birşey yoksa sağ tarafta "Create New App" yazıyor ona tıklayıp oluşturun)

![image](https://github.com/user-attachments/assets/c6dd0a5a-bc30-4d46-a208-7af771987a5b) 

Sepolia'yı seçip RPC'yi kopyalayın ve terminale dönüp yapıştırıp enterlayın

![image](https://github.com/user-attachments/assets/f1494a00-412a-4e67-8870-64e693f6921a)
![image](https://github.com/user-attachments/assets/ce12192a-f41c-448e-9582-fc3e749d2fb7)

Sonrasında metamask özel anahtarınızı isteyecek onu da yapıştırıp enterlayın

![image](https://github.com/user-attachments/assets/2001fc23-e9ba-4499-8a12-d9f2b28b4f57)

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
wget https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/base64.sh && chmod +x base64.sh && ./base64.sh
```
Size verdiği bu uzun kodu bir yere kaydedin şimdi discord işlemlerini yapacağız

![image](https://github.com/user-attachments/assets/ed506ed1-f136-43e2-9bc8-454502715e11)

Discord'da "operators|start-here" kanalına gidin ve "/operator start" yazın aşağıdaki görseldeki gibi doldurun.

Adress kısmına metamask cüzdan adresinizi.

Block-number yazan yere az önce yazdığınız kodun çıktısındaki son blok numarasını.

Proof yazan yere aldığınız uzun çıktıyı yazıp enterlayın.

![image](https://github.com/user-attachments/assets/a2adec9c-171a-4c25-a2dc-d3318ea40ed5)

Son olarak da aşağıki kod ile validatör kaydı yapalım.

```
wget https://raw.githubusercontent.com/DoganSoley/aztec-node-kurulum/refs/heads/main/validator.sh && chmod +x validator.sh && ./validator.sh
```
Günlük belirli bir kayıt limiti olduğu için her zaman kayıt etmiyor eğer günlük limit doluysa şu şekilde bir çıktı alırsınız, kayıt olana kadar birer gün arayla denersiniz.

![image](https://github.com/user-attachments/assets/85281adf-b28e-4dab-a8af-d6e03aa3dfeb)







