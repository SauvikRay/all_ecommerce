class Constants{
  static const String APP_NAME = "SkybuyBD";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "https://www.skybuybd.com";
  static const String OTP_PHONE_SUBMIT = "/api/v1/otp-phone-submit";
  static const String OTP_CODE_SUBMIT = "/api/v1/otp-code-submit";
  static const String UPLOAD_URL = "/uploads/";
  static const String LOGIN_URL = "/api/v1/login";
  static const String REGISTRATION_URL = "/api/v1/register";
  static const String PARENT_CATEGORY_URL = "/api/v1/categories";
  static const String HOME_PAGE_URL = "/api/v1/";
  static const String CATEGORY_PRODUCT_URL = "/api/v1/categories";
  static const String PRODUCT_DETAILS_URL = "/api/v1/product/";
  static const String PRODUCT_SEARCH_URL = "/api/v1/search/";
  static const String PRODUCT_IMAGE_SEARCH_URL = "/api/v1/image-search";
  static const String CONVERSION_RATE_URL = "/api/v1/site-settings/conversion-rate";
  static const String SHIPPING_TEXT_URL = "/api/v1/item-desc-messages";

  ///Orders and Invoice
  static const String CUSTOMER_ORDER_LIST_URL = "/api/v1/order/get-customer-order";
  static const String CUSTOMER_ORDER_INVOICE_LIST_URL = "/api/v1/order/customer-invoice-list";
  static const String CUSTOMER_ADDRESS_LIST_URL = "/api/v1/auth/customer-address";

  ///Cart
  static const String CART_POST_URL = "/api/v1/cart/update-customer-cart";
  static const String CART_GET_URL = "/api/v1/cart/get-customer-cart";
  static const String CART_DELETE_URL = "/api/v1/cart/remove-customer-cart";

  ///Wishlist
  static const String WISHLIST_GET_URL = "/api/v1/wishlist/customer-wishlist";
  static const String WISHLIST_POST_URL = "/api/v1/wishlist/store";

  ///Shared preference KEYS
  static const String TOKEN = "";
  static const String CONVERSION_RATE = "0";

  ///User
  static const String USER_IMAGE = "i";
  static const String USER_NAME = "name";
  static const String USER_FIRST_NAME = "first-name";
  static const String USER_LAST_NAME = "last-name";
  static const String USER_EMAIL = "email";
  static const String USER_CREATED_AT = "created_at";
  static const String USER_LAST_UPDATED = "updated_at";

  ///Drawer URL
  static const String googleImg = "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png";
  static const String avatar1 = "https://cdn.pixabay.com/photo/2016/03/29/03/14/portrait-1287421_960_720.jpg";
  static const String avatar2 = "https://cdn.pixabay.com/photo/2016/03/29/03/14/portrait-1287421_960_720.jpg";
  static const String avatar3 =  'https://images.unsplash.com/photo-1516384903227-139a8cf0ec21?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  static const String avatar4 = "https://images.unsplash.com/photo-1601412436465-922fadda062e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80";


  static const String macMiniCover = "https://www.apple.com/v/mac-mini/l/images/overview/hero__x8ruukomx2au_large_2x.jpg";

  ///Button Names
  static const String PROCEED = "Proceed";

  ///Splash Delay
  static const int delay = 1500;

  ///AppBar Logo
  static const String appBarLogo = 'assets/logo/whitelogo.png';
}