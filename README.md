# Zabbix Template: SSL Certificate Check Utility

### Установка Zabbix скрипта и темплейта

Поместить скрипт ssl_cert_check.sh для Zabbix Server в директорию для внешних скриптов, например: /usr/lib/zabbix/externalscripts
Импортировать темплейт `template_SSL_Cert_Check_External-2.0.xml` в Zabbix. Добавить темплейт на нужный хост. Настроить интерфейсы агента и имя узла сети.

##### Макросы в темплейте

| Макросы                     | Значение      | Описание                              
| --------------------------- | ------------- | ------------------------------------------------
| {$SSL_EXPIRY_NOTCLASSIFIED} | 90            | Пороговое значение в днях до истечения срока действия сертификата для триггера с уровнем важности "Не классифицировано" ('Not Classified')
| {$SSL_EXPIRY_INFO}          | 60            | Пороговое значение в днях до истечения срока действия сертификата для триггера с уровнем важности "Информация" ('Information')
| {$SSL_EXPIRY_WARN}          | 30            | Пороговое значение в днях до истечения срока действия сертификата для триггера с уровнем важности "Предупреждение" ('Warning')
| {$SSL_EXPIRY_AVG}           | 15            | Пороговое значение в днях до истечения срока действия сертификата для триггера с уровнем важности "Средняя" ('Average')
| {$SSL_EXPIRY_HIGH}          | 7             | Пороговое значение в днях до истечения срока действия сертификата для триггера с уровнем важности "Высокая" ('High')
| {$SSL_PORT}                 | 443           | Порт на который будет подключаться openssl для проверки сертификата (можно переопределять в макросах хоста)


## Credits

Based on script from [aperto.fr](http://aperto.fr/cms/en/blog/15-blog-en/15-ssl-certificate-expiration-monitoring-with-zabbix.html) with additions by [racooper@tamu.edu's](https://share.zabbix.com/owner/github_631895)

