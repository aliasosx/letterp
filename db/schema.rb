# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "banners", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "company_code", limit: 4, null: false
    t.string "company_name", null: false
    t.datetime "established_date", null: false
    t.datetime "created_date"
    t.datetime "updated_date"
    t.index ["company_code"], name: "banners_company_code_uindex", unique: true
    t.index ["company_name"], name: "banners_company_name_uindex", unique: true
    t.index ["id"], name: "banners_id_uindex", unique: true
  end

  create_table "countries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "country_code", limit: 2, null: false
    t.string "country_name", limit: 100, null: false
    t.index ["country_code"], name: "countries_country_code_uindex", unique: true
    t.index ["country_name"], name: "countries_country_name_uindex", unique: true
    t.index ["id"], name: "countries_id_uindex", unique: true
  end

  create_table "currencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "code", limit: 100
    t.string "symbol", limit: 100
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "enabled", default: false
  end

  create_table "customer_point_histories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tranxlogid", limit: 36, null: false
    t.string "customer_code", limit: 20
    t.integer "point", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "customer_point_histories_id_uindex", unique: true
    t.index ["tranxlogid"], name: "customer_point_histories_tranxlogid_uindex", unique: true
  end

  create_table "customer_points", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "customer_code", limit: 20, null: false
    t.integer "point", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "customer_points_id_uindex", unique: true
  end

  create_table "customers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "customer_code", limit: 20, null: false
    t.string "gender", limit: 1, null: false
    t.string "fullname", null: false
    t.date "dateOfBirth", null: false
    t.string "current_addr", limit: 1000
    t.string "province_code", limit: 3, null: false
    t.date "registered_date", null: false
    t.string "tel", limit: 20
    t.string "mobile", limit: 20
    t.string "email"
    t.string "fb", null: false
    t.string "socials", limit: 1000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_code"], name: "customers_customer_reg_no_uindex", unique: true
    t.index ["email"], name: "customers_email_uindex", unique: true
    t.index ["fullname"], name: "customers_fullname_uindex", unique: true
    t.index ["id"], name: "customers_id_uindex", unique: true
    t.index ["mobile"], name: "customers_mobile_uindex", unique: true
    t.index ["tel"], name: "customers_tel_uindex", unique: true
  end

  create_table "discount_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "discount_type_code", limit: 6, null: false
    t.string "discount_type_name", null: false
    t.datetime "created_at"
    t.datetime "udpated_at"
    t.index ["discount_type_code"], name: "discount_types_discount_type_code_uindex", unique: true
    t.index ["discount_type_name"], name: "discount_types_discount_type_name_uindex", unique: true
    t.index ["id"], name: "discount_types_id_uindex", unique: true
  end

  create_table "menus", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "menu_order", null: false
    t.string "menu_code", limit: 10, null: false
    t.string "menu_name", null: false
    t.string "menu_link", null: false
    t.boolean "enabled", default: true, null: false
    t.datetime "created_date", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_date", default: -> { "CURRENT_TIMESTAMP" }
    t.string "icon", null: false
    t.string "link_active", limit: 10, default: "active"
    t.index ["id"], name: "menus_id_uindex", unique: true
    t.index ["menu_code"], name: "menus_menu_code_uindex", unique: true
    t.index ["menu_link"], name: "menus_menu_link_uindex", unique: true
    t.index ["menu_name"], name: "menus_menu_name_uindex", unique: true
  end

  create_table "product_categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "prod_cat_code", limit: 20, null: false
    t.string "prod_cat_name_en", null: false
    t.string "prod_cat_name_la", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "prod_categories_id_uindex", unique: true
    t.index ["prod_cat_code"], name: "product_categories_prod_cat_code_uindex", unique: true
    t.index ["prod_cat_name_en"], name: "prod_categories_prod_cat_name_en_uindex", unique: true
    t.index ["prod_cat_name_la"], name: "prod_categories_prod_cat_name_la_uindex", unique: true
  end

  create_table "product_masters", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code", limit: 20, null: false
    t.string "product_barcode", limit: 25
    t.string "product_serial_number", limit: 25
    t.string "product_name", null: false
    t.date "manufacture_date", null: false
    t.date "expire_date", null: false
    t.float "cost_price", limit: 53, null: false
    t.integer "starting_quantity", null: false
    t.integer "minimun_quantity", null: false
    t.datetime "stock_in_date", null: false
    t.string "warehouse_code", limit: 20, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "product_master_id_uindex", unique: true
    t.index ["product_barcode"], name: "product_master_product_barcode_uindex", unique: true
    t.index ["product_code"], name: "product_master_product_code_uindex", unique: true
    t.index ["product_name"], name: "product_master_product_name_uindex", unique: true
    t.index ["product_serial_number"], name: "product_master_product_serial_number_uindex", unique: true
  end

  create_table "product_points", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code", limit: 20, null: false
    t.decimal "quantity", precision: 10, null: false
    t.integer "point", null: false
    t.date "valid_until", null: false
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "product_points_id_uindex", unique: true
  end

  create_table "sales", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code", limit: 20, null: false
    t.decimal "quantity", precision: 10, null: false
    t.decimal "price", precision: 10
    t.float "total", default: 0.0, null: false
    t.float "discount", default: 0.0, null: false
    t.float "discount_amount", default: 0.0, null: false
    t.float "total_price", default: 0.0, null: false
    t.string "currency_code", limit: 3, null: false
    t.string "terminal_code", limit: 20, null: false
    t.datetime "sale_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "customer_code", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "tranxlogid", null: false
    t.index ["id"], name: "sales_id_uindex", unique: true
  end

  create_table "stock_trackings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code", limit: 20, null: false
    t.float "old_quantity", limit: 53
    t.float "current_quantity", limit: 53, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "transxlogid", limit: 36, null: false
    t.index ["id"], name: "stock_tracking_id_uindex", unique: true
    t.index ["transxlogid"], name: "stock_trackings_transxlogid_uindex", unique: true
  end

  create_table "stocks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code", limit: 20
    t.datetime "stock_date", null: false
    t.float "init_stock", limit: 53, null: false
    t.float "current_stock", limit: 53, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "stock_masters_id_uindex", unique: true
    t.index ["product_code"], name: "stock_masters_product_code_uindex", unique: true
  end

  create_table "terminals", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "terminal_serials", null: false
    t.string "terminal_name", null: false
    t.integer "floor_id", null: false
    t.string "terminal_code", limit: 20
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["id"], name: "terminals_id_uindex", unique: true
    t.index ["terminal_name"], name: "terminals_terminal_name_uindex", unique: true
    t.index ["terminal_serials"], name: "terminals_terminal_serials_uindex", unique: true
  end

  create_table "tranx_products", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code", limit: 20, null: false
    t.integer "warehouse_code"
    t.string "prod_cat_code", limit: 20
    t.index ["id"], name: "tranx_products_id_uindex", unique: true
    t.index ["product_code"], name: "tranx_products_product_code_uindex", unique: true
  end

  create_table "user_activities", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_id", limit: 25, null: false
    t.string "activities", null: false
    t.datetime "created_at"
    t.datetime "modified_at"
  end

  create_table "user_masters", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_id", limit: 25, null: false
    t.string "gender", limit: 1, null: false
    t.string "username_en", null: false
    t.string "username_la", null: false
    t.string "email", null: false
    t.string "password", limit: 32, null: false
    t.datetime "register_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "user_master_email_uindex", unique: true
    t.index ["id"], name: "user_master_id_uindex", unique: true
    t.index ["user_id"], name: "user_master_user_id_uindex", unique: true
    t.index ["username_en"], name: "user_master_username_en_uindex", unique: true
    t.index ["username_la"], name: "user_master_username_la_uindex", unique: true
  end

  create_table "warehouse_locations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "location_name", null: false
    t.integer "contact_id", null: false
    t.string "locations", null: false
    t.datetime "created_date"
    t.datetime "updated_date"
    t.index ["id"], name: "warehose_locations_id_uindex", unique: true
    t.index ["location_name"], name: "warehose_locations_location_name_uindex", unique: true
  end

  create_table "warehouses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "warehouse_code", limit: 20, null: false
    t.integer "warehouse_location_id", null: false
    t.string "warehose_addr", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_date"
    t.datetime "updated_date"
    t.index ["id"], name: "warehousing_id_uindex", unique: true
    t.index ["warehouse_code"], name: "warehousing_warehouse_code_uindex", unique: true
  end

end
