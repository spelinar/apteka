CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "id_password" int,
  "login" varchar,
  "user_details_id" int,
  "type_of_users_id" int,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int,
  "id_apteka" uuid
);

CREATE TABLE "user_details" (
  "id" int PRIMARY KEY,
  "about_myself" varchar,
  "user_uid" uuid,
  "PESEL" varchar,
  "first_name" varchar,
  "second_name" varchar,
  "company_name" varchar,
  "job_title" varchar,
  "phone_number" number,
  "email" varchar,
  "country" varchar,
  "city" varchar,
  "street" varchar,
  "house" varchar,
  "flate_number" varchar,
  "post_code" varchar,
  "pensja" double,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int
);

CREATE TABLE "passwords" (
  "id" int PRIMARY KEY,
  "user_uid" uuid,
  "password_md5" varchar,
  "status_id" int,
  "created_at" timestamp DEFAULT (now()),
  "modifiead_at" timestamp,
  "modified_by" varchar
);

CREATE TABLE "avatar_blob" (
  "id" int PRIMARY KEY,
  "user_uid" uuid,
  "file_type" varchar(40),
  "size" int,
  "name" varchar,
  "status_id" int,
  "file" blob,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp
);

CREATE TABLE "dictionary_words" (
  "id" int PRIMARY KEY,
  "dictionary_id" int,
  "full_name" varchar,
  "short_name" varchar,
  "values" int,
  "status_id" int,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp
);

CREATE TABLE "dictionary_names" (
  "id" SERIAL PRIMARY KEY,
  "full_name" varchar,
  "short_name" varchar,
  "status_id" int,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp
);

CREATE TABLE "login_events" (
  "id" uuid[pk],
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "password" varchar,
  "login" varchar,
  "ipaddress" varchar,
  "browserinfo" varchar,
  "machineINfo" varchar,
  "description" varchar,
  "success" varchar
);

CREATE TABLE "pharmacy" (
  "id" uuid[pk],
  "address" varchar,
  "nr_telefonu" VARCHAR,
  "przychody" REAL,
  "company_id" uuid,
  "koszty" REAL,
  "date_open" TIMESTAMP,
  "date_close" TIMESTAMP,
  "mode_type_id" INTEGER
);

CREATE TABLE "products" (
  "id" uuid[pk],
  "name" varchar,
  "count" integer,
  "cena" DOUBLE,
  "company_id" integer,
  "postac" VARCHAR,
  "producent" VARCHAR,
  "barcode" varchar,
  "czy_refundowane" BOOLEAN,
  "czy_na_recepte" BOOLEAN
);

CREATE TABLE "order_products_internal" (
  "id" uuid[pk],
  "id_product" uuid,
  "final_invoice_internal_id" INTEGER,
  "data_sprzedazy" TIMESTAMP,
  "czy_refundowane" BOOLEAN,
  "count" INTEGER,
  "discount_value" DOUBLE,
  "discount_nfz_value" double,
  "discount_nfz_perc" integer,
  "total_value" double,
  "payment_type_id" number,
  "loyalty_point" number,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int
);

CREATE TABLE "final_invoice_internal" (
  "id" uuid PRIMARY KEY,
  "id_klient" uuid,
  "id_pracownik" uuid,
  "id_apteka" INTEGER,
  "amount_tendered" INTEGER,
  "balance_due" INTEGER,
  "discount_nfz_value_total" double,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int
);

CREATE TABLE "final_invoice_external" (
  "id" uuid PRIMARY KEY,
  "company_id" uuid,
  "id_pracownik" uuid,
  "id_pharmacy" INTEGER,
  "amount_tendered" INTEGER,
  "balance_due" INTEGER,
  "discount_value_total" DOUBLE,
  "discount_nfz_perc" integer,
  "discount_nfz_value_total" double,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int
);

CREATE TABLE "company" (
  "id" uuid[pk],
  "company_name" varchar,
  "NIP" varchar,
  "phone_number" varchar,
  "street" varchar,
  "house_number" varchar,
  "postcode" varchar,
  "city" varchar,
  "country" varchar,
  "flat_number" varchar,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int
);

CREATE TABLE "order_products_external" (
  "id" uuid[pk],
  "id_product" uuid,
  "final_invoice_external_id" INTEGER,
  "amount_tendered" INTEGER,
  "balance_due" INTEGER,
  "count" INTEGER,
  "payment_type_id" number,
  "created_at" timestamp DEFAULT (now()),
  "modified_at" timestamp,
  "modified_by" varchar,
  "status_id" int
);

CREATE TABLE "pharmacy_magazine" (
  "id" uuid[pk],
  "id_product" uuid,
  "id_pharmacy" uuid,
  "count" number,
  "modified_at" TIMESTAMP,
  "modified_by" uuid
);

CREATE TABLE "dyzur" (
  "id" uuid[pk],
  "id_apteka" uuid,
  "godzina_rozpoczecia" TIMESTAMP,
  "godzina_zakonczenia" TIMESTAMP
);

CREATE TABLE "dyzur_pracownik" (
  "id" uuid[pk],
  "id_pracownika" uuid,
  "id_dyzur" uuid
);

CREATE TABLE "benefit_card" (
  "id" uuid[pk],
  "id_klient" uuid,
  "id_pracownik" uuid,
  "balance" number,
  "card_number" INTEGER,
  "data_end" TIMESTAMP,
  "data_start" TIMESTAMP,
  "created_at" TIMESTAMP
);

ALTER TABLE "user_details" ADD FOREIGN KEY ("user_uid") REFERENCES "users" ("id");

ALTER TABLE "user_details" ADD FOREIGN KEY ("id") REFERENCES "users" ("user_details_id");

ALTER TABLE "passwords" ADD FOREIGN KEY ("user_uid") REFERENCES "users" ("id");

ALTER TABLE "avatar_blob" ADD FOREIGN KEY ("user_uid") REFERENCES "users" ("id");

ALTER TABLE "user_details" ADD FOREIGN KEY ("status_id") REFERENCES "dictionary_words" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("status_id") REFERENCES "dictionary_words" ("id");

ALTER TABLE "dictionary_words" ADD FOREIGN KEY ("dictionary_id") REFERENCES "dictionary_names" ("id");

ALTER TABLE "pharmacy" ADD FOREIGN KEY ("mode_type_id") REFERENCES "dictionary_words" ("id");

ALTER TABLE "pharmacy" ADD FOREIGN KEY ("company_id") REFERENCES "company" ("id");

ALTER TABLE "final_invoice_external" ADD FOREIGN KEY ("company_id") REFERENCES "company" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("company_id") REFERENCES "company" ("id");

ALTER TABLE "final_invoice_external" ADD FOREIGN KEY ("id_pharmacy") REFERENCES "pharmacy" ("id");

ALTER TABLE "order_products_external" ADD FOREIGN KEY ("final_invoice_external_id") REFERENCES "final_invoice_external" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("id") REFERENCES "order_products_external" ("id_product");

ALTER TABLE "dictionary_words" ADD FOREIGN KEY ("id") REFERENCES "order_products_external" ("payment_type_id");

ALTER TABLE "final_invoice_external" ADD FOREIGN KEY ("id_pracownik") REFERENCES "users" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("id") REFERENCES "pharmacy_magazine" ("id_product");

ALTER TABLE "pharmacy_magazine" ADD FOREIGN KEY ("id_pharmacy") REFERENCES "pharmacy" ("id");

ALTER TABLE "pharmacy_magazine" ADD FOREIGN KEY ("modified_by") REFERENCES "users" ("id");

ALTER TABLE "order_products_internal" ADD FOREIGN KEY ("id_product") REFERENCES "products" ("id");

ALTER TABLE "final_invoice_internal" ADD FOREIGN KEY ("id_klient") REFERENCES "users" ("id");

ALTER TABLE "final_invoice_internal" ADD FOREIGN KEY ("id_pracownik") REFERENCES "users" ("id");

ALTER TABLE "final_invoice_internal" ADD FOREIGN KEY ("id_apteka") REFERENCES "pharmacy" ("id");

ALTER TABLE "order_products_internal" ADD FOREIGN KEY ("payment_type_id") REFERENCES "dictionary_words" ("id");

ALTER TABLE "benefit_card" ADD FOREIGN KEY ("id_pracownik") REFERENCES "users" ("id");

ALTER TABLE "benefit_card" ADD FOREIGN KEY ("id_klient") REFERENCES "users" ("id");

ALTER TABLE "dyzur_pracownik" ADD FOREIGN KEY ("id_pracownika") REFERENCES "users" ("id");

ALTER TABLE "dyzur_pracownik" ADD FOREIGN KEY ("id_dyzur") REFERENCES "dyzur" ("id");

ALTER TABLE "login_events" ADD FOREIGN KEY ("login") REFERENCES "avatar_blob" ("status_id");

ALTER TABLE "final_invoice_internal" ADD FOREIGN KEY ("modified_by") REFERENCES "company" ("id");
