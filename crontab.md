### Crontab

1. Crontab düzenlemesi yapılır. Crontab dosyası açılır.

       crontab -e


2. Örneğin her gün saat 23.59 da sh dosyaları çalıştırılsın.

       59 23 * * * sudo kubernetes-postgresql.sh
       59 23 * * * sudo kubernetes-mongodb.sh
       59 23 * * * sudo docker-postgresql.sh
       59 23 * * * sudo docker-mongodb.sh

3. Kaydedip çıkın.