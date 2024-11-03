# Здесь будет наглядно показано какой путь проходят данные начиная со стадии storage доходя до пункта прибытия Google Data Studio. 

Начнем с того что такое Google Data Studio, также называемый Data Studio, — это бесплатный инструмент для создания отчетов и визуализации данных . Он извлекает данные из 12 различных источников, включая PostgreSQL, и объединяет их в отчет, который легко изменять, которым легко делиться и который легко читать. 

Можно использовать другие аналоги как:

+ Klipfolio
+ AWS QuickSight

###### Всё это нужно в первую очередь для принятия каких-либо решений бизнесу. В основном эти данные генерируют и анализируют аналитики данных и BI но важно понимать всю логику действий для лучшего создания и структруирования витрины данных.

---

И так, начнем с того что для начала вам понадобится загрузить данные в базу данных из схемы [schema_stg.sql](https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/schema_stg.sql)
Так как эти данные взяты из хранилища их можно считать упакованными, не сырыми данными готовыми к работе. 

> # Что такое сырые данные и причем здесь Data Lake 
> Сырыми данными называют данные, взятые из Data Lake (Озеро Данных) \
> Data Lake - централизованное хранилище, которое принимает, хранит и позволяет обрабатывать большие объемы данных в исходной форме. \
> Есть же альтернативный способ хранения данных это Data Warehouse (Хранилище Данных) \
> Подробную статью про способы храние данных можно прочитать [тут](https://habr.com/ru/articles/485180/) \
> 
> *Анлийская версия статьи [здесь](https://medium.com/rock-your-data/getting-started-with-data-lake-4bb13643f9)*

---

После загрузки данных важно сделать таблицу нормализированной, как это делается вы можете посмотреть [здесь](https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/from_stg_to_dw.sql)

### Сейчас мы имеем базу данных о продаже товаров в USA c таблицами данных о доставке, продукте, гео, дате и полной информацией о сделке

Структура нашей схемы имеет названия **Звезда** 

Существует 2 типа схем:
- Снежинка
- Звезда

Узнать о типах схем подробнее, а также их отличие можно [здесь](https://www.astera.com/ru/type/blog/star-schema-vs-snowflake-schema/)

---
## Концептуальная модель данных 
Концептуальная модель базы данных это некая наглядная диаграмма, нарисованная в принятых обозначениях и подробно показывающая связь между объектами и их характеристиками. \
\
<image src="https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/%D0%BA%D0%BE%D0%BD%D1%86%D0%B5%D0%BF%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F%20%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C.png" alt="Концептуальная модель данных">

---
## Логическая модель данных
Логической моделью данных называют усовершенствованную версию концептуальной модели. В ней схематически представлены ограничения данных, имена сущностей и связи, которые нужно будет реализовать независимо от платформы.\
\
<image
src="https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F%20%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C.png" alt="Логическая модель данных">

## Физическая модель данных
Физическая модель базы данных — это модель данных, которая определяет, каким образом представляются данные, и содержит все детали, необходимые СУБД для создания базы данных.\
\
<image
src="https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/%D1%84%D0%B8%D0%B7%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F%20%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C.png" alt="Физическая модель данных">

###### Подробнее про моделирование данных вы можете прочитать [здесь](https://habr.com/ru/articles/556790/)\
\
Код sql физической модели данных берите [здесь](https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/physical_model_data.sql)

---

# Подключаем базу данных к  Google Data Studio

Подробная интрукция подключение находиться по этой [ссылке](https://easyinsights.ai/forum/t/how-do-i-connect-google-datastudio-with-postegresql/109/)\
\
После подключение к бд выполняем этот запрос: 

```
select count(*) from dw.sales_fact sf
inner join dw.shipping_dim s on sf.ship_id=s.ship_id
inner join dw.geo_dim g on sf.geo_id=g.geo_id
inner join dw.product_dim p on sf.prod_id=p.prod_id
inner join dw.customer_dim cd on sf.cust_id=cd.cust_id;
```
---
## Готово! Теперь вы можете делать аналитику прямо в Google Data Studio и получать любую аналитическую характиристику которая вам нужна

Какой вид заказчика делает больше покупок:
\
<image src="https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/by_which_customer_made_more_sales.png" alt="Какой вид заказчика делает больше покупок">
\
Рекордное количество продаж каждого штата:
\
<image src="https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/the_record_count_sales.png" alt="Рекордное количество продаж каждого штата">
\
Какой штат принес больше прибыли:
\
<image src="https://github.com/ASAVDt/sql_date_eng/blob/main/practice_1/from_which_state_was_made_more_sales.png" alt="Какой штат принес больше прибыли">

---
# Поздравляю! Теперь вы знаете какой путь проходят данные до такого как они дойдут до аналитиков данных и BI 
Теперь вы знаете что такое:
* [DATA LAKE AND DATA WAREHOUSE](https://habr.com/ru/articles/485180/) 
* [Схемы Звезда и Снежинка](https://www.astera.com/ru/type/blog/star-schema-vs-snowflake-schema/)
* [Моделирование данных](https://habr.com/ru/articles/556790/)
* [Как подключать и работать с Google Data Studio](https://easyinsights.ai/forum/t/how-do-i-connect-google-datastudio-with-postegresql/109/)
